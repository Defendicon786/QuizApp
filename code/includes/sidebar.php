<?php
$logout = isset($_SESSION['studentloggedin']) ? 'studentlogout.php' : 'instructorlogout.php';
?>
<aside class="sidebar">
    <button class="toggle-sidebar close-sidebar"><i class="fas fa-times"></i></button>
    <div class="logo"><span>QuizApp</span></div>
    <ul>
        <li><a href="manage_classes_subjects.php"><i class="fas fa-book"></i><span>Manage Classes &amp; Subjects</span></a></li>
        <li><a href="questionfeed.php"><i class="fas fa-upload"></i><span>Feed Questions</span></a></li>
        <li><a href="view_questions.php"><i class="fas fa-database"></i><span>Questions Bank</span></a></li>
        <li><a href="quizconfig.php"><i class="fas fa-cog"></i><span>Set Quiz</span></a></li>
        <li><a href="manage_quizzes.php"><i class="fas fa-tasks"></i><span>Manage Quizzes</span></a></li>
        <li><a href="view_quiz_results.php"><i class="fas fa-chart-bar"></i><span>View Results</span></a></li>
        <li><a href="manage_instructors.php"><i class="fas fa-user-tie"></i><span>Manage Instructors</span></a></li>
        <li><a href="manage_students.php"><i class="fas fa-user-graduate"></i><span>Manage Students</span></a></li>
        <li><a href="manage_notifications.php"><i class="fas fa-bell"></i><span>Manage Notifications</span></a></li>
        <li><a href="my_profile.php"><i class="fas fa-user"></i><span>My Profile</span></a></li>
        <li><a href="<?php echo $logout; ?>"><i class="fas fa-sign-out-alt"></i><span>Log Out</span></a></li>
    </ul>
    <footer class="sidebar-footer">&copy; <?php echo date('Y'); ?> QuizApp</footer>
</aside>
