<?php
session_start();
include "database.php";
if(!isset($_SESSION['instructorloggedin']) || $_SESSION['instructorloggedin'] !== true){
    header('Location: instructorlogin.php');
    exit;
}

$message = "";
if($_SERVER['REQUEST_METHOD'] === 'POST'){
    $action = trim($_POST['action'] ?? '');
    $target_type = trim($_POST['target_type'] ?? '');
    $target_id = intval($_POST['target_id'] ?? 0);
    $rationale = trim($_POST['rationale'] ?? '');
    if($action && $target_type && $rationale){
        $stmt = $conn->prepare("INSERT INTO change_requests (instructor_email,action,target_type,target_id,rationale,created_at) VALUES (?,?,?,?,?,NOW())");
        $stmt->bind_param('sssds',$_SESSION['email'],$action,$target_type,$target_id,$rationale);
        if($stmt->execute()){
            $message = "<p class='text-success'>Request submitted for admin approval.</p>";
            $log = date('c')." Instructor {$_SESSION['email']} submitted request {$conn->insert_id}\n";
            file_put_contents('request_logs.log',$log,FILE_APPEND);
        }else{
            $message = "<p class='text-danger'>Error: ".$conn->error."</p>";
        }
    }else{
        $message = "<p class='text-danger'>All fields required.</p>";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Request</title>
    <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Modification Request</h2>
    <?php echo $message; ?>
    <form method="post">
        <div class="form-group">
            <label>Action</label>
            <select name="action" class="form-control" required>
                <option value="delete">Delete</option>
                <option value="update">Update</option>
                <option value="create">Create</option>
            </select>
        </div>
        <div class="form-group">
            <label>Target Type</label>
            <input type="text" name="target_type" class="form-control" placeholder="quiz/question" required>
        </div>
        <div class="form-group">
            <label>Target ID (optional)</label>
            <input type="number" name="target_id" class="form-control" value="0">
        </div>
        <div class="form-group">
            <label>Rationale</label>
            <textarea name="rationale" class="form-control" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Request</button>
    </form>
</div>
</body>
</html>
