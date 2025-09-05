<?php
session_start();
if (!isset($_SESSION['paperloggedin']) || $_SESSION['paperloggedin'] !== true) {
    header('Location: paper_login.php');
    exit;
}
include 'database.php';
$subjects = $conn->query("SELECT subject_id, subject_name FROM subjects ORDER BY subject_name");
$chapters = $conn->query("SELECT chapter_id, chapter_name FROM chapters ORDER BY chapter_name");
$topics   = $conn->query("SELECT topic_id, topic_name FROM topics ORDER BY topic_name");
$conn->close();
$logo = $_SESSION['paper_logo'];
$header = $_SESSION['paper_header'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="./assets/img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Generate Paper</title>
    <meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="./assets/css/material-kit.css?v=2.0.4" rel="stylesheet" />
    <link href="./assets/css/modern.css" rel="stylesheet" />
    <style>
        html, body { height: 100%; }
        body { display: flex; flex-direction: column; min-height: 100vh; margin: 0; }
        .page-header {
            background: linear-gradient(45deg, rgba(0,0,0,0.7), rgba(72,72,176,0.7)),
                        url('./assets/img/bg.jpg') center center;
            background-size: cover;
            margin: 0;
            padding: 0;
            border: 0;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            flex: 1 0 auto;
        }
        .card { margin-top: 20px; }
        .card .card-header-primary {
            background: linear-gradient(60deg, #ab47bc, #8e24aa);
            box-shadow: 0 5px 20px 0px rgba(0, 0, 0, 0.2),
                       0 13px 24px -11px rgba(156, 39, 176, 0.6);
            margin: -20px 20px 15px;
            border-radius: 3px;
            padding: 15px;
        }
        .card-header-primary .card-title { color: #fff; margin: 0; }
        .btn { width: 100%; }
    </style>
</head>
<body>
    <div class="page-header header-filter">
        <div class="container">
            <?php if ($logo) { echo '<div class="text-center"><img src="' . htmlspecialchars($logo) . '" height="80"></div>'; } ?>
            <h2 class="text-center text-white"><?php echo htmlspecialchars($header); ?></h2>
            <div class="row">
                <div class="col-md-6 ml-auto mr-auto">
                    <div class="card">
                        <form method="post" action="generate_paper.php">
                            <div class="card-header card-header-primary text-center">
                                <h4 class="card-title">Generate Paper</h4>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Paper Name</label>
                                    <input type="text" name="paper_name" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Select Subject</label>
                                    <select name="subject_id" class="form-control">
                                        <?php while($row = $subjects->fetch_assoc()) { echo '<option value="'.$row['subject_id'].'">'.htmlspecialchars($row['subject_name']).'</option>'; } ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Select Chapter</label>
                                    <select name="chapter_id" class="form-control">
                                        <?php while($row = $chapters->fetch_assoc()) { echo '<option value="'.$row['chapter_id'].'">'.htmlspecialchars($row['chapter_name']).'</option>'; } ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Select Topic</label>
                                    <select name="topic_id" class="form-control">
                                        <option value="">Any</option>
                                        <?php while($row = $topics->fetch_assoc()) { echo '<option value="'.$row['topic_id'].'">'.htmlspecialchars($row['topic_name']).'</option>'; } ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">MCQs</label>
                                    <input type="number" name="mcq" value="0" min="0" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Short Questions</label>
                                    <input type="number" name="short" value="0" min="0" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Long Questions</label>
                                    <input type="number" name="essay" value="0" min="0" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Fill in the Blanks</label>
                                    <input type="number" name="fill" value="0" min="0" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Numerical</label>
                                    <input type="number" name="numerical" value="0" min="0" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Date (optional)</label>
                                    <input type="date" name="paper_date" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Selection Mode</label><br>
                                    <div class="form-check form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="mode" value="random" checked> Random
                                            <span class="circle"><span class="check"></span></span>
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="mode" value="manual"> Manual
                                            <span class="circle"><span class="check"></span></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="footer text-center">
                                <button type="submit" class="btn btn-primary btn-lg">Generate Paper</button>
                                <a href="paper_logout.php" class="btn btn-default btn-lg">Logout</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
