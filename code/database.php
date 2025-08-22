<?php
// Ensure a session is active before using \$_SESSION
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Set PHP default timezone to match your country's timezone
date_default_timezone_set('Asia/Karachi'); // Replace with your timezone

$db_host = 'localhost';
$db_name = 'database';
$db_user = 'username';
$db_pass = 'password';

$conn = null;

// Attempt to create the database connection. Newer versions of PHP throw
// mysqli_sql_exception on connection failure. Catch the exception so that the
// calling script can handle the error and return a clean JSON response.
try {
    $conn = new mysqli($db_host, $db_user, $db_pass, $db_name);
} catch (mysqli_sql_exception $e) {
    error_log('Database Connection Failed: ' . $e->getMessage(), 3, 'quiz_errors.log');
    $conn = null;
}

// If the connection object exists but has an error, log it without producing
// any output that could corrupt API responses.
if ($conn && $conn->connect_error) {
    error_log('Database Connection Failed: ' . $conn->connect_error, 3, 'quiz_errors.log');
}

if ($conn) {
    // Set session timezone to match PHP timezone
    if (!$conn->query("SET time_zone = '+05:00'")) { // Replace +05:00 with your timezone offset
        // Failed to set timezone, log error.
        error_log('Failed to set database session timezone: ' . $conn->error, 3, 'quiz_errors.log');
    }

    // Set session variables for timezone
    $_SESSION['timezone'] = 'Asia/Karachi';
    $_SESSION['timezone_offset'] = '+05:00';
}
