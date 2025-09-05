<?php
session_start();
if (!isset($_SESSION['instructorloggedin']) || $_SESSION['instructorloggedin'] !== true) {
    header('Location: instructorlogin.php');
    exit;
}
include 'database.php';

$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $headerText = trim($_POST['header'] ?? '');
    $logoPath = null;

    if (isset($_FILES['logo']) && $_FILES['logo']['error'] === UPLOAD_ERR_OK) {
        $uploadDir = 'assets/paper_logos/';
        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }
        $ext = pathinfo($_FILES['logo']['name'], PATHINFO_EXTENSION);
        $filename = uniqid('logo_', true) . '.' . $ext;
        $logoPath = $uploadDir . $filename;
        move_uploaded_file($_FILES['logo']['tmp_name'], $logoPath);
    }

    if ($name && $email && $password) {
        $stmt = $conn->prepare('INSERT INTO paper_users (name, email, password, logo, header) VALUES (?, ?, ?, ?, ?)');
        $stmt->bind_param('sssss', $name, $email, $password, $logoPath, $headerText);
        if ($stmt->execute()) {
            $message = '<p class="text-success">User added successfully!</p>';
        } else {
            $message = '<p class="text-danger">Error adding user.</p>';
        }
        $stmt->close();
    } else {
        $message = '<p class="text-danger">Please fill in all required fields.</p>';
    }
}

$users = [];
$res = $conn->query('SELECT name, email FROM paper_users ORDER BY name');
if ($res) {
    while ($row = $res->fetch_assoc()) {
        $users[] = $row;
    }
    $res->free();
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="./assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Manage Paper Users</title>
    <meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="./assets/css/material-kit.css?v=2.0.4" rel="stylesheet" />
    <link href="./assets/css/modern.css" rel="stylesheet" />
</head>
<body>
    <?php include './includes/sidebar.php'; ?>
    <div class="main-content">
        <div class="container mt-5">
            <h2>Manage Paper Generator Users</h2>
            <?php echo $message; ?>
            <form method="post" enctype="multipart/form-data" class="mt-4">
                <div class="form-group">
                    <label class="bmd-label-floating">Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="bmd-label-floating">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="bmd-label-floating">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="bmd-label-floating">Header Text</label>
                    <input type="text" name="header" class="form-control">
                </div>
                <div class="form-group">
                    <label class="bmd-label-floating">Logo</label>
                    <input type="file" name="logo" class="form-control">
                </div>
                <button type="submit" class="btn btn-primary btn-lg">Add User</button>
            </form>
            <h4 class="mt-5">Current Paper Users</h4>
            <ul class="list-group">
                <?php foreach ($users as $row) { echo '<li class="list-group-item">'.htmlspecialchars($row['name']).' ('.htmlspecialchars($row['email']).')</li>'; } ?>
            </ul>
        </div>
    </div>
</body>
</html>
