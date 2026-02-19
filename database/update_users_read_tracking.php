<?php
require_once __DIR__ . '/../config/config.php';

try {
    $db = Database::getInstance()->getConnection();
    
    // Add last_read_announcement_id column to users table
    $db->exec("ALTER TABLE users ADD COLUMN last_read_announcement_id INT DEFAULT 0");
    
    echo "Successfully added last_read_announcement_id column to users table.\n";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
