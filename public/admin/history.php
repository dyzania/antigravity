<?php
$pageTitle = 'Ticket History';
require_once __DIR__ . '/../../models/Ticket.php';
include __DIR__ . '/../../includes/admin-layout-header.php';

$ticketModel = new Ticket();

$startDate = $_GET['start_date'] ?? null;
$endDate = $_GET['end_date'] ?? null;

$history = $ticketModel->getGlobalHistory($startDate, $endDate);
?>

<div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
            <p class="text-[10px] font-black uppercase tracking-[0.3em] text-primary-600 mb-1">Logs & Archive</p>
            <h1 class="text-2xl font-black text-gray-900 font-heading tracking-tight">Ticket History</h1>
        </div>
        
        <!-- Filters -->
        <form method="GET" class="bg-white p-3 rounded-xl shadow-sm border border-slate-100 flex flex-wrap items-center gap-3">
            <div class="flex flex-col">
                <label class="text-[10px] font-black uppercase text-gray-400 mb-1 ml-1">Start Date</label>
                <input type="date" name="start_date" value="<?php echo $startDate; ?>" 
                       class="bg-slate-50 border-none rounded-lg text-xs font-bold focus:ring-primary-500 py-1.5 px-3">
            </div>
            <div class="flex flex-col">
                <label class="text-[10px] font-black uppercase text-gray-400 mb-1 ml-1">End Date</label>
                <input type="date" name="end_date" value="<?php echo $endDate; ?>"
                       class="bg-slate-50 border-none rounded-lg text-xs font-bold focus:ring-primary-500 py-1.5 px-3">
            </div>
            <div class="flex items-end h-full mt-4">
                <button type="submit" class="px-4 py-2 bg-primary-600 text-white rounded-lg font-bold hover:bg-primary-700 transition-all shadow-lg shadow-primary-900/20 text-xs">
                    <i class="fas fa-filter mr-2"></i>Filter
                </button>
                <?php if ($startDate || $endDate): ?>
                    <a href="history.php" class="ml-2 px-4 py-2 bg-slate-100 text-gray-600 rounded-lg font-bold hover:bg-slate-200 transition-all text-xs">
                        Clear
                    </a>
                <?php endif; ?>
            </div>
        </form>
    </div>

    <!-- Table Card -->
    <div class="bg-white rounded-2xl shadow-xl shadow-slate-300/50 border border-slate-300 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="border-b border-slate-200 bg-slate-100">
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Ticket</th>
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Customer</th>
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Service</th>
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Window</th>
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Notes</th>
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Proc. Time</th>
                        <th class="px-4 py-3 text-[10px] font-black uppercase tracking-widest text-slate-500 text-center">Completed At</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-200">
                    <?php if (empty($history)): ?>
                        <tr>
                            <td colspan="8" class="px-4 py-8 text-center text-slate-400 font-medium text-xs">
                                No tickets found for this period.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($history as $ticket): ?>
                            <tr class="hover:bg-slate-50/50 transition-colors">
                                <td class="px-4 py-3 text-center">
                                    <span class="font-black text-slate-900 text-xs"><?php echo $ticket['ticket_number']; ?></span>
                                </td>
                                <td class="px-4 py-3 text-center">
                                    <div class="flex items-center justify-center space-x-2">
                                        <div class="w-6 h-6 rounded bg-slate-100 flex items-center justify-center text-slate-500 font-bold text-[10px] uppercase">
                                            <?php echo substr($ticket['user_name'], 0, 2); ?>
                                        </div>
                                        <span class="font-bold text-slate-700 text-xs"><?php echo $ticket['user_name']; ?></span>
                                    </div>
                                </td>
                                <td class="px-4 py-3 text-center">
                                    <span class="px-2 py-0.5 bg-primary-50 text-primary-600 rounded-md text-[10px] font-black uppercase tracking-wider border border-primary-100">
                                        <?php echo $ticket['service_name']; ?>
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-center">
                                    <span class="font-bold text-slate-600 text-xs">
                                        <?php echo $ticket['window_name'] ? "W-{$ticket['window_number']}" : '-'; ?>
                                    </span>
                                </td>
                                <td class="px-4 py-3 text-center">
                                    <?php if ($ticket['staff_notes']): ?>
                                        <div class="max-w-[150px] mx-auto text-[10px] font-medium text-slate-500 truncate" title="<?php echo htmlspecialchars($ticket['staff_notes']); ?>">
                                            "<?php echo $ticket['staff_notes']; ?>"
                                        </div>
                                    <?php else: ?>
                                        <span class="text-slate-300 text-[10px]">-</span>
                                    <?php endif; ?>
                                </td>
                                <td class="px-4 py-3 font-bold text-slate-500 text-xs text-center">
                                    <?php echo $ticket['processing_time']; ?>
                                </td>
                                <td class="px-4 py-3 text-center">
                                    <div class="text-xs font-bold text-slate-900">
                                        <?php echo date('M d', strtotime($ticket['created_at'])); ?>
                                    </div>
                                    <div class="text-[9px] font-black text-slate-400 uppercase tracking-widest">
                                        <?php echo date('h:i A', strtotime($ticket['created_at'])); ?>
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php include __DIR__ . '/../../includes/admin-layout-footer.php'; ?>
