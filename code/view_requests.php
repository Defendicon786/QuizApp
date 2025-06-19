<?php
session_start();
include "database.php";
if(!isset($_SESSION['adminloggedin']) || $_SESSION['adminloggedin'] !== true){
    header('Location: admin_login.php');
    exit;
}

$requests = $conn->query("SELECT * FROM change_requests ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Requests</title>
    <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Change Requests</h2>
    <table class="table table-bordered">
        <thead><tr><th>ID</th><th>Instructor</th><th>Action</th><th>Target</th><th>Rationale</th><th>Status</th><th>Decision</th></tr></thead>
        <tbody>
        <?php while($row = $requests->fetch_assoc()): ?>
            <tr>
                <td><?php echo $row['id']; ?></td>
                <td><?php echo htmlspecialchars($row['instructor_email']); ?></td>
                <td><?php echo htmlspecialchars($row['action']); ?></td>
                <td><?php echo htmlspecialchars($row['target_type'].' #'.$row['target_id']); ?></td>
                <td><?php echo htmlspecialchars($row['rationale']); ?></td>
                <td><?php echo htmlspecialchars($row['status']); ?></td>
                <td>
                    <?php if($row['status']=='pending'): ?>
                        <form method="post" action="handle_request.php" style="display:inline-block;">
                            <input type="hidden" name="request_id" value="<?php echo $row['id']; ?>">
                            <button class="btn btn-success" name="decision" value="approved">Approve</button>
                        </form>
                        <form method="post" action="handle_request.php" style="display:inline-block;">
                            <input type="hidden" name="request_id" value="<?php echo $row['id']; ?>">
                            <button class="btn btn-danger" name="decision" value="denied">Deny</button>
                        </form>
                    <?php else: ?>
                        <?php echo htmlspecialchars($row['status']); ?> on <?php echo $row['decision_at']; ?>
                    <?php endif; ?>
                </td>
            </tr>
        <?php endwhile; ?>
        </tbody>
    </table>
</div>
</body>
</html>
