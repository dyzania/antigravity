<?php
session_start();
require_once __DIR__ . '/../../config/config.php';
require_once __DIR__ . '/../../models/Service.php';
require_once __DIR__ . '/../../models/Ticket.php';

requireLogin();
requireRole('user');

$serviceModel = new Service();
$ticketModel = new Ticket();
$db = Database::getInstance()->getConnection();

$services = $serviceModel->getAllServices();
$error = '';
$success = '';

// Check for pending feedback
$hasPendingFeedback = $ticketModel->hasPendingFeedback(getUserId());
// Check for current active ticket
$currentTicket = $ticketModel->getCurrentTicket(getUserId());


if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['service_id'])) {
    $serviceId = intval($_POST['service_id']);
    $userNote = isset($_POST['user_note']) ? trim($_POST['user_note']) : null;
    $result = $ticketModel->createTicket(getUserId(), $serviceId, $userNote);
    
    if ($result['success']) {
        $success = "Ticket created successfully!";
        header('Location: my-ticket.php');
        exit;
    } else {
        $error = $result['message'];
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="<?php echo $_SESSION['csrf_token']; ?>">
    <title>Get Ticket - <?php echo APP_NAME; ?></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <?php injectTailwindConfig(); ?>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        const ANTIGRAVITY_BASE_URL = "<?php echo defined('BASE_URL') ? BASE_URL : ''; ?>";
    </script>
</head>
<body class="min-h-screen">
    <?php include __DIR__ . '/../../includes/user-navbar.php'; ?>

    <main class="container-ultra px-4 md:px-10 py-8 pb-20">
        <div class="mb-12">
            <p class="text-[10px] 3xl:text-xs font-black uppercase tracking-[0.4em] text-primary-600 mb-2">Service Selection</p>
            <h1 class="text-4xl 3xl:text-7xl font-black text-gray-900 font-heading tracking-tight leading-none">Get Your Ticket</h1>
            <p class="text-gray-500 font-medium mt-2 3xl:text-xl">Choose a service to get your ticket.</p>
        </div>



        <?php if ($hasPendingFeedback): ?>
            <div class="bg-secondary-600 rounded-[32px] 3xl:rounded-[48px] p-10 3xl:p-16 text-white shadow-premium mb-12 relative overflow-hidden group">
                <div class="relative z-10 flex flex-col md:flex-row items-center justify-between gap-8 md:gap-16">
                    <div class="flex items-center space-x-6 3xl:space-x-12 text-center md:text-left">
                        <div class="w-20 3xl:w-32 h-20 3xl:h-32 bg-white/20 rounded-3xl 3xl:rounded-[48px] flex items-center justify-center animate-bounce">
                            <i class="fas fa-star-half-alt text-3xl 3xl:text-5xl"></i>
                        </div>
                        <div>
                            <h2 class="text-3xl 3xl:text-5xl font-black font-heading mb-1 tracking-tight">Feedback Required</h2>
                            <p class="text-secondary-100 font-medium 3xl:text-2xl">Please share your thoughts on your last visit before taking a new ticket.</p>
                        </div>
                    </div>
                    <a href="my-ticket.php" class="bg-white text-secondary-600 px-10 3xl:px-16 py-5 3xl:py-8 rounded-[22px] 3xl:rounded-[32px] font-black text-lg 3xl:text-2xl hover:scale-105 transition-all shadow-xl active:scale-95 flex items-center space-x-3">
                        <span>Go to My Ticket</span>
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <!-- Decorative back text -->
                <div class="absolute -right-10 top-0 text-[120px] 3xl:text-[200px] font-black text-white/10 select-none pointer-events-none uppercase tracking-tighter">REVIEW</div>
            </div>
        <?php elseif ($currentTicket): ?>
            <div class="bg-primary-600 rounded-[32px] 3xl:rounded-[48px] p-10 3xl:p-16 text-white shadow-premium mb-12 relative overflow-hidden group">
                <div class="relative z-10 flex flex-col md:flex-row items-center justify-between gap-8 md:gap-16">
                    <div class="flex items-center space-x-6 3xl:space-x-12 text-center md:text-left">
                        <div class="w-20 3xl:w-32 h-20 3xl:h-32 bg-white/20 rounded-3xl 3xl:rounded-[48px] flex items-center justify-center animate-pulse">
                            <i class="fas fa-ticket-alt text-3xl 3xl:text-5xl"></i>
                        </div>
                        <div>
                            <h2 class="text-3xl 3xl:text-5xl font-black font-heading mb-1 tracking-tight">Active Ticket Found</h2>
                            <p class="text-primary-100 font-medium 3xl:text-2xl">You currently have a ticket (<?php echo $currentTicket['ticket_number']; ?>). You can only have one active ticket at a time.</p>
                        </div>
                    </div>
                    <a href="my-ticket.php" class="bg-white text-primary-600 px-10 3xl:px-16 py-5 3xl:py-8 rounded-[22px] 3xl:rounded-[32px] font-black text-lg 3xl:text-2xl hover:scale-105 transition-all shadow-xl active:scale-95 flex items-center space-x-3">
                        <span>View My Ticket</span>
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <!-- Decorative back text -->
                <div class="absolute -right-10 top-0 text-[120px] 3xl:text-[200px] font-black text-white/10 select-none pointer-events-none uppercase tracking-tighter">ACTIVE</div>
            </div>
        <?php else: ?>
            
            <!-- Walk-in Tab Content -->
        <div id="walkinContent" class="tab-content">
            <?php if ($error): ?>
                <div class="p-6 3xl:p-10 mb-10 text-secondary-800 bg-secondary-50 rounded-3xl 3xl:rounded-[32px] border border-secondary-100 flex items-center shadow-premium" role="alert">
                    <i class="fas fa-exclamation-triangle mr-4 text-2xl 3xl:text-4xl"></i>
                    <span class="font-bold text-lg 3xl:text-3xl"><?php echo $error; ?></span>
                </div>
            <?php endif; ?>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 3xl:grid-cols-5 gap-6">
                <?php $counter = 1; foreach ($services as $service): ?>
                    <div class="bg-white rounded-[24px] md:rounded-[32px] 3xl:rounded-[48px] shadow-division border border-white hover:shadow-premium hover:-translate-y-1.5 transition-all duration-500 overflow-hidden flex flex-col h-full group">
                        <!-- Card Header -->
                        <div class="px-5 md:px-8 pt-6 md:pt-8 3xl:pt-10 pb-2 md:pb-3 relative overflow-hidden">
                            <div class="bg-primary-600 w-10 md:w-12 h-10 md:h-12 3xl:w-16 3xl:h-16 rounded-lg md:rounded-xl 3xl:rounded-[24px] flex items-center justify-center text-white shadow-lg shadow-primary-100 mb-3 md:mb-4 group-hover:rotate-6 transition-transform">
                                <span class="text-sm md:text-lg 3xl:text-2xl font-black"><?php echo $counter; ?></span>
                            </div>
                            <h3 class="text-md md:text-xl 3xl:text-2xl font-black text-gray-900 font-heading leading-tight tracking-tight"><?php echo $service['service_name']; ?></h3>
                            
                            <!-- BG Abstract Text -->
                            <div class="absolute -right-2 top-0 text-5xl md:text-6xl 3xl:text-8xl font-black text-slate-50 opacity-50 select-none pointer-events-none"><?php echo $counter; ?></div>
                        </div>
                        
                        <!-- Card Content Wrapper -->
                        <div class="px-5 md:px-8 flex flex-col flex-grow">
                            <!-- Body: Expands to fill space -->
                            <div class="flex-grow space-y-4 pt-4 border-t border-slate-50">
                                <div class="flex items-start space-x-2">
                                    <i class="fas fa-clipboard-check text-primary-600 mt-1 3xl:text-xl text-[10px]"></i>
                                    <div class="flex-1">
                                        <p class="text-[8px] 3xl:text-xs font-black text-gray-400 uppercase tracking-widest leading-none mb-1.5">Requirements</p>
                                        <div class="space-y-1 3xl:space-y-2">
                                            <?php 
                                            $reqs = preg_split('/[,\n\r]+/', $service['requirements']);
                                            foreach ($reqs as $req): 
                                                $req = trim($req);
                                                if (empty($req)) continue;
                                            ?>
                                                <div class="flex items-start space-x-2 text-[10px] md:text-xs 3xl:text-base font-bold text-gray-700">
                                                    <i class="fas fa-check-circle text-primary-500 mt-0.5 text-[8px] 3xl:text-xs"></i>
                                                    <span><?php echo htmlspecialchars($req); ?></span>
                                                </div>
                                            <?php endforeach; ?>
                                        </div>
                                    </div>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <i class="fas fa-bolt text-amber-500 text-[10px] 3xl:text-xl"></i>
                                    <div>
                                        <p class="text-[8px] 3xl:text-xs font-black text-gray-400 uppercase tracking-widest leading-none mb-0.5">Process Time</p>
                                        <p class="text-[10px] md:text-xs 3xl:text-lg font-black text-gray-900">Est. <?php echo $ticketModel->getAverageProcessTime($service['id']); ?> Minutes</p>
                                    </div>
                                </div>

                                <?php if ($service['service_code'] === 'GEN-INQ'): ?>
                                    <div class="pt-4 border-t border-slate-50">
                                        <label for="note-<?php echo $service['id']; ?>" class="block text-[8px] md:text-[10px] font-bold text-gray-500 uppercase tracking-wider mb-2">Note (Optional)</label>
                                        <textarea id="note-<?php echo $service['id']; ?>" form="form-<?php echo $service['id']; ?>" name="user_note" class="w-full bg-slate-50 border border-slate-200 rounded-xl p-3 text-[10px] font-medium focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all resize-none" placeholder="Please briefly specify your concern..." rows="2"></textarea>
                                    </div>
                                <?php endif; ?>
                            </div>
                            
                            <!-- Footer: Stays pinned to the bottom -->
                            <form id="form-<?php echo $service['id']; ?>" method="POST" action="" class="pb-8 md:pb-10 pt-6">
                                <input type="hidden" name="service_id" value="<?php echo $service['id']; ?>">
                                <button type="submit" class="w-full bg-slate-900 text-white py-3 md:py-4 3xl:py-6 rounded-lg md:rounded-xl 3xl:rounded-2xl font-black text-xs md:text-sm 3xl:text-xl shadow-lg shadow-slate-200 hover:bg-black transition-all active:scale-95 flex items-center justify-center space-x-2">
                                    <span>Get Ticket</span>
                                    <i class="fas fa-ticket-alt"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                <?php $counter++; endforeach; ?>
            </div>
        <?php endif; ?>
        </div><!-- End Walk-in Content -->

        <!-- Appointment Tab Content -->
        <div id="appointmentContent" class="tab-content hidden">
            <!-- Service Cards for Appointment -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 3xl:grid-cols-5 gap-6">
                    <?php $counter = 1; foreach ($services as $service): ?>
                        <div class="bg-white rounded-[24px] md:rounded-[32px] 3xl:rounded-[48px] shadow-division border border-white hover:shadow-premium hover:-translate-y-1.5 transition-all duration-500 overflow-hidden flex flex-col h-full group">
                            <!-- Card Header -->
                            <div class="px-5 md:px-8 pt-6 md:pt-8 3xl:pt-10 pb-2 md:pb-3 relative overflow-hidden">
                                <div class="bg-primary-600 w-10 md:w-12 h-10 md:h-12 3xl:w-16 3xl:h-16 rounded-lg md:rounded-xl 3xl:rounded-[24px] flex items-center justify-center text-white shadow-lg shadow-primary-100 mb-3 md:mb-4 group-hover:rotate-6 transition-transform">
                                    <span class="text-sm md:text-lg 3xl:text-2xl font-black"><?php echo $counter; ?></span>
                                </div>
                                <h3 class="text-md md:text-xl 3xl:text-2xl font-black text-gray-900 font-heading leading-tight tracking-tight"><?php echo $service['service_name']; ?></h3>
                                
                                <!-- BG Abstract Text -->
                                <div class="absolute -right-2 top-0 text-5xl md:text-6xl 3xl:text-8xl font-black text-slate-50 opacity-50 select-none pointer-events-none"><?php echo $counter; ?></div>
                            </div>
                            
                            <!-- Card Content Wrapper -->
                            <div class="px-5 md:px-8 flex flex-col flex-grow">
                                <!-- Body: Expands to fill space -->
                                <div class="flex-grow space-y-4 pt-4 border-t border-slate-50">
                                    <div class="flex items-start space-x-2">
                                        <i class="fas fa-clipboard-check text-primary-600 mt-1 3xl:text-xl text-[10px]"></i>
                                        <div class="flex-1">
                                            <p class="text-[8px] 3xl:text-xs font-black text-gray-400 uppercase tracking-widest leading-none mb-1.5">Requirements</p>
                                            <div class="space-y-1 3xl:space-y-2">
                                                <?php 
                                                $reqs = preg_split('/[,\n\r]+/', $service['requirements']);
                                                foreach ($reqs as $req): 
                                                    $req = trim($req);
                                                    if (empty($req)) continue;
                                                ?>
                                                    <div class="flex items-start space-x-2 text-[10px] md:text-xs 3xl:text-base font-bold text-gray-700">
                                                        <i class="fas fa-check-circle text-primary-500 mt-0.5 text-[8px] 3xl:text-xs"></i>
                                                        <span><?php echo htmlspecialchars($req); ?></span>
                                                    </div>
                                                <?php endforeach; ?>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex items-center space-x-2">
                                        <i class="fas fa-bolt text-amber-500 text-[10px] 3xl:text-xl"></i>
                                        <div>
                                            <p class="text-[8px] 3xl:text-xs font-black text-gray-400 uppercase tracking-widest leading-none mb-0.5">Process Time</p>
                                            <p class="text-[10px] md:text-xs 3xl:text-lg font-black text-gray-900">Est. <?php echo $ticketModel->getAverageProcessTime($service['id']); ?> Minutes</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Footer: Stays pinned to the bottom -->
                                <div class="pb-8 md:pb-10 pt-6">
                                    <button onclick="openAppointmentModal(<?php echo $service['id']; ?>, '<?php echo htmlspecialchars($service['service_name']); ?>')" class="w-full bg-slate-900 text-white py-3 md:py-4 3xl:py-6 rounded-lg md:rounded-xl 3xl:rounded-2xl font-black text-xs md:text-sm 3xl:text-xl shadow-lg shadow-slate-200 hover:bg-black transition-all active:scale-95 flex items-center justify-center space-x-2">
                                        <span>Schedule Ticket</span>
                                        <i class="fas fa-calendar-check"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    <?php $counter++; endforeach; ?>
                </div>
        </div>

        <!-- Appointment Modal -->
        <div id="appointmentModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
            <div class="bg-white rounded-3xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
                <div class="p-8">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-3xl font-black text-slate-900">Schedule Ticket Creation</h2>
                        <button onclick="closeAppointmentModal()" class="text-slate-400 hover:text-slate-900 transition">
                            <i class="fas fa-times text-2xl"></i>
                        </button>
                    </div>
                    
                    <div class="mb-6">
                        <p class="text-slate-600">Service: <span id="modalServiceName" class="font-bold text-slate-900"></span></p>
                    </div>
                    
                    <div class="space-y-6">
                        <!-- Date Selection -->
                        <div>
                            <label class="block text-sm font-bold text-slate-700 mb-2">Select Date</label>
                            <input type="date" id="appointmentDate" 
                                   min="<?php echo date('Y-m-d'); ?>" 
                                   max="<?php echo date('Y-m-d', strtotime('+30 days')); ?>"
                                   class="w-full px-4 py-3 border-2 border-slate-200 rounded-lg focus:border-primary-500 focus:outline-none text-lg"
                                   onchange="loadAppointmentSlots()">
                        </div>
                        
                        <!-- Time Slots -->
                        <div id="timeSlotsSection" class="hidden">
                            <label class="block text-sm font-bold text-slate-700 mb-2">Select Time</label>
                            <div id="timeSlots" class="grid grid-cols-3 gap-3">
                                <!-- Time slots will be loaded here -->
                            </div>
                        </div>
                        
                        <!-- Confirm Button -->
                        <button id="confirmAppointmentBtn" onclick="confirmAppointment()" disabled class="w-full bg-primary-600 text-white py-4 rounded-lg font-bold text-lg hover:bg-primary-700 transition disabled:opacity-50 disabled:cursor-not-allowed">
                            <i class="fas fa-check mr-2"></i> Confirm Schedule
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let selectedServiceId = null;
            let selectedServiceName = '';
            let selectedDate = '';
            let selectedTime = '';
            let selectedTime24h = '';

            function switchTab(tab) {
                // Update tab buttons
                document.getElementById('walkinTab').classList.remove('active');
                document.getElementById('appointmentTab').classList.remove('active');
                
                // Update content
                document.getElementById('walkinContent').classList.add('hidden');
                document.getElementById('appointmentContent').classList.add('hidden');
                
                if (tab === 'walkin') {
                    document.getElementById('walkinTab').classList.add('active');
                    document.getElementById('walkinContent').classList.remove('hidden');
                } else {
                    document.getElementById('appointmentTab').classList.add('active');
                    document.getElementById('appointmentContent').classList.remove('hidden');
                }
            }

            function openAppointmentModal(serviceId, serviceName) {
                selectedServiceId = serviceId;
                selectedServiceName = serviceName;
                document.getElementById('modalServiceName').textContent = serviceName;
                document.getElementById('appointmentModal').classList.remove('hidden');
                document.getElementById('appointmentModal').classList.add('flex');
                
                // Reset form
                document.getElementById('appointmentDate').value = '';
                document.getElementById('timeSlotsSection').classList.add('hidden');
                document.getElementById('confirmAppointmentBtn').disabled = true;
            }

            function closeAppointmentModal() {
                document.getElementById('appointmentModal').classList.add('hidden');
                document.getElementById('appointmentModal').classList.remove('flex');
            }

            async function loadAppointmentSlots() {
                const date = document.getElementById('appointmentDate').value;
                if (!date) return;
                
                selectedDate = date;
                const container = document.getElementById('timeSlots');
                const section = document.getElementById('timeSlotsSection');
                
                container.innerHTML = '<div class="col-span-full text-center py-4"><i class="fas fa-spinner fa-spin text-2xl text-primary-600"></i></div>';
                section.classList.remove('hidden');
                
                try {
                    const response = await fetch(`${ANTIGRAVITY_BASE_URL}/api/get-available-slots.php?service_id=${selectedServiceId}&date=${date}`);
                    const data = await response.json();
                    
                    if (data.error) {
                        container.innerHTML = `<div class="col-span-full text-center text-red-600 py-4 text-sm">${data.error}</div>`;
                        return;
                    }
                    
                    if (data.slots.length === 0) {
                        container.innerHTML = '<div class="col-span-full text-center text-slate-600 py-4 text-sm">No available slots</div>';
                        return;
                    }
                    
                    container.innerHTML = '';
                    data.slots.forEach(slot => {
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = `p-3 border-2 rounded-lg font-bold transition text-sm ${
                            slot.available 
                                ? 'border-slate-200 hover:border-primary-500 hover:bg-primary-50 text-slate-900' 
                                : 'border-slate-100 bg-slate-50 text-slate-400 cursor-not-allowed'
                        }`;
                        btn.innerHTML = `<div>${slot.time}</div>`;
                        btn.disabled = !slot.available;
                        if (slot.available) {
                            btn.onclick = () => selectTimeSlot(slot.time, slot.time_24h, btn);
                        }
                        container.appendChild(btn);
                    });
                    
                } catch (error) {
                    console.error('Error loading slots:', error);
                    container.innerHTML = '<div class="col-span-full text-center text-red-600 py-4 text-sm">Failed to load time slots</div>';
                }
            }

            function selectTimeSlot(time, time24h, button) {
                // Remove selection from all buttons
                document.querySelectorAll('#timeSlots button').forEach(btn => {
                    btn.classList.remove('border-primary-600', 'bg-primary-50');
                });
                
                // Highlight selected button
                button.classList.add('border-primary-600', 'bg-primary-50');
                
                selectedTime = time;
                selectedTime24h = time24h;
                document.getElementById('confirmAppointmentBtn').disabled = false;
            }

            async function confirmAppointment() {
                const btn = document.getElementById('confirmAppointmentBtn');
                btn.disabled = true;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Booking...';
                
                try {
                    const response = await fetch(`${ANTIGRAVITY_BASE_URL}/api/create-appointment.php`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-Token': '<?php echo $_SESSION['csrf_token']; ?>'
                        },
                        body: JSON.stringify({
                            service_id: selectedServiceId,
                            date: selectedDate,
                            time: selectedTime24h
                        })
                    });
                    
                    const data = await response.json();
                    
                    if (data.error) {
                        await equeueAlert('Error: ' + data.error, 'Scheduling Failed');
                        btn.disabled = false;
                        btn.innerHTML = '<i class="fas fa-check mr-2"></i> Confirm Schedule';
                        return;
                    }
                    
                    // Success - redirect to dashboard
                    await equeueSuccess('Ticket scheduled successfully! Ticket: ' + data.ticket_number, 'Success');
                    window.location.href = 'my-ticket.php';
                    
                } catch (error) {
                    console.error('Error:', error);
                    await equeueAlert('Failed to schedule ticket. Please try again.', 'Network Error');
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-check mr-2"></i> Confirm Schedule';
                }
            }

            async function cancelScheduledTicket(ticketId) {
                if (!await equeueConfirm('Are you sure you want to cancel this scheduled ticket?', 'Cancel Ticket')) {
                    return;
                }

                try {
                    const response = await fetch(`${ANTIGRAVITY_BASE_URL}/api/cancel-appointment.php`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-Token': '<?php echo $_SESSION['csrf_token']; ?>'
                        },
                        body: JSON.stringify({ ticket_id: ticketId })
                    });

                    const data = await response.json();

                    if (data.error) {
                        await equeueAlert('Error: ' + data.error, 'Cancellation Failed');
                        return;
                    }

                    await equeueSuccess('Scheduled ticket cancelled successfully!', 'Cancelled');
                    window.location.reload();
                } catch (error) {
                    console.error('Error:', error);
                    await equeueAlert('Failed to cancel ticket. Please try again.', 'Network Error');
                }
            }
        </script>
    </main>


    <?php include __DIR__ . '/../../includes/chatbot-widget.php'; ?>
    <script src="<?php echo BASE_URL; ?>/js/notifications.js"></script>
</body>
</html>
