<?php
header('Content-Type: application/json');
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Add logging function
function logDebug($message, $data = null) {
    $log_message = date('Y-m-d H:i:s') . " DEBUG: $message";
    if ($data !== null) {
        $log_message .= " Data: " . print_r($data, true);
    }
    error_log($log_message, 3, "questions_debug.log");
}

include "database.php";

logDebug("Request received", $_POST);

if (!isset($_POST['type']) || !isset($_POST['chapter_ids'])) {
    logDebug("Missing parameters", $_POST);
    echo json_encode(['error' => 'Missing required parameters']);
    exit;
}

$type = $_POST['type'];
$chapter_ids = $_POST['chapter_ids'];
$topic_ids = isset($_POST['topic_ids']) ? $_POST['topic_ids'] : [];

logDebug("Processing request", ['type' => $type, 'chapter_ids' => $chapter_ids]);

// Validate chapter IDs
if (!is_array($chapter_ids)) {
    $chapter_ids = explode(',', $chapter_ids);
}
$chapter_ids = array_filter($chapter_ids, 'is_numeric');
if (!is_array($topic_ids)) {
    $topic_ids = explode(',', $topic_ids);
}
$topic_ids = array_filter($topic_ids, 'is_numeric');

if (empty($chapter_ids)) {
    logDebug("Invalid chapter IDs", $chapter_ids);
    echo json_encode(['error' => 'Invalid chapter IDs']);
    exit;
}

$topic_filter = '';
if (!empty($topic_ids)) {
    $topic_ids_str = implode(',', $topic_ids);
    $topic_filter = " AND topic_id IN ($topic_ids_str)";
}

$chapter_ids_str = implode(',', $chapter_ids);
logDebug("Chapter IDs string", $chapter_ids_str);

// Map type to table and prefix
$table_map = [
    'mcq' => ['table' => 'mcqdb', 'prefix' => 'mcq_'],
    'numerical' => ['table' => 'numericaldb', 'prefix' => 'numerical_'],
    'dropdown' => ['table' => 'dropdown', 'prefix' => 'dropdown_'],
    'fillblanks' => ['table' => 'fillintheblanks', 'prefix' => 'fillblanks_'],
    'short' => ['table' => 'shortanswer', 'prefix' => 'short_'],
    'essay' => ['table' => 'essay', 'prefix' => 'essay_']
];

if (!isset($table_map[$type])) {
    logDebug("Invalid question type", $type);
    echo json_encode(['error' => 'Invalid question type']);
    exit;
}

$table_info = $table_map[$type];
$sql = "SELECT id, question FROM {$table_info['table']} WHERE chapter_id IN ($chapter_ids_str)$topic_filter";
logDebug("SQL Query", $sql);

try {
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        logDebug("Prepare statement failed", $conn->error);
        throw new Exception("Failed to prepare statement: " . $conn->error);
    }
    
    if (!$stmt->execute()) {
        logDebug("Execute statement failed", $stmt->error);
        throw new Exception("Failed to execute statement: " . $stmt->error);
    }
    
    $result = $stmt->get_result();
    $questions = [];
    
    while ($row = $result->fetch_assoc()) {
        $questions[] = [
            'id' => $table_info['prefix'] . $row['id'],
            'question' => htmlspecialchars($row['question'])
        ];
    }
    
    logDebug("Questions loaded", ['count' => count($questions)]);
    echo json_encode($questions);
    
} catch (Exception $e) {
    logDebug("Error occurred", ['error' => $e->getMessage()]);
    echo json_encode(['error' => $e->getMessage()]);
}
?> 