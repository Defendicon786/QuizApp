<?php
$home = isset($_SESSION['studentloggedin']) ? 'studenthome.php' : 'instructorhome.php';
$logout = isset($_SESSION['studentloggedin']) ? 'studentlogout.php' : 'instructorlogout.php';
?>
<aside class="sidebar">
    <div class="logo">QuizApp</div>
    <ul>
        <li><a href="<?php echo $home; ?>" class="active"><i class="fas fa-home"></i><span>Dashboard</span></a></li>
        <li><a href="quizhome.php"><i class="fas fa-question-circle"></i><span>Quizzes</span></a></li>
        <li><a href="view_quiz_results.php"><i class="fas fa-chart-bar"></i><span>Results</span></a></li>
        <li><a href="my_profile.php"><i class="fas fa-user"></i><span>Profile</span></a></li>
        <li><a href="<?php echo $logout; ?>"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a></li>
    </ul>
</aside>
