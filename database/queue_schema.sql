-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2026 at 06:51 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `equeue_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_context`
--

CREATE TABLE `ai_context` (
  `id` int(11) NOT NULL,
  `content` longtext DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ai_context`
--

INSERT INTO `ai_context` (`id`, `content`, `updated_at`) VALUES
(1, '<h2>I am inevitable. We are located at San Nicolas, Candon City, Ilocos Sur</h2>', '2026-02-15 16:50:09');

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_data`
--

CREATE TABLE `chatbot_data` (
  `id` int(11) NOT NULL,
  `answer` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category_id` int(11) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `keywords` text DEFAULT NULL,
  `usage_count` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chatbot_data`
--

INSERT INTO `chatbot_data` (`id`, `answer`, `updated_at`, `category_id`, `question`, `keywords`, `usage_count`, `is_active`, `created_at`) VALUES
(1, '<p>We are the Registrar of ISPSC Main Campus</p>', '2026-02-15 06:31:04', 1, NULL, NULL, 0, 1, '2026-02-15 06:08:44'),
(2, '<p><br></p>', '2026-02-15 06:22:47', 1, 'Imported from BLISSFUL RURAL LIFE.docx', '', 0, 1, '2026-02-15 06:22:29');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `window_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5 or `rating` is null),
  `comment` text DEFAULT NULL,
  `sentiment` enum('positive','neutral','negative','very_positive','very_negative') DEFAULT NULL,
  `sentiment_score` decimal(5,4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `type` enum('ticket_created','turn_next','serving','now_serving','completed','cancelled') DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `service_code` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `staff_notes` text DEFAULT NULL,
  `estimated_time` int(11) DEFAULT 10,
  `target_time` int(11) DEFAULT 10,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `service_name`, `service_code`, `description`, `requirements`, `staff_notes`, `estimated_time`, `target_time`, `is_active`, `created_at`, `updated_at`) VALUES
(14, 'Certificate of Grades', 'COG', '', 'Route Sheet\r\nValid ID\r\nCashier Receipt', '', 10, 10, 1, '2026-02-14 02:22:06', '2026-02-17 15:48:48'),
(15, 'Request of Diploma', 'DPLM', '', 'Official Transcript of Records', NULL, 10, 30, 1, '2026-02-14 02:23:01', '2026-02-17 15:48:28'),
(16, 'Good Moral Character', 'GMC', 'Good Moral Character', 'Valid ID\r\nOfficial Transcript of Records', NULL, 10, 25, 1, '2026-02-14 07:39:51', '2026-02-17 15:48:28'),
(17, 'General Inquiry', 'GEN-INQ', 'General concerns', 'None', '', 10, 15, 1, '2026-02-14 19:44:00', '2026-02-17 15:50:08');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `ticket_number` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `auto_generated` tinyint(1) DEFAULT 0,
  `user_note` text DEFAULT NULL,
  `window_id` int(11) DEFAULT NULL,
  `status` enum('waiting','called','serving','completed','cancelled') DEFAULT 'waiting',
  `staff_notes` text DEFAULT NULL,
  `queue_position` int(11) DEFAULT NULL,
  `called_at` timestamp NULL DEFAULT NULL,
  `served_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_archived` tinyint(1) DEFAULT 0,
  `service_time_accumulated` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `school_id` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `role` enum('user','staff','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `verification_token` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `school_id`, `password`, `full_name`, `role`, `created_at`, `updated_at`, `verification_token`, `is_verified`, `otp_code`, `otp_expiry`) VALUES
(1, 'admin@equeue.com', NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'System Administrator', 'admin', '2026-02-13 16:38:21', '2026-02-13 16:38:21', NULL, 0, NULL, NULL),
(18, 'w01@window.local', NULL, '$2y$10$Rm1uBXHsPpHPHOq/lyIyN.oS0ofP6rbdVHXE6aUPvlaJ7T83XrOle', 'Staff W-01', 'staff', '2026-02-14 08:04:35', '2026-02-14 08:04:35', NULL, 1, NULL, NULL),
(19, 'w02@window.local', NULL, '$2y$10$X86VU44sQQXZ98dGLcAvk.IfiR8QzF3WWrJvDgJ7Na742.cPLB1a.', 'Staff W-02', 'staff', '2026-02-14 14:21:48', '2026-02-14 14:21:48', NULL, 1, NULL, NULL),
(24, 'w03@window.local', NULL, '$2y$10$eL39jKmSNhnElHktV1l39.P6EZ60vhUsRTDdNGwWW/HpFVQkA18Ra', 'Staff W-03', 'staff', '2026-02-15 07:47:03', '2026-02-15 07:47:03', NULL, 1, NULL, NULL),
(25, 'w04@window.local', NULL, '$2y$10$0M4mIZjkDcgCnK7jxdNvUOjvaYp9nrZ/nvAxhBCpMVw8YXdREaPky', 'Staff W-04', 'staff', '2026-02-15 07:47:11', '2026-02-15 07:47:11', NULL, 1, NULL, NULL),
(26, 'w05@window.local', NULL, '$2y$10$qvhTIOh761yDJ/b0avt6C.l38yYzzpQJFWHGVJxIBmHd946Fn4lp6', 'Staff W-05', 'staff', '2026-02-15 07:47:16', '2026-02-15 07:47:16', NULL, 1, NULL, NULL),
(27, 'w06@window.local', NULL, '$2y$10$aE0.I3b7EHkkW/dFIYS94OUvTYylyKxZ1JzW6yG8jIbpp.PmSedKG', 'Staff W-06', 'staff', '2026-02-15 07:47:20', '2026-02-15 07:47:20', NULL, 1, NULL, NULL),
(28, 'w07@window.local', NULL, '$2y$10$BfNWbHZJKVeRF1fCi/4LoeOSpv3XxLFeglveSnu5HlpsiI9hbwWlK', 'Staff W-07', 'staff', '2026-02-15 07:47:25', '2026-02-15 07:47:25', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `windows`
--

CREATE TABLE `windows` (
  `id` int(11) NOT NULL,
  `window_number` varchar(50) NOT NULL,
  `window_name` varchar(255) NOT NULL,
  `location_info` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `windows`
--

INSERT INTO `windows` (`id`, `window_number`, `window_name`, `location_info`, `staff_id`, `is_active`, `created_at`, `updated_at`) VALUES
(14, 'W-01', 'Window 1', NULL, 18, 1, '2026-02-14 08:04:35', '2026-02-18 03:44:26'),
(15, 'W-02', 'Window 2', NULL, 19, 1, '2026-02-14 14:21:48', '2026-02-17 16:27:40'),
(16, 'W-03', 'Window 3', NULL, 24, 1, '2026-02-15 07:47:03', '2026-02-18 02:42:30'),
(17, 'W-04', 'Window 4', NULL, 25, 1, '2026-02-15 07:47:11', '2026-02-18 02:42:41'),
(18, 'W-05', 'Window 5', NULL, 26, 1, '2026-02-15 07:47:16', '2026-02-18 02:42:50'),
(19, 'W-06', 'Window 6', NULL, 27, 0, '2026-02-15 07:47:20', '2026-02-17 14:51:59'),
(20, 'W-07', 'Window 7', NULL, 28, 0, '2026-02-15 07:47:25', '2026-02-17 14:52:56');

-- --------------------------------------------------------

--
-- Table structure for table `window_services`
--

CREATE TABLE `window_services` (
  `id` int(11) NOT NULL,
  `window_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `is_enabled` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `window_services`
--

INSERT INTO `window_services` (`id`, `window_id`, `service_id`, `is_enabled`, `created_at`) VALUES
(37, 14, 14, 1, '2026-02-14 08:04:45'),
(38, 14, 15, 1, '2026-02-14 08:04:45'),
(39, 14, 16, 1, '2026-02-14 08:04:45'),
(40, 15, 14, 1, '2026-02-14 14:22:01'),
(41, 15, 15, 1, '2026-02-14 14:22:01'),
(42, 15, 16, 1, '2026-02-14 14:22:01'),
(43, 14, 17, 1, '2026-02-14 19:47:13'),
(44, 15, 17, 1, '2026-02-14 19:47:13'),
(45, 20, 14, 0, '2026-02-15 07:49:35'),
(46, 20, 15, 0, '2026-02-15 07:49:35'),
(47, 20, 16, 0, '2026-02-15 07:49:35'),
(48, 20, 17, 0, '2026-02-15 07:49:35'),
(49, 16, 14, 0, '2026-02-15 09:04:36'),
(50, 16, 17, 0, '2026-02-15 09:04:37'),
(51, 16, 16, 0, '2026-02-15 09:04:38'),
(52, 16, 15, 0, '2026-02-15 09:04:38'),
(53, 17, 14, 0, '2026-02-15 09:05:56'),
(54, 17, 15, 0, '2026-02-15 09:05:56'),
(55, 17, 16, 0, '2026-02-15 09:05:56'),
(56, 17, 17, 0, '2026-02-15 09:05:56'),
(57, 18, 14, 0, '2026-02-15 16:18:16'),
(58, 18, 15, 0, '2026-02-15 16:18:16'),
(59, 18, 16, 1, '2026-02-15 16:18:16'),
(60, 18, 17, 0, '2026-02-15 16:18:16'),
(61, 19, 14, 0, '2026-02-15 16:18:28'),
(62, 19, 15, 1, '2026-02-15 16:18:28'),
(63, 19, 16, 0, '2026-02-15 16:18:28'),
(64, 19, 17, 0, '2026-02-15 16:18:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `ai_context`
--
ALTER TABLE `ai_context`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chatbot_data`
--
ALTER TABLE `chatbot_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `window_id` (`window_id`),
  ADD KEY `idx_ticket` (`ticket_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_sentiment` (`sentiment`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `service_code` (`service_code`),
  ADD KEY `idx_code` (`service_code`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_number` (`ticket_number`),
  ADD KEY `window_id` (`window_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_service` (`service_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created` (`created_at`),
  ADD KEY `idx_queue` (`service_id`,`status`,`created_at`),
  ADD KEY `idx_queue_lookup` (`service_id`,`status`,`created_at`,`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `school_id` (`school_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_otp` (`otp_code`);

--
-- Indexes for table `windows`
--
ALTER TABLE `windows`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `window_number` (`window_number`),
  ADD KEY `idx_staff` (`staff_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `window_services`
--
ALTER TABLE `window_services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_window_service` (`window_id`,`service_id`),
  ADD KEY `idx_window` (`window_id`),
  ADD KEY `idx_service` (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ai_context`
--
ALTER TABLE `ai_context`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chatbot_data`
--
ALTER TABLE `chatbot_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `windows`
--
ALTER TABLE `windows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `window_services`
--
ALTER TABLE `window_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_3` FOREIGN KEY (`window_id`) REFERENCES `windows` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`window_id`) REFERENCES `windows` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `windows`
--
ALTER TABLE `windows`
  ADD CONSTRAINT `windows_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `window_services`
--
ALTER TABLE `window_services`
  ADD CONSTRAINT `window_services_ibfk_1` FOREIGN KEY (`window_id`) REFERENCES `windows` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `window_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
