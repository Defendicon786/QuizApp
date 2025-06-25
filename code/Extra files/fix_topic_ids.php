<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include 'database.php';

$topicName = 'Domain Archaea';

// find the current topic_id for Domain Archaea
$sql = "SELECT topic_id FROM topics WHERE topic_name = '$topicName' LIMIT 1";
$result = $conn->query($sql);

if (!$result || $result->num_rows === 0) {
    echo "Topic '$topicName' not found in topics table.";
    exit;
}

$row = $result->fetch_assoc();
$topicId = (int)$row['topic_id'];

// update mcqdb rows that mention Archaea but have a different topic_id
$update = "UPDATE mcqdb SET topic_id = $topicId WHERE chapter_id = 6 AND question LIKE '%Archaea%' AND topic_id <> $topicId";

if ($conn->query($update)) {
    echo "Updated " . $conn->affected_rows . " MCQ questions to topic_id $topicId.";
} else {
    echo "Failed to update MCQ questions: " . $conn->error;
}

$conn->close();
?>
