<?php
$logoutLink = '';
$userName = 'Guest';
if (isset($_SESSION['studentloggedin'])) {
    $logoutLink = 'studentlogout.php';
    if (isset($_SESSION['name'])) {
        $userName = $_SESSION['name'];
    }
} elseif (isset($_SESSION['instructorloggedin'])) {
    $logoutLink = 'instructorlogout.php';
    if (isset($_SESSION['email'])) {
        $userName = $_SESSION['email'];
    }
} elseif (isset($_SESSION['paperloggedin'])) {
    $logoutLink = 'paper_logout.php';
    if (isset($_SESSION['paper_user_name'])) {
        $userName = $_SESSION['paper_user_name'];
    } else {
        $userName = 'Paper User';
    }
} else {
    $logoutLink = 'studentlogin.php';
}
?>
<header class="header">
    <button class="toggle-sidebar" type="button"><i class="fas fa-bars"></i></button>
    <div class="user-info">
        <img src="./assets/img/profile.jpg" alt="Profile">
        <span><?php echo htmlspecialchars($userName); ?></span>
        <a class="logout-btn" href="<?php echo $logoutLink; ?>">
            <?php echo (isset($_SESSION['studentloggedin']) || isset($_SESSION['instructorloggedin']) || isset($_SESSION['paperloggedin'])) ? 'Logout' : 'Login'; ?>
        </a>
    </div>
</header>
