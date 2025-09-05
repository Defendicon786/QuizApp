<?php
session_start();
session_destroy();
header('Location: paper_login.php');
exit;
?>
