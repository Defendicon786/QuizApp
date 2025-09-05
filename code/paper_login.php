<?php
session_start();

if (isset($_SESSION['paperloggedin']) && $_SESSION['paperloggedin'] === true) {
    header('Location: paper_home.php');
    exit;
}

$login_error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    include 'database.php';
    $email = trim($_POST['email'] ?? '');
    $password = trim($_POST['password'] ?? '');
    if ($email !== '' && $password !== '') {
        $stmt = $conn->prepare('SELECT id, name, password, logo, header, activated_on, expires_on, is_active FROM paper_users WHERE email = ? AND password = ?');
        if ($stmt) {
            $stmt->bind_param('ss', $email, $password);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($user = $result->fetch_assoc()) {
                $today = date('Y-m-d');
                if ((!empty($user['activated_on']) && $today < $user['activated_on']) ||
                    (!empty($user['expires_on']) && $today > $user['expires_on']) ||
                    !$user['is_active']) {
                    $login_error = 'Account inactive. Please contact administrator.';
                } else {
                    $_SESSION['paperloggedin'] = true;
                    $_SESSION['paper_user_id'] = $user['id'];
                    $_SESSION['paper_logo'] = $user['logo'];
                    $_SESSION['paper_header'] = $user['header'];
                    header('Location: paper_home.php');
                    exit;
                }
            } else {
                $login_error = 'Invalid credentials';
            }
            $stmt->close();
        }
        $conn->close();
    } else {
        $login_error = 'Please enter email and password';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Paper Generator Login</title>
</head>
<body>
    <h2>Paper Generator Login</h2>
    <?php if ($login_error) echo '<p style="color:red;">' . htmlspecialchars($login_error) . '</p>'; ?>
    <form method="post">
        <label>Email: <input type="email" name="email" required></label><br>
        <label>Password: <input type="password" name="password" required></label><br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
