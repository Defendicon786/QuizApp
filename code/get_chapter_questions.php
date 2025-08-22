<?php
/**
 * Fetches questions for selected chapters and returns them as JSON.
 * Some PHP configurations emit warnings/notices which can corrupt JSON
 * responses.  To guarantee that the client always receives valid JSON,
 * we buffer any unexpected output and clear it before sending the final
 * response.
 */

// Start output buffering to capture any stray warnings/notices.
ob_start();

include 'database.php';

/**
 * Helper function to emit a clean JSON response and terminate the script.
 */
function send_json($data) {
    if (ob_get_length()) {
        ob_clean();
    }
    header('Content-Type: application/json');
    echo json_encode($data);
    exit;
}

// If the database connection failed, return a JSON error immediately. The
// database bootstrap file deliberately avoids emitting output on failure so
// that we can send a clean JSON response here.
if (!isset($conn) || $conn === null) {
    send_json(['error' => 'Database connection failed']);
}

if ($conn->connect_errno) {
    send_json(['error' => 'Database connection failed: ' . $conn->connect_error]);
}

// Get parameters
$chapter_ids = isset($_GET['chapter_ids']) ? explode(',', $_GET['chapter_ids']) : [];
$question_type = isset($_GET['type']) ? $_GET['type'] : '';
$topic_ids = [];
if (isset($_GET['topic_ids']) && strlen($_GET['topic_ids']) > 0) {
    $topic_ids = explode(',', $_GET['topic_ids']);
}

// Sanitize input
$chapter_ids = array_map('intval', $chapter_ids);
$chapter_ids_str = implode(',', array_map('intval', $chapter_ids));
$topic_ids = array_map('intval', $topic_ids);
$topic_filter = '';
if (!empty($topic_ids)) {
    $topic_ids_str = implode(',', $topic_ids);
    $topic_filter = " AND topic_id IN ($topic_ids_str)";
}

if (empty($chapter_ids) || empty($chapter_ids_str)) {
    send_json(['error' => 'No chapter IDs provided']);
}

if (empty($question_type)) {
    send_json(['error' => 'No question type specified']);
}

$questions = [];

try {
    switch ($question_type) {
        case 'mcq':
            $sql = "SELECT id, question, optiona, optionb, optionc, optiond, answer, chapter_id
                    FROM mcqdb
                    WHERE chapter_id IN ($chapter_ids_str)$topic_filter
                    ORDER BY id";
            break;
            
        case 'numerical':
            $sql = "SELECT id, question, answer, chapter_id
                    FROM numericaldb
                    WHERE chapter_id IN ($chapter_ids_str)$topic_filter
                    ORDER BY id";
            break;
            
        case 'dropdown':
            $sql = "SELECT id, question, options, answer, chapter_id
                    FROM dropdown
                    WHERE chapter_id IN ($chapter_ids_str)$topic_filter
                    ORDER BY id";
            break;
            
        case 'fillblanks':
            // The fillintheblanks table stores the question text in the
            // `question` column. Older frontend code expects a `sentence`
            // field, so alias it here to maintain compatibility.
            $sql = "SELECT id, question AS sentence, options, answer, chapter_id
                    FROM fillintheblanks
                    WHERE chapter_id IN ($chapter_ids_str)$topic_filter
                    ORDER BY id";
            break;
            
        case 'short':
            $sql = "SELECT id, question, answer, chapter_id
                    FROM shortanswer
                    WHERE chapter_id IN ($chapter_ids_str)$topic_filter
                    ORDER BY id";
            break;
            
        case 'essay':
            $sql = "SELECT id, question, answer, chapter_id
                    FROM essay
                    WHERE chapter_id IN ($chapter_ids_str)$topic_filter
                    ORDER BY id";
            break;
            
        default:
            send_json(['error' => 'Invalid question type']);
    }

    $result = $conn->query($sql);
    
    if (!$result) {
        throw new Exception("Query error: " . $conn->error);
    }
    
    while ($row = $result->fetch_assoc()) {
        // Add prefix to id for identification when saving selected questions
        $row['unique_id'] = $question_type . '_' . $row['id'];
        $questions[] = $row;
    }
    
    send_json($questions);

} catch (Exception $e) {
    send_json(['error' => $e->getMessage()]);
}
