<?php
session_start();
if(!isset($_SESSION['adminloggedin']) || $_SESSION['adminloggedin'] !== true) {
    header('Location: adminlogin.php');
    exit;
}
include 'database.php';

// Handle approve/deny
if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['request_id'], $_POST['action'])) {
    $id = (int)$_POST['request_id'];
    $action = ($_POST['action'] === 'approve') ? 'approved' : 'denied';
    $comment = $conn->real_escape_string(trim($_POST['comment'] ?? ''));
    $update = sprintf("UPDATE instructor_requests SET status='%s', admin_comment='%s', decision_at=NOW() WHERE id=%d", $action, $comment, $id);
    $conn->query($update);
    $log = sprintf("%s - Admin %d %s request %d\n", date('c'), $_SESSION['admin_id'], $action, $id);
    file_put_contents('../request_audit.log', $log, FILE_APPEND);
}

$pending = $conn->query("SELECT * FROM instructor_requests WHERE status='pending' ORDER BY created_at ASC");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="assets/css/modern.css">
</head>
<body>
<div class="container" style="margin-top:60px;">
    <h3>Pending Instructor Requests</h3>
    <?php if($pending && $pending->num_rows > 0): ?>
    <table class="table">
        <thead><tr><th>ID</th><th>Instructor</th><th>Action</th><th>Details</th><th>Submitted</th><th>Decision</th></tr></thead>
        <tbody>
        <?php while($row = $pending->fetch_assoc()): ?>
        <tr>
            <td><?= $row['id'] ?></td>
            <td><?= htmlspecialchars($row['instructor_email']) ?></td>
            <td><?= htmlspecialchars($row['action']) ?></td>
            <td><?= nl2br(htmlspecialchars($row['details'])) ?></td>
            <td><?= $row['created_at'] ?></td>
            <td>
                <form method="post" style="display:inline-block;">
                    <input type="hidden" name="request_id" value="<?= $row['id'] ?>">
                    <input type="hidden" name="action" value="approve">
                    <input type="text" name="comment" placeholder="Comment" class="form-control mb-2">
                    <button class="btn btn-success btn-sm" type="submit">Approve</button>
                </form>
                <form method="post" style="display:inline-block;">
                    <input type="hidden" name="request_id" value="<?= $row['id'] ?>">
                    <input type="hidden" name="action" value="deny">
                    <button class="btn btn-danger btn-sm" type="submit">Deny</button>
                </form>
            </td>
        </tr>
        <?php endwhile; ?>
        </tbody>
    </table>
    <?php else: ?>
    <p>No pending requests.</p>
    <?php endif; ?>
</div>
</body>
</html>
