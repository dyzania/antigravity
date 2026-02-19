<?php
require_once __DIR__ . '/config/config.php';

echo "PHP Timezone: " . date_default_timezone_set('Asia/Manila') . " (Force Set Result)\n";
echo "Current PHP Time: " . date('Y-m-d H:i:s') . "\n";
echo "Current PHP Timestamp: " . time() . "\n";

try {
    $db = Database::getInstance()->getConnection();
    $stmt = $db->query("SELECT NOW() as now, @@session.time_zone as session_tz, @@global.time_zone as global_tz");
    $dbTime = $stmt->fetch();
    echo "DB Time (NOW()): " . $dbTime['now'] . "\n";
    echo "DB Session TZ: " . $dbTime['session_tz'] . "\n";
    echo "DB Global TZ: " . $dbTime['global_tz'] . "\n";
    
    $testExpiry = date('Y-m-d H:i:s', strtotime('+15 minutes'));
    echo "Test Expiry (+15m): " . $testExpiry . "\n";
    echo "strtotime(Test Expiry): " . strtotime($testExpiry) . "\n";
    echo "Comparison (strtotime > time): " . (strtotime($testExpiry) > time() ? "VALID" : "EXPIRED") . "\n";
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
