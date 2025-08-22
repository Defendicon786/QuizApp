<?php
include 'database.php';

// If the database connection failed, return a JSON error immediately. The
// database bootstrap file deliberately avoids emitting output on failure so
// that we can send a clean JSON response here.
if (!isset($conn) || $conn === null) {
    echo json_encode(['error' => 'Database connection failed']);
    exit;
}

if ($conn->connect_errno) {
    echo json_encode(['error' => 'Database connection failed: ' . $conn->connect_error]);
    exit;
}

header('Content-Type: application/json');

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
    echo json_encode(['error' => 'No chapter IDs provided']);
    exit;
}

if (empty($question_type)) {
    echo json_encode(['error' => 'No question type specified']);
    exit;
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
            echo json_encode(['error' => 'Invalid question type']);
            exit;
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
    
    echo json_encode($questions);
    
} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
