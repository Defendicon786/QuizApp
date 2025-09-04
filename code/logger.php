<?php
use Monolog\Logger;
use Monolog\Handler\RotatingFileHandler;

$autoload = __DIR__ . '/vendor/autoload.php';
if (file_exists($autoload)) {
    require_once $autoload;
}

$logDir = __DIR__ . '/logs';
if (!is_dir($logDir)) {
    mkdir($logDir, 0777, true);
}

$env = $_ENV['APP_ENV'] ?? 'production';
$levelName = $_ENV['LOG_LEVEL'] ?? ($env === 'production' ? 'WARNING' : 'DEBUG');
$level = Logger::toMonologLevel($levelName);
if ($env === 'production' && $level < Logger::WARNING) {
    $level = Logger::WARNING;
}

$handler = new RotatingFileHandler($logDir . '/app.log', 30, $level, true);
$handler->setFilenameFormat('{date}-{filename}', 'Y-m-d');

$logger = new Logger('quizapp');
$logger->pushHandler($handler);
