<?php
session_start();
include "database.php";

// Allow registration only if no admin exists or current session is admin
$admin_check = $conn->query("SELECT id FROM admininfo LIMIT 1");
$allow_register = ($admin_check && $admin_check->num_rows == 0) || (isset($_SESSION['adminloggedin']) && $_SESSION['adminloggedin'] === true);

if(!$allow_register){
    echo "<p>Registration disabled. Admin already exists.</p>";
    exit;
}

$message = "";
if($_SERVER['REQUEST_METHOD'] === 'POST'){
    $email = trim($_POST['email'] ?? '');
    $password = trim($_POST['password'] ?? '');
    if(filter_var($email, FILTER_VALIDATE_EMAIL) && !empty($password)){
        $secret = bin2hex(random_bytes(10));
        $hash = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $conn->prepare("INSERT INTO admininfo (email,password_hash,otp_secret) VALUES (?,?,?)");
        $stmt->bind_param('sss',$email,$hash,$secret);
        if($stmt->execute()){
            $message = "<p class='text-success'>Admin account created. Save this OTP secret for your authenticator app: <strong>".htmlspecialchars($secret)."</strong></p>";
        }else{
            $message = "<p class='text-danger'>Error: ".$conn->error."</p>";
        }
    }else{
        $message = "<p class='text-danger'>Invalid input.</p>";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Register Admin</title>
    <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Create Admin Account</h2>
    <?php echo $message; ?>
    <form method="post">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Register</button>
    </form>
</div>
</body>
</html>
