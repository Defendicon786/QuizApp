<?php
  session_start();
  if(!isset($_SESSION["instructorloggedin"]) || $_SESSION["instructorloggedin"] !== true){
      header("location: instructorlogin.php");
      exit;
  }
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>Studyht quiz system - Instructor Portal</title>
  <meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,700|Material+Icons" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="./assets/css/sidebar.css" rel="stylesheet" />
  <style>
    .intro-text {
      text-align: center;
      margin-top: 2rem;
    }
    .intro-text h1,
    .intro-text p {
      margin-bottom: 0.5rem;
    }
    .credits {
      text-align: center;
      position: fixed;
      bottom: 1rem;
      width: 100%;
    }
    .credits p {
      margin: 0;
    }
    @media (max-width: 600px) {
      .intro-text h1 {
        font-size: 5vw;
      }
      .intro-text p {
        font-size: 4vw;
      }
      .credits p {
        font-size: 4vw;
        white-space: nowrap;
      }
      .intro-text h1,
      .intro-text p {
        white-space: nowrap;
      }
    }
  </style>
</head>
<body>
<div class="layout">
  <?php include './includes/sidebar.php'; ?>
  <div class="main">
    <?php include './includes/header.php'; ?>
    <main class="content intro-text">
      <h1>Welcome to the Instructor Portal</h1>
      <p>Use the menu to manage classes, questions, and quizzes.</p>
    </main>
  </div>
</div>
<footer class="credits">
  <p>Narowal Public School and College</p>
  <p>Developed and Maintained by Sir Hassan Tariq</p>
</footer>
<script src="./assets/js/sidebar.js"></script>
</body>
</html>
