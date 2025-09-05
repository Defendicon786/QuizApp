<?php
session_start();
if (!isset($_SESSION['paperloggedin']) || $_SESSION['paperloggedin'] !== true) {
    header('Location: paper_login.php');
    exit;
}
include 'database.php';
$classes = $conn->query("SELECT class_id, class_name FROM classes ORDER BY class_name");
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
                                    <label class="bmd-label-floating">Select Class</label>
                                    <select name="class_id" id="class_id" class="form-control" required>
                                        <option value="">Select Class</option>
                                        <?php while($row = $classes->fetch_assoc()) { echo '<option value="'.$row['class_id'].'">'.htmlspecialchars($row['class_name']).'</option>'; } ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Select Subject</label>
                                    <select name="subject_id" id="subject_id" class="form-control" required>
                                        <option value="">Select Subject</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Select Chapter</label>
                                    <select name="chapter_id" id="chapter_id" class="form-control" required>
                                        <option value="">Select Chapter</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Select Topic</label>
                                    <select name="topic_id" id="topic_id" class="form-control">
                                        <option value="">Select Topic</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">MCQs</label>
                                    <input type="number" name="mcq" value="0" min="0" class="form-control">
                                    <small class="form-text text-muted">Available: <span id="mcq-count">0</span></small>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Short Questions</label>
                                    <input type="number" name="short" value="0" min="0" class="form-control">
                                    <small class="form-text text-muted">Available: <span id="short-count">0</span></small>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Long Questions</label>
                                    <input type="number" name="essay" value="0" min="0" class="form-control">
                                    <small class="form-text text-muted">Available: <span id="essay-count">0</span></small>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Fill in the Blanks</label>
                                    <input type="number" name="fill" value="0" min="0" class="form-control">
                                    <small class="form-text text-muted">Available: <span id="fill-count">0</span></small>
                                </div>
                                <div class="form-group">
                                    <label class="bmd-label-floating">Numerical</label>
                                    <input type="number" name="numerical" value="0" min="0" class="form-control">
                                    <small class="form-text text-muted">Available: <span id="numerical-count">0</span></small>
                                </div>
                                <div class="form-group" id="manual-select-wrapper" style="display:none;">
                                    <button type="button" id="manual-select" class="btn btn-secondary">Manual Selection</button>
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
<script>
document.addEventListener('DOMContentLoaded', function() {
    const classSelect = document.getElementById('class_id');
    const subjectSelect = document.getElementById('subject_id');
    const chapterSelect = document.getElementById('chapter_id');
    const topicSelect = document.getElementById('topic_id');
    const manualBtn = document.getElementById('manual-select');
    const manualWrapper = document.getElementById('manual-select-wrapper');
    const counts = {
        mcq: document.getElementById('mcq-count'),
        short: document.getElementById('short-count'),
        essay: document.getElementById('essay-count'),
        fill: document.getElementById('fill-count'),
        numerical: document.getElementById('numerical-count')
    };

    classSelect.addEventListener('change', function() {
        const classId = this.value;
        subjectSelect.innerHTML = '<option value="">Select Subject</option>';
        chapterSelect.innerHTML = '<option value="">Select Chapter</option>';
        topicSelect.innerHTML = '<option value="">Select Topic</option>';
        if (!classId) return;
        fetch('get_subjects.php?class_id=' + classId)
            .then(r => r.json())
            .then(data => {
                data.forEach(s => {
                    subjectSelect.insertAdjacentHTML('beforeend', `<option value="${s.subject_id}">${s.subject_name}</option>`);
                });
            });
    });

    subjectSelect.addEventListener('change', function() {
        const classId = classSelect.value;
        const subjectId = this.value;
        chapterSelect.innerHTML = '<option value="">Select Chapter</option>';
        topicSelect.innerHTML = '<option value="">Select Topic</option>';
        if (!classId || !subjectId) return;
        fetch(`get_chapters.php?class_id=${classId}&subject_id=${subjectId}`)
            .then(r => r.json())
            .then(data => {
                if (Array.isArray(data)) {
                    data.forEach(c => {
                        chapterSelect.insertAdjacentHTML('beforeend', `<option value="${c.chapter_id}">${c.chapter_name}</option>`);
                    });
                }
            });
    });

    chapterSelect.addEventListener('change', function() {
        const chapterId = this.value;
        topicSelect.innerHTML = '<option value="">Select Topic</option>';
        if (!chapterId) return;
        fetch('get_topics.php?chapter_id=' + chapterId)
            .then(r => r.json())
            .then(data => {
                data.forEach(t => {
                    topicSelect.insertAdjacentHTML('beforeend', `<option value="${t.topic_id}">${t.topic_name}</option>`);
                });
            });
    });

    function updateCounts() {
        const chapterId = chapterSelect.value;
        const topicId = topicSelect.value;
        manualWrapper.style.display = topicId ? 'block' : 'none';
        if (!chapterId) return;
        let url = `get_question_counts.php?chapter_ids=${chapterId}`;
        if (topicId) url += `&topic_ids=${topicId}`;
        fetch(url)
            .then(r => r.json())
            .then(data => {
                counts.mcq.textContent = data.mcq || 0;
                counts.short.textContent = data.short || 0;
                counts.essay.textContent = data.essay || 0;
                counts.fill.textContent = data.fillblanks || 0;
                counts.numerical.textContent = data.numerical || 0;
            });
    }

    topicSelect.addEventListener('change', updateCounts);
    chapterSelect.addEventListener('change', updateCounts);

    manualBtn.addEventListener('click', function() {
        const params = new URLSearchParams({
            filter_class: classSelect.value,
            filter_subject: subjectSelect.value,
            filter_chapter: chapterSelect.value,
            filter_topic: topicSelect.value
        });
        window.location.href = 'view_questions.php?' + params.toString();
    });
});
</script>
</body>
</html>
