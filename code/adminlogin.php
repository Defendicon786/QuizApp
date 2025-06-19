<?php
session_start();
include 'database.php';

function base32_decode_custom($b32) {
    $alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    $b32 = strtoupper($b32);
    $out = '';
    $buffer = 0;
    $bits = 0;
    for ($i = 0; $i < strlen($b32); $i++) {
        $v = strpos($alphabet, $b32[$i]);
        if ($v === false) continue;
        $buffer = ($buffer << 5) | $v;
        $bits += 5;
        if ($bits >= 8) {
            $bits -= 8;
            $out .= chr(($buffer & (0xFF << $bits)) >> $bits);
        }
    }
    return $out;
}

function get_totp($secret, $timeSlice = null) {
    if ($timeSlice === null) {
        $timeSlice = floor(time() / 30);
    }
    $secretKey = base32_decode_custom($secret);
    $time = chr(0).chr(0).chr(0).chr(0).pack('N*', $timeSlice);
    $hmac = hash_hmac('sha1', $time, $secretKey, true);
    $offset = ord($hmac[19]) & 0xf;
    $code = (
        ((ord($hmac[$offset]) & 0x7f) << 24) |
        ((ord($hmac[$offset + 1]) & 0xff) << 16) |
        ((ord($hmac[$offset + 2]) & 0xff) << 8) |
        (ord($hmac[$offset + 3]) & 0xff)
    ) % 1000000;
    return str_pad($code, 6, '0', STR_PAD_LEFT);
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['email'], $_POST['password']) && !isset($_POST['otp'])) {
        $email = $conn->real_escape_string(trim($_POST['email']));
        $password = $conn->real_escape_string(trim($_POST['password']));
        $query = sprintf("SELECT id, otp_secret FROM admininfo WHERE email='%s' AND password='%s'", $email, $password);
        $res = $conn->query($query);
        if ($res && $res->num_rows === 1) {
            $row = $res->fetch_assoc();
            $_SESSION['pending_admin'] = $row['id'];
            $_SESSION['otp_secret'] = $row['otp_secret'];
        } else {
            $error = 'Invalid credentials';
        }
    } elseif (isset($_POST['otp']) && isset($_SESSION['pending_admin'])) {
        $otp = trim($_POST['otp']);
        $code = get_totp($_SESSION['otp_secret']);
        if (hash_equals($code, $otp)) {
            $_SESSION['adminloggedin'] = true;
            $_SESSION['admin_id'] = $_SESSION['pending_admin'];
            unset($_SESSION['pending_admin'], $_SESSION['otp_secret']);
            header('Location: adminhome.php');
            exit;
        } else {
            $error = 'Invalid verification code';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" href="assets/css/modern.css">
</head>
<body>
<div class="container" style="max-width:400px;margin-top:60px;">
    <h3>Admin Login</h3>
    <?php if(!isset($_SESSION['pending_admin'])): ?>
    <form method="post">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
        <?php if($error) echo '<p class="text-danger">'.htmlspecialchars($error).'</p>'; ?>
    </form>
    <?php else: ?>
    <p>A verification code has been generated. Enter it below.</p>
    <form method="post">
        <div class="form-group">
            <label>Verification Code</label>
            <input type="text" name="otp" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Verify</button>
        <?php if($error) echo '<p class="text-danger">'.htmlspecialchars($error).'</p>'; ?>
    </form>
    <?php endif; ?>
</div>
</body>
</html>
