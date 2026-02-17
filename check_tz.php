<?php
require_once 'config/config.php';
$db = Database::getInstance()->getConnection();

echo "PHP Time: " . date('Y-m-d H:i:s') . "\n";
$stmt = $db->query("SELECT NOW() as db_now, @@session.time_zone as session_tz, @@global.time_zone as global_tz");
$res = $stmt->fetch();
echo "DB NOW(): " . $res['db_now'] . "\n";
echo "Session TZ: " . $res['session_tz'] . "\n";
echo "Global TZ: " . $res['global_tz'] . "\n";
?>
