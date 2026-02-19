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

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `ticket_id`, `user_id`, `window_id`, `rating`, `comment`, `sentiment`, `sentiment_score`, `created_at`) VALUES
(72, 132, 31, 14, NULL, 'slow', 'negative', -0.4000, '2026-02-16 09:40:06'),
(73, 136, 31, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-16 10:30:37'),
(74, 137, 31, 14, NULL, 'Nice', 'neutral', 0.0000, '2026-02-16 10:37:10'),
(75, 138, 31, 14, NULL, 'Nice', 'neutral', 0.0000, '2026-02-16 10:40:02'),
(76, 139, 31, 14, NULL, 'anlala', 'neutral', 0.0000, '2026-02-16 12:15:21'),
(77, 133, 32, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-16 14:24:44'),
(78, 140, 31, 14, NULL, 'Sheesh so good', 'very_positive', 0.8000, '2026-02-16 15:32:16'),
(79, 142, 32, 15, NULL, 'niceee', 'positive', 0.4000, '2026-02-16 15:33:03'),
(80, 145, 32, 14, NULL, 'Nice', 'neutral', 0.0000, '2026-02-16 16:09:26'),
(81, 146, 32, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-17 13:01:50'),
(82, 147, 32, 14, NULL, 'very good', 'positive', 0.4000, '2026-02-17 13:04:28'),
(83, 148, 32, 14, NULL, 'great', 'positive', 0.4000, '2026-02-17 13:07:48'),
(84, 144, 31, 14, NULL, 'So nice', 'positive', 0.4000, '2026-02-17 13:14:23'),
(85, 149, 32, 14, NULL, 'Nicee', 'neutral', 0.0000, '2026-02-17 13:57:48'),
(86, 150, 32, 14, NULL, 'Nice', 'neutral', 0.0000, '2026-02-17 13:58:33'),
(87, 151, 32, 14, NULL, 'bad', 'negative', -0.4000, '2026-02-17 14:07:21'),
(88, 152, 32, 14, NULL, 'okay', 'positive', 0.4000, '2026-02-17 14:33:32'),
(89, 153, 32, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-17 14:41:19'),
(90, 155, 31, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-17 14:43:35'),
(91, 154, 32, 14, NULL, 'So bad', 'very_negative', -0.8000, '2026-02-17 14:44:22'),
(92, 157, 32, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-17 15:27:53'),
(93, 156, 31, 14, NULL, 'goods', 'neutral', 0.0000, '2026-02-17 15:28:09'),
(94, 143, 33, 14, NULL, 'k', 'neutral', 0.0000, '2026-02-17 15:29:36'),
(95, 159, 31, 14, NULL, 'sheesh', 'positive', 0.4000, '2026-02-17 15:55:19'),
(96, 161, 31, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-17 16:24:17'),
(97, 163, 31, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-17 17:25:00'),
(98, 158, 32, 14, NULL, 'Sheesh', 'very_positive', 0.8000, '2026-02-17 17:25:26'),
(99, 160, 33, 14, NULL, 'sheesh', 'positive', 0.4000, '2026-02-17 17:33:55'),
(100, 166, 33, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-18 03:07:45'),
(101, 167, 33, 14, NULL, 'Nice', 'neutral', 0.0000, '2026-02-18 03:24:42'),
(102, 168, 33, 14, NULL, 'nice', 'positive', 0.4000, '2026-02-18 03:44:07'),
(103, 169, 33, 14, NULL, 'Nice', 'neutral', 0.0000, '2026-02-18 03:51:42'),
(104, 170, 33, 14, NULL, 'Good', 'positive', 0.4000, '2026-02-18 03:56:40'),
(105, 171, 33, 14, NULL, 'Good', 'positive', 0.4000, '2026-02-18 04:01:34'),
(106, 164, 31, 14, NULL, 'okay', 'neutral', 0.0000, '2026-02-18 05:19:26'),
(107, 165, 32, 14, NULL, 'K', 'neutral', 0.0000, '2026-02-18 05:21:09');

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

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `ticket_id`, `type`, `message`, `is_read`, `created_at`) VALUES
(332, 31, 132, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 07:12:33'),
(333, 32, 133, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 07:12:45'),
(334, 31, 132, 'now_serving', 'You are now being served.', 1, '2026-02-16 07:12:54'),
(335, 32, 133, 'now_serving', 'You are now being served.', 1, '2026-02-16 07:13:07'),
(336, 32, 133, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 07:13:19'),
(337, 31, 132, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 09:20:57'),
(338, 31, 134, 'cancelled', 'Your ticket has been cancelled.', 1, '2026-02-16 09:43:53'),
(339, 31, 135, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 09:47:45'),
(340, 31, 135, 'cancelled', 'Your ticket has been cancelled.', 1, '2026-02-16 09:54:14'),
(341, 31, 136, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 10:21:58'),
(342, 31, 136, 'now_serving', 'You are now being served.', 1, '2026-02-16 10:23:32'),
(343, 31, 136, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 10:30:24'),
(344, 31, 137, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 10:36:19'),
(345, 31, 137, 'now_serving', 'You are now being served.', 1, '2026-02-16 10:36:35'),
(346, 31, 137, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 10:36:48'),
(347, 31, 138, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 10:37:31'),
(348, 31, 138, 'now_serving', 'You are now being served.', 1, '2026-02-16 10:39:45'),
(349, 31, 138, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 10:39:50'),
(350, 31, 139, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 10:40:17'),
(351, 31, 139, 'now_serving', 'You are now being served.', 1, '2026-02-16 12:11:03'),
(352, 31, 139, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 12:11:42'),
(353, 31, 140, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 13:03:16'),
(354, 32, 141, 'cancelled', 'Your ticket has been cancelled.', 1, '2026-02-16 15:08:50'),
(355, 32, 142, 'turn_next', 'It\'s your turn! Please proceed to Window 2', 1, '2026-02-16 15:25:34'),
(356, 31, 140, 'now_serving', 'You are now being served.', 1, '2026-02-16 15:30:55'),
(357, 31, 140, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 15:31:03'),
(358, 32, 142, 'now_serving', 'You are now being served.', 1, '2026-02-16 15:31:29'),
(359, 32, 142, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 15:31:34'),
(360, 33, 143, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 16:02:45'),
(361, 33, 143, 'now_serving', 'You are now being served.', 1, '2026-02-16 16:02:50'),
(362, 33, 143, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 16:02:56'),
(363, 31, 144, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 16:03:02'),
(364, 31, 144, 'now_serving', 'You are now being served.', 1, '2026-02-16 16:03:16'),
(365, 31, 144, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 16:03:23'),
(366, 32, 145, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 16:03:33'),
(367, 32, 145, 'now_serving', 'You are now being served.', 1, '2026-02-16 16:03:46'),
(368, 32, 145, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 16:03:50'),
(369, 32, 146, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-16 16:20:42'),
(370, 32, 146, 'now_serving', 'You are now being served.', 1, '2026-02-16 16:20:47'),
(371, 32, 146, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-16 16:20:50'),
(372, 32, 147, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 13:02:50'),
(373, 32, 147, 'now_serving', 'You are now being served.', 1, '2026-02-17 13:03:19'),
(374, 32, 147, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 13:03:55'),
(375, 32, 148, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 13:06:58'),
(376, 32, 148, 'now_serving', 'You are now being served.', 1, '2026-02-17 13:07:15'),
(377, 32, 148, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 13:07:31'),
(378, 32, 149, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 13:54:00'),
(379, 32, 149, 'now_serving', 'You are now being served.', 1, '2026-02-17 13:54:19'),
(380, 32, 149, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 13:54:32'),
(381, 32, 150, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 13:57:57'),
(382, 32, 150, 'now_serving', 'You are now being served.', 1, '2026-02-17 13:58:07'),
(383, 32, 150, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 13:58:14'),
(384, 32, 151, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 13:59:09'),
(385, 32, 151, 'now_serving', 'You are now being served.', 1, '2026-02-17 13:59:22'),
(386, 32, 151, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 13:59:53'),
(387, 32, 152, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 14:07:54'),
(388, 32, 152, 'now_serving', 'You are now being served.', 1, '2026-02-17 14:23:06'),
(389, 32, 152, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 14:26:51'),
(390, 32, 153, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 14:37:17'),
(391, 32, 153, 'now_serving', 'You are now being served.', 1, '2026-02-17 14:37:24'),
(392, 32, 153, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 14:40:43'),
(393, 32, 154, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 14:42:26'),
(394, 31, 155, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 14:42:32'),
(395, 31, 155, 'now_serving', 'You are now being served.', 1, '2026-02-17 14:42:39'),
(396, 31, 155, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 14:42:41'),
(397, 32, 154, 'now_serving', 'You are now being served.', 1, '2026-02-17 14:42:46'),
(398, 32, 154, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 14:44:02'),
(399, 31, 156, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 15:25:18'),
(400, 32, 157, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 15:25:24'),
(401, 31, 156, 'now_serving', 'You are now being served.', 1, '2026-02-17 15:25:28'),
(402, 32, 157, 'now_serving', 'You are now being served.', 1, '2026-02-17 15:25:31'),
(403, 32, 157, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 15:25:58'),
(404, 31, 156, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 15:26:03'),
(405, 32, 158, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 15:32:42'),
(406, 32, 158, 'now_serving', 'You are now being served.', 1, '2026-02-17 15:33:18'),
(407, 32, 158, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 15:33:22'),
(408, 31, 159, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 15:33:27'),
(409, 31, 159, 'now_serving', 'You are now being served.', 1, '2026-02-17 15:33:40'),
(410, 31, 159, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 15:33:51'),
(411, 33, 160, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 15:33:57'),
(412, 33, 160, 'now_serving', 'You are now being served.', 1, '2026-02-17 15:36:48'),
(413, 33, 160, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 15:36:54'),
(414, 31, 161, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 16:13:48'),
(415, 31, 161, 'now_serving', 'You are now being served.', 1, '2026-02-17 16:20:09'),
(416, 31, 161, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 16:23:47'),
(417, 31, 162, 'cancelled', 'Your ticket has been cancelled.', 1, '2026-02-17 16:24:28'),
(418, 31, 163, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-17 17:19:20'),
(419, 31, 163, 'now_serving', 'You are now being served.', 1, '2026-02-17 17:19:26'),
(420, 31, 163, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-17 17:24:21'),
(421, 31, 164, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 02:58:32'),
(422, 32, 165, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:01:23'),
(423, 33, 166, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:01:30'),
(424, 32, 165, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:02:06'),
(425, 33, 166, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:02:07'),
(426, 31, 164, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:02:09'),
(427, 33, 166, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:04:18'),
(428, 32, 165, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:04:22'),
(429, 31, 164, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:04:26'),
(430, 33, 167, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:08:10'),
(431, 33, 167, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:22:25'),
(432, 33, 168, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:26:43'),
(433, 33, 168, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:26:51'),
(434, 33, 168, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:26:54'),
(435, 33, 169, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:44:29'),
(436, 33, 169, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:48:19'),
(437, 33, 169, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:51:35'),
(438, 33, 170, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:51:55'),
(439, 33, 170, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:56:00'),
(440, 33, 170, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 03:56:06'),
(441, 33, 171, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 03:56:50'),
(442, 33, 171, 'now_serving', 'You are now being served.', 1, '2026-02-18 03:58:03'),
(443, 33, 171, 'completed', 'Transaction completed. Please provide your feedback.', 1, '2026-02-18 04:01:25'),
(444, 33, 172, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 1, '2026-02-18 04:01:46'),
(445, 33, 172, 'now_serving', 'You are now being served.', 1, '2026-02-18 04:02:07'),
(446, 33, 172, 'completed', 'Transaction completed. Please provide your feedback.', 0, '2026-02-18 05:20:02'),
(447, 31, 173, 'turn_next', 'It\'s your turn! Please proceed to Window 1', 0, '2026-02-18 05:20:07');

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

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `ticket_number`, `user_id`, `service_id`, `auto_generated`, `user_note`, `window_id`, `status`, `staff_notes`, `queue_position`, `called_at`, `served_at`, `completed_at`, `created_at`, `updated_at`, `is_archived`, `service_time_accumulated`) VALUES
(132, 'COG0216-001', 31, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 07:12:33', '2026-02-16 07:12:54', '2026-02-16 09:20:57', '2026-02-16 07:10:03', '2026-02-16 09:20:57', 0, 0),
(133, 'COG0216-002', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 07:12:45', '2026-02-16 07:13:07', '2026-02-16 07:13:19', '2026-02-16 07:11:39', '2026-02-16 07:13:19', 0, 0),
(134, 'GMC0216-001', 31, 16, 0, NULL, NULL, 'cancelled', NULL, NULL, NULL, NULL, NULL, '2026-02-16 09:42:53', '2026-02-16 09:43:53', 0, 0),
(135, 'DPLM0216-001', 31, 15, 0, NULL, 14, 'cancelled', NULL, NULL, '2026-02-16 09:47:45', NULL, NULL, '2026-02-16 09:43:58', '2026-02-16 09:54:14', 0, 0),
(136, 'GMC0216-002', 31, 16, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 10:21:58', '2026-02-16 10:23:32', '2026-02-16 10:30:24', '2026-02-16 10:10:22', '2026-02-16 10:30:24', 0, 0),
(137, 'COG0216-003', 31, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 10:36:19', '2026-02-16 10:36:35', '2026-02-16 10:36:48', '2026-02-16 10:30:40', '2026-02-16 10:36:48', 0, 0),
(138, 'COG0216-004', 31, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 10:37:31', '2026-02-16 10:39:45', '2026-02-16 10:39:50', '2026-02-16 10:37:14', '2026-02-16 10:39:50', 0, 0),
(139, 'COG0216-005', 31, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 10:40:17', '2026-02-16 12:11:03', '2026-02-16 12:11:42', '2026-02-16 10:40:04', '2026-02-16 12:11:42', 0, 0),
(140, 'COG0216-006', 31, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 13:03:16', '2026-02-16 15:30:55', '2026-02-16 15:31:03', '2026-02-16 12:15:53', '2026-02-16 15:31:03', 0, 0),
(141, 'COG0216-007', 32, 14, 0, NULL, NULL, 'cancelled', NULL, NULL, NULL, NULL, NULL, '2026-02-16 14:28:48', '2026-02-16 15:08:50', 0, 0),
(142, 'GEN-INQ0216-001', 32, 17, 0, 'Nathzz', 15, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 15:25:34', '2026-02-16 15:31:29', '2026-02-16 15:31:34', '2026-02-16 15:10:07', '2026-02-16 15:31:34', 0, 0),
(143, 'COG0216-008', 33, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 16:02:45', '2026-02-16 16:02:50', '2026-02-16 16:02:56', '2026-02-16 15:30:28', '2026-02-16 16:02:56', 0, 0),
(144, 'GEN-INQ0216-002', 31, 17, 0, 'orayt', 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 16:03:02', '2026-02-16 16:03:16', '2026-02-16 16:03:23', '2026-02-16 15:32:23', '2026-02-16 16:03:23', 0, 0),
(145, 'COG0216-009', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 16:03:33', '2026-02-16 16:03:46', '2026-02-16 16:03:50', '2026-02-16 15:33:07', '2026-02-16 16:03:50', 0, 0),
(146, 'COG0217-001', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-16 16:20:42', '2026-02-16 16:20:47', '2026-02-16 16:20:50', '2026-02-16 16:09:29', '2026-02-16 16:20:50', 0, 0),
(147, 'COG0217-002', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 13:02:50', '2026-02-17 13:03:19', '2026-02-17 13:03:55', '2026-02-17 13:02:04', '2026-02-17 13:03:55', 0, 0),
(148, 'COG0217-003', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 13:06:58', '2026-02-17 13:07:15', '2026-02-17 13:07:31', '2026-02-17 13:06:49', '2026-02-17 13:07:31', 0, 0),
(149, 'GEN-INQ0217-001', 32, 17, 0, 'Sir want the best', 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 13:54:00', '2026-02-17 13:54:19', '2026-02-17 13:54:32', '2026-02-17 13:38:59', '2026-02-17 13:54:32', 0, 0),
(150, 'COG0217-004', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 13:57:57', '2026-02-17 13:58:07', '2026-02-17 13:58:14', '2026-02-17 13:57:50', '2026-02-17 13:58:14', 0, 0),
(151, 'COG0217-005', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 13:59:09', '2026-02-17 13:59:22', '2026-02-17 13:59:53', '2026-02-17 13:58:39', '2026-02-17 13:59:53', 0, 0),
(152, 'COG0217-006', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 14:07:54', '2026-02-17 14:23:06', '2026-02-17 14:26:51', '2026-02-17 14:07:23', '2026-02-17 14:26:51', 0, 0),
(153, 'COG0217-007', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 14:37:17', '2026-02-17 14:37:24', '2026-02-17 14:40:43', '2026-02-17 14:35:24', '2026-02-17 14:40:43', 0, 0),
(154, 'DPLM0217-001', 32, 15, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 14:42:26', '2026-02-17 14:42:46', '2026-02-17 14:44:02', '2026-02-17 14:41:26', '2026-02-17 14:44:02', 0, 0),
(155, 'DPLM0217-002', 31, 15, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 14:42:32', '2026-02-17 14:42:39', '2026-02-17 14:42:41', '2026-02-17 14:41:52', '2026-02-17 14:42:41', 0, 0),
(156, 'GMC0217-001', 31, 16, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 15:25:18', '2026-02-17 15:25:28', '2026-02-17 15:26:03', '2026-02-17 14:43:37', '2026-02-17 15:26:03', 0, 0),
(157, 'COG0217-008', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 15:25:24', '2026-02-17 15:25:31', '2026-02-17 15:25:58', '2026-02-17 14:44:26', '2026-02-17 15:25:58', 0, 0),
(158, 'COG0217-009', 32, 14, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 15:32:42', '2026-02-17 15:33:18', '2026-02-17 15:33:22', '2026-02-17 15:27:57', '2026-02-17 15:33:22', 0, 0),
(159, 'GMC0217-002', 31, 16, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 15:33:27', '2026-02-17 15:33:40', '2026-02-17 15:33:51', '2026-02-17 15:28:22', '2026-02-17 15:33:51', 0, 0),
(160, 'DPLM0217-003', 33, 15, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 15:33:57', '2026-02-17 15:36:48', '2026-02-17 15:36:54', '2026-02-17 15:29:41', '2026-02-17 15:36:54', 0, 0),
(161, 'GMC0218-001', 31, 16, 0, NULL, 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 16:13:48', '2026-02-17 16:20:09', '2026-02-17 16:23:47', '2026-02-17 16:12:55', '2026-02-17 16:23:47', 0, 0),
(162, 'GMC0218-002', 31, 16, 0, NULL, NULL, 'cancelled', NULL, NULL, NULL, NULL, NULL, '2026-02-17 16:24:22', '2026-02-17 16:24:28', 0, 0),
(163, 'GEN-INQ0218-001', 31, 17, 0, '', 14, 'completed', 'Your document is ready to be received', NULL, '2026-02-17 17:19:20', '2026-02-17 17:19:26', '2026-02-17 17:24:21', '2026-02-17 17:18:07', '2026-02-17 17:24:21', 0, 0),
(164, 'COG0218-001', 31, 14, 0, NULL, 14, 'completed', '', NULL, '2026-02-18 02:58:32', '2026-02-18 03:02:09', '2026-02-18 03:04:26', '2026-02-17 17:25:06', '2026-02-18 03:04:26', 0, 0),
(165, 'COG0218-002', 32, 14, 0, NULL, 14, 'completed', '', NULL, '2026-02-18 03:01:23', '2026-02-18 03:02:06', '2026-02-18 03:04:22', '2026-02-17 17:25:29', '2026-02-18 03:04:22', 0, 0),
(166, 'COG0218-003', 33, 14, 0, NULL, 14, 'completed', '', NULL, '2026-02-18 03:01:30', '2026-02-18 03:02:07', '2026-02-18 03:04:18', '2026-02-18 02:47:29', '2026-02-18 03:04:18', 0, 0),
(167, 'COG0218-004', 33, 14, 0, NULL, 14, 'completed', '', NULL, '2026-02-18 03:08:10', NULL, '2026-02-18 03:22:25', '2026-02-18 03:08:08', '2026-02-18 03:22:25', 1, 0),
(168, 'COG0218-005', 33, 14, 0, NULL, 14, 'completed', '', 1, '2026-02-18 03:26:43', '2026-02-18 03:26:51', '2026-02-18 03:26:54', '2026-02-18 03:24:45', '2026-02-18 03:26:54', 0, 0),
(169, 'COG0218-006', 33, 14, 0, NULL, 14, 'completed', '', 1, '2026-02-18 03:44:29', '2026-02-18 03:48:19', '2026-02-18 03:51:35', '2026-02-18 03:44:18', '2026-02-18 03:51:35', 0, 196),
(170, 'COG0218-007', 33, 14, 0, NULL, 14, 'completed', '', 1, '2026-02-18 03:51:55', '2026-02-18 03:56:00', '2026-02-18 03:56:05', '2026-02-18 03:51:45', '2026-02-18 03:56:05', 0, 5),
(171, 'GMC0218-003', 33, 16, 0, NULL, 14, 'completed', '', 1, '2026-02-18 03:56:50', '2026-02-18 03:58:03', '2026-02-18 04:01:25', '2026-02-18 03:56:44', '2026-02-18 04:01:25', 0, 202),
(172, 'GEN-INQ0218-002', 33, 17, 0, '', 14, 'completed', '', 1, '2026-02-18 04:01:46', '2026-02-18 04:02:07', '2026-02-18 05:20:02', '2026-02-18 04:01:38', '2026-02-18 05:20:02', 0, 4675),
(173, 'COG0218-008', 31, 14, 0, NULL, 14, 'called', '', 1, '2026-02-18 05:20:07', NULL, NULL, '2026-02-18 05:19:42', '2026-02-18 05:20:18', 1, 0),
(174, 'COG0218-009', 32, 14, 0, NULL, NULL, 'waiting', NULL, 1, NULL, NULL, NULL, '2026-02-18 05:21:12', '2026-02-18 05:21:12', 0, 0);

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
(28, 'w07@window.local', NULL, '$2y$10$BfNWbHZJKVeRF1fCi/4LoeOSpv3XxLFeglveSnu5HlpsiI9hbwWlK', 'Staff W-07', 'staff', '2026-02-15 07:47:25', '2026-02-15 07:47:25', NULL, 1, NULL, NULL),
(31, 'exodusgalimba@gmail.com', NULL, '$2y$10$fVUCJyf6UYWVMDF68egdGew35oQ4sge1dFtol/Dvg80QqgpDW0jPm', 'Genesis Manzano', 'user', '2026-02-16 07:09:23', '2026-02-16 09:14:29', NULL, 1, NULL, NULL),
(32, 'eklabushgulliver@gmail.com', 'NLP-22-00673', '$2y$10$R9rZNw/h/2Yk2/R2C20YP.6IqpW4iIYSaBcb56F7/0cUnVn.Xne0e', 'Jay Paulo', 'user', '2026-02-16 07:10:55', '2026-02-16 14:24:29', NULL, 1, NULL, NULL),
(33, 'thanosthemadtitan0101@gmail.com', 'NLP-22-00669', '$2y$10$7CBad5OR5lQE4hNVDhAQmuZ9p4bxAbBWt0uiC45wyXvQMDO7inn5K', 'Hezekiah Publico', 'user', '2026-02-16 15:28:53', '2026-02-16 15:29:47', NULL, 1, NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=448;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

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
