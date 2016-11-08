# File latendy monitor


if (count($argv) < 2) {
    fwrite(STDERR, “Usage: %s <file to listen>\n”);
    exit 1;
}

php -r "file_put_content($argv[1], round(microtime(true) * 1000));"
exec('monitor out');
