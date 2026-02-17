<?php
require_once 'config/config.php';
$db = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);

echo "PHP Time: " . date('Y-m-d H:i:s') . " (Epoch: " . time() . ")\n";
echo "Config Timezone: " . date_default_timezone_get() . "\n\n";

$stmt = $db->query("SELECT id, ticket_number, status, served_at, service_id FROM tickets WHERE status = 'serving' LIMIT 1");
$ticket = $stmt->fetch(PDO::FETCH_ASSOC);

if ($ticket) {
    echo "Active Ticket: " . $ticket['ticket_number'] . "\n";
    echo "Served At: " . $ticket['served_at'] . " (Epoch: " . strtotime($ticket['served_at']) . ")\n";
    $elapsed = time() - strtotime($ticket['served_at']);
    echo "Elapsed Seconds: " . $elapsed . "s\n";
    
    $stmt = $db->prepare("SELECT target_time FROM services WHERE id = ?");
    $stmt->execute([$ticket['service_id']]);
    $svc = $stmt->fetch();
    $totalEst = $svc['target_time'] * 60;
    $remaining = max(0, $totalEst - $elapsed);
    echo "Service Est: " . $totalEst . "s\n";
    echo "Remaining Calculation: " . $remaining . "s\n";
} else {
    echo "No serving tickets found to debug.\n";
}
?>
