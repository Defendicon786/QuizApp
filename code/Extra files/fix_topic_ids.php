<?php
require_once __DIR__ . '/../database.php';

$topicName = 'Domain Archaea';
$topicId = null;

$sql = "SELECT topic_id FROM topics WHERE topic_name = ? LIMIT 1";
$stmt = $conn->prepare($sql);
if ($stmt) {
    $stmt->bind_param('s', $topicName);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
        $topicId = (int)$row['topic_id'];
    }
    $stmt->close();
}

if ($topicId === null) {
    echo "Topic '$topicName' not found" . PHP_EOL;
    exit(1);
}

$query = "UPDATE mcqdb SET topic_id=? WHERE question LIKE '%Archaea%'";
$stmt = $conn->prepare($query);
if (!$stmt) {
    echo "Failed to prepare update: " . $conn->error . PHP_EOL;
    exit(1);
}

$stmt->bind_param('i', $topicId);
$stmt->execute();

echo "Updated " . $stmt->affected_rows . " MCQ rows" . PHP_EOL;
$stmt->close();

