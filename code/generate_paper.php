<?php
session_start();
if (!isset($_SESSION['paperloggedin']) || $_SESSION['paperloggedin'] !== true) {
    header('Location: paper_login.php');
    exit;
}

$useMpdf = false;
$vendorAutoload = __DIR__ . '/vendor/autoload.php';
if (file_exists($vendorAutoload)) {
    require_once $vendorAutoload;
    if (class_exists('\\Mpdf\\Mpdf')) {
        $useMpdf = true;
    }
}
if (!$useMpdf) {
    require_once __DIR__ . '/lib/fpdf.php';
}

include 'database.php';

$paperName = trim($_POST['paper_name'] ?? 'Question Paper');
$classId = intval($_POST['class_id'] ?? 0);
$subjectId = intval($_POST['subject_id'] ?? 0);
$chapterId = intval($_POST['chapter_id'] ?? 0);
$topicId = isset($_POST['topic_id']) && $_POST['topic_id'] !== '' ? intval($_POST['topic_id']) : null;
$mcq = intval($_POST['mcq'] ?? 0);
$short = intval($_POST['short'] ?? 0);
$essay = intval($_POST['essay'] ?? 0);
$fill = intval($_POST['fill'] ?? 0);
$numerical = intval($_POST['numerical'] ?? 0);
$paperDate = trim($_POST['paper_date'] ?? '');
$mode = $_POST['mode'] ?? 'random';
$logo = $_SESSION['paper_logo'] ?? '';
$header = $_SESSION['paper_header'] ?? '';

function fetch_questions($conn, $table, $fields, $chapterId, $topicId, $limit) {
    if ($limit <= 0 || !$conn) return [];
    $sql = "SELECT $fields FROM $table WHERE chapter_id=?";
    $types = 'i';
    $params = [$chapterId];
    if ($topicId) { $sql .= " AND topic_id=?"; $types .= 'i'; $params[] = $topicId; }
    $sql .= " ORDER BY RAND() LIMIT ?"; $types .= 'i'; $params[] = $limit;
    $stmt = $conn->prepare($sql);
    if (!$stmt) return [];
    $stmt->bind_param($types, ...$params);
    $stmt->execute();
    $res = $stmt->get_result();
    $qs = [];
    while($row = $res->fetch_assoc()) { $qs[] = $row; }
    $stmt->close();
    return $qs;
}

$sections = [];

if ($mode === 'manual') {
    $selected = [
        'MCQs' => ['ids' => $_POST['selected_mcq'] ?? '', 'table' => 'mcqdb', 'fields' => 'question, optiona, optionb, optionc, optiond'],
        'Short Questions' => ['ids' => $_POST['selected_short'] ?? '', 'table' => 'shortanswer', 'fields' => 'question'],
        'Long Questions' => ['ids' => $_POST['selected_essay'] ?? '', 'table' => 'essay', 'fields' => 'question'],
        'Fill in the Blanks' => ['ids' => $_POST['selected_fill'] ?? '', 'table' => 'fillintheblanks', 'fields' => 'question'],
        'Numerical' => ['ids' => $_POST['selected_numerical'] ?? '', 'table' => 'numericaldb', 'fields' => 'question']
    ];
    foreach ($selected as $title => $info) {
        $ids = array_filter(array_map('intval', array_filter(explode(',', $info['ids']))));
        $sections[$title] = [];
        if (!empty($ids) && $conn) {
            $placeholders = implode(',', array_fill(0, count($ids), '?'));
            $sql = "SELECT {$info['fields']} FROM {$info['table']} WHERE id IN ($placeholders)";
            $stmt = $conn->prepare($sql);
            if ($stmt) {
                $types = str_repeat('i', count($ids));
                $stmt->bind_param($types, ...$ids);
                $stmt->execute();
                $res = $stmt->get_result();
                while ($row = $res->fetch_assoc()) { $sections[$title][] = $row; }
                $stmt->close();
            }
        }
    }
} else {
    $sections['MCQs'] = fetch_questions($conn, 'mcqdb', 'question, optiona, optionb, optionc, optiond', $chapterId, $topicId, $mcq);
    $sections['Short Questions'] = fetch_questions($conn, 'shortanswer', 'question', $chapterId, $topicId, $short);
    $sections['Long Questions'] = fetch_questions($conn, 'essay', 'question', $chapterId, $topicId, $essay);
    $sections['Fill in the Blanks'] = fetch_questions($conn, 'fillintheblanks', 'question', $chapterId, $topicId, $fill);
    $sections['Numerical'] = fetch_questions($conn, 'numericaldb', 'question', $chapterId, $topicId, $numerical);
}
if ($conn) {
    $conn->close();
}

$html = '';
// Build a header with logo on the left and text centered
$html .= '<table style="width:100%; border-bottom:1px solid #000; margin-bottom:20px;"><tr>';
if ($logo) {
    $html .= '<td style="width:80px;"><img src="'.htmlspecialchars($logo).'" style="height:80px;"></td>';
} else {
    $html .= '<td style="width:80px;"></td>';
}
$html .= '<td style="text-align:center;">';
$html .= '<h1 style="margin:0;">'.htmlspecialchars($header).'</h1>';
$html .= '<h2 style="margin:0;">'.htmlspecialchars($paperName).'</h2>';
if ($paperDate) {
    $html .= '<div>Date: '.htmlspecialchars($paperDate).'</div>';
}
$html .= '</td></tr></table>';

foreach ($sections as $title => $questions) {
    if (count($questions) === 0) continue;
    $html .= '<h3 style="margin-bottom:5px;">'.htmlspecialchars($title).'</h3><ol>';
    foreach ($questions as $q) {
        if ($title === 'MCQs') {
            $html .= '<li>'.htmlspecialchars($q['question']).'<ul style="list-style-type:upper-alpha;">';
            $html .= '<li>'.htmlspecialchars($q['optiona']).'</li>';
            $html .= '<li>'.htmlspecialchars($q['optionb']).'</li>';
            $html .= '<li>'.htmlspecialchars($q['optionc']).'</li>';
            $html .= '<li>'.htmlspecialchars($q['optiond']).'</li></ul></li>';
        } else {
            $html .= '<li>'.htmlspecialchars($q['question']).'</li>';
        }
    }
    $html .= '</ol>';
}

$mpdf = null;
if ($useMpdf) {
    $mpdf = new \Mpdf\Mpdf();
    header('Content-Type: application/pdf');
    $mpdf->WriteHTML($html);
    $mpdf->Output('paper.pdf', 'I');
} else {
    $pdf = new FPDF();
    $pdf->AddPage();
    if ($logo) {
        @ $pdf->Image($logo, 10, 10, 25);
    }
    // Position text to the right of the logo
    $pdf->SetXY(40, 10);
    $pdf->SetFont('Helvetica', 'B', 16);
    $pdf->Cell(0, 8, $header, 0, 1, 'L');
    $pdf->SetX(40);
    $pdf->SetFont('Helvetica', '', 14);
    $pdf->Cell(0, 8, $paperName, 0, 1, 'L');
    if ($paperDate) {
        $pdf->SetX(40);
        $pdf->SetFont('Helvetica', '', 12);
        $pdf->Cell(0, 6, 'Date: ' . $paperDate, 0, 1, 'L');
    }
    $pdf->Ln(10);
    foreach ($sections as $title => $questions) {
        if (count($questions) === 0) continue;
        $pdf->SetFont('Helvetica', 'B', 12);
        $pdf->Cell(0, 8, $title, 0, 1);
        $pdf->SetFont('Helvetica', '', 11);
        $i = 1;
        foreach ($questions as $q) {
            $text = $i . '. ' . $q['question'];
            if ($title === 'MCQs') {
                $text .= "\nA. " . $q['optiona'] . "\nB. " . $q['optionb'] . "\nC. " . $q['optionc'] . "\nD. " . $q['optiond'];
            }
            $pdf->MultiCell(0, 6, $text);
            $pdf->Ln(2);
            $i++;
        }
        $pdf->Ln(4);
    }
    header('Content-Type: application/pdf');
    $pdf->Output('paper.pdf', 'I');
}
exit;
?>
