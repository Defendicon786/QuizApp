<?php
/**
 * Minimal autoloader for environments without Composer.
 * Loads classes from the project's lib directory.
 */
spl_autoload_register(function ($class) {
    $baseDir = __DIR__ . '/../lib/';
    $file = $baseDir . str_replace('\\', '/', $class) . '.php';
    if (file_exists($file)) {
        require $file;
    }
});
