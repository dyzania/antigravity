<?php
session_start();
require_once __DIR__ . '/../config/config.php';

// If already logged in, redirect to dashboard
if (isset($_SESSION['user_id'])) {
    switch ($_SESSION['role']) {
        case 'admin': header('Location: admin/dashboard.php'); break;
        case 'staff': header('Location: staff/dashboard.php'); break;
        default: header('Location: user/dashboard.php'); break;
    }
    exit;
}
?>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Antigravity - Next-Gen Queue Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <?php injectTailwindConfig(); ?>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .hero-bg {
            background-image: linear-gradient(to right, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.4) 100%), url('img/drone.png');
            background-size: cover;
            background-position: center;
        }
        .glass-nav {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .animate-float {
            animation: float 6s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        .text-glow {
            text-shadow: 0 0 20px rgba(16, 185, 129, 0.2); /* Soft Primary Glow */
        }
        .text-glow-secondary {
            text-shadow: 0 0 20px rgba(139, 1, 1, 0.3); /* Crimson Glow */
        }
    </style>
</head>
<body class="bg-primary-950 text-white font-sans selection:bg-primary-500/30">

    <!-- Premium Navbar -->
    <nav class="fixed top-0 left-0 right-0 z-50 glass-nav">
        <div class="container-ultra px-6 md:px-12 py-4 md:py-6 flex items-center justify-between">
            <div class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-primary-600 rounded-xl flex items-center justify-center shadow-lg shadow-primary-900/40">
                    <i class="fas fa-layer-group text-white text-xl"></i>
                </div>
                <span class="text-2xl font-black tracking-tight font-heading text-white">ANTIGRAVITY</span>
            </div>
            
            <div class="hidden md:flex items-center space-x-10 text-sm font-black uppercase tracking-[0.2em] text-gray-400">
                <a href="#features" class="hover:text-white transition-colors">Features</a>
                <a href="#stats" class="hover:text-white transition-colors">Metrics</a>
                <a href="#about" class="hover:text-white transition-colors">Vision</a>
            </div>

            <div class="flex items-center space-x-4">
                <a href="login.php" class="text-sm font-black uppercase tracking-widest px-6 py-2 hover:text-primary-400 transition-colors">Sign In</a>
                <a href="register.php" class="bg-white text-slate-900 px-6 py-3 rounded-xl font-black text-sm uppercase tracking-widest hover:bg-primary-500 hover:text-white transition-all shadow-xl shadow-white/5 active:scale-95">Get Started</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative min-h-screen flex items-center pt-20 overflow-hidden hero-bg">
        <div class="container-ultra px-6 md:px-12 relative z-10 w-full">
            <div class="max-w-4xl">
                <div class="inline-flex items-center space-x-3 px-4 py-2 bg-primary-500/10 border border-primary-500/20 rounded-full mb-8 animate-pulse">
                    <span class="w-2 h-2 rounded-full bg-primary-500"></span>
                    <span class="text-[10px] md:text-xs font-black uppercase tracking-[0.3em] text-primary-400">V2.0 Quantum Edition Now Live</span>
                </div>
                
                <h1 class="text-5xl md:text-[7rem] font-black leading-[0.9] font-heading tracking-tighter mb-8 text-glow">
                    ELIMINATE THE <br>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-primary-400 to-secondary-500">WAITING LINE.</span>
                </h1>
                
                <p class="text-lg md:text-2xl text-gray-400 font-medium max-w-2xl leading-relaxed mb-12">
                    Experience a revolutionary queue management ecosystem driven by real-time optics and predictive intelligence. Seamless, silent, and superior.
                </p>

                <div class="flex flex-col sm:flex-row items-center gap-6">
                    <a href="register.php" class="w-full sm:w-auto bg-primary-600 text-white px-10 py-6 rounded-2xl font-black text-xl flex items-center justify-center space-x-4 hover:bg-primary-500 transition-all hover:shadow-2xl hover:shadow-primary-500/40 hover:-translate-y-1 active:scale-95 group">
                        <span>Deploy Now</span>
                        <i class="fas fa-rocket group-hover:translate-x-1 group-hover:-translate-y-1 transition-transform"></i>
                    </a>
                    <a href="#features" class="w-full sm:w-auto bg-white/5 backdrop-blur-md border border-white/10 text-white px-10 py-6 rounded-2xl font-black text-xl flex items-center justify-center space-x-4 hover:bg-white/10 transition-all active:scale-95">
                        <span>The Experience</span>
                        <i class="fas fa-play text-sm opacity-50"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Decorative Elements -->
        <div class="absolute bottom-0 right-0 w-1/3 h-1/2 bg-primary-600/10 blur-[120px] rounded-full translate-x-1/2 translate-y-1/2"></div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-32 bg-primary-950 relative">
        <div class="container-ultra px-6 md:px-12">
            <div class="text-center mb-24">
                <p class="text-[10px] md:text-xs font-black uppercase tracking-[0.5em] text-primary-500 mb-4">Core Capabilities</p>
                <h2 class="text-4xl md:text-6xl font-black font-heading tracking-tight">ENGINEERED FOR PRECISION.</h2>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Feature 1: Primary (Green) -->
                <div class="bg-white/5 border border-white/10 p-10 rounded-[40px] hover:bg-white/[0.08] transition-all group">
                    <div class="w-16 h-16 bg-primary-600/20 rounded-2xl flex items-center justify-center mb-8 group-hover:scale-110 transition-transform">
                        <i class="fas fa-bolt text-3xl text-primary-500"></i>
                    </div>
                    <h3 class="text-2xl font-black mb-4 font-heading">Quantum Routing</h3>
                    <p class="text-gray-400 font-medium leading-relaxed">
                        Intelligent ticket distribution that balances load across windows instantly using proprietary algorithms.
                    </p>
                </div>

                <!-- Feature 2: Secondary (Crimson) -->
                <div class="bg-white/5 border border-white/10 p-10 rounded-[40px] hover:bg-white/[0.08] transition-all group">
                    <div class="w-16 h-16 bg-secondary-600/20 rounded-2xl flex items-center justify-center mb-8 group-hover:scale-110 transition-transform">
                        <i class="fas fa-chart-line text-3xl text-secondary-500"></i>
                    </div>
                    <h3 class="text-2xl font-black mb-4 font-heading">Real-Time Optics</h3>
                    <p class="text-gray-400 font-medium leading-relaxed" style="color: rgba(255, 255, 255, 0.6);">
                        Monitor every heartbeat of your facility with live dashboards and instant notification streams with secondary metrics.
                    </p>
                </div>

                <!-- Feature 3: Primary (Green/Gold Mix) -->
                <div class="bg-white/5 border border-white/10 p-10 rounded-[40px] hover:bg-white/[0.08] transition-all group">
                    <div class="w-16 h-16 bg-primary-600/20 rounded-2xl flex items-center justify-center mb-8 group-hover:scale-110 transition-transform">
                        <i class="fas fa-brain text-3xl text-primary-500"></i>
                    </div>
                    <h3 class="text-2xl font-black mb-4 font-heading">AI Sentiment</h3>
                    <p class="text-gray-400 font-medium leading-relaxed">
                        Automated feedback analysis that understands your customers' emotions through natural language processing.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section id="stats" class="py-24 border-y border-white/5 bg-primary-900/50">
        <div class="container-ultra px-6 md:px-12 grid grid-cols-2 md:grid-cols-4 gap-12 text-center">
            <div>
                <p class="text-4xl md:text-6xl font-black font-heading text-white mb-2">99.9<span class="text-primary-500">%</span></p>
                <p class="text-xs font-black uppercase tracking-widest text-gray-500">Uptime Reliability</p>
            </div>
            <div>
                <p class="text-4xl md:text-6xl font-black font-heading text-white mb-2">45<span class="text-primary-500">%</span></p>
                <p class="text-xs font-black uppercase tracking-widest text-gray-500">Wait Reduction</p>
            </div>
            <div>
                <p class="text-4xl md:text-6xl font-black font-heading text-white mb-2">2<span class="text-primary-500">k+</span></p>
                <p class="text-xs font-black uppercase tracking-widest text-gray-500">Daily Travelers</p>
            </div>
            <div>
                <p class="text-4xl md:text-6xl font-black font-heading text-white mb-2">0<span class="text-primary-500">ms</span></p>
                <p class="text-xs font-black uppercase tracking-widest text-gray-500">Lag Latency</p>
            </div>
        </div>
    </section>

    <!-- Enhanced Footer -->
    <footer class="py-20 bg-primary-950 border-t border-white/5">
        <div class="container-ultra px-6 md:px-12 flex flex-col md:flex-row justify-between items-center gap-10">
            <div class="flex items-center space-x-3 opacity-50">
                <div class="w-8 h-8 bg-white rounded-lg flex items-center justify-center">
                    <i class="fas fa-layer-group text-slate-950 text-sm"></i>
                </div>
                <span class="text-lg font-black tracking-tight font-heading">ANTIGRAVITY</span>
            </div>
            
            <p class="text-gray-500 font-medium text-sm">
                &copy; 2026 Antigravity Systems. All rights reserved. Built for Excellence.
            </p>

            <div class="flex space-x-6 text-gray-500">
                <a href="#" class="hover:text-white transition-colors"><i class="fab fa-twitter"></i></a>
                <a href="#" class="hover:text-white transition-colors"><i class="fab fa-github"></i></a>
                <a href="#" class="hover:text-white transition-colors"><i class="fab fa-linkedin"></i></a>
            </div>
        </div>
    </footer>

</body>
</html>
