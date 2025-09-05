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
    <meta charset="UTF-8">
    <title>Generate Paper</title>
</head>
<body>
<?php if ($logo) { echo '<div style="text-align:center;"><img src="' . htmlspecialchars($logo) . '" height="80"></div>'; } ?>
<h2 style="text-align:center;"><?php echo htmlspecialchars($header); ?></h2>
<form method="post" action="generate_paper.php">
    <label>Paper Name: <input type="text" name="paper_name" required></label><br>
    <label>Select Subject: <select name="subject_id">
        <?php while($row = $subjects->fetch_assoc()) { echo '<option value="'.$row['subject_id'].'">'.htmlspecialchars($row['subject_name']).'</option>'; } ?>
    </select></label><br>
    <label>Select Chapter: <select name="chapter_id">
        <?php while($row = $chapters->fetch_assoc()) { echo '<option value="'.$row['chapter_id'].'">'.htmlspecialchars($row['chapter_name']).'</option>'; } ?>
    </select></label><br>
    <label>Select Topic: <select name="topic_id">
        <option value="">Any</option>
        <?php while($row = $topics->fetch_assoc()) { echo '<option value="'.$row['topic_id'].'">'.htmlspecialchars($row['topic_name']).'</option>'; } ?>
    </select></label><br>
    <label>MCQs: <input type="number" name="mcq" value="0" min="0"></label><br>
    <label>Short Questions: <input type="number" name="short" value="0" min="0"></label><br>
    <label>Long Questions: <input type="number" name="essay" value="0" min="0"></label><br>
    <label>Fill in the Blanks: <input type="number" name="fill" value="0" min="0"></label><br>
    <label>Numerical: <input type="number" name="numerical" value="0" min="0"></label><br>
    <label>Date (optional): <input type="date" name="paper_date"></label><br>
    <label>Selection Mode:
        <input type="radio" name="mode" value="random" checked> Random
        <input type="radio" name="mode" value="manual"> Manual
    </label><br>
    <button type="submit">Generate Paper</button>
</form>
<a href="paper_logout.php">Logout</a>
</body>
</html>
