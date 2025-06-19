<?php
session_start();
if(!isset($_SESSION['instructorloggedin']) || $_SESSION['instructorloggedin'] !== true){
    header('Location: instructorlogin.php');
    exit;
}
include 'database.php';

$message = '';
if($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $conn->real_escape_string(trim($_POST['action']));
    $details = $conn->real_escape_string(trim($_POST['details']));
    if($action && $details) {
        $email = $conn->real_escape_string($_SESSION['email']);
        $sql = sprintf("INSERT INTO instructor_requests (instructor_email, action, details) VALUES ('%s','%s','%s')",
            $email, $action, $details);
        if($conn->query($sql)) {
            $message = '<p class="text-success">Request submitted for admin review.</p>';
            $log = sprintf("%s - %s submitted request %d\n", date('c'), $email, $conn->insert_id);
            file_put_contents('../request_audit.log', $log, FILE_APPEND);
        } else {
            $message = '<p class="text-danger">Error submitting request.</p>';
        }
    } else {
        $message = '<p class="text-danger">All fields required.</p>';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Modification</title>
    <link rel="stylesheet" href="assets/css/modern.css">
</head>
<body>
<div class="container" style="max-width:600px;margin-top:60px;">
    <h3>Request Content Modification</h3>
    <?= $message ?>
    <form method="post">
        <div class="form-group">
            <label>Action</label>
            <select name="action" class="form-control" required>
                <option value="delete">Delete</option>
                <option value="update">Update</option>
                <option value="other">Other</option>
            </select>
        </div>
        <div class="form-group">
            <label>Details and Rationale</label>
            <textarea name="details" class="form-control" rows="5" required></textarea>
        </div>
        <button class="btn btn-primary" type="submit">Submit Request</button>
    </form>
</div>
</body>
</html>
