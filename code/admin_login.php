<?php
session_start();
include "database.php";

function verify_totp($secret, $code){
    $timeSlice = floor(time() / 30);
    $codeInt = intval($code);
    for($i=-1; $i<=1; $i++){
        $slice = pack('N*', 0) . pack('N*', $timeSlice + $i);
        $hash = hash_hmac('sha1', $slice, $secret, true);
        $offset = ord(substr($hash, -1)) & 0x0F;
        $truncated = ((ord($hash[$offset]) & 0x7F) << 24) |
                     ((ord($hash[$offset+1]) & 0xFF) << 16) |
                     ((ord($hash[$offset+2]) & 0xFF) << 8) |
                     (ord($hash[$offset+3]) & 0xFF);
        $otp = $truncated % 1000000;
        if($otp === $codeInt){
            return true;
        }
    }
    return false;
}

$message = "";
if($_SERVER['REQUEST_METHOD'] === 'POST'){
    $email = trim($_POST['email'] ?? '');
    $password = trim($_POST['password'] ?? '');
    $otp = trim($_POST['otp'] ?? '');
    if(filter_var($email, FILTER_VALIDATE_EMAIL) && !empty($password) && ctype_digit($otp)){
        $stmt = $conn->prepare("SELECT id,password_hash,otp_secret FROM admininfo WHERE email=?");
        $stmt->bind_param('s',$email);
        $stmt->execute();
        $result = $stmt->get_result();
        if($result && $result->num_rows === 1){
            $row = $result->fetch_assoc();
            if(password_verify($password, $row['password_hash']) && verify_totp($row['otp_secret'], $otp)){
                $_SESSION['adminloggedin'] = true;
                $_SESSION['admin_id'] = $row['id'];
                header('Location: view_requests.php');
                exit;
            }else{
                $message = "<p class='text-danger'>Invalid credentials or OTP.</p>";
            }
        }else{
            $message = "<p class='text-danger'>Admin not found.</p>";
        }
    }else{
        $message = "<p class='text-danger'>Invalid input.</p>";
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Admin Login</h2>
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
        <div class="form-group">
            <label>OTP</label>
            <input type="text" name="otp" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
</div>
</body>
</html>
