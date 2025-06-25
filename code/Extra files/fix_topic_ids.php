<?php
include __DIR__ . '/../database.php';

if ($conn->connect_errno) {
    die("Database connection failed: " . $conn->connect_error);
}

// Find the topic_id for Domain Archaea
$topicRes = $conn->query("SELECT topic_id FROM topics WHERE topic_name = 'Domain Archaea' LIMIT 1");
if (!$topicRes || $topicRes->num_rows === 0) {
    die("Could not find topic 'Domain Archaea'.\n");
}
$topicId = (int)$topicRes->fetch_assoc()['topic_id'];

// Update mcqdb entries containing the word 'Archaea' to use the correct topic_id
$update = $conn->prepare("UPDATE mcqdb SET topic_id = ? WHERE question LIKE '%Archaea%'");
if (!$update) {
    die("Failed to prepare statement: " . $conn->error);
}
$update->bind_param('i', $topicId);
if ($update->execute()) {
    echo "Updated " . $update->affected_rows . " records.\n";
} else {
    echo "Failed to update records: " . $update->error . "\n";
}
$update->close();
$conn->close();
?>

