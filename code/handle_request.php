<?php
session_start();
include "database.php";
if(!isset($_SESSION['adminloggedin']) || $_SESSION['adminloggedin'] !== true){
    header('Location: admin_login.php');
    exit;
}

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    $request_id = intval($_POST['request_id'] ?? 0);
    $decision = $_POST['decision'] ?? '';
    if($request_id > 0 && in_array($decision,['approved','denied'])){
        $stmt = $conn->prepare("UPDATE change_requests SET status=?, admin_id=?, decision_at=NOW() WHERE id=?");
        $stmt->bind_param('sii',$decision,$_SESSION['admin_id'],$request_id);
        if($stmt->execute()){
            $log = date('c')." Admin {$_SESSION['admin_id']} {$decision} request {$request_id}\n";
            file_put_contents('request_logs.log',$log,FILE_APPEND);
        }
    }
}
header('Location: view_requests.php');
exit;
