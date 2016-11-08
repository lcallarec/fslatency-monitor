#!/usr/bin/env bash
php -r 'file_put_contents("out", "");' && ./monitor out & sleep 1 && php -r 'file_put_contents("out", round(microtime(true) * 1000));'
