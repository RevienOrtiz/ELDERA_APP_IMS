-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 19, 2026 at 05:17 AM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u377971199_Eldera`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `what` text NOT NULL,
  `when` varchar(255) NOT NULL,
  `where` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'GENERAL',
  `department` varchar(255) DEFAULT NULL,
  `hasListen` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `postedDate` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `what`, `when`, `where`, `category`, `department`, `hasListen`, `is_active`, `postedDate`, `created_at`, `updated_at`) VALUES
(1, 'Health Checkup Camp', 'Free health checkup for senior citizens including blood pressure, sugar level, and general health assessment.', 'October 25, 2023 at 9:00 AM', 'Community Center, Main Hall', 'HEALTH', 'Health Department', 1, 1, 'Oct 15, 2023', '2025-09-26 07:25:44', '2025-09-26 07:25:44'),
(2, 'Pension Distribution', 'Monthly pension distribution for registered senior citizens. Please bring your ID card.', 'November 1, 2023 at 10:00 AM', 'Municipal Office, Room 101', 'PENSION', 'Finance Department', 1, 1, 'Oct 16, 2023', '2025-09-26 07:25:44', '2025-09-26 07:25:44'),
(3, 'Community Gathering', 'Monthly community gathering for senior citizens with games, music, and refreshments.', 'October 30, 2023 at 3:00 PM', 'Senior Citizens Park', 'GENERAL', 'Community Affairs', 1, 1, 'Oct 17, 2023', '2025-09-26 07:25:44', '2025-09-26 07:25:44');

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `senior_id` bigint(20) UNSIGNED DEFAULT NULL,
  `application_type` enum('senior_id','pension','benefits') NOT NULL,
  `status` enum('pending','received','approved','rejected') NOT NULL DEFAULT 'pending',
  `submitted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `estimated_completion_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`id`, `senior_id`, `application_type`, `status`, `submitted_by`, `submitted_at`, `reviewed_by`, `reviewed_at`, `notes`, `metadata`, `estimated_completion_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'pension', 'received', NULL, '2025-09-07 10:32:40', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-10-02 11:32:12'),
(2, 2, 'pension', 'pending', NULL, '2025-06-23 09:54:45', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(3, 3, 'pension', 'pending', NULL, '2025-04-22 04:41:47', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(4, 4, 'pension', 'received', NULL, '2025-07-25 12:14:21', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(5, 5, 'pension', 'pending', NULL, '2025-08-04 22:10:08', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(6, 6, 'pension', 'received', NULL, '2025-08-06 04:13:48', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(7, 7, 'pension', 'pending', NULL, '2025-07-14 19:08:43', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(8, 8, 'pension', 'pending', NULL, '2025-08-15 00:07:53', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(9, 9, 'pension', 'received', NULL, '2025-09-09 06:22:22', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(10, 10, 'pension', 'rejected', NULL, '2025-05-27 10:01:18', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(11, 11, 'pension', 'rejected', NULL, '2025-07-15 23:30:41', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(12, 12, 'pension', 'rejected', NULL, '2025-03-31 07:17:48', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(13, 13, 'pension', 'pending', NULL, '2025-09-01 17:54:32', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(14, 14, 'pension', 'rejected', NULL, '2025-07-27 18:38:35', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(15, 15, 'pension', 'approved', NULL, '2025-05-07 19:34:34', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(16, 16, 'pension', 'rejected', NULL, '2025-04-25 19:29:40', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(17, 17, 'pension', 'approved', NULL, '2025-08-28 23:24:58', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(18, 18, 'pension', 'received', NULL, '2025-09-13 02:15:51', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(19, 19, 'pension', 'pending', NULL, '2025-04-10 16:37:02', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(20, 20, 'pension', 'rejected', NULL, '2025-09-15 06:39:26', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-12-05 02:12:05'),
(21, 21, 'pension', 'rejected', NULL, '2025-08-31 08:10:34', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(22, 22, 'pension', 'approved', NULL, '2025-03-23 22:14:44', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-12-05 02:13:13'),
(23, 23, 'pension', 'pending', NULL, '2025-06-26 05:11:13', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(24, 24, 'pension', 'approved', NULL, '2025-04-12 08:30:42', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(25, 25, 'pension', 'rejected', NULL, '2025-08-20 16:28:20', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(26, 26, 'pension', 'pending', NULL, '2025-08-05 16:01:42', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(27, 27, 'pension', 'rejected', NULL, '2025-07-29 05:36:37', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(28, 28, 'pension', 'pending', NULL, '2025-04-12 22:59:27', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(29, 29, 'pension', 'rejected', NULL, '2025-05-08 22:35:41', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(30, 30, 'pension', 'received', NULL, '2025-03-24 07:42:14', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(31, 31, 'pension', 'approved', NULL, '2025-05-20 16:22:25', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(32, 32, 'pension', 'approved', NULL, '2025-03-27 04:21:44', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(33, 33, 'pension', 'received', NULL, '2025-07-29 13:47:57', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(34, 34, 'pension', 'rejected', NULL, '2025-07-25 18:15:13', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(35, 35, 'pension', 'rejected', NULL, '2025-04-04 16:07:48', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(36, 36, 'pension', 'received', NULL, '2025-05-06 22:31:21', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(37, 37, 'pension', 'rejected', NULL, '2025-05-08 07:03:39', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(38, 38, 'pension', 'pending', NULL, '2025-07-01 06:17:17', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(39, 39, 'pension', 'pending', NULL, '2025-06-17 06:46:05', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(40, 40, 'pension', 'received', NULL, '2025-05-25 09:45:30', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(41, 41, 'pension', 'received', NULL, '2025-03-26 22:57:11', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(42, 42, 'pension', 'rejected', NULL, '2025-04-22 09:30:04', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(43, 43, 'pension', 'approved', NULL, '2025-04-08 10:19:48', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(44, 44, 'pension', 'rejected', NULL, '2025-06-26 06:47:31', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(45, 45, 'pension', 'received', NULL, '2025-08-01 12:12:23', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(46, 46, 'pension', 'pending', NULL, '2025-03-26 00:07:20', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(47, 47, 'pension', 'received', NULL, '2025-04-20 17:28:03', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(48, 48, 'pension', 'approved', NULL, '2025-08-11 03:30:55', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(49, 49, 'pension', 'pending', NULL, '2025-05-13 12:56:27', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(50, 50, 'pension', 'pending', NULL, '2025-08-22 07:21:33', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(51, 51, 'pension', 'approved', NULL, '2025-04-01 02:12:42', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(52, 52, 'pension', 'approved', NULL, '2025-09-02 11:23:58', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(53, 53, 'pension', 'received', NULL, '2025-08-07 18:57:25', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(54, 54, 'pension', 'received', NULL, '2025-07-28 21:28:57', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(55, 55, 'pension', 'rejected', NULL, '2025-08-21 09:41:03', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(56, 56, 'pension', 'approved', NULL, '2025-06-01 01:35:46', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(57, 57, 'pension', 'received', NULL, '2025-04-03 22:46:53', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(58, 58, 'pension', 'received', NULL, '2025-05-19 16:22:04', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(59, 59, 'pension', 'rejected', NULL, '2025-06-24 02:58:47', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(60, 60, 'pension', 'pending', NULL, '2025-05-05 01:34:20', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(61, 61, 'pension', 'rejected', NULL, '2025-06-05 20:30:06', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(62, 62, 'pension', 'rejected', NULL, '2025-04-14 03:53:23', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(63, 63, 'pension', 'rejected', NULL, '2025-06-18 00:56:50', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(64, 64, 'pension', 'received', NULL, '2025-03-31 22:50:17', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(65, 65, 'pension', 'received', NULL, '2025-05-16 07:17:24', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(66, 66, 'pension', 'approved', NULL, '2025-07-29 01:51:49', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(67, 67, 'pension', 'rejected', NULL, '2025-09-04 21:11:30', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(68, 68, 'pension', 'rejected', NULL, '2025-06-27 17:25:48', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(69, 69, 'pension', 'approved', NULL, '2025-06-09 11:57:46', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(70, 70, 'pension', 'received', NULL, '2025-07-06 09:15:40', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(71, 71, 'pension', 'rejected', NULL, '2025-08-29 02:10:44', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(72, 72, 'pension', 'received', NULL, '2025-09-09 13:13:57', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-10-02 11:24:08'),
(73, 73, 'pension', 'rejected', NULL, '2025-07-22 07:33:26', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(74, 74, 'pension', 'rejected', NULL, '2025-07-24 08:10:26', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(75, 75, 'pension', 'received', NULL, '2025-05-11 04:33:50', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(76, 76, 'pension', 'received', NULL, '2025-04-15 21:34:52', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(77, 77, 'pension', 'pending', NULL, '2025-08-15 01:17:34', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(78, 78, 'pension', 'rejected', NULL, '2025-05-09 06:23:33', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(79, 79, 'pension', 'approved', NULL, '2025-06-12 08:44:49', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(80, 80, 'pension', 'received', NULL, '2025-04-30 12:09:52', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(81, 81, 'pension', 'pending', NULL, '2025-07-02 04:26:53', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(82, 82, 'pension', 'pending', NULL, '2025-03-30 22:49:08', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(83, 83, 'pension', 'approved', NULL, '2025-08-17 10:13:53', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(84, 84, 'pension', 'received', NULL, '2025-05-30 10:02:42', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(85, 85, 'pension', 'approved', NULL, '2025-07-02 07:34:36', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(86, 86, 'pension', 'pending', NULL, '2025-07-28 17:50:05', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(87, 87, 'pension', 'rejected', NULL, '2025-06-02 22:41:35', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(88, 88, 'pension', 'rejected', NULL, '2025-05-04 19:02:06', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(89, 89, 'pension', 'rejected', NULL, '2025-07-12 15:30:25', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(90, 90, 'pension', 'pending', NULL, '2025-07-10 15:24:53', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(91, 91, 'pension', 'approved', NULL, '2025-04-22 14:50:18', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(92, 92, 'pension', 'pending', NULL, '2025-03-21 16:02:52', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(93, 93, 'pension', 'received', NULL, '2025-06-06 13:53:39', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(94, 94, 'pension', 'pending', NULL, '2025-07-18 13:18:34', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(95, 95, 'pension', 'pending', NULL, '2025-07-01 00:16:31', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(96, 96, 'pension', 'rejected', NULL, '2025-07-03 09:54:59', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(97, 97, 'pension', 'approved', NULL, '2025-04-23 18:11:12', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(98, 98, 'pension', 'rejected', NULL, '2025-08-22 18:58:19', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(99, 99, 'pension', 'approved', NULL, '2025-05-01 23:00:58', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-10-02 11:23:53'),
(100, 100, 'pension', 'approved', NULL, '2025-05-04 09:56:36', NULL, NULL, NULL, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14'),
(102, 1, 'benefits', 'received', 4, '2025-09-19 08:50:11', NULL, NULL, 'Updated via edit form at 2025-10-02 19:23:01', '{\"permanent_address\":{\"house_number\":\"Zone 1, Purok 4\",\"street\":\"Street 4\",\"barangay\":\"maniboc\",\"city\":\"Lingayen\",\"province\":\"Pangasinan\",\"zip\":\"\"},\"spouse_information\":{\"name\":\"\",\"citizenship\":\"\"},\"children\":[null,null,null,null,null],\"authorized_representatives\":[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}],\"beneficiaries\":{\"primary\":\"wafaesf\",\"contingent\":\"aegsedf\"},\"utilization\":[\"food\",\"medical_checkup\"],\"utilization_others\":\"\",\"certification\":[\"information_correct\"],\"citizenship_details\":{\"citizenship\":\"Filipino\",\"dual_citizenship_details\":\"\"},\"civil_status_others\":\"\",\"assessment\":{\"findings_concerns\":\"\",\"initial_assessment\":\"eligible\"}}', '2025-10-09', '2025-09-19 00:50:11', '2025-10-02 11:23:01'),
(103, 3, 'senior_id', 'received', 4, '2025-09-19 09:19:58', NULL, NULL, NULL, NULL, '2025-10-19', '2025-09-19 01:19:58', '2025-10-02 04:27:34'),
(104, 2, 'benefits', 'rejected', 4, '2025-09-21 12:20:51', NULL, NULL, 'Updated via edit form at 2025-10-03 07:59:06', '{\"permanent_address\":{\"house_number\":\"Zone 2, Purok 5\",\"street\":\"Street 5\",\"barangay\":\"malimpuec\",\"city\":\"Lingayen\",\"province\":\"Pangasinan\",\"zip\":\"\"},\"spouse_information\":{\"name\":\"\",\"citizenship\":\"\"},\"children\":[null,null,null,null,null],\"authorized_representatives\":[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}],\"beneficiaries\":{\"primary\":\"awdfaw\",\"contingent\":\"sefse\"},\"utilization\":[\"medical_checkup\"],\"utilization_others\":\"\",\"certification\":[\"information_correct\"],\"citizenship_details\":{\"citizenship\":\"Filipino\",\"dual_citizenship_details\":\"\"},\"civil_status_others\":\"\",\"assessment\":{\"findings_concerns\":\"\",\"initial_assessment\":\"eligible\"}}', '2025-10-11', '2025-09-21 04:20:51', '2025-10-02 23:59:06'),
(105, 57, 'senior_id', 'received', 4, '2025-09-22 06:27:14', NULL, NULL, NULL, NULL, '2025-10-22', '2025-09-21 22:27:14', '2025-10-02 06:53:17'),
(106, NULL, 'senior_id', 'pending', 4, '2025-09-22 06:30:49', NULL, NULL, NULL, NULL, '2025-10-22', '2025-09-21 22:30:49', '2025-10-02 11:14:46'),
(107, 4, 'senior_id', 'received', 4, '2025-09-22 06:35:48', NULL, NULL, NULL, NULL, '2025-10-22', '2025-09-21 22:35:48', '2025-10-02 11:43:46'),
(108, 19, 'senior_id', 'approved', 4, '2025-09-22 06:37:41', NULL, NULL, NULL, NULL, '2025-10-22', '2025-09-21 22:37:41', '2025-10-02 11:02:46'),
(109, 15, 'senior_id', 'received', 6, '2025-10-01 19:31:21', NULL, NULL, NULL, NULL, '2025-10-31', '2025-10-01 11:31:21', '2025-10-02 11:43:28'),
(110, 9, 'senior_id', 'pending', 6, '2025-10-08 15:28:04', NULL, NULL, NULL, NULL, '2025-11-07', '2025-10-08 07:28:04', '2025-10-08 07:28:04'),
(111, 18, 'benefits', 'pending', 6, '2025-10-08 15:56:45', NULL, NULL, NULL, NULL, '2025-10-28', '2025-10-08 07:56:45', '2025-10-08 07:56:45'),
(112, 18, 'senior_id', 'pending', 6, '2025-12-03 13:37:47', NULL, NULL, NULL, NULL, '2026-01-02', '2025-12-03 13:37:47', '2025-12-03 13:37:47'),
(113, 95, 'senior_id', 'pending', 6, '2025-12-03 13:45:09', NULL, NULL, NULL, NULL, '2026-01-02', '2025-12-03 13:45:09', '2025-12-03 13:45:09'),
(114, 130, 'benefits', 'pending', 16, '2025-12-04 13:42:38', NULL, NULL, NULL, NULL, '2025-12-24', '2025-12-04 13:42:38', '2025-12-04 13:42:38'),
(115, 129, 'benefits', 'pending', 16, '2025-12-04 13:43:47', NULL, NULL, NULL, NULL, '2025-12-24', '2025-12-04 13:43:47', '2025-12-04 13:43:47'),
(116, 128, 'pension', 'pending', 16, '2025-12-04 13:45:34', NULL, NULL, NULL, NULL, '2025-12-19', '2025-12-04 13:45:34', '2025-12-04 13:45:34'),
(117, 115, 'senior_id', 'pending', 16, '2025-12-04 13:51:36', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 13:51:36', '2025-12-04 13:51:36'),
(118, 130, 'senior_id', 'pending', 16, '2025-12-04 13:52:51', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 13:52:51', '2025-12-04 13:52:51'),
(119, 106, 'senior_id', 'approved', 16, '2025-12-04 13:54:38', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 13:54:38', '2025-12-05 02:25:03'),
(122, 136, 'senior_id', 'pending', 4, '2025-12-04 14:05:39', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 14:05:39', '2025-12-04 14:05:39'),
(123, 122, 'benefits', 'pending', 16, '2025-12-04 14:06:33', NULL, NULL, NULL, NULL, '2025-12-24', '2025-12-04 14:06:33', '2025-12-04 14:06:33'),
(124, 113, 'benefits', 'received', 4, '2025-12-04 14:10:10', NULL, NULL, 'Updated via edit form at 2025-12-05 02:11:10', '{\"permanent_address\":{\"house_number\":\"Not specified\",\"street\":\"\",\"barangay\":\"tumbar\",\"city\":\"Lingayen\",\"province\":\"Pangasinan\",\"zip\":\"\"},\"spouse_information\":{\"name\":\"\",\"citizenship\":\"\"},\"children\":[null,null,null,null,null],\"authorized_representatives\":[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}],\"beneficiaries\":{\"primary\":\"\",\"contingent\":\"\"},\"utilization\":[],\"utilization_others\":\"\",\"certification\":[\"information_correct\"],\"citizenship_details\":{\"citizenship\":\"Filipino\",\"dual_citizenship_details\":\"\"},\"civil_status_others\":\"\",\"assessment\":{\"findings_concerns\":\"\",\"initial_assessment\":\"eligible\"}}', '2025-12-24', '2025-12-04 14:10:10', '2025-12-05 02:11:10'),
(125, 131, 'pension', 'pending', 16, '2025-12-04 14:14:45', NULL, NULL, NULL, NULL, '2025-12-19', '2025-12-04 14:14:45', '2025-12-04 14:14:45'),
(126, 131, 'senior_id', 'received', 16, '2025-12-04 14:15:32', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 14:15:32', '2025-12-05 02:14:33'),
(127, 122, 'senior_id', 'pending', 16, '2025-12-04 14:18:37', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 14:18:37', '2025-12-04 14:18:37'),
(128, 128, 'senior_id', 'received', 16, '2025-12-04 14:22:05', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 14:22:05', '2025-12-05 02:14:20'),
(129, 44, 'senior_id', 'approved', 16, '2025-12-04 14:28:20', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 14:28:20', '2025-12-05 02:14:06'),
(130, 134, 'senior_id', 'approved', 4, '2025-12-04 14:29:15', NULL, NULL, NULL, NULL, '2026-01-03', '2025-12-04 14:29:15', '2025-12-05 02:13:53'),
(131, 136, 'pension', 'pending', 4, '2025-12-04 15:09:42', NULL, NULL, NULL, NULL, '2025-12-19', '2025-12-04 15:09:42', '2025-12-04 15:09:42'),
(132, 32, 'benefits', 'pending', 4, '2025-12-04 15:12:47', NULL, NULL, NULL, NULL, '2025-12-24', '2025-12-04 15:12:47', '2025-12-04 15:12:47'),
(133, 95, 'benefits', 'approved', 4, '2025-12-04 15:39:41', NULL, NULL, 'Updated via edit form at 2025-12-05 02:10:02', '{\"permanent_address\":{\"house_number\":\"Zone 1, Purok 4\",\"street\":\"Street 3\",\"barangay\":\"maniboc\",\"city\":\"Lingayen\",\"province\":\"Pangasinan\",\"zip\":\"\"},\"spouse_information\":{\"name\":\"\",\"citizenship\":\"\"},\"children\":[null,null,null,null,null],\"authorized_representatives\":[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}],\"beneficiaries\":{\"primary\":\"\",\"contingent\":\"\"},\"utilization\":[],\"utilization_others\":\"\",\"certification\":[\"information_correct\"],\"citizenship_details\":{\"citizenship\":\"Filipino\",\"dual_citizenship_details\":\"\"},\"civil_status_others\":\"\",\"assessment\":{\"findings_concerns\":\"\",\"initial_assessment\":\"eligible\"}}', '2025-12-24', '2025-12-04 15:39:41', '2025-12-05 02:10:02');

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE `app_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `osca_id` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'senior',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_users`
--

INSERT INTO `app_users` (`id`, `osca_id`, `username`, `email`, `password`, `first_name`, `last_name`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, '2025-003', NULL, 'jon.crona3@email.com', '$2y$12$krqzvy65J1plmbGAu5agjeYTxCVa22QZG0gcswlwnoxb7iKAbmtK.', 'Jon', 'Crona', 'senior', NULL, '2025-09-29 06:56:26', '2025-10-08 21:20:44'),
(2, '2025-004', NULL, 'evalyn.haag4@email.com', '$2y$12$abhFFj5.dOXkrdVFdhTawOGMhUE//VYK37d5lh.Xzn5Dcn60kUH9G', 'Evalyn', 'Haag', 'senior', NULL, '2025-09-29 08:03:41', '2025-10-08 14:43:19'),
(3, '2025-005', NULL, 'fleta.kohler5@email.com', '$2y$12$R42CAM3NSRMeUUwv3qMzneFVGD88JGxZ50vIa4FRbk.ceuC7hAlX6', 'Fleta', 'Kohler', 'senior', NULL, '2025-09-30 03:21:30', '2025-10-08 00:49:28'),
(4, '2025-018', NULL, 'felicity.bode18@email.com', '$2y$12$8QgR9jI.yorBqScymE/hjuudkfb9rki7lEh3C1/6ewZ5Mt29a6U5S', 'Felicity', 'Bode', 'senior', NULL, '2025-09-30 14:18:47', '2025-12-03 06:18:06'),
(5, '2025-009', NULL, 'theodora.abernathy9@email.com', '$2y$12$cHFi51tyjNj4wgnegaOPR.JvAir2ZveDSGoYsT35QiIObytWdezcK', 'Theodora', 'Abernathy', 'senior', NULL, '2025-10-06 09:03:23', '2025-11-28 16:25:58'),
(6, 'TEST-001', NULL, 'test@example.com', '$2y$12$PkIRHwcy8XbKoMfCbvpEFez0waA9FrTl2zZys5yvep4FdcGWXrxO.', 'Test', 'User', 'senior', NULL, '2025-10-07 06:52:38', '2025-10-07 06:52:38'),
(7, '2025-017', NULL, 'anthony.padberg17@email.com', '$2y$12$8dXWg2Iw/W9jJLGEZte6OuvhnFAfuWfkeGdH07mB5HlT5Y84G.Kmq', 'Anthony', 'Padberg', 'senior', NULL, '2025-10-07 07:39:37', '2025-10-07 07:39:37'),
(8, '2025-006', NULL, 'milan.reynolds6@email.com', '$2y$12$2p9XuZUJu5LYfcjsJnizmuOoxhTexpTJVCdhgOlo42qmmyrNrSyKm', 'Milan', 'Reynolds', 'senior', NULL, '2025-10-07 08:37:04', '2025-10-07 08:37:04'),
(9, '2025-007', NULL, 'valentine.kuhlman7@email.com', '$2y$12$O3O/W.V4mYBI9Bkov8G0ru2Utc8OPZTn5wvWS7jdE0UfUUDmyriC2', 'Valentine', 'Kuhlman', 'senior', NULL, '2025-10-08 07:13:43', '2025-10-08 07:13:43'),
(10, '2025-008', NULL, 'maci.larson8@email.com', '$2y$12$Y6SmTWw9VhKn67T2XeSpduouNAAJU8gXN.Zn9TGphjgm.FNttXEoC', 'Maci', 'Larson', 'senior', NULL, '2025-10-08 12:33:14', '2025-10-08 12:33:14'),
(11, '2025-010', NULL, 'yessenia.steuber10@email.com', '$2y$12$BZKEQB.qIur7D.vShz4wmuvQfdTJkOhJ73I6jMw7BAO3B9G0wx51u', 'Yessenia', 'Steuber', 'senior', NULL, '2025-10-08 12:40:12', '2025-10-08 12:41:05'),
(12, '2025-089', NULL, 'americo.runolfsdottir89@email.com', '$2y$12$GJDeArkhx600Bnh8pDp4pe9yHJmkHtd2HVWjQ3OsQ3pg7Po4/tgnm', 'Americo', 'Runolfsdottir', 'senior', NULL, '2025-10-08 12:55:51', '2025-12-05 02:22:22'),
(13, '2025-013', NULL, 'avis.king13@email.com', '$2y$12$i/DmUGiq5jJeynyxCfLqm.h43Gqiy1ae1j9q/8zMPnkvgtSiSrn.e', 'Avis', 'King', 'senior', NULL, '2025-12-01 17:24:48', '2025-12-01 17:24:48'),
(14, '2025-096', NULL, 'sharon.beatty96@email.com', '$2y$12$IbAmXM6UbsiCsakDZIW09.l4AODn81RaAICAo6xtbugPj6GzdwBnO', 'Sharon', 'Beatty', 'senior', NULL, '2025-12-01 17:28:45', '2025-12-01 17:28:45'),
(15, '2025-019', NULL, 'cory.bosco19@email.com', '$2y$12$gQRatYVJo/SnyU2d9zH3aOiQsS3KuXCWuQgxuAY5nym/FVuLCyXyu', 'Cory', 'Bosco', 'senior', NULL, '2025-12-02 14:38:40', '2025-12-02 14:38:40'),
(16, '2025-364', NULL, NULL, '$2y$12$6jzFIxFrMScZ/JCAqymDRuyezOZg9QJuLxLb8Rpy.o1P4o30.4dN.', 'Virgillo', 'Basilio', 'senior', NULL, '2025-12-04 14:00:55', '2025-12-04 14:00:55'),
(17, '2025-363', NULL, 'noemail@example.com', '$2y$12$DkNSgk.23B.PqrhKyEWQt.1Zal1qHMLnOcLVR4G0jhPGFHOPtizk.', 'Gerardo', 'Tandoc', 'senior', NULL, '2025-12-05 02:24:10', '2025-12-05 02:24:10'),
(18, '2025-362', NULL, 'noemail@example.com', '$2y$12$6RF/q2xTRIltp//XiuYIQ.CyYTJvbXW/uR04Rh2Wz3ZApl8u7tihK', 'Maria', 'Mendoza', 'senior', NULL, '2026-01-13 00:04:02', '2026-01-13 00:04:02');

-- --------------------------------------------------------

--
-- Table structure for table `barangays`
--

CREATE TABLE `barangays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barangays`
--

INSERT INTO `barangays` (`id`, `name`, `code`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Aliwekwek', 'ALW', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(2, 'Baay', 'BAA', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(3, 'Balangobong', 'BAL', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(4, 'Balococ', 'BCO', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(5, 'Bantayan', 'BAN', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(6, 'Basing', 'BAS', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(7, 'Capandanan', 'CAP', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(8, 'Domalandan Center', 'DMC', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(9, 'Domalandan East', 'DME', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(10, 'Domalandan West', 'DMW', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(11, 'Dorongan', 'DOR', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(12, 'Dulag', 'DUL', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(13, 'Estanza', 'EST', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(14, 'Lasip', 'LAS', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(15, 'Libsong East', 'LSE', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(16, 'Libsong West', 'LSW', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(17, 'Malawa', 'MAL', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(18, 'Malimpuec', 'MLP', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(19, 'Maniboc', 'MAN', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(20, 'Matalava', 'MAT', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(21, 'Naguelguel', 'NAG', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(22, 'Namolan', 'NAM', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(23, 'Pangapisan North', 'PNN', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(24, 'Pangapisan Sur', 'PNS', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(25, 'Poblacion', 'POB', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(26, 'Quibaol', 'QUI', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(27, 'Rosario', 'ROS', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(28, 'Sabangan', 'SAB', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(29, 'Talogtog', 'TAL', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(30, 'Tonton', 'TON', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(31, 'Tumbar', 'TUM', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(32, 'Wawa', 'WAW', 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54');

-- --------------------------------------------------------

--
-- Table structure for table `benefits_applications`
--

CREATE TABLE `benefits_applications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `senior_id` bigint(20) UNSIGNED NOT NULL,
  `milestone_age` int(11) NOT NULL,
  `rrn` varchar(255) DEFAULT NULL,
  `osca_id` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `name_extension` varchar(255) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `age` int(11) NOT NULL,
  `res_house_number` varchar(255) DEFAULT NULL,
  `res_street` varchar(255) DEFAULT NULL,
  `res_barangay` varchar(255) DEFAULT NULL,
  `res_city` varchar(255) DEFAULT NULL,
  `res_province` varchar(255) DEFAULT NULL,
  `res_zip` varchar(255) DEFAULT NULL,
  `perm_house_number` varchar(255) DEFAULT NULL,
  `perm_street` varchar(255) DEFAULT NULL,
  `perm_barangay` varchar(255) DEFAULT NULL,
  `perm_city` varchar(255) DEFAULT NULL,
  `perm_province` varchar(255) DEFAULT NULL,
  `perm_zip` varchar(255) DEFAULT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `civil_status` varchar(255) NOT NULL,
  `civil_status_others` varchar(255) DEFAULT NULL,
  `citizenship` enum('Filipino','Dual') NOT NULL,
  `dual_citizenship_details` varchar(255) DEFAULT NULL,
  `spouse_name` text DEFAULT NULL,
  `spouse_citizenship` varchar(255) DEFAULT NULL,
  `children` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`children`)),
  `authorized_reps` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`authorized_reps`)),
  `contact_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `primary_beneficiary` varchar(255) DEFAULT NULL,
  `contingent_beneficiary` varchar(255) DEFAULT NULL,
  `utilization` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`utilization`)),
  `utilization_others` varchar(255) DEFAULT NULL,
  `certification` tinyint(1) NOT NULL DEFAULT 0,
  `findings_concerns` text DEFAULT NULL,
  `initial_assessment` enum('eligible','ineligible') DEFAULT NULL,
  `applicant_type` varchar(255) NOT NULL DEFAULT 'local',
  `local_annex_a` varchar(255) DEFAULT NULL,
  `local_annex_a_remarks` text DEFAULT NULL,
  `local_primary_docs` varchar(255) DEFAULT NULL,
  `local_primary_docs_remarks` text DEFAULT NULL,
  `local_id_picture` varchar(255) DEFAULT NULL,
  `local_id_picture_remarks` text DEFAULT NULL,
  `local_full_body` varchar(255) DEFAULT NULL,
  `local_full_body_remarks` text DEFAULT NULL,
  `local_endorsed_list` varchar(255) DEFAULT NULL,
  `local_endorsed_list_remarks` text DEFAULT NULL,
  `abroad_annex_a` varchar(255) DEFAULT NULL,
  `abroad_annex_a_remarks` text DEFAULT NULL,
  `abroad_primary_docs` varchar(255) DEFAULT NULL,
  `abroad_primary_docs_remarks` text DEFAULT NULL,
  `abroad_id_picture` varchar(255) DEFAULT NULL,
  `abroad_id_picture_remarks` text DEFAULT NULL,
  `abroad_full_body` varchar(255) DEFAULT NULL,
  `abroad_full_body_remarks` text DEFAULT NULL,
  `abroad_endorsed_list` varchar(255) DEFAULT NULL,
  `abroad_endorsed_list_remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `application_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `benefits_applications`
--

INSERT INTO `benefits_applications` (`id`, `senior_id`, `milestone_age`, `rrn`, `osca_id`, `last_name`, `first_name`, `middle_name`, `name_extension`, `date_of_birth`, `age`, `res_house_number`, `res_street`, `res_barangay`, `res_city`, `res_province`, `res_zip`, `perm_house_number`, `perm_street`, `perm_barangay`, `perm_city`, `perm_province`, `perm_zip`, `sex`, `civil_status`, `civil_status_others`, `citizenship`, `dual_citizenship_details`, `spouse_name`, `spouse_citizenship`, `children`, `authorized_reps`, `contact_number`, `email`, `primary_beneficiary`, `contingent_beneficiary`, `utilization`, `utilization_others`, `certification`, `findings_concerns`, `initial_assessment`, `applicant_type`, `local_annex_a`, `local_annex_a_remarks`, `local_primary_docs`, `local_primary_docs_remarks`, `local_id_picture`, `local_id_picture_remarks`, `local_full_body`, `local_full_body_remarks`, `local_endorsed_list`, `local_endorsed_list_remarks`, `abroad_annex_a`, `abroad_annex_a_remarks`, `abroad_primary_docs`, `abroad_primary_docs_remarks`, `abroad_id_picture`, `abroad_id_picture_remarks`, `abroad_full_body`, `abroad_full_body_remarks`, `abroad_endorsed_list`, `abroad_endorsed_list_remarks`, `created_at`, `updated_at`, `application_id`) VALUES
(1, 1, 90, NULL, '2025-001', 'Kuhn', 'Branon', 'Tomasa', NULL, '1935-01-31', 90, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, 'Female', 'Married', NULL, 'Dual', 'Filipino, Spanish', NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '0945644377', 'brannon.kuhn1@email.com', 'wafaesf', 'aegsedf', '[\"food\",\"medical_checkup\"]', NULL, 1, NULL, NULL, 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-19 00:50:11', '2025-09-21 03:55:14', 102),
(2, 2, 85, NULL, '2025-002', 'Hansen', 'Nasir', 'Rosendo', NULL, '1938-04-11', 87, NULL, NULL, 'malimpuec', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'malimpuec', 'Lingayen', 'Pangasinan', NULL, 'Female', 'Separated', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '0953721186', 'nasir.hansen2@email.com', 'awdfaw', 'sefse', '[\"medical_checkup\"]', NULL, 1, NULL, NULL, 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-21 04:20:51', '2025-09-21 05:51:52', 104),
(3, 18, 90, NULL, '2025-018', 'Bode', 'Felicity', 'Garfield', NULL, '1935-06-01', 90, NULL, NULL, 'malawa', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'malawa', 'Lingayen', 'Pangasinan', NULL, 'Female', 'Widowed', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '0930699698', 'felicity.bode18@email.com', NULL, NULL, NULL, NULL, 1, NULL, NULL, 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-08 07:56:45', '2025-10-08 07:56:45', 111),
(4, 130, 80, NULL, '2025-358', 'Albarida', 'Teofilo', NULL, NULL, '1945-07-03', 80, NULL, NULL, 'domalandan-center', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'domalandan-center', 'Lingayen', 'Pangasinan', NULL, 'Male', 'Widowed', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '09237622748', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 13:42:38', '2025-12-04 13:42:38', 114),
(5, 129, 85, NULL, '2025-357', 'Toringan', 'Teodora', 'Abalos', NULL, '1940-09-24', 85, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, 'Female', 'Widowed', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '09987643272', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 13:43:47', '2025-12-04 13:43:47', 115),
(6, 122, 85, NULL, '2025-350', 'Jimenez', 'Felicitas', 'Baltazar', NULL, '1940-06-06', 85, NULL, NULL, 'pangapisan-sur', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'pangapisan-sur', 'Lingayen', 'Pangasinan', NULL, 'Female', 'Widowed', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '09994734283', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 14:06:33', '2025-12-04 14:06:33', 123),
(7, 113, 80, NULL, '2025-341', 'Arias', 'Frederico', 'Santos', NULL, '1940-02-25', 85, NULL, NULL, 'tumbar', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'tumbar', 'Lingayen', 'Pangasinan', NULL, 'Male', 'Separated', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '09546352724', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'eligible', 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 14:10:10', '2025-12-04 14:10:10', 124),
(8, 32, 80, NULL, '2025-032', 'Langworth', 'Isaias', 'Edgardo', 'V', '1943-05-05', 82, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, 'Male', 'Others', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '0963145843', 'isaias.langworth32@email.com', NULL, NULL, NULL, NULL, 1, NULL, 'eligible', 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 15:12:47', '2025-12-04 15:12:47', 132),
(9, 95, 90, NULL, '2025-095', 'Christiansen', 'Jordon', 'Stephany', NULL, '1935-03-10', 90, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, NULL, NULL, 'maniboc', 'Lingayen', 'Pangasinan', NULL, 'Female', 'Others', NULL, 'Filipino', NULL, NULL, NULL, '[null,null,null,null,null]', '[{\"name\":null,\"relationship\":null},{\"name\":null,\"relationship\":null}]', '0936299766', 'jordon.christiansen95@email.com', NULL, NULL, NULL, NULL, 1, NULL, 'eligible', 'local', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 15:39:41', '2025-12-04 15:39:41', 133);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-0716d9708d321ffb6a00818614779e779925365c', 'i:4;', 1765281251),
('laravel-cache-0716d9708d321ffb6a00818614779e779925365c:timer', 'i:1765281251;', 1765281251),
('laravel-cache-1574bddb75c78a6fd2251d61e2993b5146201319', 'i:1;', 1766548382),
('laravel-cache-1574bddb75c78a6fd2251d61e2993b5146201319:timer', 'i:1766548382;', 1766548382),
('laravel-cache-1b6453892473a467d07372d45eb05abc2031647a', 'i:1;', 1767206504),
('laravel-cache-1b6453892473a467d07372d45eb05abc2031647a:timer', 'i:1767206504;', 1767206504),
('laravel-cache-7b52009b64fd0a2a49e6d8a939753077792b0554', 'i:2;', 1764901401),
('laravel-cache-7b52009b64fd0a2a49e6d8a939753077792b0554:timer', 'i:1764901401;', 1764901401),
('laravel-cache-902ba3cda1883801594b6e1b452790cc53948fda', 'i:2;', 1768262710),
('laravel-cache-902ba3cda1883801594b6e1b452790cc53948fda:timer', 'i:1768262710;', 1768262710),
('laravel-cache-9e6a55b6b4563e652a23be9d623ca5055c356940', 'i:2;', 1768322385),
('laravel-cache-9e6a55b6b4563e652a23be9d623ca5055c356940:timer', 'i:1768322385;', 1768322385);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-active_barangays', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:32:{i:0;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:9:\"Aliwekwek\";s:4:\"code\";s:3:\"ALW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:9:\"Aliwekwek\";s:4:\"code\";s:3:\"ALW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:2;s:4:\"name\";s:4:\"Baay\";s:4:\"code\";s:3:\"BAA\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:2;s:4:\"name\";s:4:\"Baay\";s:4:\"code\";s:3:\"BAA\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Balangobong\";s:4:\"code\";s:3:\"BAL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:3;s:4:\"name\";s:11:\"Balangobong\";s:4:\"code\";s:3:\"BAL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Balococ\";s:4:\"code\";s:3:\"BCO\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:4;s:4:\"name\";s:7:\"Balococ\";s:4:\"code\";s:3:\"BCO\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:5;s:4:\"name\";s:8:\"Bantayan\";s:4:\"code\";s:3:\"BAN\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:5;s:4:\"name\";s:8:\"Bantayan\";s:4:\"code\";s:3:\"BAN\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:6;s:4:\"name\";s:6:\"Basing\";s:4:\"code\";s:3:\"BAS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:6;s:4:\"name\";s:6:\"Basing\";s:4:\"code\";s:3:\"BAS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:7;s:4:\"name\";s:10:\"Capandanan\";s:4:\"code\";s:3:\"CAP\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:7;s:4:\"name\";s:10:\"Capandanan\";s:4:\"code\";s:3:\"CAP\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:8;s:4:\"name\";s:17:\"Domalandan Center\";s:4:\"code\";s:3:\"DMC\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:8;s:4:\"name\";s:17:\"Domalandan Center\";s:4:\"code\";s:3:\"DMC\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:9;s:4:\"name\";s:15:\"Domalandan East\";s:4:\"code\";s:3:\"DME\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:9;s:4:\"name\";s:15:\"Domalandan East\";s:4:\"code\";s:3:\"DME\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:9;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:10;s:4:\"name\";s:15:\"Domalandan West\";s:4:\"code\";s:3:\"DMW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:10;s:4:\"name\";s:15:\"Domalandan West\";s:4:\"code\";s:3:\"DMW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:10;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:11;s:4:\"name\";s:8:\"Dorongan\";s:4:\"code\";s:3:\"DOR\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:11;s:4:\"name\";s:8:\"Dorongan\";s:4:\"code\";s:3:\"DOR\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:11;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:12;s:4:\"name\";s:5:\"Dulag\";s:4:\"code\";s:3:\"DUL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:12;s:4:\"name\";s:5:\"Dulag\";s:4:\"code\";s:3:\"DUL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:12;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:13;s:4:\"name\";s:7:\"Estanza\";s:4:\"code\";s:3:\"EST\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:13;s:4:\"name\";s:7:\"Estanza\";s:4:\"code\";s:3:\"EST\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:13;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:14;s:4:\"name\";s:5:\"Lasip\";s:4:\"code\";s:3:\"LAS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:14;s:4:\"name\";s:5:\"Lasip\";s:4:\"code\";s:3:\"LAS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:14;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:15;s:4:\"name\";s:12:\"Libsong East\";s:4:\"code\";s:3:\"LSE\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:15;s:4:\"name\";s:12:\"Libsong East\";s:4:\"code\";s:3:\"LSE\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:15;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:16;s:4:\"name\";s:12:\"Libsong West\";s:4:\"code\";s:3:\"LSW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:16;s:4:\"name\";s:12:\"Libsong West\";s:4:\"code\";s:3:\"LSW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:16;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:17;s:4:\"name\";s:6:\"Malawa\";s:4:\"code\";s:3:\"MAL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:17;s:4:\"name\";s:6:\"Malawa\";s:4:\"code\";s:3:\"MAL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:17;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:18;s:4:\"name\";s:9:\"Malimpuec\";s:4:\"code\";s:3:\"MLP\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:18;s:4:\"name\";s:9:\"Malimpuec\";s:4:\"code\";s:3:\"MLP\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:18;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:19;s:4:\"name\";s:7:\"Maniboc\";s:4:\"code\";s:3:\"MAN\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:19;s:4:\"name\";s:7:\"Maniboc\";s:4:\"code\";s:3:\"MAN\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:19;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:20;s:4:\"name\";s:8:\"Matalava\";s:4:\"code\";s:3:\"MAT\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:20;s:4:\"name\";s:8:\"Matalava\";s:4:\"code\";s:3:\"MAT\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:20;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:21;s:4:\"name\";s:10:\"Naguelguel\";s:4:\"code\";s:3:\"NAG\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:21;s:4:\"name\";s:10:\"Naguelguel\";s:4:\"code\";s:3:\"NAG\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:21;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:22;s:4:\"name\";s:7:\"Namolan\";s:4:\"code\";s:3:\"NAM\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:22;s:4:\"name\";s:7:\"Namolan\";s:4:\"code\";s:3:\"NAM\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:22;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:23;s:4:\"name\";s:16:\"Pangapisan North\";s:4:\"code\";s:3:\"PNN\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:23;s:4:\"name\";s:16:\"Pangapisan North\";s:4:\"code\";s:3:\"PNN\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:23;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:24;s:4:\"name\";s:14:\"Pangapisan Sur\";s:4:\"code\";s:3:\"PNS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:24;s:4:\"name\";s:14:\"Pangapisan Sur\";s:4:\"code\";s:3:\"PNS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:24;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:25;s:4:\"name\";s:9:\"Poblacion\";s:4:\"code\";s:3:\"POB\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:25;s:4:\"name\";s:9:\"Poblacion\";s:4:\"code\";s:3:\"POB\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:25;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:26;s:4:\"name\";s:7:\"Quibaol\";s:4:\"code\";s:3:\"QUI\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:26;s:4:\"name\";s:7:\"Quibaol\";s:4:\"code\";s:3:\"QUI\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:26;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:27;s:4:\"name\";s:7:\"Rosario\";s:4:\"code\";s:3:\"ROS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:27;s:4:\"name\";s:7:\"Rosario\";s:4:\"code\";s:3:\"ROS\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:27;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:28;s:4:\"name\";s:8:\"Sabangan\";s:4:\"code\";s:3:\"SAB\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:28;s:4:\"name\";s:8:\"Sabangan\";s:4:\"code\";s:3:\"SAB\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:28;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:29;s:4:\"name\";s:8:\"Talogtog\";s:4:\"code\";s:3:\"TAL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:29;s:4:\"name\";s:8:\"Talogtog\";s:4:\"code\";s:3:\"TAL\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:29;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:30;s:4:\"name\";s:6:\"Tonton\";s:4:\"code\";s:3:\"TON\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:30;s:4:\"name\";s:6:\"Tonton\";s:4:\"code\";s:3:\"TON\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:30;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:31;s:4:\"name\";s:6:\"Tumbar\";s:4:\"code\";s:3:\"TUM\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:31;s:4:\"name\";s:6:\"Tumbar\";s:4:\"code\";s:3:\"TUM\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:31;O:19:\"App\\Models\\Barangay\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:9:\"barangays\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:32;s:4:\"name\";s:4:\"Wawa\";s:4:\"code\";s:3:\"WAW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:32;s:4:\"name\";s:4:\"Wawa\";s:4:\"code\";s:3:\"WAW\";s:9:\"is_active\";i:1;s:10:\"created_at\";s:19:\"2025-09-18 01:48:54\";s:10:\"updated_at\";s:19:\"2025-09-18 01:48:54\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:9:\"is_active\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:9:\"is_active\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1768325095);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-barangay_statistics', 'a:2:{s:5:\"total\";i:32;s:9:\"barangays\";a:32:{i:0;a:7:{s:4:\"name\";s:9:\"Aliwekwek\";s:4:\"code\";s:3:\"ALW\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:1;a:7:{s:4:\"name\";s:4:\"Baay\";s:4:\"code\";s:3:\"BAA\";s:13:\"total_seniors\";i:6;s:10:\"male_count\";s:1:\"2\";s:12:\"female_count\";s:1:\"4\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:1:\"4\";}i:2;a:7:{s:4:\"name\";s:11:\"Balangobong\";s:4:\"code\";s:3:\"BAL\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:3;a:7:{s:4:\"name\";s:7:\"Balococ\";s:4:\"code\";s:3:\"BCO\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:4;a:7:{s:4:\"name\";s:8:\"Bantayan\";s:4:\"code\";s:3:\"BAN\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:5;a:7:{s:4:\"name\";s:6:\"Basing\";s:4:\"code\";s:3:\"BAS\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:6;a:7:{s:4:\"name\";s:10:\"Capandanan\";s:4:\"code\";s:3:\"CAP\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:7;a:7:{s:4:\"name\";s:17:\"Domalandan Center\";s:4:\"code\";s:3:\"DMC\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:8;a:7:{s:4:\"name\";s:15:\"Domalandan East\";s:4:\"code\";s:3:\"DME\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:9;a:7:{s:4:\"name\";s:15:\"Domalandan West\";s:4:\"code\";s:3:\"DMW\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:10;a:7:{s:4:\"name\";s:8:\"Dorongan\";s:4:\"code\";s:3:\"DOR\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:11;a:7:{s:4:\"name\";s:5:\"Dulag\";s:4:\"code\";s:3:\"DUL\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:12;a:7:{s:4:\"name\";s:7:\"Estanza\";s:4:\"code\";s:3:\"EST\";s:13:\"total_seniors\";i:3;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"2\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"3\";}i:13;a:7:{s:4:\"name\";s:5:\"Lasip\";s:4:\"code\";s:3:\"LAS\";s:13:\"total_seniors\";i:3;s:10:\"male_count\";s:1:\"2\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:1:\"1\";}i:14;a:7:{s:4:\"name\";s:12:\"Libsong East\";s:4:\"code\";s:3:\"LSE\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:15;a:7:{s:4:\"name\";s:12:\"Libsong West\";s:4:\"code\";s:3:\"LSW\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:16;a:7:{s:4:\"name\";s:6:\"Malawa\";s:4:\"code\";s:3:\"MAL\";s:13:\"total_seniors\";i:7;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"6\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"6\";}i:17;a:7:{s:4:\"name\";s:9:\"Malimpuec\";s:4:\"code\";s:3:\"MLP\";s:13:\"total_seniors\";i:5;s:10:\"male_count\";s:1:\"2\";s:12:\"female_count\";s:1:\"3\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"4\";}i:18;a:7:{s:4:\"name\";s:7:\"Maniboc\";s:4:\"code\";s:3:\"MAN\";s:13:\"total_seniors\";i:15;s:10:\"male_count\";s:1:\"3\";s:12:\"female_count\";s:2:\"12\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:2:\"13\";}i:19;a:7:{s:4:\"name\";s:8:\"Matalava\";s:4:\"code\";s:3:\"MAT\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:20;a:7:{s:4:\"name\";s:10:\"Naguelguel\";s:4:\"code\";s:3:\"NAG\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:21;a:7:{s:4:\"name\";s:7:\"Namolan\";s:4:\"code\";s:3:\"NAM\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:22;a:7:{s:4:\"name\";s:16:\"Pangapisan North\";s:4:\"code\";s:3:\"PNN\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:23;a:7:{s:4:\"name\";s:14:\"Pangapisan Sur\";s:4:\"code\";s:3:\"PNS\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:24;a:7:{s:4:\"name\";s:9:\"Poblacion\";s:4:\"code\";s:3:\"POB\";s:13:\"total_seniors\";i:5;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"4\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"4\";}i:25;a:7:{s:4:\"name\";s:7:\"Quibaol\";s:4:\"code\";s:3:\"QUI\";s:13:\"total_seniors\";i:4;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"3\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:1:\"2\";}i:26;a:7:{s:4:\"name\";s:7:\"Rosario\";s:4:\"code\";s:3:\"ROS\";s:13:\"total_seniors\";i:9;s:10:\"male_count\";s:1:\"6\";s:12:\"female_count\";s:1:\"3\";s:18:\"with_pension_count\";s:1:\"6\";s:21:\"without_pension_count\";s:1:\"3\";}i:27;a:7:{s:4:\"name\";s:8:\"Sabangan\";s:4:\"code\";s:3:\"SAB\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:28;a:7:{s:4:\"name\";s:8:\"Talogtog\";s:4:\"code\";s:3:\"TAL\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:29;a:7:{s:4:\"name\";s:6:\"Tonton\";s:4:\"code\";s:3:\"TON\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:30;a:7:{s:4:\"name\";s:6:\"Tumbar\";s:4:\"code\";s:3:\"TUM\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:31;a:7:{s:4:\"name\";s:4:\"Wawa\";s:4:\"code\";s:3:\"WAW\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}}}', 1768321788),
('laravel-cache-bd307a3ec329e10a2cff8fb87480823da114f8f4', 'i:7;', 1767284234),
('laravel-cache-bd307a3ec329e10a2cff8fb87480823da114f8f4:timer', 'i:1767284234;', 1767284234);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-benefits_applications_page_1', 'O:42:\"Illuminate\\Pagination\\LengthAwarePaginator\":12:{s:8:\"\0*\0items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:9:{i:0;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:133;s:9:\"senior_id\";i:95;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 15:39:41\";s:10:\"created_at\";s:19:\"2025-12-04 15:39:41\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:133;s:9:\"senior_id\";i:95;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 15:39:41\";s:10:\"created_at\";s:19:\"2025-12-04 15:39:41\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:95;s:7:\"osca_id\";s:8:\"2025-095\";s:10:\"first_name\";s:6:\"Jordon\";s:9:\"last_name\";s:12:\"Christiansen\";s:11:\"middle_name\";s:8:\"Stephany\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1935-03-10\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:95;s:7:\"osca_id\";s:8:\"2025-095\";s:10:\"first_name\";s:6:\"Jordon\";s:9:\"last_name\";s:12:\"Christiansen\";s:11:\"middle_name\";s:8:\"Stephany\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1935-03-10\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:132;s:9:\"senior_id\";i:32;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 15:12:47\";s:10:\"created_at\";s:19:\"2025-12-04 15:12:47\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:132;s:9:\"senior_id\";i:32;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 15:12:47\";s:10:\"created_at\";s:19:\"2025-12-04 15:12:47\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:32;s:7:\"osca_id\";s:8:\"2025-032\";s:10:\"first_name\";s:6:\"Isaias\";s:9:\"last_name\";s:9:\"Langworth\";s:11:\"middle_name\";s:7:\"Edgardo\";s:14:\"name_extension\";s:1:\"V\";s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1943-05-05\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:32;s:7:\"osca_id\";s:8:\"2025-032\";s:10:\"first_name\";s:6:\"Isaias\";s:9:\"last_name\";s:9:\"Langworth\";s:11:\"middle_name\";s:7:\"Edgardo\";s:14:\"name_extension\";s:1:\"V\";s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1943-05-05\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:124;s:9:\"senior_id\";i:113;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:10:10\";s:10:\"created_at\";s:19:\"2025-12-04 14:10:10\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:124;s:9:\"senior_id\";i:113;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:10:10\";s:10:\"created_at\";s:19:\"2025-12-04 14:10:10\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:113;s:7:\"osca_id\";s:8:\"2025-341\";s:10:\"first_name\";s:9:\"Frederico\";s:9:\"last_name\";s:5:\"Arias\";s:11:\"middle_name\";s:6:\"Santos\";s:14:\"name_extension\";N;s:8:\"barangay\";s:6:\"tumbar\";s:13:\"date_of_birth\";s:10:\"1940-02-25\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:113;s:7:\"osca_id\";s:8:\"2025-341\";s:10:\"first_name\";s:9:\"Frederico\";s:9:\"last_name\";s:5:\"Arias\";s:11:\"middle_name\";s:6:\"Santos\";s:14:\"name_extension\";N;s:8:\"barangay\";s:6:\"tumbar\";s:13:\"date_of_birth\";s:10:\"1940-02-25\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:123;s:9:\"senior_id\";i:122;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:06:33\";s:10:\"created_at\";s:19:\"2025-12-04 14:06:33\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:123;s:9:\"senior_id\";i:122;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:06:33\";s:10:\"created_at\";s:19:\"2025-12-04 14:06:33\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:122;s:7:\"osca_id\";s:8:\"2025-350\";s:10:\"first_name\";s:9:\"Felicitas\";s:9:\"last_name\";s:7:\"Jimenez\";s:11:\"middle_name\";s:8:\"Baltazar\";s:14:\"name_extension\";N;s:8:\"barangay\";s:14:\"pangapisan-sur\";s:13:\"date_of_birth\";s:10:\"1940-06-06\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:122;s:7:\"osca_id\";s:8:\"2025-350\";s:10:\"first_name\";s:9:\"Felicitas\";s:9:\"last_name\";s:7:\"Jimenez\";s:11:\"middle_name\";s:8:\"Baltazar\";s:14:\"name_extension\";N;s:8:\"barangay\";s:14:\"pangapisan-sur\";s:13:\"date_of_birth\";s:10:\"1940-06-06\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:115;s:9:\"senior_id\";i:129;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:43:47\";s:10:\"created_at\";s:19:\"2025-12-04 13:43:47\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:115;s:9:\"senior_id\";i:129;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:43:47\";s:10:\"created_at\";s:19:\"2025-12-04 13:43:47\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:129;s:7:\"osca_id\";s:8:\"2025-357\";s:10:\"first_name\";s:7:\"Teodora\";s:9:\"last_name\";s:8:\"Toringan\";s:11:\"middle_name\";s:6:\"Abalos\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1940-09-24\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:129;s:7:\"osca_id\";s:8:\"2025-357\";s:10:\"first_name\";s:7:\"Teodora\";s:9:\"last_name\";s:8:\"Toringan\";s:11:\"middle_name\";s:6:\"Abalos\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1940-09-24\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:114;s:9:\"senior_id\";i:130;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:42:38\";s:10:\"created_at\";s:19:\"2025-12-04 13:42:38\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:114;s:9:\"senior_id\";i:130;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:42:38\";s:10:\"created_at\";s:19:\"2025-12-04 13:42:38\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:130;s:7:\"osca_id\";s:8:\"2025-358\";s:10:\"first_name\";s:7:\"Teofilo\";s:9:\"last_name\";s:8:\"Albarida\";s:11:\"middle_name\";N;s:14:\"name_extension\";N;s:8:\"barangay\";s:17:\"domalandan-center\";s:13:\"date_of_birth\";s:10:\"1945-07-03\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:130;s:7:\"osca_id\";s:8:\"2025-358\";s:10:\"first_name\";s:7:\"Teofilo\";s:9:\"last_name\";s:8:\"Albarida\";s:11:\"middle_name\";N;s:14:\"name_extension\";N;s:8:\"barangay\";s:17:\"domalandan-center\";s:13:\"date_of_birth\";s:10:\"1945-07-03\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:111;s:9:\"senior_id\";i:18;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-10-08 15:56:45\";s:10:\"created_at\";s:19:\"2025-10-08 07:56:45\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:111;s:9:\"senior_id\";i:18;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-10-08 15:56:45\";s:10:\"created_at\";s:19:\"2025-10-08 07:56:45\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:18;s:7:\"osca_id\";s:8:\"2025-018\";s:10:\"first_name\";s:8:\"Felicity\";s:9:\"last_name\";s:4:\"Bode\";s:11:\"middle_name\";s:8:\"Garfield\";s:14:\"name_extension\";N;s:8:\"barangay\";s:6:\"malawa\";s:13:\"date_of_birth\";s:10:\"1935-06-01\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:18;s:7:\"osca_id\";s:8:\"2025-018\";s:10:\"first_name\";s:8:\"Felicity\";s:9:\"last_name\";s:4:\"Bode\";s:11:\"middle_name\";s:8:\"Garfield\";s:14:\"name_extension\";N;s:8:\"barangay\";s:6:\"malawa\";s:13:\"date_of_birth\";s:10:\"1935-06-01\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:104;s:9:\"senior_id\";i:2;s:6:\"status\";s:8:\"rejected\";s:12:\"submitted_at\";s:19:\"2025-09-21 12:20:51\";s:10:\"created_at\";s:19:\"2025-09-21 04:20:51\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:104;s:9:\"senior_id\";i:2;s:6:\"status\";s:8:\"rejected\";s:12:\"submitted_at\";s:19:\"2025-09-21 12:20:51\";s:10:\"created_at\";s:19:\"2025-09-21 04:20:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:2;s:7:\"osca_id\";s:8:\"2025-002\";s:10:\"first_name\";s:5:\"Nasir\";s:9:\"last_name\";s:6:\"Hansen\";s:11:\"middle_name\";s:7:\"Rosendo\";s:14:\"name_extension\";N;s:8:\"barangay\";s:9:\"malimpuec\";s:13:\"date_of_birth\";s:10:\"1938-04-11\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:2;s:7:\"osca_id\";s:8:\"2025-002\";s:10:\"first_name\";s:5:\"Nasir\";s:9:\"last_name\";s:6:\"Hansen\";s:11:\"middle_name\";s:7:\"Rosendo\";s:14:\"name_extension\";N;s:8:\"barangay\";s:9:\"malimpuec\";s:13:\"date_of_birth\";s:10:\"1938-04-11\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:102;s:9:\"senior_id\";i:1;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-09-19 08:50:11\";s:10:\"created_at\";s:19:\"2025-09-19 00:50:11\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:102;s:9:\"senior_id\";i:1;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-09-19 08:50:11\";s:10:\"created_at\";s:19:\"2025-09-19 00:50:11\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:1;s:7:\"osca_id\";s:8:\"2025-001\";s:10:\"first_name\";s:7:\"Brannon\";s:9:\"last_name\";s:4:\"Kuhn\";s:11:\"middle_name\";s:6:\"Tomasa\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1935-01-31\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:1;s:7:\"osca_id\";s:8:\"2025-001\";s:10:\"first_name\";s:7:\"Brannon\";s:9:\"last_name\";s:4:\"Kuhn\";s:11:\"middle_name\";s:6:\"Tomasa\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1935-01-31\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}s:10:\"\0*\0perPage\";i:10;s:14:\"\0*\0currentPage\";i:1;s:7:\"\0*\0path\";s:31:\"https://eldera-osca.com/Seniors\";s:8:\"\0*\0query\";a:0:{}s:11:\"\0*\0fragment\";N;s:11:\"\0*\0pageName\";s:4:\"page\";s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:10:\"onEachSide\";i:3;s:10:\"\0*\0options\";a:2:{s:4:\"path\";s:31:\"https://eldera-osca.com/Seniors\";s:8:\"pageName\";s:4:\"page\";}s:8:\"\0*\0total\";i:9;s:11:\"\0*\0lastPage\";i:1;}', 1768321795);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-dashboard_statistics', 'a:5:{s:7:\"seniors\";a:8:{s:5:\"total\";i:132;s:4:\"male\";s:2:\"63\";s:6:\"female\";s:2:\"69\";s:12:\"with_pension\";s:2:\"50\";s:15:\"without_pension\";s:2:\"82\";s:6:\"active\";s:2:\"97\";s:8:\"deceased\";s:2:\"35\";s:12:\"pension_rate\";d:37.88;}s:12:\"applications\";a:6:{s:5:\"total\";i:130;s:7:\"pending\";s:2:\"40\";s:8:\"received\";s:2:\"33\";s:8:\"approved\";s:2:\"25\";s:8:\"rejected\";s:2:\"32\";s:15:\"completion_rate\";d:19.23;}s:6:\"events\";a:4:{s:5:\"total\";i:25;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"20\";}s:9:\"barangays\";a:2:{s:5:\"total\";i:32;s:9:\"barangays\";a:32:{i:0;a:7:{s:4:\"name\";s:9:\"Aliwekwek\";s:4:\"code\";s:3:\"ALW\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:1;a:7:{s:4:\"name\";s:4:\"Baay\";s:4:\"code\";s:3:\"BAA\";s:13:\"total_seniors\";i:6;s:10:\"male_count\";s:1:\"2\";s:12:\"female_count\";s:1:\"4\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:1:\"4\";}i:2;a:7:{s:4:\"name\";s:11:\"Balangobong\";s:4:\"code\";s:3:\"BAL\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:3;a:7:{s:4:\"name\";s:7:\"Balococ\";s:4:\"code\";s:3:\"BCO\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:4;a:7:{s:4:\"name\";s:8:\"Bantayan\";s:4:\"code\";s:3:\"BAN\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:5;a:7:{s:4:\"name\";s:6:\"Basing\";s:4:\"code\";s:3:\"BAS\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:6;a:7:{s:4:\"name\";s:10:\"Capandanan\";s:4:\"code\";s:3:\"CAP\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:7;a:7:{s:4:\"name\";s:17:\"Domalandan Center\";s:4:\"code\";s:3:\"DMC\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:8;a:7:{s:4:\"name\";s:15:\"Domalandan East\";s:4:\"code\";s:3:\"DME\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:9;a:7:{s:4:\"name\";s:15:\"Domalandan West\";s:4:\"code\";s:3:\"DMW\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:10;a:7:{s:4:\"name\";s:8:\"Dorongan\";s:4:\"code\";s:3:\"DOR\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:11;a:7:{s:4:\"name\";s:5:\"Dulag\";s:4:\"code\";s:3:\"DUL\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:12;a:7:{s:4:\"name\";s:7:\"Estanza\";s:4:\"code\";s:3:\"EST\";s:13:\"total_seniors\";i:3;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"2\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"3\";}i:13;a:7:{s:4:\"name\";s:5:\"Lasip\";s:4:\"code\";s:3:\"LAS\";s:13:\"total_seniors\";i:3;s:10:\"male_count\";s:1:\"2\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:1:\"1\";}i:14;a:7:{s:4:\"name\";s:12:\"Libsong East\";s:4:\"code\";s:3:\"LSE\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:15;a:7:{s:4:\"name\";s:12:\"Libsong West\";s:4:\"code\";s:3:\"LSW\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:16;a:7:{s:4:\"name\";s:6:\"Malawa\";s:4:\"code\";s:3:\"MAL\";s:13:\"total_seniors\";i:7;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"6\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"6\";}i:17;a:7:{s:4:\"name\";s:9:\"Malimpuec\";s:4:\"code\";s:3:\"MLP\";s:13:\"total_seniors\";i:5;s:10:\"male_count\";s:1:\"2\";s:12:\"female_count\";s:1:\"3\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"4\";}i:18;a:7:{s:4:\"name\";s:7:\"Maniboc\";s:4:\"code\";s:3:\"MAN\";s:13:\"total_seniors\";i:15;s:10:\"male_count\";s:1:\"3\";s:12:\"female_count\";s:2:\"12\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:2:\"13\";}i:19;a:7:{s:4:\"name\";s:8:\"Matalava\";s:4:\"code\";s:3:\"MAT\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:20;a:7:{s:4:\"name\";s:10:\"Naguelguel\";s:4:\"code\";s:3:\"NAG\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:21;a:7:{s:4:\"name\";s:7:\"Namolan\";s:4:\"code\";s:3:\"NAM\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:22;a:7:{s:4:\"name\";s:16:\"Pangapisan North\";s:4:\"code\";s:3:\"PNN\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:23;a:7:{s:4:\"name\";s:14:\"Pangapisan Sur\";s:4:\"code\";s:3:\"PNS\";s:13:\"total_seniors\";i:0;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"0\";}i:24;a:7:{s:4:\"name\";s:9:\"Poblacion\";s:4:\"code\";s:3:\"POB\";s:13:\"total_seniors\";i:5;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"4\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"4\";}i:25;a:7:{s:4:\"name\";s:7:\"Quibaol\";s:4:\"code\";s:3:\"QUI\";s:13:\"total_seniors\";i:4;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"3\";s:18:\"with_pension_count\";s:1:\"2\";s:21:\"without_pension_count\";s:1:\"2\";}i:26;a:7:{s:4:\"name\";s:7:\"Rosario\";s:4:\"code\";s:3:\"ROS\";s:13:\"total_seniors\";i:9;s:10:\"male_count\";s:1:\"6\";s:12:\"female_count\";s:1:\"3\";s:18:\"with_pension_count\";s:1:\"6\";s:21:\"without_pension_count\";s:1:\"3\";}i:27;a:7:{s:4:\"name\";s:8:\"Sabangan\";s:4:\"code\";s:3:\"SAB\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"0\";s:12:\"female_count\";s:1:\"1\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:28;a:7:{s:4:\"name\";s:8:\"Talogtog\";s:4:\"code\";s:3:\"TAL\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:29;a:7:{s:4:\"name\";s:6:\"Tonton\";s:4:\"code\";s:3:\"TON\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}i:30;a:7:{s:4:\"name\";s:6:\"Tumbar\";s:4:\"code\";s:3:\"TUM\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"0\";s:21:\"without_pension_count\";s:1:\"1\";}i:31;a:7:{s:4:\"name\";s:4:\"Wawa\";s:4:\"code\";s:3:\"WAW\";s:13:\"total_seniors\";i:1;s:10:\"male_count\";s:1:\"1\";s:12:\"female_count\";s:1:\"0\";s:18:\"with_pension_count\";s:1:\"1\";s:21:\"without_pension_count\";s:1:\"0\";}}}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:3:{s:5:\"total\";i:25;s:4:\"male\";i:12;s:6:\"female\";i:13;}s:5:\"66-70\";a:3:{s:5:\"total\";i:20;s:4:\"male\";i:12;s:6:\"female\";i:8;}s:5:\"71-75\";a:3:{s:5:\"total\";i:18;s:4:\"male\";i:7;s:6:\"female\";i:11;}s:5:\"76-80\";a:3:{s:5:\"total\";i:22;s:4:\"male\";i:9;s:6:\"female\";i:13;}s:5:\"81-85\";a:3:{s:5:\"total\";i:18;s:4:\"male\";i:11;s:6:\"female\";i:7;}s:5:\"86-90\";a:3:{s:5:\"total\";i:13;s:4:\"male\";i:6;s:6:\"female\";i:7;}s:3:\"90+\";a:3:{s:5:\"total\";i:16;s:4:\"male\";i:6;s:6:\"female\";i:10;}}}', 1768321608),
('laravel-cache-dashboard_statistics_barangay_Aliwekwek', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:9:\"Aliwekwek\";s:9:\"barangays\";a:1:{i:0;s:9:\"Aliwekwek\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764902062),
('laravel-cache-dashboard_statistics_barangay_Balangobong', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:11:\"Balangobong\";s:9:\"barangays\";a:1:{i:0;s:11:\"Balangobong\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"1\";s:15:\"without_pension\";s:1:\"0\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:18;s:8:\"upcoming\";s:1:\"3\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764902725),
('laravel-cache-dashboard_statistics_barangay_Balococ', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:7:\"Balococ\";s:9:\"barangays\";a:1:{i:0;s:7:\"Balococ\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764902066),
('laravel-cache-dashboard_statistics_barangay_Bantayan', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:8:\"Bantayan\";s:9:\"barangays\";a:1:{i:0;s:8:\"Bantayan\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764901031),
('laravel-cache-dashboard_statistics_barangay_Basing', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:6:\"Basing\";s:9:\"barangays\";a:1:{i:0;s:6:\"Basing\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"1\";s:15:\"without_pension\";s:1:\"0\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:21;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"1\";s:9:\"completed\";s:2:\"16\";}}', 1764863463),
('laravel-cache-dashboard_statistics_barangay_Capandanan', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:10:\"Capandanan\";s:9:\"barangays\";a:1:{i:0;s:10:\"Capandanan\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"0\";s:6:\"female\";s:1:\"1\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:1;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764902109),
('laravel-cache-dashboard_statistics_barangay_Domalandan Center', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:17:\"Domalandan Center\";s:9:\"barangays\";a:1:{i:0;s:17:\"Domalandan Center\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:2;s:7:\"pending\";s:1:\"2\";s:8:\"received\";s:1:\"0\";s:8:\"approved\";s:1:\"0\";s:8:\"rejected\";s:1:\"0\";}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:21;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"1\";s:9:\"completed\";s:2:\"16\";}}', 1764863484),
('laravel-cache-dashboard_statistics_barangay_Domalandan East', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:15:\"Domalandan East\";s:9:\"barangays\";a:1:{i:0;s:15:\"Domalandan East\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:7;s:4:\"male\";s:1:\"4\";s:6:\"female\";s:1:\"3\";s:12:\"with_pension\";s:1:\"2\";s:15:\"without_pension\";s:1:\"5\";}s:12:\"applications\";a:5:{s:5:\"total\";i:8;s:7:\"pending\";s:1:\"1\";s:8:\"received\";s:1:\"2\";s:8:\"approved\";s:1:\"4\";s:8:\"rejected\";s:1:\"1\";}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:1;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:1;}s:5:\"76-80\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:1;}s:5:\"81-85\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764901067),
('laravel-cache-dashboard_statistics_barangay_Domalandan West', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:15:\"Domalandan West\";s:9:\"barangays\";a:1:{i:0;s:15:\"Domalandan West\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"1\";s:15:\"without_pension\";s:1:\"0\";}s:12:\"applications\";a:5:{s:5:\"total\";i:2;s:7:\"pending\";s:1:\"1\";s:8:\"received\";s:1:\"1\";s:8:\"approved\";s:1:\"0\";s:8:\"rejected\";s:1:\"0\";}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764901079),
('laravel-cache-dashboard_statistics_barangay_Naguelguel', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:10:\"Naguelguel\";s:9:\"barangays\";a:1:{i:0;s:10:\"Naguelguel\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"0\";s:6:\"female\";s:1:\"1\";s:12:\"with_pension\";s:1:\"1\";s:15:\"without_pension\";s:1:\"0\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:1;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764901056),
('laravel-cache-dashboard_statistics_barangay_Pangapisan North', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:16:\"Pangapisan North\";s:9:\"barangays\";a:1:{i:0;s:16:\"Pangapisan North\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764902112),
('laravel-cache-dashboard_statistics_barangay_Poblacion', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:9:\"Poblacion\";s:9:\"barangays\";a:1:{i:0;s:9:\"Poblacion\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:8;s:4:\"male\";s:1:\"2\";s:6:\"female\";s:1:\"6\";s:12:\"with_pension\";s:1:\"3\";s:15:\"without_pension\";s:1:\"5\";}s:12:\"applications\";a:5:{s:5:\"total\";i:7;s:7:\"pending\";s:1:\"3\";s:8:\"received\";s:1:\"1\";s:8:\"approved\";s:1:\"1\";s:8:\"rejected\";s:1:\"2\";}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:2;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:1;}s:5:\"71-75\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:1;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:2;}}s:6:\"events\";a:4:{s:5:\"total\";i:17;s:8:\"upcoming\";s:1:\"2\";s:7:\"ongoing\";s:1:\"0\";s:9:\"completed\";s:2:\"15\";}}', 1764901061),
('laravel-cache-dashboard_statistics_barangay_Rosario', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:7:\"Rosario\";s:9:\"barangays\";a:1:{i:0;s:7:\"Rosario\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:11;s:4:\"male\";s:1:\"8\";s:6:\"female\";s:1:\"3\";s:12:\"with_pension\";s:1:\"6\";s:15:\"without_pension\";s:1:\"5\";}s:12:\"applications\";a:5:{s:5:\"total\";i:10;s:7:\"pending\";s:1:\"0\";s:8:\"received\";s:1:\"3\";s:8:\"approved\";s:1:\"2\";s:8:\"rejected\";s:1:\"5\";}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:2;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:2;s:6:\"female\";i:1;}s:5:\"71-75\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:2;}s:5:\"81-85\";a:2:{s:4:\"male\";i:2;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:21;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"1\";s:9:\"completed\";s:2:\"16\";}}', 1764863497),
('laravel-cache-dashboard_statistics_barangay_Sabangan', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:8:\"Sabangan\";s:9:\"barangays\";a:1:{i:0;s:8:\"Sabangan\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"0\";s:6:\"female\";s:1:\"1\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:1;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:21;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"1\";s:9:\"completed\";s:2:\"16\";}}', 1764863470),
('laravel-cache-dashboard_statistics_barangay_Talogtog', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:8:\"Talogtog\";s:9:\"barangays\";a:1:{i:0;s:8:\"Talogtog\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"1\";s:15:\"without_pension\";s:1:\"0\";}s:12:\"applications\";a:5:{s:5:\"total\";i:0;s:7:\"pending\";i:0;s:8:\"received\";i:0;s:8:\"approved\";i:0;s:8:\"rejected\";i:0;}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:21;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"1\";s:9:\"completed\";s:2:\"16\";}}', 1764863468),
('laravel-cache-dashboard_statistics_barangay_Tumbar', 'a:5:{s:9:\"barangays\";a:3:{s:5:\"total\";i:1;s:8:\"selected\";s:6:\"Tumbar\";s:9:\"barangays\";a:1:{i:0;s:6:\"Tumbar\";}}s:7:\"seniors\";a:5:{s:5:\"total\";i:1;s:4:\"male\";s:1:\"1\";s:6:\"female\";s:1:\"0\";s:12:\"with_pension\";s:1:\"0\";s:15:\"without_pension\";s:1:\"1\";}s:12:\"applications\";a:5:{s:5:\"total\";i:1;s:7:\"pending\";s:1:\"1\";s:8:\"received\";s:1:\"0\";s:8:\"approved\";s:1:\"0\";s:8:\"rejected\";s:1:\"0\";}s:16:\"age_distribution\";a:7:{s:5:\"60-65\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"66-70\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"71-75\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"76-80\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:5:\"81-85\";a:2:{s:4:\"male\";i:1;s:6:\"female\";i:0;}s:5:\"86-90\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}s:3:\"90+\";a:2:{s:4:\"male\";i:0;s:6:\"female\";i:0;}}s:6:\"events\";a:4:{s:5:\"total\";i:21;s:8:\"upcoming\";s:1:\"5\";s:7:\"ongoing\";s:1:\"1\";s:9:\"completed\";s:2:\"16\";}}', 1764863487);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-id_applications_page_1', 'O:42:\"Illuminate\\Pagination\\LengthAwarePaginator\":12:{s:8:\"\0*\0items\";O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:10:{i:0;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:130;s:9:\"senior_id\";i:134;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:29:15\";s:10:\"created_at\";s:19:\"2025-12-04 14:29:15\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:130;s:9:\"senior_id\";i:134;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:29:15\";s:10:\"created_at\";s:19:\"2025-12-04 14:29:15\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:134;s:7:\"osca_id\";s:8:\"2025-362\";s:10:\"first_name\";s:5:\"Maria\";s:9:\"last_name\";s:7:\"Mendoza\";s:11:\"middle_name\";s:5:\"Lopez\";s:14:\"name_extension\";N;s:8:\"barangay\";s:5:\"dulag\";s:13:\"date_of_birth\";s:10:\"1953-07-30\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:134;s:7:\"osca_id\";s:8:\"2025-362\";s:10:\"first_name\";s:5:\"Maria\";s:9:\"last_name\";s:7:\"Mendoza\";s:11:\"middle_name\";s:5:\"Lopez\";s:14:\"name_extension\";N;s:8:\"barangay\";s:5:\"dulag\";s:13:\"date_of_birth\";s:10:\"1953-07-30\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:129;s:9:\"senior_id\";i:44;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:28:20\";s:10:\"created_at\";s:19:\"2025-12-04 14:28:20\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:129;s:9:\"senior_id\";i:44;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:28:20\";s:10:\"created_at\";s:19:\"2025-12-04 14:28:20\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:44;s:7:\"osca_id\";s:8:\"2025-044\";s:10:\"first_name\";s:3:\"Flo\";s:9:\"last_name\";s:5:\"Zieme\";s:11:\"middle_name\";s:5:\"Grace\";s:14:\"name_extension\";N;s:8:\"barangay\";s:12:\"libsong-east\";s:13:\"date_of_birth\";s:10:\"1941-08-17\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:44;s:7:\"osca_id\";s:8:\"2025-044\";s:10:\"first_name\";s:3:\"Flo\";s:9:\"last_name\";s:5:\"Zieme\";s:11:\"middle_name\";s:5:\"Grace\";s:14:\"name_extension\";N;s:8:\"barangay\";s:12:\"libsong-east\";s:13:\"date_of_birth\";s:10:\"1941-08-17\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:128;s:9:\"senior_id\";i:128;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:22:05\";s:10:\"created_at\";s:19:\"2025-12-04 14:22:05\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:128;s:9:\"senior_id\";i:128;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:22:05\";s:10:\"created_at\";s:19:\"2025-12-04 14:22:05\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:128;s:7:\"osca_id\";s:8:\"2025-356\";s:10:\"first_name\";s:7:\"Avelino\";s:9:\"last_name\";s:7:\"Salinas\";s:11:\"middle_name\";s:7:\"Jacinto\";s:14:\"name_extension\";N;s:8:\"barangay\";s:5:\"lasip\";s:13:\"date_of_birth\";s:10:\"1959-04-07\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:128;s:7:\"osca_id\";s:8:\"2025-356\";s:10:\"first_name\";s:7:\"Avelino\";s:9:\"last_name\";s:7:\"Salinas\";s:11:\"middle_name\";s:7:\"Jacinto\";s:14:\"name_extension\";N;s:8:\"barangay\";s:5:\"lasip\";s:13:\"date_of_birth\";s:10:\"1959-04-07\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:127;s:9:\"senior_id\";i:122;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:18:37\";s:10:\"created_at\";s:19:\"2025-12-04 14:18:37\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:127;s:9:\"senior_id\";i:122;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:18:37\";s:10:\"created_at\";s:19:\"2025-12-04 14:18:37\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:122;s:7:\"osca_id\";s:8:\"2025-350\";s:10:\"first_name\";s:9:\"Felicitas\";s:9:\"last_name\";s:7:\"Jimenez\";s:11:\"middle_name\";s:8:\"Baltazar\";s:14:\"name_extension\";N;s:8:\"barangay\";s:14:\"pangapisan-sur\";s:13:\"date_of_birth\";s:10:\"1940-06-06\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:122;s:7:\"osca_id\";s:8:\"2025-350\";s:10:\"first_name\";s:9:\"Felicitas\";s:9:\"last_name\";s:7:\"Jimenez\";s:11:\"middle_name\";s:8:\"Baltazar\";s:14:\"name_extension\";N;s:8:\"barangay\";s:14:\"pangapisan-sur\";s:13:\"date_of_birth\";s:10:\"1940-06-06\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:126;s:9:\"senior_id\";i:131;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:15:32\";s:10:\"created_at\";s:19:\"2025-12-04 14:15:32\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:126;s:9:\"senior_id\";i:131;s:6:\"status\";s:8:\"received\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:15:32\";s:10:\"created_at\";s:19:\"2025-12-04 14:15:32\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:131;s:7:\"osca_id\";s:8:\"2025-359\";s:10:\"first_name\";s:5:\"Mario\";s:9:\"last_name\";s:7:\"Quimson\";s:11:\"middle_name\";N;s:14:\"name_extension\";N;s:8:\"barangay\";s:15:\"domalandan-west\";s:13:\"date_of_birth\";s:10:\"1957-03-06\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:131;s:7:\"osca_id\";s:8:\"2025-359\";s:10:\"first_name\";s:5:\"Mario\";s:9:\"last_name\";s:7:\"Quimson\";s:11:\"middle_name\";N;s:14:\"name_extension\";N;s:8:\"barangay\";s:15:\"domalandan-west\";s:13:\"date_of_birth\";s:10:\"1957-03-06\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:122;s:9:\"senior_id\";i:136;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:05:39\";s:10:\"created_at\";s:19:\"2025-12-04 14:05:39\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:122;s:9:\"senior_id\";i:136;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 14:05:39\";s:10:\"created_at\";s:19:\"2025-12-04 14:05:39\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:136;s:7:\"osca_id\";s:8:\"2025-364\";s:10:\"first_name\";s:8:\"Virgillo\";s:9:\"last_name\";s:7:\"Basilio\";s:11:\"middle_name\";s:8:\"Bautista\";s:14:\"name_extension\";N;s:8:\"barangay\";s:8:\"dorongan\";s:13:\"date_of_birth\";s:10:\"1955-08-25\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:136;s:7:\"osca_id\";s:8:\"2025-364\";s:10:\"first_name\";s:8:\"Virgillo\";s:9:\"last_name\";s:7:\"Basilio\";s:11:\"middle_name\";s:8:\"Bautista\";s:14:\"name_extension\";N;s:8:\"barangay\";s:8:\"dorongan\";s:13:\"date_of_birth\";s:10:\"1955-08-25\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:119;s:9:\"senior_id\";i:106;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:54:38\";s:10:\"created_at\";s:19:\"2025-12-04 13:54:38\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:119;s:9:\"senior_id\";i:106;s:6:\"status\";s:8:\"approved\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:54:38\";s:10:\"created_at\";s:19:\"2025-12-04 13:54:38\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:106;s:7:\"osca_id\";s:8:\"2025-334\";s:10:\"first_name\";s:4:\"John\";s:9:\"last_name\";s:9:\"Casaclang\";s:11:\"middle_name\";s:4:\"Cruz\";s:14:\"name_extension\";N;s:8:\"barangay\";s:6:\"tonton\";s:13:\"date_of_birth\";s:10:\"1951-09-09\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:106;s:7:\"osca_id\";s:8:\"2025-334\";s:10:\"first_name\";s:4:\"John\";s:9:\"last_name\";s:9:\"Casaclang\";s:11:\"middle_name\";s:4:\"Cruz\";s:14:\"name_extension\";N;s:8:\"barangay\";s:6:\"tonton\";s:13:\"date_of_birth\";s:10:\"1951-09-09\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:118;s:9:\"senior_id\";i:130;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:52:51\";s:10:\"created_at\";s:19:\"2025-12-04 13:52:51\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:118;s:9:\"senior_id\";i:130;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:52:51\";s:10:\"created_at\";s:19:\"2025-12-04 13:52:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:130;s:7:\"osca_id\";s:8:\"2025-358\";s:10:\"first_name\";s:7:\"Teofilo\";s:9:\"last_name\";s:8:\"Albarida\";s:11:\"middle_name\";N;s:14:\"name_extension\";N;s:8:\"barangay\";s:17:\"domalandan-center\";s:13:\"date_of_birth\";s:10:\"1945-07-03\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:130;s:7:\"osca_id\";s:8:\"2025-358\";s:10:\"first_name\";s:7:\"Teofilo\";s:9:\"last_name\";s:8:\"Albarida\";s:11:\"middle_name\";N;s:14:\"name_extension\";N;s:8:\"barangay\";s:17:\"domalandan-center\";s:13:\"date_of_birth\";s:10:\"1945-07-03\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:117;s:9:\"senior_id\";i:115;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:51:36\";s:10:\"created_at\";s:19:\"2025-12-04 13:51:36\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:117;s:9:\"senior_id\";i:115;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-04 13:51:36\";s:10:\"created_at\";s:19:\"2025-12-04 13:51:36\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:115;s:7:\"osca_id\";s:8:\"2025-343\";s:10:\"first_name\";s:5:\"Lilio\";s:9:\"last_name\";s:9:\"De Guzman\";s:11:\"middle_name\";s:8:\"Santiago\";s:14:\"name_extension\";N;s:8:\"barangay\";s:12:\"libsong-west\";s:13:\"date_of_birth\";s:10:\"1957-07-30\";s:3:\"sex\";s:4:\"Male\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:115;s:7:\"osca_id\";s:8:\"2025-343\";s:10:\"first_name\";s:5:\"Lilio\";s:9:\"last_name\";s:9:\"De Guzman\";s:11:\"middle_name\";s:8:\"Santiago\";s:14:\"name_extension\";N;s:8:\"barangay\";s:12:\"libsong-west\";s:13:\"date_of_birth\";s:10:\"1957-07-30\";s:3:\"sex\";s:4:\"Male\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:9;O:22:\"App\\Models\\Application\":33:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:12:\"applications\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:113;s:9:\"senior_id\";i:95;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-03 13:45:09\";s:10:\"created_at\";s:19:\"2025-12-03 13:45:09\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:113;s:9:\"senior_id\";i:95;s:6:\"status\";s:7:\"pending\";s:12:\"submitted_at\";s:19:\"2025-12-03 13:45:09\";s:10:\"created_at\";s:19:\"2025-12-03 13:45:09\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:4:{s:12:\"submitted_at\";s:8:\"datetime\";s:11:\"reviewed_at\";s:8:\"datetime\";s:25:\"estimated_completion_date\";s:4:\"date\";s:8:\"metadata\";s:5:\"array\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:6:\"senior\";O:17:\"App\\Models\\Senior\":34:{s:13:\"\0*\0connection\";s:10:\"eldera_ims\";s:8:\"\0*\0table\";s:7:\"seniors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:95;s:7:\"osca_id\";s:8:\"2025-095\";s:10:\"first_name\";s:6:\"Jordon\";s:9:\"last_name\";s:12:\"Christiansen\";s:11:\"middle_name\";s:8:\"Stephany\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1935-03-10\";s:3:\"sex\";s:6:\"Female\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:95;s:7:\"osca_id\";s:8:\"2025-095\";s:10:\"first_name\";s:6:\"Jordon\";s:9:\"last_name\";s:12:\"Christiansen\";s:11:\"middle_name\";s:8:\"Stephany\";s:14:\"name_extension\";N;s:8:\"barangay\";s:7:\"maniboc\";s:13:\"date_of_birth\";s:10:\"1935-03-10\";s:3:\"sex\";s:6:\"Female\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:21:{s:13:\"date_of_birth\";s:4:\"date\";s:10:\"can_travel\";s:7:\"boolean\";s:11:\"has_pension\";s:7:\"boolean\";s:15:\"has_app_account\";s:7:\"boolean\";s:6:\"skills\";s:5:\"array\";s:20:\"community_activities\";s:5:\"array\";s:11:\"living_with\";s:5:\"array\";s:19:\"household_condition\";s:5:\"array\";s:16:\"source_of_income\";s:5:\"array\";s:11:\"real_assets\";s:5:\"array\";s:15:\"personal_assets\";s:5:\"array\";s:14:\"problems_needs\";s:5:\"array\";s:15:\"health_problems\";s:5:\"array\";s:14:\"dental_concern\";s:5:\"array\";s:14:\"visual_concern\";s:5:\"array\";s:17:\"hearing_condition\";s:5:\"array\";s:16:\"social_emotional\";s:5:\"array\";s:15:\"area_difficulty\";s:5:\"array\";s:8:\"children\";s:5:\"array\";s:9:\"dependent\";s:5:\"array\";s:10:\"deleted_at\";s:8:\"datetime\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:2:{i:0;s:9:\"full_name\";i:1;s:3:\"age\";}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:76:{i:0;s:7:\"osca_id\";i:1;s:9:\"last_name\";i:2;s:10:\"first_name\";i:3;s:11:\"middle_name\";i:4;s:14:\"name_extension\";i:5;s:6:\"region\";i:6;s:8:\"province\";i:7;s:4:\"city\";i:8;s:8:\"barangay\";i:9;s:9:\"residence\";i:10;s:6:\"street\";i:11;s:13:\"date_of_birth\";i:12;s:11:\"birth_place\";i:13;s:14:\"marital_status\";i:14;s:3:\"sex\";i:15;s:14:\"contact_number\";i:16;s:5:\"email\";i:17;s:8:\"religion\";i:18;s:13:\"ethnic_origin\";i:19;s:8:\"language\";i:20;s:8:\"gsis_sss\";i:21;s:3:\"tin\";i:22;s:10:\"philhealth\";i:23;s:14:\"sc_association\";i:24;s:13:\"other_govt_id\";i:25;s:10:\"can_travel\";i:26;s:10:\"employment\";i:27;s:11:\"has_pension\";i:28;s:15:\"has_app_account\";i:29;s:6:\"status\";i:30;s:10:\"photo_path\";i:31;s:16:\"spouse_last_name\";i:32;s:17:\"spouse_first_name\";i:33;s:18:\"spouse_middle_name\";i:34;s:16:\"spouse_extension\";i:35;s:16:\"father_last_name\";i:36;s:17:\"father_first_name\";i:37;s:18:\"father_middle_name\";i:38;s:16:\"father_extension\";i:39;s:16:\"mother_last_name\";i:40;s:17:\"mother_first_name\";i:41;s:18:\"mother_middle_name\";i:42;s:16:\"mother_extension\";i:43;s:8:\"children\";i:44;s:9:\"dependent\";i:45;s:15:\"education_level\";i:46;s:6:\"skills\";i:47;s:13:\"shared_skills\";i:48;s:20:\"community_activities\";i:49;s:24:\"living_condition_primary\";i:50;s:11:\"living_with\";i:51;s:19:\"household_condition\";i:52;s:16:\"source_of_income\";i:53;s:11:\"real_assets\";i:54;s:15:\"personal_assets\";i:55;s:14:\"monthly_income\";i:56;s:14:\"problems_needs\";i:57;s:10:\"blood_type\";i:58;s:19:\"physical_disability\";i:59;s:15:\"health_problems\";i:60;s:14:\"dental_concern\";i:61;s:14:\"visual_concern\";i:62;s:17:\"hearing_condition\";i:63;s:16:\"social_emotional\";i:64;s:15:\"area_difficulty\";i:65;s:21:\"maintenance_medicines\";i:66;s:17:\"scheduled_checkup\";i:67;s:17:\"checkup_frequency\";i:68;s:16:\"permanent_income\";i:69;s:13:\"income_amount\";i:70;s:13:\"income_source\";i:71;s:16:\"existing_illness\";i:72;s:15:\"illness_specify\";i:73;s:15:\"with_disability\";i:74;s:18:\"disability_specify\";i:75;s:13:\"certification\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:16:\"\0*\0forceDeleting\";b:0;}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:10:{i:0;s:9:\"senior_id\";i:1;s:16:\"application_type\";i:2;s:6:\"status\";i:3;s:12:\"submitted_by\";i:4;s:12:\"submitted_at\";i:5;s:11:\"reviewed_by\";i:6;s:11:\"reviewed_at\";i:7;s:5:\"notes\";i:8;s:8:\"metadata\";i:9;s:25:\"estimated_completion_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}s:10:\"\0*\0perPage\";i:10;s:14:\"\0*\0currentPage\";i:1;s:7:\"\0*\0path\";s:31:\"https://eldera-osca.com/Seniors\";s:8:\"\0*\0query\";a:0:{}s:11:\"\0*\0fragment\";N;s:11:\"\0*\0pageName\";s:4:\"page\";s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:10:\"onEachSide\";i:3;s:10:\"\0*\0options\";a:2:{s:4:\"path\";s:31:\"https://eldera-osca.com/Seniors\";s:8:\"pageName\";s:4:\"page\";}s:8:\"\0*\0total\";i:18;s:11:\"\0*\0lastPage\";i:2;}', 1768321795);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `application_id` bigint(20) UNSIGNED DEFAULT NULL,
  `event_id` bigint(20) UNSIGNED DEFAULT NULL,
  `senior_id` bigint(20) UNSIGNED DEFAULT NULL,
  `document_type` enum('photo','id_document','supporting_document','event_document') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `uploaded_by` bigint(20) UNSIGNED NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eldera_users`
--

CREATE TABLE `eldera_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `osca_id` varchar(255) NOT NULL,
  `senior_id` bigint(20) UNSIGNED NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `event_type` enum('general','pension','health','id_claiming') NOT NULL,
  `event_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `organizer` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `status` enum('upcoming','ongoing','completed','cancelled') NOT NULL DEFAULT 'upcoming',
  `max_participants` int(11) DEFAULT NULL,
  `current_participants` int(11) NOT NULL DEFAULT 0,
  `requirements` text DEFAULT NULL,
  `recipient_selection` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `event_type`, `event_date`, `start_time`, `end_time`, `location`, `organizer`, `contact_person`, `contact_number`, `status`, `max_participants`, `current_participants`, `requirements`, `recipient_selection`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'Health Check-up Program', 'Free health check-up including blood pressure, blood sugar, and general health assessment.', 'health', '2025-09-28', '08:00:00', '12:00:00', 'Municipal Health Center', 'Municipal Health Office', 'Dr. Juan Dela Cruz', '09123456790', 'upcoming', 100, 0, 'Fasting for 8 hours, bring previous medical records', NULL, 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(3, 'Pension Distribution', 'Monthly distribution of social pension for qualified senior citizens.', 'pension', '2025-10-03', '08:00:00', '16:00:00', 'Municipal Hall', 'DSWD Municipal Office', 'Ana Rodriguez', '09123456791', 'upcoming', 200, 0, 'Valid OSCA ID, DSWD ID, and authorization letter', NULL, 1, '2025-09-18 01:48:54', '2025-09-18 01:48:54'),
(4, 'Senior Citizen ID Claiming', 'Distribution of newly printed Senior Citizen ID cards.', 'id_claiming', '2025-10-08', '09:00:00', '15:00:00', 'OSCA Office', 'Office of Senior Citizens Affairs', 'Pedro Martinez', '09123456792', 'upcoming', 75, 3, 'Application receipt and valid ID', NULL, 1, '2025-09-18 01:48:54', '2025-10-07 07:40:30'),
(5, 'Nutrition Program', 'Distribution of nutritional supplements and health education session.', 'health', '2025-10-13', '10:00:00', '12:00:00', 'Barangay Health Station', 'Municipal Nutrition Office', 'Carmen Lopez', '09123456793', 'upcoming', 30, 3, 'Valid OSCA ID and medical clearance', NULL, 1, '2025-09-18 01:48:54', '2025-10-07 08:52:50'),
(7, 'Senior Citizen Meeting', NULL, 'general', '2025-09-30', '10:00:00', '12:00:00', 'Lingayen Plaza', 'Brenda Mage', 'Brenda Tank', '09725235451', 'upcoming', NULL, 0, NULL, NULL, 4, '2025-09-19 01:30:31', '2025-09-19 01:30:31'),
(8, 'Monthly Senior Citizens Meeting', 'Regular monthly meeting for all senior citizens to discuss community matters and upcoming activities.', 'general', '2025-09-28', '09:00:00', '11:00:00', 'LCSCF Office', 'LCSCF Office', 'Maria Santos', '09123456789', 'upcoming', 50, 0, 'Valid Senior Citizen ID', NULL, 1, '2025-09-21 01:16:23', '2025-09-21 01:16:23'),
(9, 'Pension Distribution Day', 'Distribution of monthly pension benefits to eligible senior citizens.', 'pension', '2025-10-05', '08:00:00', '16:00:00', 'Municipal Hall', 'Municipal Social Welfare Office', 'Juan Dela Cruz', '09234567890', 'upcoming', 100, 0, 'Valid Senior Citizen ID, Pension Booklet', NULL, 1, '2025-09-21 01:16:23', '2025-09-21 01:16:23'),
(10, 'Free Health Check-up', 'Free medical check-up including blood pressure, blood sugar, and general health assessment.', 'health', '2025-10-12', '07:00:00', '12:00:00', 'Health Center', 'Municipal Health Office', 'Dr. Ana Rodriguez', '09345678901', 'upcoming', 75, 0, 'Valid Senior Citizen ID, Fasting (for blood sugar test)', NULL, 1, '2025-09-21 01:16:23', '2025-09-21 01:16:23'),
(11, 'Senior Citizen ID Claiming', 'Distribution of newly printed Senior Citizen ID cards.', 'id_claiming', '2025-10-19', '09:00:00', '15:00:00', 'LCSCF Office', 'LCSCF Office', 'Pedro Garcia', '09456789012', 'upcoming', 30, 1, 'Valid Senior Citizen ID, Authorization Letter (if claimed by representative)', NULL, 1, '2025-09-21 01:16:23', '2025-10-07 08:52:50'),
(12, 'Completed Health Seminar', 'Educational seminar about healthy aging and nutrition for senior citizens.', 'health', '2025-09-14', '10:00:00', '12:00:00', 'Community Center', 'Municipal Health Office', 'Dr. Elena Gonzalez', '09567890123', 'completed', 40, 35, 'Valid Senior Citizen ID', NULL, 1, '2025-09-21 01:16:23', '2025-09-21 01:16:23'),
(13, 'ID Claiming', NULL, 'id_claiming', '2025-09-27', '10:00:00', '16:00:00', 'Balococ', 'Mickey Mouse', 'Donald Duck', '09767452546', 'upcoming', NULL, 0, NULL, NULL, 4, '2025-09-21 21:27:43', '2025-09-21 21:27:43'),
(16, 'Medical', NULL, 'health', '2025-09-26', '09:00:00', NULL, 'Lingayen Plaza', 'LCSCF Office', 'Event Coordinator', '09123456789', 'upcoming', NULL, 0, 'Valid Senior Citizen ID', NULL, 4, '2025-09-21 21:49:31', '2025-09-21 21:49:31'),
(24, 'Pension', 'Receiving Pension', 'pension', '2025-10-22', '01:00:00', NULL, 'Lingayen', 'LCSCF Office', 'Event Coordinator', '000-000-0000', 'upcoming', NULL, 0, NULL, NULL, 6, '2025-10-08 07:42:00', '2025-10-08 07:42:00'),
(25, 'Medical Check UP', NULL, 'health', '2025-10-14', '10:00:00', NULL, 'baay Center', 'LCSCF Office', 'Event Coordinator', '000-000-0000', 'upcoming', NULL, 0, NULL, NULL, 6, '2025-10-08 07:48:05', '2025-10-08 07:54:52'),
(36, 'Pension Distribution', 'Monthly distribution of social pension for qualified senior citizens.', 'pension', '2025-12-02', '08:00:00', NULL, 'Municipal Hall', 'LCSCF Office', 'Event Coordinator', '000-000-0000', 'upcoming', NULL, 1, NULL, NULL, 6, '2025-11-30 14:19:18', '2025-12-01 14:09:35'),
(46, 'PENSION', 'Distribution of Pension.', 'pension', '2025-12-07', '08:00:00', NULL, 'OSCA OFFICE', NULL, NULL, NULL, 'upcoming', NULL, 100, NULL, NULL, 5, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(48, 'Social Pension', 'claiming for social pension of all senior citizens', 'pension', '2025-12-17', '08:00:00', '23:21:00', 'OSCA OFFICE', NULL, NULL, NULL, 'upcoming', NULL, 103, NULL, '{\"types\":[\"category\"],\"barangays\":[],\"categories\":[\"pension\"]}', 4, '2025-12-04 15:22:31', '2025-12-04 15:22:57'),
(49, 'OSCA', 'Senior ID claiming', 'id_claiming', '2025-12-17', '08:00:00', NULL, 'OSCA OFFICE', NULL, NULL, NULL, 'upcoming', NULL, 17, NULL, '{\"types\":[\"category\"],\"barangays\":[],\"categories\":[\"id_applicants\"]}', 16, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(50, 'DOH', 'Free Medical CheckUp to all Senior.', 'health', '2025-12-26', '08:00:00', NULL, 'Lingayen Center', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 5, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(51, 'Zumba', 'Zumba for all seniors', 'general', '2025-12-27', '08:00:00', '09:00:00', 'Lingayen Plaza', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 4, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(52, 'Free Medical Checkup', 'Free medical checkup for all senior.', 'health', '2026-08-01', '08:00:00', NULL, 'Lingayen Center', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 5, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(53, 'HEALTH CHECKUP', 'Free medical checkup for all seniors.', 'health', '2026-01-21', '08:00:00', NULL, 'Lingayen Center', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 5, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(54, 'Pension', 'Pension distribution.', 'pension', '2026-01-22', '08:00:00', '09:00:00', 'Lingayen Civic Center', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 6, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(55, 'ID', 'Claim your ID now', 'id_claiming', '2026-01-23', '08:00:00', '12:00:00', 'Lingayen Civic Center', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 6, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(56, 'Zumba', 'Zumba ng Katandaan', 'general', '2026-01-24', '17:00:00', '18:00:00', 'Lingayen Civic Center', NULL, NULL, NULL, 'upcoming', NULL, 132, NULL, '{\"types\":[\"all\"],\"barangays\":[],\"categories\":[]}', 6, '2026-01-13 00:09:26', '2026-01-13 00:09:27');

-- --------------------------------------------------------

--
-- Table structure for table `event_participants`
--

CREATE TABLE `event_participants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` bigint(20) UNSIGNED NOT NULL,
  `senior_id` bigint(20) UNSIGNED NOT NULL,
  `registered_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `attended` tinyint(1) NOT NULL DEFAULT 0,
  `attendance_notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_participants`
--

INSERT INTO `event_participants` (`id`, `event_id`, `senior_id`, `registered_at`, `attended`, `attendance_notes`, `created_at`, `updated_at`) VALUES
(3, 5, 17, '2025-10-02 01:43:51', 1, NULL, '2025-10-02 01:43:51', '2025-10-02 01:44:01'),
(4, 5, 5, '2025-10-02 01:44:46', 1, NULL, '2025-10-02 01:44:46', '2025-10-02 01:44:53'),
(5, 4, 1, '2025-10-03 00:06:47', 0, NULL, '2025-10-03 00:06:47', '2025-10-03 00:06:47'),
(6, 4, 8, '2025-10-03 00:07:02', 0, NULL, '2025-10-03 00:07:02', '2025-10-03 00:07:02'),
(7, 4, 17, '2025-10-07 07:40:30', 1, NULL, '2025-10-07 07:40:30', '2025-10-07 07:40:46'),
(8, 11, 6, '2025-10-07 08:52:50', 1, 'Present and engaged', '2025-10-07 08:52:50', '2025-10-07 08:52:50'),
(10, 5, 6, '2025-10-07 08:52:50', 0, 'Absent - family emergency', '2025-10-07 08:52:50', '2025-10-07 08:52:50'),
(20, 36, 17, '2025-12-01 14:09:35', 0, NULL, '2025-12-01 14:09:35', '2025-12-01 14:09:35'),
(638, 46, 1, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(639, 46, 2, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(640, 46, 3, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(641, 46, 4, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(642, 46, 5, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(643, 46, 6, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(644, 46, 7, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(645, 46, 8, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(646, 46, 9, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(647, 46, 10, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(648, 46, 11, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(649, 46, 12, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(650, 46, 13, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(651, 46, 14, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(652, 46, 15, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(653, 46, 16, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(654, 46, 17, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(655, 46, 18, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(656, 46, 19, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(657, 46, 20, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(658, 46, 21, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(659, 46, 22, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(660, 46, 23, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(661, 46, 24, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(662, 46, 25, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(663, 46, 26, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(664, 46, 27, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(665, 46, 28, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(666, 46, 29, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(667, 46, 30, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(668, 46, 31, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(669, 46, 32, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(670, 46, 33, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(671, 46, 34, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(672, 46, 35, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(673, 46, 36, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(674, 46, 37, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(675, 46, 38, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(676, 46, 39, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(677, 46, 40, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(678, 46, 41, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(679, 46, 42, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(680, 46, 43, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(681, 46, 44, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(682, 46, 45, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(683, 46, 46, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(684, 46, 47, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(685, 46, 48, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(686, 46, 49, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(687, 46, 50, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(688, 46, 51, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(689, 46, 52, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(690, 46, 53, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(691, 46, 54, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(692, 46, 55, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(693, 46, 56, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(694, 46, 57, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(695, 46, 58, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(696, 46, 59, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(697, 46, 60, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(698, 46, 61, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(699, 46, 62, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(700, 46, 63, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(701, 46, 64, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(702, 46, 65, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(703, 46, 66, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(704, 46, 67, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(705, 46, 68, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(706, 46, 69, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(707, 46, 70, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(708, 46, 71, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(709, 46, 72, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(710, 46, 73, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(711, 46, 74, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(712, 46, 75, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(713, 46, 76, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(714, 46, 77, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(715, 46, 78, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(716, 46, 79, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(717, 46, 80, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(718, 46, 81, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(719, 46, 82, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(720, 46, 83, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(721, 46, 84, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(722, 46, 85, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(723, 46, 86, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(724, 46, 87, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(725, 46, 88, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(726, 46, 89, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(727, 46, 90, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(728, 46, 91, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(729, 46, 92, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(730, 46, 93, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(731, 46, 94, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(732, 46, 95, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(733, 46, 96, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(734, 46, 97, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(735, 46, 98, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(736, 46, 99, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(737, 46, 100, '2025-12-04 00:11:58', 0, NULL, '2025-12-04 00:11:58', '2025-12-04 00:11:58'),
(841, 48, 1, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(842, 48, 2, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(843, 48, 3, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(844, 48, 4, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(845, 48, 5, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(846, 48, 6, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(847, 48, 7, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(848, 48, 8, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(849, 48, 9, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(850, 48, 10, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(851, 48, 11, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(852, 48, 12, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(853, 48, 13, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(854, 48, 14, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(855, 48, 15, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(856, 48, 16, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(857, 48, 17, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(858, 48, 18, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(859, 48, 19, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(860, 48, 20, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(861, 48, 21, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(862, 48, 22, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(863, 48, 23, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(864, 48, 24, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(865, 48, 25, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(866, 48, 26, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(867, 48, 27, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(868, 48, 28, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(869, 48, 29, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(870, 48, 30, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(871, 48, 31, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(872, 48, 32, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(873, 48, 33, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(874, 48, 34, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(875, 48, 35, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(876, 48, 36, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(877, 48, 37, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(878, 48, 38, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(879, 48, 39, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(880, 48, 40, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(881, 48, 41, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(882, 48, 42, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(883, 48, 43, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(884, 48, 44, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(885, 48, 45, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(886, 48, 46, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(887, 48, 47, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(888, 48, 48, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(889, 48, 49, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(890, 48, 50, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(891, 48, 51, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(892, 48, 52, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(893, 48, 53, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(894, 48, 54, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(895, 48, 55, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(896, 48, 56, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(897, 48, 57, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(898, 48, 58, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(899, 48, 59, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(900, 48, 60, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(901, 48, 61, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(902, 48, 62, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(903, 48, 63, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(904, 48, 64, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(905, 48, 65, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(906, 48, 66, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(907, 48, 67, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(908, 48, 68, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(909, 48, 69, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(910, 48, 70, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(911, 48, 71, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(912, 48, 72, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(913, 48, 73, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(914, 48, 74, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(915, 48, 75, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(916, 48, 76, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(917, 48, 77, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(918, 48, 78, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(919, 48, 79, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(920, 48, 80, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(921, 48, 81, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(922, 48, 82, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(923, 48, 83, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(924, 48, 84, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(925, 48, 85, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(926, 48, 86, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(927, 48, 87, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(928, 48, 88, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(929, 48, 89, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(930, 48, 90, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(931, 48, 91, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(932, 48, 92, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(933, 48, 93, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(934, 48, 94, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(935, 48, 95, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(936, 48, 96, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(937, 48, 97, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(938, 48, 98, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(939, 48, 99, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(940, 48, 100, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(941, 48, 128, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(942, 48, 131, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(943, 48, 136, '2025-12-04 15:22:57', 0, NULL, '2025-12-04 15:22:57', '2025-12-04 15:22:57'),
(946, 49, 3, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(947, 49, 4, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(948, 49, 9, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(949, 49, 15, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(950, 49, 18, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(951, 49, 19, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(952, 49, 44, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(953, 49, 57, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(954, 49, 95, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(955, 49, 106, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(956, 49, 115, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(957, 49, 122, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(958, 49, 128, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(959, 49, 130, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(960, 49, 131, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(961, 49, 134, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(962, 49, 136, '2025-12-05 02:41:13', 0, NULL, '2025-12-05 02:41:13', '2025-12-05 02:41:13'),
(963, 50, 1, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(964, 50, 2, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(965, 50, 3, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(966, 50, 4, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(967, 50, 5, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(968, 50, 6, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(969, 50, 7, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(970, 50, 8, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(971, 50, 9, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(972, 50, 10, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(973, 50, 11, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(974, 50, 12, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(975, 50, 13, '2025-12-05 04:35:35', 1, NULL, '2025-12-05 04:35:35', '2025-12-05 04:38:25'),
(976, 50, 14, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(977, 50, 15, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(978, 50, 16, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(979, 50, 17, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(980, 50, 18, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(981, 50, 19, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(982, 50, 20, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(983, 50, 21, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(984, 50, 22, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(985, 50, 23, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(986, 50, 24, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(987, 50, 25, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(988, 50, 26, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(989, 50, 27, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(990, 50, 28, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(991, 50, 29, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(992, 50, 30, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(993, 50, 31, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(994, 50, 32, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(995, 50, 33, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(996, 50, 34, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(997, 50, 35, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(998, 50, 36, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(999, 50, 37, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1000, 50, 38, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1001, 50, 39, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1002, 50, 40, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1003, 50, 41, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1004, 50, 42, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1005, 50, 43, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1006, 50, 44, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1007, 50, 45, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1008, 50, 46, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1009, 50, 47, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1010, 50, 48, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1011, 50, 49, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1012, 50, 50, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1013, 50, 51, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1014, 50, 52, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1015, 50, 53, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1016, 50, 54, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1017, 50, 55, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1018, 50, 56, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1019, 50, 57, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1020, 50, 58, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1021, 50, 59, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1022, 50, 60, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1023, 50, 61, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1024, 50, 62, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1025, 50, 63, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1026, 50, 64, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1027, 50, 65, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1028, 50, 66, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1029, 50, 67, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1030, 50, 68, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1031, 50, 69, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1032, 50, 70, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1033, 50, 71, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1034, 50, 72, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1035, 50, 73, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1036, 50, 74, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1037, 50, 75, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1038, 50, 76, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1039, 50, 77, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1040, 50, 78, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1041, 50, 79, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1042, 50, 80, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1043, 50, 81, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1044, 50, 82, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1045, 50, 83, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1046, 50, 84, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1047, 50, 85, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1048, 50, 86, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1049, 50, 87, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1050, 50, 88, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1051, 50, 89, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1052, 50, 90, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1053, 50, 91, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1054, 50, 92, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1055, 50, 93, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1056, 50, 94, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1057, 50, 95, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1058, 50, 96, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1059, 50, 97, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1060, 50, 98, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1061, 50, 99, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1062, 50, 100, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1063, 50, 104, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1064, 50, 105, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1065, 50, 106, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1066, 50, 107, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1067, 50, 108, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1068, 50, 109, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1069, 50, 110, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1070, 50, 111, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1071, 50, 112, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1072, 50, 113, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1073, 50, 114, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1074, 50, 115, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1075, 50, 116, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1076, 50, 117, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1077, 50, 118, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1078, 50, 119, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1079, 50, 120, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1080, 50, 121, '2025-12-05 04:35:35', 1, NULL, '2025-12-05 04:35:35', '2025-12-05 04:36:07'),
(1081, 50, 122, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1082, 50, 123, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1083, 50, 124, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1084, 50, 125, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1085, 50, 126, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1086, 50, 127, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1087, 50, 128, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1088, 50, 129, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1089, 50, 130, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1090, 50, 131, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1091, 50, 133, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1092, 50, 134, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1093, 50, 135, '2025-12-05 04:35:35', 0, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:35'),
(1094, 50, 136, '2025-12-05 04:35:35', 1, NULL, '2025-12-05 04:35:35', '2025-12-05 04:35:56'),
(1095, 51, 1, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1096, 51, 2, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1097, 51, 3, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1098, 51, 4, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1099, 51, 5, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1100, 51, 6, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1101, 51, 7, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1102, 51, 8, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1103, 51, 9, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1104, 51, 10, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1105, 51, 11, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1106, 51, 12, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1107, 51, 13, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1108, 51, 14, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1109, 51, 15, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1110, 51, 16, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1111, 51, 17, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1112, 51, 18, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1113, 51, 19, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1114, 51, 20, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1115, 51, 21, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1116, 51, 22, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1117, 51, 23, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1118, 51, 24, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1119, 51, 25, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1120, 51, 26, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1121, 51, 27, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1122, 51, 28, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1123, 51, 29, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1124, 51, 30, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1125, 51, 31, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1126, 51, 32, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1127, 51, 33, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1128, 51, 34, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1129, 51, 35, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1130, 51, 36, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1131, 51, 37, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1132, 51, 38, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1133, 51, 39, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1134, 51, 40, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1135, 51, 41, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1136, 51, 42, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1137, 51, 43, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1138, 51, 44, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1139, 51, 45, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1140, 51, 46, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1141, 51, 47, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1142, 51, 48, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1143, 51, 49, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1144, 51, 50, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1145, 51, 51, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1146, 51, 52, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1147, 51, 53, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1148, 51, 54, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1149, 51, 55, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1150, 51, 56, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1151, 51, 57, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1152, 51, 58, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1153, 51, 59, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1154, 51, 60, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1155, 51, 61, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1156, 51, 62, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1157, 51, 63, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1158, 51, 64, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1159, 51, 65, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1160, 51, 66, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1161, 51, 67, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1162, 51, 68, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1163, 51, 69, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1164, 51, 70, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1165, 51, 71, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1166, 51, 72, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1167, 51, 73, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1168, 51, 74, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1169, 51, 75, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1170, 51, 76, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1171, 51, 77, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1172, 51, 78, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1173, 51, 79, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1174, 51, 80, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1175, 51, 81, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1176, 51, 82, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1177, 51, 83, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1178, 51, 84, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1179, 51, 85, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1180, 51, 86, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1181, 51, 87, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1182, 51, 88, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1183, 51, 89, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1184, 51, 90, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1185, 51, 91, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1186, 51, 92, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1187, 51, 93, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1188, 51, 94, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1189, 51, 95, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1190, 51, 96, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1191, 51, 97, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1192, 51, 98, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1193, 51, 99, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1194, 51, 100, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1195, 51, 104, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1196, 51, 105, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1197, 51, 106, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1198, 51, 107, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1199, 51, 108, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1200, 51, 109, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1201, 51, 110, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1202, 51, 111, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1203, 51, 112, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1204, 51, 113, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1205, 51, 114, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1206, 51, 115, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1207, 51, 116, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1208, 51, 117, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1209, 51, 118, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1210, 51, 119, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1211, 51, 120, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1212, 51, 121, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1213, 51, 122, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1214, 51, 123, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1215, 51, 124, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1216, 51, 125, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1217, 51, 126, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1218, 51, 127, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1219, 51, 128, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1220, 51, 129, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1221, 51, 130, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1222, 51, 131, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1223, 51, 133, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1224, 51, 134, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1225, 51, 135, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1226, 51, 136, '2025-12-05 05:19:17', 0, NULL, '2025-12-05 05:19:17', '2025-12-05 05:19:17'),
(1227, 52, 1, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1228, 52, 2, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1229, 52, 3, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1230, 52, 4, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1231, 52, 5, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1232, 52, 6, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1233, 52, 7, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1234, 52, 8, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1235, 52, 9, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1236, 52, 10, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1237, 52, 11, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1238, 52, 12, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1239, 52, 13, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1240, 52, 14, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1241, 52, 15, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1242, 52, 16, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1243, 52, 17, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1244, 52, 18, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1245, 52, 19, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1246, 52, 20, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1247, 52, 21, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1248, 52, 22, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1249, 52, 23, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1250, 52, 24, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1251, 52, 25, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1252, 52, 26, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1253, 52, 27, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1254, 52, 28, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1255, 52, 29, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1256, 52, 30, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1257, 52, 31, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1258, 52, 32, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1259, 52, 33, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1260, 52, 34, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1261, 52, 35, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1262, 52, 36, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1263, 52, 37, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1264, 52, 38, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1265, 52, 39, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1266, 52, 40, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1267, 52, 41, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1268, 52, 42, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1269, 52, 43, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1270, 52, 44, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1271, 52, 45, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1272, 52, 46, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1273, 52, 47, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1274, 52, 48, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1275, 52, 49, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1276, 52, 50, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1277, 52, 51, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1278, 52, 52, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14');
INSERT INTO `event_participants` (`id`, `event_id`, `senior_id`, `registered_at`, `attended`, `attendance_notes`, `created_at`, `updated_at`) VALUES
(1279, 52, 53, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1280, 52, 54, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1281, 52, 55, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1282, 52, 56, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1283, 52, 57, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1284, 52, 58, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1285, 52, 59, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1286, 52, 60, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1287, 52, 61, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1288, 52, 62, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1289, 52, 63, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1290, 52, 64, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1291, 52, 65, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1292, 52, 66, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1293, 52, 67, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1294, 52, 68, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1295, 52, 69, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1296, 52, 70, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1297, 52, 71, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1298, 52, 72, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1299, 52, 73, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1300, 52, 74, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1301, 52, 75, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1302, 52, 76, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1303, 52, 77, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1304, 52, 78, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1305, 52, 79, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1306, 52, 80, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1307, 52, 81, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1308, 52, 82, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1309, 52, 83, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1310, 52, 84, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1311, 52, 85, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1312, 52, 86, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1313, 52, 87, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1314, 52, 88, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1315, 52, 89, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1316, 52, 90, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1317, 52, 91, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1318, 52, 92, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1319, 52, 93, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1320, 52, 94, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1321, 52, 95, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1322, 52, 96, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1323, 52, 97, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1324, 52, 98, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1325, 52, 99, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1326, 52, 100, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1327, 52, 104, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1328, 52, 105, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1329, 52, 106, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1330, 52, 107, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1331, 52, 108, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1332, 52, 109, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1333, 52, 110, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1334, 52, 111, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1335, 52, 112, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1336, 52, 113, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1337, 52, 114, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1338, 52, 115, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1339, 52, 116, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1340, 52, 117, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1341, 52, 118, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1342, 52, 119, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1343, 52, 120, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1344, 52, 121, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1345, 52, 122, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1346, 52, 123, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1347, 52, 124, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1348, 52, 125, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1349, 52, 126, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1350, 52, 127, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1351, 52, 128, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1352, 52, 129, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1353, 52, 130, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1354, 52, 131, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1355, 52, 133, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1356, 52, 134, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1357, 52, 135, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1358, 52, 136, '2026-01-12 13:34:14', 0, NULL, '2026-01-12 13:34:14', '2026-01-12 13:34:14'),
(1359, 53, 1, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1360, 53, 2, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1361, 53, 3, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1362, 53, 4, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1363, 53, 5, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1364, 53, 6, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1365, 53, 7, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1366, 53, 8, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1367, 53, 9, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1368, 53, 10, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1369, 53, 11, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1370, 53, 12, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1371, 53, 13, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1372, 53, 14, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1373, 53, 15, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1374, 53, 16, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1375, 53, 17, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1376, 53, 18, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1377, 53, 19, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1378, 53, 20, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1379, 53, 21, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1380, 53, 22, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1381, 53, 23, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1382, 53, 24, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1383, 53, 25, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1384, 53, 26, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1385, 53, 27, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1386, 53, 28, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1387, 53, 29, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1388, 53, 30, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1389, 53, 31, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1390, 53, 32, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1391, 53, 33, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1392, 53, 34, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1393, 53, 35, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1394, 53, 36, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1395, 53, 37, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1396, 53, 38, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1397, 53, 39, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1398, 53, 40, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1399, 53, 41, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1400, 53, 42, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1401, 53, 43, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1402, 53, 44, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1403, 53, 45, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1404, 53, 46, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1405, 53, 47, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1406, 53, 48, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1407, 53, 49, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1408, 53, 50, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1409, 53, 51, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1410, 53, 52, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1411, 53, 53, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1412, 53, 54, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1413, 53, 55, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1414, 53, 56, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1415, 53, 57, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1416, 53, 58, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1417, 53, 59, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1418, 53, 60, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1419, 53, 61, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1420, 53, 62, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1421, 53, 63, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1422, 53, 64, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1423, 53, 65, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1424, 53, 66, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1425, 53, 67, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1426, 53, 68, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1427, 53, 69, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1428, 53, 70, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1429, 53, 71, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1430, 53, 72, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1431, 53, 73, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1432, 53, 74, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1433, 53, 75, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1434, 53, 76, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1435, 53, 77, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1436, 53, 78, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1437, 53, 79, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1438, 53, 80, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1439, 53, 81, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1440, 53, 82, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1441, 53, 83, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1442, 53, 84, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1443, 53, 85, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1444, 53, 86, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1445, 53, 87, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1446, 53, 88, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1447, 53, 89, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1448, 53, 90, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1449, 53, 91, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1450, 53, 92, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1451, 53, 93, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1452, 53, 94, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1453, 53, 95, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1454, 53, 96, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1455, 53, 97, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1456, 53, 98, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1457, 53, 99, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1458, 53, 100, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1459, 53, 104, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1460, 53, 105, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1461, 53, 106, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1462, 53, 107, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1463, 53, 108, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1464, 53, 109, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1465, 53, 110, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1466, 53, 111, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1467, 53, 112, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1468, 53, 113, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1469, 53, 114, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1470, 53, 115, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1471, 53, 116, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1472, 53, 117, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1473, 53, 118, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1474, 53, 119, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1475, 53, 120, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1476, 53, 121, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1477, 53, 122, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1478, 53, 123, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1479, 53, 124, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1480, 53, 125, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1481, 53, 126, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1482, 53, 127, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1483, 53, 128, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1484, 53, 129, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1485, 53, 130, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1486, 53, 131, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1487, 53, 133, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1488, 53, 134, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1489, 53, 135, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1490, 53, 136, '2026-01-12 13:36:49', 0, NULL, '2026-01-12 13:36:49', '2026-01-12 13:36:49'),
(1491, 54, 1, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1492, 54, 2, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1493, 54, 3, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1494, 54, 4, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1495, 54, 5, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1496, 54, 6, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1497, 54, 7, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1498, 54, 8, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1499, 54, 9, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1500, 54, 10, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1501, 54, 11, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1502, 54, 12, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1503, 54, 13, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1504, 54, 14, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1505, 54, 15, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1506, 54, 16, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1507, 54, 17, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1508, 54, 18, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1509, 54, 19, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1510, 54, 20, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1511, 54, 21, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1512, 54, 22, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1513, 54, 23, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1514, 54, 24, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1515, 54, 25, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1516, 54, 26, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1517, 54, 27, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1518, 54, 28, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1519, 54, 29, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1520, 54, 30, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1521, 54, 31, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1522, 54, 32, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1523, 54, 33, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1524, 54, 34, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1525, 54, 35, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1526, 54, 36, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1527, 54, 37, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1528, 54, 38, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1529, 54, 39, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1530, 54, 40, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1531, 54, 41, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1532, 54, 42, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1533, 54, 43, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1534, 54, 44, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1535, 54, 45, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1536, 54, 46, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1537, 54, 47, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1538, 54, 48, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1539, 54, 49, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1540, 54, 50, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1541, 54, 51, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1542, 54, 52, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1543, 54, 53, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1544, 54, 54, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1545, 54, 55, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1546, 54, 56, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1547, 54, 57, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1548, 54, 58, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1549, 54, 59, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1550, 54, 60, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1551, 54, 61, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1552, 54, 62, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1553, 54, 63, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1554, 54, 64, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1555, 54, 65, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1556, 54, 66, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1557, 54, 67, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1558, 54, 68, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1559, 54, 69, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1560, 54, 70, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1561, 54, 71, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1562, 54, 72, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1563, 54, 73, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1564, 54, 74, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1565, 54, 75, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1566, 54, 76, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1567, 54, 77, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1568, 54, 78, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1569, 54, 79, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1570, 54, 80, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1571, 54, 81, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1572, 54, 82, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1573, 54, 83, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1574, 54, 84, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1575, 54, 85, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1576, 54, 86, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1577, 54, 87, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1578, 54, 88, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1579, 54, 89, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1580, 54, 90, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1581, 54, 91, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1582, 54, 92, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1583, 54, 93, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1584, 54, 94, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1585, 54, 95, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1586, 54, 96, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1587, 54, 97, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1588, 54, 98, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1589, 54, 99, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1590, 54, 100, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1591, 54, 104, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1592, 54, 105, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1593, 54, 106, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1594, 54, 107, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1595, 54, 108, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1596, 54, 109, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1597, 54, 110, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1598, 54, 111, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1599, 54, 112, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1600, 54, 113, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1601, 54, 114, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1602, 54, 115, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1603, 54, 116, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1604, 54, 117, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1605, 54, 118, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1606, 54, 119, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1607, 54, 120, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1608, 54, 121, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1609, 54, 122, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1610, 54, 123, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1611, 54, 124, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1612, 54, 125, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1613, 54, 126, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1614, 54, 127, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1615, 54, 128, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1616, 54, 129, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1617, 54, 130, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1618, 54, 131, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1619, 54, 133, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1620, 54, 134, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1621, 54, 135, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1622, 54, 136, '2026-01-13 00:07:04', 0, NULL, '2026-01-13 00:07:04', '2026-01-13 00:07:04'),
(1623, 55, 1, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1624, 55, 2, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1625, 55, 3, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1626, 55, 4, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1627, 55, 5, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1628, 55, 6, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1629, 55, 7, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1630, 55, 8, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1631, 55, 9, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1632, 55, 10, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1633, 55, 11, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1634, 55, 12, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1635, 55, 13, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1636, 55, 14, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1637, 55, 15, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1638, 55, 16, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1639, 55, 17, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1640, 55, 18, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1641, 55, 19, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1642, 55, 20, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1643, 55, 21, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1644, 55, 22, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1645, 55, 23, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1646, 55, 24, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1647, 55, 25, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1648, 55, 26, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1649, 55, 27, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1650, 55, 28, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1651, 55, 29, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1652, 55, 30, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1653, 55, 31, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1654, 55, 32, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1655, 55, 33, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1656, 55, 34, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1657, 55, 35, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1658, 55, 36, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1659, 55, 37, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1660, 55, 38, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1661, 55, 39, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1662, 55, 40, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1663, 55, 41, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1664, 55, 42, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1665, 55, 43, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1666, 55, 44, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1667, 55, 45, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1668, 55, 46, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1669, 55, 47, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1670, 55, 48, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1671, 55, 49, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1672, 55, 50, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1673, 55, 51, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1674, 55, 52, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1675, 55, 53, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1676, 55, 54, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1677, 55, 55, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1678, 55, 56, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1679, 55, 57, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1680, 55, 58, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1681, 55, 59, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1682, 55, 60, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1683, 55, 61, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1684, 55, 62, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1685, 55, 63, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1686, 55, 64, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1687, 55, 65, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1688, 55, 66, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1689, 55, 67, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1690, 55, 68, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1691, 55, 69, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1692, 55, 70, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1693, 55, 71, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1694, 55, 72, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1695, 55, 73, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1696, 55, 74, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1697, 55, 75, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1698, 55, 76, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1699, 55, 77, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1700, 55, 78, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1701, 55, 79, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1702, 55, 80, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1703, 55, 81, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1704, 55, 82, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1705, 55, 83, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1706, 55, 84, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1707, 55, 85, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1708, 55, 86, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1709, 55, 87, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1710, 55, 88, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1711, 55, 89, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1712, 55, 90, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1713, 55, 91, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1714, 55, 92, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1715, 55, 93, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1716, 55, 94, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1717, 55, 95, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1718, 55, 96, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1719, 55, 97, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1720, 55, 98, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1721, 55, 99, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1722, 55, 100, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1723, 55, 104, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1724, 55, 105, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1725, 55, 106, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1726, 55, 107, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1727, 55, 108, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1728, 55, 109, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1729, 55, 110, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1730, 55, 111, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1731, 55, 112, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1732, 55, 113, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1733, 55, 114, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1734, 55, 115, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1735, 55, 116, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1736, 55, 117, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1737, 55, 118, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1738, 55, 119, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1739, 55, 120, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1740, 55, 121, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1741, 55, 122, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1742, 55, 123, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1743, 55, 124, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1744, 55, 125, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1745, 55, 126, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1746, 55, 127, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1747, 55, 128, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1748, 55, 129, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1749, 55, 130, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1750, 55, 131, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1751, 55, 133, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1752, 55, 134, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1753, 55, 135, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1754, 55, 136, '2026-01-13 00:08:02', 0, NULL, '2026-01-13 00:08:02', '2026-01-13 00:08:02'),
(1755, 56, 1, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1756, 56, 2, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1757, 56, 3, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1758, 56, 4, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1759, 56, 5, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1760, 56, 6, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1761, 56, 7, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1762, 56, 8, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1763, 56, 9, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1764, 56, 10, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1765, 56, 11, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1766, 56, 12, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1767, 56, 13, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1768, 56, 14, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1769, 56, 15, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1770, 56, 16, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1771, 56, 17, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1772, 56, 18, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1773, 56, 19, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1774, 56, 20, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1775, 56, 21, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1776, 56, 22, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1777, 56, 23, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1778, 56, 24, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1779, 56, 25, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1780, 56, 26, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1781, 56, 27, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1782, 56, 28, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1783, 56, 29, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1784, 56, 30, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1785, 56, 31, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1786, 56, 32, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1787, 56, 33, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1788, 56, 34, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1789, 56, 35, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1790, 56, 36, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1791, 56, 37, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1792, 56, 38, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1793, 56, 39, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1794, 56, 40, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1795, 56, 41, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1796, 56, 42, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1797, 56, 43, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1798, 56, 44, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1799, 56, 45, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1800, 56, 46, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1801, 56, 47, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1802, 56, 48, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1803, 56, 49, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1804, 56, 50, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1805, 56, 51, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1806, 56, 52, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1807, 56, 53, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1808, 56, 54, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1809, 56, 55, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1810, 56, 56, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1811, 56, 57, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1812, 56, 58, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1813, 56, 59, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1814, 56, 60, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1815, 56, 61, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1816, 56, 62, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1817, 56, 63, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1818, 56, 64, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26');
INSERT INTO `event_participants` (`id`, `event_id`, `senior_id`, `registered_at`, `attended`, `attendance_notes`, `created_at`, `updated_at`) VALUES
(1819, 56, 65, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1820, 56, 66, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1821, 56, 67, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1822, 56, 68, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1823, 56, 69, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1824, 56, 70, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1825, 56, 71, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1826, 56, 72, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1827, 56, 73, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1828, 56, 74, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1829, 56, 75, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1830, 56, 76, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1831, 56, 77, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1832, 56, 78, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1833, 56, 79, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1834, 56, 80, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1835, 56, 81, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1836, 56, 82, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1837, 56, 83, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1838, 56, 84, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1839, 56, 85, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1840, 56, 86, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1841, 56, 87, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1842, 56, 88, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1843, 56, 89, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1844, 56, 90, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1845, 56, 91, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1846, 56, 92, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1847, 56, 93, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1848, 56, 94, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1849, 56, 95, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1850, 56, 96, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1851, 56, 97, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1852, 56, 98, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1853, 56, 99, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1854, 56, 100, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1855, 56, 104, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1856, 56, 105, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1857, 56, 106, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1858, 56, 107, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1859, 56, 108, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1860, 56, 109, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1861, 56, 110, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1862, 56, 111, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1863, 56, 112, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1864, 56, 113, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1865, 56, 114, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1866, 56, 115, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1867, 56, 116, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1868, 56, 117, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1869, 56, 118, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1870, 56, 119, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1871, 56, 120, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1872, 56, 121, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1873, 56, 122, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1874, 56, 123, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1875, 56, 124, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1876, 56, 125, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1877, 56, 126, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1878, 56, 127, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1879, 56, 128, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1880, 56, 129, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1881, 56, 130, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1882, 56, 131, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1883, 56, 133, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1884, 56, 134, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1885, 56, 135, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26'),
(1886, 56, 136, '2026-01-13 00:09:26', 0, NULL, '2026-01-13 00:09:26', '2026-01-13 00:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_codes`
--

CREATE TABLE `login_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `code` varchar(6) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_codes`
--

INSERT INTO `login_codes` (`id`, `email`, `code`, `expires_at`, `used`, `created_at`, `updated_at`) VALUES
(2, 'aeronbaustista32@gmail.com', '819435', '2025-09-18 05:58:29', 0, '2025-09-18 05:53:29', '2025-09-18 05:53:29'),
(169, 'elderacapstone@gmail.com', '254420', '2025-12-02 10:23:16', 0, '2025-12-02 10:18:16', '2025-12-02 10:18:16'),
(173, 'Babyjanedanas628@gmail.com', '292980', '2025-12-02 13:12:24', 1, '2025-12-02 13:11:10', '2025-12-02 13:12:24'),
(196, 'jieloucagampan21@gmail.com', '251326', '2025-12-05 02:05:24', 1, '2025-12-05 02:05:02', '2025-12-05 02:05:24'),
(207, 'tripwapakxd@gmail.com', '941511', '2025-12-22 02:54:02', 1, '2025-12-22 02:53:28', '2025-12-22 02:54:02'),
(213, 'aeronbautista32@gmail.com', '073092', '2026-01-12 12:14:37', 1, '2026-01-12 12:14:05', '2026-01-12 12:14:37'),
(215, 'revienortiz@gmail.com', '529752', '2026-01-13 16:24:48', 1, '2026-01-13 16:23:07', '2026-01-13 16:24:48');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_01_01_000001_create_seniors_table', 1),
(5, '2024_01_01_000002_create_applications_table', 1),
(6, '2024_01_01_000003_create_senior_id_applications_table', 1),
(7, '2024_01_01_000004_create_pension_applications_table', 1),
(8, '2024_01_01_000005_create_benefits_applications_table', 1),
(9, '2024_01_01_000006_create_events_table', 1),
(10, '2024_01_01_000007_create_event_participants_table', 1),
(11, '2024_01_01_000008_create_documents_table', 1),
(12, '2024_01_01_000009_create_notifications_table', 1),
(13, '2024_01_01_000010_create_barangays_table', 1),
(14, '2025_09_09_075307_create_personal_access_tokens_table', 1),
(15, '2025_09_10_065824_add_performance_indexes_to_seniors_and_applications', 1),
(16, '2025_09_11_153847_add_comprehensive_fields_to_seniors_table', 1),
(17, '2025_09_11_160923_remove_benefit_type_and_reason_from_benefits_applications', 1),
(18, '2025_09_12_103515_add_google_oauth_fields_to_users_table', 1),
(19, '2025_09_12_104000_create_verification_codes_table', 1),
(20, '2025_09_12_110725_create_login_codes_table', 1),
(21, '2025_09_12_131856_add_missing_fields_to_senior_id_applications_table', 1),
(22, '2025_09_12_133021_add_pension_source_and_ctc_number_to_seniors_table', 1),
(23, '2025_09_12_161531_add_metadata_to_applications_table', 1),
(24, '2025_09_15_074728_remove_contact_number_from_senior_id_applications_table', 1),
(25, '2025_09_18_162213_make_middle_name_nullable_in_seniors_table', 2),
(26, '2025_01_15_000000_add_missing_pension_fields_to_seniors_table', 3),
(27, '2025_09_19_040955_add_missing_pension_fields_to_seniors_table', 3),
(28, '2025_09_19_041829_add_missing_pension_fields_to_seniors_table', 3),
(29, '2025_09_19_050000_clear_all_senior_data', 4),
(31, '2025_09_19_051000_clear_seniors_keep_admins', 5),
(32, '2025_09_19_052100_clear_seniors_for_complete_data', 5),
(33, '2025_09_19_053000_clear_for_comprehensive_seniors', 6),
(35, '2025_09_19_064547_update_barangay_values_to_match_form', 7),
(36, '2025_09_19_072426_add_certification_field_to_seniors_table', 8),
(37, '2025_09_19_073211_add_benefits_fields_to_seniors_table', 9),
(38, '2025_09_19_080006_add_validation_assessment_fields_to_seniors_table', 10),
(39, '2025_09_19_080401_remove_benefits_fields_from_seniors_table', 11),
(40, '2025_09_19_080825_add_missing_fields_to_benefits_applications_table', 12),
(41, '2025_09_19_080939_add_missing_fields_to_pension_applications_table', 12),
(42, '2025_09_21_104531_add_health_fields_to_pension_applications_table', 13),
(43, '2025_09_21_115425_add_application_id_to_benefits_applications_table', 14),
(44, '2025_09_21_133407_add_performance_indexes_to_tables', 15),
(45, '2025_09_21_134713_add_senior_id_to_pension_applications_table', 16),
(46, '2025_09_22_064030_add_photo_field_to_seniors_table', 17),
(47, '2023_10_15_000000_create_announcements_table', 18),
(48, '2024_07_27_000000_add_has_app_account_to_seniors_table', 19),
(49, '2025_09_27_151226_add_role_to_users_table', 20),
(50, '2025_09_27_151630_add_user_id_to_seniors_table', 21),
(51, '2025_09_29_135936_create_app_users_table', 22),
(52, '2025_09_30_000001_add_is_active_to_announcements_table', 23),
(53, '2025_10_02_000100_update_application_status_enum_to_received', 24),
(54, '2024_06_06_000001_update_pension_applications_monthly_income', 25),
(55, '2024_06_06_000002_create_monthly_income_sync_trigger', 25),
(56, '2024_06_06_000003_create_reverse_monthly_income_sync_trigger', 25),
(57, '2025_10_07_023415_add_civil_status_to_pension_applications_table', 25),
(60, '2025_10_08_212130_create_password_reset_requests_table', 26),
(61, '2025_10_08_215544_add_columns_to_password_reset_requests_table', 26),
(62, '2025_11_28_000001_add_recipient_selection_to_events_table', 27),
(63, '2025_12_04_000010_drop_reverse_monthly_income_sync_trigger', 27),
(64, '2025_12_04_000011_drop_forward_monthly_income_sync_trigger', 27);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `senior_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('application_update','event_reminder','system_alert','pension_reminder') NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `senior_id`, `title`, `message`, `type`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES
(1, 5, 77, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-18 12:50:11', '2025-09-18 12:50:11'),
(2, 5, 102, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-18 13:23:40', '2025-09-18 13:23:40'),
(3, 5, 71, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-18 13:26:34', '2025-09-18 13:26:34'),
(4, 5, 78, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-18 18:47:56', '2025-09-18 18:47:56'),
(5, 5, 33, 'Application Update', 'Pension application submitted successfully', 'application_update', 0, NULL, '2025-09-18 20:00:28', '2025-09-18 20:00:28'),
(6, 5, 58, 'Application Update', 'Pension application submitted successfully', 'application_update', 0, NULL, '2025-09-18 20:04:57', '2025-09-18 20:04:57'),
(7, 5, 35, 'Application Update', 'Pension application submitted successfully', 'application_update', 0, NULL, '2025-09-18 20:28:43', '2025-09-18 20:28:43'),
(8, 4, 70, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-09-18 23:56:39', '2025-09-18 23:56:39'),
(9, 4, 1, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-09-19 00:50:11', '2025-09-19 00:50:11'),
(10, 4, 3, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-19 01:19:58', '2025-09-19 01:19:58'),
(11, 4, 2, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-09-21 04:20:51', '2025-09-21 04:20:51'),
(12, 4, 57, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-21 22:27:14', '2025-09-21 22:27:14'),
(14, 4, 4, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-21 22:35:48', '2025-09-21 22:35:48'),
(15, 4, 19, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-09-21 22:37:41', '2025-09-21 22:37:41'),
(16, 6, 15, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-10-01 11:31:21', '2025-10-01 11:31:21'),
(17, 6, 9, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-10-08 07:28:04', '2025-10-08 07:28:04'),
(18, 6, 18, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-10-08 07:56:45', '2025-10-08 07:56:45'),
(19, 6, 18, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-03 13:37:47', '2025-12-03 13:37:47'),
(20, 6, 95, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-03 13:45:09', '2025-12-03 13:45:09'),
(21, 16, 130, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-12-04 13:42:38', '2025-12-04 13:42:38'),
(22, 16, 129, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-12-04 13:43:47', '2025-12-04 13:43:47'),
(23, 16, 128, 'Application Update', 'Pension application submitted successfully', 'application_update', 0, NULL, '2025-12-04 13:45:34', '2025-12-04 13:45:34'),
(24, 16, 115, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 13:51:36', '2025-12-04 13:51:36'),
(25, 16, 130, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 13:52:51', '2025-12-04 13:52:51'),
(26, 16, 106, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 13:54:38', '2025-12-04 13:54:38'),
(29, 4, 136, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:05:39', '2025-12-04 14:05:39'),
(30, 16, 122, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:06:33', '2025-12-04 14:06:33'),
(31, 4, 113, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:10:10', '2025-12-04 14:10:10'),
(32, 16, 131, 'Application Update', 'Pension application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:14:45', '2025-12-04 14:14:45'),
(33, 16, 131, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:15:32', '2025-12-04 14:15:32'),
(34, 16, 122, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:18:37', '2025-12-04 14:18:37'),
(35, 16, 128, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:22:05', '2025-12-04 14:22:05'),
(36, 16, 44, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:28:20', '2025-12-04 14:28:20'),
(37, 4, 134, 'Application Update', 'Senior ID application submitted successfully', 'application_update', 0, NULL, '2025-12-04 14:29:15', '2025-12-04 14:29:15'),
(38, 4, 136, 'Application Update', 'Pension application submitted successfully', 'application_update', 0, NULL, '2025-12-04 15:09:42', '2025-12-04 15:09:42'),
(39, 4, 32, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-12-04 15:12:47', '2025-12-04 15:12:47'),
(40, 4, 95, 'Application Update', 'Benefits application submitted successfully', 'application_update', 0, NULL, '2025-12-04 15:39:41', '2025-12-04 15:39:41');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_requests`
--

CREATE TABLE `password_reset_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `osca_id` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `resolved_at` timestamp NULL DEFAULT NULL,
  `resolved_by` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_requests`
--

INSERT INTO `password_reset_requests` (`id`, `osca_id`, `full_name`, `status`, `requested_at`, `resolved_at`, `resolved_by`, `notes`, `ip_address`, `created_at`, `updated_at`) VALUES
(4, '2025-017', 'Anthony Padberg', 'approved', '2025-11-28 16:23:36', '2025-11-28 16:23:36', 'adminPogi', NULL, '182.255.40.181', '2025-11-28 16:21:52', '2025-11-28 16:23:36');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pension_applications`
--

CREATE TABLE `pension_applications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `application_id` bigint(20) UNSIGNED NOT NULL,
  `rrn` varchar(50) DEFAULT NULL,
  `monthly_income` decimal(15,2) NOT NULL,
  `has_pension` tinyint(1) NOT NULL DEFAULT 0,
  `pension_source` varchar(255) DEFAULT NULL,
  `pension_amount` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permanent_income` varchar(10) DEFAULT NULL,
  `income_amount` varchar(50) DEFAULT NULL,
  `income_source` varchar(255) DEFAULT NULL,
  `existing_illness` varchar(10) DEFAULT NULL,
  `illness_specify` varchar(255) DEFAULT NULL,
  `with_disability` varchar(10) DEFAULT NULL,
  `disability_specify` varchar(255) DEFAULT NULL,
  `living_arrangement` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`living_arrangement`)),
  `certification` tinyint(1) NOT NULL DEFAULT 0,
  `senior_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pension_applications`
--

INSERT INTO `pension_applications` (`id`, `application_id`, `rrn`, `monthly_income`, `has_pension`, `pension_source`, `pension_amount`, `created_at`, `updated_at`, `permanent_income`, `income_amount`, `income_source`, `existing_illness`, `illness_specify`, `with_disability`, `disability_specify`, `living_arrangement`, `certification`, `senior_id`) VALUES
(1, 1, 'RRN000001', 181722.00, 0, NULL, 3630.00, '2025-09-18 21:28:14', '2025-10-02 11:32:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1),
(2, 2, 'RRN000002', 35458.00, 0, 'SSS', 12627.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2),
(3, 3, 'RRN000003', 17987.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3),
(4, 4, 'RRN000004', 18839.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4),
(5, 5, 'RRN000005', 39919.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5),
(6, 6, 'RRN000006', 35886.00, 0, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6),
(7, 7, 'RRN000007', 4945.00, 0, 'Private', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 7),
(8, 8, 'RRN000008', 3703.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8),
(9, 9, 'RRN000009', 39938.00, 0, NULL, 8397.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 9),
(10, 10, 'RRN000010', 15302.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10),
(11, 11, 'RRN000011', 46928.00, 0, NULL, 4242.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 11),
(12, 12, 'RRN000012', 11667.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 12),
(13, 13, 'RRN000013', 18916.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 13),
(14, 14, 'RRN000014', 41924.00, 0, NULL, 11646.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 14),
(15, 15, 'RRN000015', 4509.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 15),
(16, 16, 'RRN000016', 30211.00, 0, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 16),
(17, 17, 'RRN000017', 26722.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 17),
(18, 18, 'RRN000018', 28696.00, 0, 'GSIS', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 18),
(19, 19, 'RRN000019', 36505.00, 0, 'GSIS', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 19),
(20, 20, 'RRN000020', 32723.00, 0, 'PVAO', 0.00, '2025-09-18 21:28:14', '2025-12-05 02:12:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[\"living with children or relatives\"]', 1, 20),
(21, 21, 'RRN000021', 16133.00, 0, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 21),
(22, 22, 'RRN000022', 10119.00, 0, NULL, 0.00, '2025-09-18 21:28:14', '2025-12-05 02:13:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[\"rent\"]', 1, 22),
(23, 23, 'RRN000023', 19779.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 23),
(24, 24, 'RRN000024', 15728.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 24),
(25, 25, 'RRN000025', 22875.00, 1, 'AFP', 2020.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25),
(26, 26, 'RRN000026', 20007.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 26),
(27, 27, 'RRN000027', 34273.00, 0, 'SSS', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 27),
(28, 28, 'RRN000028', 41466.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 28),
(29, 29, 'RRN000029', 28005.00, 1, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 29),
(30, 30, 'RRN000030', 18412.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 30),
(31, 31, 'RRN000031', 9018.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 31),
(32, 32, 'RRN000032', 26655.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 32),
(33, 33, 'RRN000033', 8962.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 33),
(34, 34, 'RRN000034', 45637.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 34),
(35, 35, 'RRN000035', 9145.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 35),
(36, 36, 'RRN000036', 21407.00, 0, 'GSIS', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 36),
(37, 37, 'RRN000037', 22221.00, 0, NULL, 12176.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 37),
(38, 38, 'RRN000038', 41904.00, 0, 'Government', 11961.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 38),
(39, 39, 'RRN000039', 48069.00, 0, NULL, 14288.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 39),
(40, 40, 'RRN000040', 13117.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 40),
(41, 41, 'RRN000041', 34383.00, 0, NULL, 13259.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 41),
(42, 42, 'RRN000042', 17409.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 42),
(43, 43, 'RRN000043', 41585.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 43),
(44, 44, 'RRN000044', 3425.00, 1, NULL, 10533.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 44),
(45, 45, 'RRN000045', 47868.00, 0, 'AFP', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 45),
(46, 46, 'RRN000046', 31899.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 46),
(47, 47, 'RRN000047', 32722.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 47),
(48, 48, 'RRN000048', 10576.00, 1, 'Government', 5360.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 48),
(49, 49, 'RRN000049', 49326.00, 1, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 49),
(50, 50, 'RRN000050', 38343.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 50),
(51, 51, 'RRN000051', 15504.00, 1, 'Private', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 51),
(52, 52, 'RRN000052', 12882.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 52),
(53, 53, 'RRN000053', 24416.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 53),
(54, 54, 'RRN000054', 18683.00, 1, 'SSS', 3397.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 54),
(55, 55, 'RRN000055', 31876.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 55),
(56, 56, 'RRN000056', 35285.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 56),
(57, 57, 'RRN000057', 34775.00, 0, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 57),
(58, 58, 'RRN000058', 15793.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 58),
(59, 59, 'RRN000059', 43132.00, 1, NULL, 8130.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 59),
(60, 60, 'RRN000060', 13292.00, 0, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60),
(61, 61, 'RRN000061', 15023.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 61),
(62, 62, 'RRN000062', 47350.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 62),
(63, 63, 'RRN000063', 28797.00, 0, 'AFP', 8211.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 63),
(64, 64, 'RRN000064', 17708.00, 0, NULL, 4014.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 64),
(65, 65, 'RRN000065', 46867.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 65),
(66, 66, 'RRN000066', 42368.00, 0, 'SSS', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 66),
(67, 67, 'RRN000067', 32461.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 67),
(68, 68, 'RRN000068', 46320.00, 1, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 68),
(69, 69, 'RRN000069', 49135.00, 0, NULL, 12121.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 69),
(70, 70, 'RRN000070', 19219.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 70),
(71, 71, 'RRN000071', 42500.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 71),
(72, 72, 'RRN000072', 25694.00, 0, NULL, 0.00, '2025-09-18 21:28:14', '2025-10-02 11:24:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 72),
(73, 73, 'RRN000073', 18848.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 73),
(74, 74, 'RRN000074', 6137.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 74),
(75, 75, 'RRN000075', 34418.00, 0, NULL, 13359.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 75),
(76, 76, 'RRN000076', 15425.00, 0, 'Government', 2823.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 76),
(77, 77, 'RRN000077', 18808.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 77),
(78, 78, 'RRN000078', 26687.00, 0, NULL, 10247.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 78),
(79, 79, 'RRN000079', 4263.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 79),
(80, 80, 'RRN000080', 47214.00, 0, 'Private', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 80),
(81, 81, 'RRN000081', 4863.00, 0, 'PVAO', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 81),
(82, 82, 'RRN000082', 32370.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 82),
(83, 83, 'RRN000083', 44890.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 83),
(84, 84, 'RRN000084', 38582.00, 0, 'Government', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 84),
(85, 85, 'RRN000085', 34737.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 85),
(86, 86, 'RRN000086', 20043.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 86),
(87, 87, 'RRN000087', 17406.00, 1, NULL, 4063.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 87),
(88, 88, 'RRN000088', 45490.00, 0, NULL, 14146.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 88),
(89, 89, 'RRN000089', 15909.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 89),
(90, 90, 'RRN000090', 42001.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 90),
(91, 91, 'RRN000091', 41613.00, 0, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 91),
(92, 92, 'RRN000092', 49288.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 92),
(93, 93, 'RRN000093', 42942.00, 0, 'PVAO', 4578.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 93),
(94, 94, 'RRN000094', 18595.00, 0, 'Private', 2084.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 94),
(95, 95, 'RRN000095', 43473.00, 1, NULL, NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 95),
(96, 96, 'RRN000096', 31120.00, 1, NULL, 3357.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 96),
(97, 97, 'RRN000097', 33224.00, 1, NULL, 4402.00, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 97),
(98, 98, 'RRN000098', 30051.00, 0, 'Government', NULL, '2025-09-18 21:28:14', '2025-09-18 21:28:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 98),
(99, 99, 'RRN000099', 28725.00, 0, NULL, 0.00, '2025-09-18 21:28:14', '2025-10-02 11:23:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 99),
(100, 100, 'RRN000100', 9865.00, 0, NULL, 0.00, '2025-09-18 21:28:14', '2025-09-21 05:55:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[\"living alone\"]', 1, 100),
(101, 116, NULL, 250000.00, 0, NULL, 0.00, '2025-12-04 13:45:34', '2025-12-04 15:11:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 128),
(103, 125, NULL, 20000.00, 0, NULL, 0.00, '2025-12-04 14:14:45', '2025-12-04 14:14:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 131),
(104, 131, NULL, 5000000.00, 0, NULL, 0.00, '2025-12-04 15:09:42', '2025-12-04 15:09:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 136);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\AppUser', 1, 'app_user_token', 'c705c0277651eceb1bd1ced2bc21ee067e7ac57f7d7a4fc9e36ad1911bdca8ba', '[\"*\"]', '2025-09-29 07:51:55', NULL, '2025-09-29 07:51:54', '2025-09-29 07:51:55'),
(2, 'App\\Models\\AppUser', 1, 'app_user_token', 'cfac34d9272c14e19c01e3e4c27429afe425c0d19b07878ff72eb8447a190f1e', '[\"*\"]', '2025-09-29 07:52:01', NULL, '2025-09-29 07:52:01', '2025-09-29 07:52:01'),
(3, 'App\\Models\\AppUser', 1, 'app_user_token', 'e4e223b4f79d12995a0389c7fdae5e3ea3a0622ffa811bc269ec8e42e44f99ff', '[\"*\"]', '2025-09-29 07:52:07', NULL, '2025-09-29 07:52:06', '2025-09-29 07:52:07'),
(4, 'App\\Models\\AppUser', 1, 'app_user_token', '50a3770978ec9f45af44e02611a6787cb7456416373e8f90bd9788cabe80257b', '[\"*\"]', '2025-09-29 07:56:04', NULL, '2025-09-29 07:56:03', '2025-09-29 07:56:04'),
(5, 'App\\Models\\AppUser', 1, 'app_user_token', '052fa7137249bd813da9b7cce7d3fa010357b9d7ef23f84c6ff725153a98ebd0', '[\"*\"]', '2025-09-29 07:56:07', NULL, '2025-09-29 07:56:07', '2025-09-29 07:56:07'),
(6, 'App\\Models\\AppUser', 1, 'app_user_token', '1abf427d2f5d24f881af30dd97fcba3f4c1a3e674d87f3daf268c73447b3f523', '[\"*\"]', '2025-09-29 07:56:12', NULL, '2025-09-29 07:56:12', '2025-09-29 07:56:12'),
(7, 'App\\Models\\AppUser', 1, 'app_user_token', 'a8ace0c2a6e5f3d468c22e34931a1c210333416ba726422d5fdc99cf0c30c1c7', '[\"*\"]', '2025-09-29 08:02:31', NULL, '2025-09-29 08:02:30', '2025-09-29 08:02:31'),
(8, 'App\\Models\\AppUser', 2, 'app_user_token', '7d5182a347dd4e668d5cd1a5ffc7d29972efe94488cdbe62ea68c65204c3c07b', '[\"*\"]', '2025-09-29 08:04:45', NULL, '2025-09-29 08:04:45', '2025-09-29 08:04:45'),
(9, 'App\\Models\\AppUser', 2, 'app_user_token', 'e5e4a20511c1c5c3f0155a05325e7d438d39d7096a4cd01234a5049cc5d18088', '[\"*\"]', '2025-09-29 08:10:20', NULL, '2025-09-29 08:10:20', '2025-09-29 08:10:20'),
(10, 'App\\Models\\AppUser', 2, 'app_user_token', 'd330ab76dde87e180fa1217214410e95fbb3d8c9bce887c9c4194790710d518e', '[\"*\"]', '2025-09-29 08:15:11', NULL, '2025-09-29 08:15:11', '2025-09-29 08:15:11'),
(11, 'App\\Models\\AppUser', 2, 'app_user_token', 'eaa24dd1e072456d722658b7001ae86bcd38e18742ef7b1c2a54f6d3ae419788', '[\"*\"]', '2025-09-29 08:15:13', NULL, '2025-09-29 08:15:13', '2025-09-29 08:15:13'),
(12, 'App\\Models\\AppUser', 2, 'app_user_token', '88db4783af75c37148bf7905e1cd26e70c3c33286fc4aab0bec17c54f5660e19', '[\"*\"]', '2025-09-29 08:15:29', NULL, '2025-09-29 08:15:29', '2025-09-29 08:15:29'),
(13, 'App\\Models\\AppUser', 2, 'app_user_token', '4c275e24a09d7aa25f2a5ccbab2aac06f085aeb3166ee031160c91620bc0e173', '[\"*\"]', '2025-09-29 08:17:52', NULL, '2025-09-29 08:17:52', '2025-09-29 08:17:52'),
(14, 'App\\Models\\AppUser', 2, 'app_user_token', '454a881eb7eaee6d40cc24f48e070108e407538383004ad2b87b4ab2f4967c05', '[\"*\"]', '2025-09-29 08:20:07', NULL, '2025-09-29 08:20:06', '2025-09-29 08:20:07'),
(15, 'App\\Models\\AppUser', 2, 'app_user_token', 'e678b0a07e0c1d121218f255dd63d5162fb3ef1e13e15a592ad4f0bc9ea4e955', '[\"*\"]', '2025-09-29 08:22:16', NULL, '2025-09-29 08:22:16', '2025-09-29 08:22:16'),
(16, 'App\\Models\\AppUser', 2, 'app_user_token', '50ce82aceca2a1c41eb03afc8236458cfcaaec5ed7d5170308ac03f86d76a5f7', '[\"*\"]', '2025-09-29 08:25:04', NULL, '2025-09-29 08:25:04', '2025-09-29 08:25:04'),
(17, 'App\\Models\\AppUser', 2, 'app_user_token', 'bb39ce83eabd519fbff13b653a8c4ecf50bcf63735a4070bce50d7bdc48a8c13', '[\"*\"]', '2025-09-29 08:25:18', NULL, '2025-09-29 08:25:17', '2025-09-29 08:25:18'),
(18, 'App\\Models\\AppUser', 2, 'app_user_token', 'f1a3b5ce7bcb96906f5ddcfd53fc9d056cb88483f11461bfce3c6a392e79dbec', '[\"*\"]', '2025-09-29 08:25:19', NULL, '2025-09-29 08:25:19', '2025-09-29 08:25:19'),
(19, 'App\\Models\\AppUser', 2, 'app_user_token', '6dca5fb7579deb63956031b81e8fbda6b29a8ae67116aaf71a6922bb46b193b1', '[\"*\"]', '2025-09-29 08:25:40', NULL, '2025-09-29 08:25:40', '2025-09-29 08:25:40'),
(20, 'App\\Models\\AppUser', 2, 'app_user_token', '6754d751c56de5675804652cde21217e0d80f9ee074518511e8b7478f00bb500', '[\"*\"]', '2025-09-29 08:25:43', NULL, '2025-09-29 08:25:43', '2025-09-29 08:25:43'),
(21, 'App\\Models\\AppUser', 2, 'app_user_token', 'f2355df3512ab8e4435a3c66c1daeb0e0f9dc3063e7a40d8f76a071e9231754c', '[\"*\"]', NULL, NULL, '2025-09-29 08:34:12', '2025-09-29 08:34:12'),
(22, 'App\\Models\\AppUser', 2, 'app_user_token', '1b11f79df535b6fe8daec13f91ac6f6de7d5bcb0c9e4cfe342624cca8a5a6cad', '[\"*\"]', NULL, NULL, '2025-09-29 08:34:23', '2025-09-29 08:34:23'),
(23, 'App\\Models\\AppUser', 2, 'app_user_token', '68c34014f65bbfc3c51e4d7249519a93fac95de6ec777465c71949d21b005f6f', '[\"*\"]', NULL, NULL, '2025-09-29 08:34:35', '2025-09-29 08:34:35'),
(24, 'App\\Models\\AppUser', 2, 'app_user_token', '8aabff95745f6f5a30fba63211e95e532cfe91a4d351d11901920093611a6606', '[\"*\"]', NULL, NULL, '2025-09-29 08:34:44', '2025-09-29 08:34:44'),
(25, 'App\\Models\\AppUser', 2, 'app_user_token', '91a6882aa2741640497e850386761e92217087ab04ed6d513e0732a20108626d', '[\"*\"]', NULL, NULL, '2025-09-29 08:35:06', '2025-09-29 08:35:06'),
(29, 'App\\Models\\AppUser', 2, 'app_user_token', '3384aec062ac987b1872f5c977cddc5cec20c39b69c4b94948aa3295e9efee3e', '[\"*\"]', NULL, NULL, '2025-09-29 08:43:34', '2025-09-29 08:43:34'),
(32, 'App\\Models\\AppUser', 2, 'app_user_token', '452553564599bacb7058ab94808918183e3f2f7f4a35bfc97dd6bd6ce0f5b141', '[\"*\"]', '2025-09-29 08:50:22', NULL, '2025-09-29 08:50:22', '2025-09-29 08:50:22'),
(34, 'App\\Models\\AppUser', 3, 'app_user_token', 'ec8b3d2cb6a635f0c0ecc44ec7d4f6e836d7d970c6e5c54c9594c0fcdfe0d705', '[\"*\"]', '2025-09-30 03:39:47', NULL, '2025-09-30 03:39:47', '2025-09-30 03:39:47'),
(35, 'App\\Models\\AppUser', 3, 'app_user_token', '90ba7d4fa5f2ff623d4542ff2bd5fdea33f7280beca360fb560c13d52192d6b4', '[\"*\"]', '2025-09-30 03:42:58', NULL, '2025-09-30 03:42:58', '2025-09-30 03:42:58'),
(36, 'App\\Models\\AppUser', 3, 'app_user_token', '7ef1f122d0487669997a619be2f4b49fd6f69794d680b3301bdb50d4b2d2e9e0', '[\"*\"]', '2025-09-30 10:06:17', NULL, '2025-09-30 10:06:15', '2025-09-30 10:06:17'),
(37, 'App\\Models\\AppUser', 3, 'app_user_token', '3e185d679f3289b9c50e64c55bcad3c73dc865668a7ff92a703f17b05f69add4', '[\"*\"]', '2025-09-30 10:16:26', NULL, '2025-09-30 10:16:19', '2025-09-30 10:16:26'),
(38, 'App\\Models\\AppUser', 3, 'app_user_token', '8548ad33db95dc185f8986db5c9b99f4fb3f4c5f5c8aa23654dd76bb79b6033a', '[\"*\"]', '2025-09-30 10:20:54', NULL, '2025-09-30 10:20:53', '2025-09-30 10:20:54'),
(39, 'App\\Models\\AppUser', 3, 'app_user_token', 'dfd4a62227a00bce49b2f37f69b26f47469538c9d21b388ae3a7df44873c74df', '[\"*\"]', '2025-09-30 10:48:17', NULL, '2025-09-30 10:48:09', '2025-09-30 10:48:17'),
(40, 'App\\Models\\AppUser', 3, 'app_user_token', 'bcb23331533eb2884ea558682374f72ae33de35a700b15f0f3d8638a31e4a240', '[\"*\"]', '2025-09-30 10:55:28', NULL, '2025-09-30 10:55:23', '2025-09-30 10:55:28'),
(42, 'App\\Models\\AppUser', 2, 'app_user_token', 'cc5e47c3ae312a71a19ed352fe11d9c1ea625f9c96b0ecc9b358fe5760208c45', '[\"*\"]', '2025-09-30 11:31:39', NULL, '2025-09-30 11:31:36', '2025-09-30 11:31:39'),
(43, 'App\\Models\\AppUser', 3, 'app_user_token', '29e39b224d0de8d8dbf3fbb9614ef234328d017f438a359b1bfd69aeb2385d4f', '[\"*\"]', '2025-09-30 11:36:37', NULL, '2025-09-30 11:36:33', '2025-09-30 11:36:37'),
(44, 'App\\Models\\AppUser', 3, 'app_user_token', 'a17001a79a96cf40de1e30e3f6fcb40721976bb5c3dbce8067ccfce83bd9b08e', '[\"*\"]', '2025-09-30 12:41:15', NULL, '2025-09-30 12:41:11', '2025-09-30 12:41:15'),
(45, 'App\\Models\\AppUser', 1, 'app_user_token', '5c887dcc2c9c50a1af8593886c8f746b9791146989b40f0b83f03f09ed6b7cd0', '[\"*\"]', '2025-09-30 12:47:28', NULL, '2025-09-30 12:47:23', '2025-09-30 12:47:28'),
(46, 'App\\Models\\AppUser', 3, 'app_user_token', '47bff204b9302eed841b55b89693e895ef39b510d5f853a8456ecdfb8327de05', '[\"*\"]', '2025-09-30 12:52:46', NULL, '2025-09-30 12:52:46', '2025-09-30 12:52:46'),
(47, 'App\\Models\\AppUser', 2, 'app_user_token', 'a8425b1b4183ee4fe86c6bd138ca86d487bad9b887a962ad0ef05df0c6af2f92', '[\"*\"]', '2025-09-30 12:57:04', NULL, '2025-09-30 12:56:39', '2025-09-30 12:57:04'),
(48, 'App\\Models\\AppUser', 3, 'app_user_token', 'b1a6d3990c6ff47aa3798bf9fa15f91109c1018caca3f75ba79b07bb615b82cd', '[\"*\"]', '2025-09-30 13:01:04', NULL, '2025-09-30 13:01:03', '2025-09-30 13:01:04'),
(49, 'App\\Models\\AppUser', 3, 'app_user_token', 'b5f565fbf008c989cbd97a62037a952010d189ccc3ae6bfd5468945d6c802b10', '[\"*\"]', '2025-09-30 13:05:20', NULL, '2025-09-30 13:05:20', '2025-09-30 13:05:20'),
(50, 'App\\Models\\AppUser', 3, 'app_user_token', '64b662e52bf4c9fef6977120c7ff4242f541281c08a5a5072ba7a0ef1d0d3e62', '[\"*\"]', '2025-09-30 13:13:47', NULL, '2025-09-30 13:13:46', '2025-09-30 13:13:47'),
(51, 'App\\Models\\AppUser', 2, 'app_user_token', '1e8444fd3845fbfc19f881f8b8b4c350557f993c20033d19f135782c93602c24', '[\"*\"]', '2025-09-30 13:22:33', NULL, '2025-09-30 13:22:32', '2025-09-30 13:22:33'),
(52, 'App\\Models\\AppUser', 3, 'app_user_token', '0c39fbab6634310cad4f84502176b9ec2f69a1ce1f183c048e01791a906bdd1f', '[\"*\"]', '2025-09-30 13:30:13', NULL, '2025-09-30 13:30:13', '2025-09-30 13:30:13'),
(53, 'App\\Models\\AppUser', 3, 'app_user_token', 'e695a3bec69ad1778e8191bef73ff198444c43c11aa0c89a3dd7924a8ac20540', '[\"*\"]', '2025-09-30 13:49:18', NULL, '2025-09-30 13:46:36', '2025-09-30 13:49:18'),
(54, 'App\\Models\\AppUser', 3, 'app_user_token', '0636e404c727a8b02809015a1ca8b252742769f169101ba6f8dd5473807c35a1', '[\"*\"]', '2025-09-30 13:52:29', NULL, '2025-09-30 13:52:28', '2025-09-30 13:52:29'),
(55, 'App\\Models\\AppUser', 1, 'app_user_token', 'b801d01824aa347dbf3e88f43abe807535bbb1e23174d35bdae00da8c73c84e0', '[\"*\"]', '2025-09-30 13:58:30', NULL, '2025-09-30 13:57:39', '2025-09-30 13:58:30'),
(57, 'App\\Models\\AppUser', 4, 'app_user_token', 'bc42d80f6379c4272f0b8c21e33cf3134bc2cd0804367aef502e924bca0ac2b5', '[\"*\"]', '2025-09-30 14:19:29', NULL, '2025-09-30 14:19:20', '2025-09-30 14:19:29'),
(58, 'App\\Models\\AppUser', 3, 'app_user_token', '52c830c918be25a388db8241de44bd6ee1fc3315ec02b0e9fdc1d48fb8dd64c8', '[\"*\"]', '2025-10-01 10:34:24', NULL, '2025-10-01 10:34:23', '2025-10-01 10:34:24'),
(59, 'App\\Models\\AppUser', 1, 'app_user_token', 'edeaaf7d39731759d16d349831081bc057886f7adbe31c4dc318ed62e364bc99', '[\"*\"]', '2025-10-01 10:39:29', NULL, '2025-10-01 10:39:29', '2025-10-01 10:39:29'),
(60, 'App\\Models\\AppUser', 3, 'app_user_token', 'a1371a00d59880f8dbe3265e33b46e5447869805504e1a37ca0d1d93afefe825', '[\"*\"]', '2025-10-01 10:58:55', NULL, '2025-10-01 10:58:54', '2025-10-01 10:58:55'),
(61, 'App\\Models\\AppUser', 3, 'app_user_token', '82febe41ed9c951204415e2b5945cc8725745267f3c7dc208e50d5b5114d3ae5', '[\"*\"]', '2025-10-01 10:59:41', NULL, '2025-10-01 10:59:41', '2025-10-01 10:59:41'),
(63, 'App\\Models\\AppUser', 3, 'app_user_token', 'ead96c77099d2b3a32341458e12861224522c79c7629c59a5f48168350df3265', '[\"*\"]', '2025-10-01 11:16:17', NULL, '2025-10-01 11:16:08', '2025-10-01 11:16:17'),
(64, 'App\\Models\\AppUser', 3, 'app_user_token', 'c8d7969f50c302110eb6df225e947c9fef75feae5ce0a39dc8df5692dcc4c8f7', '[\"*\"]', '2025-10-01 17:32:52', NULL, '2025-10-01 17:32:31', '2025-10-01 17:32:52'),
(65, 'App\\Models\\AppUser', 3, 'app_user_token', '337543a1c51486002807ec94b716258ff8c45e9460d4d8c9f125cfc4cce854f0', '[\"*\"]', '2025-10-02 01:44:15', NULL, '2025-10-02 01:42:56', '2025-10-02 01:44:15'),
(66, 'App\\Models\\AppUser', 3, 'app_user_token', 'ddeae7abd46e155394e4b8c578f874d02e640a2b2f60730675f12dd46b0a38c3', '[\"*\"]', '2025-10-03 00:09:44', NULL, '2025-10-03 00:09:43', '2025-10-03 00:09:44'),
(67, 'App\\Models\\AppUser', 2, 'app_user_token', '3b2726facae4b8087325e647bccaa022e40c2edb44694fbbe4cc8f7e38fff537', '[\"*\"]', '2025-10-03 00:18:17', NULL, '2025-10-03 00:18:16', '2025-10-03 00:18:17'),
(68, 'App\\Models\\AppUser', 3, 'app_user_token', '9deab355b770f05ebabcfd73ca52b31ce73c39e7f989696852e511c79f22d532', '[\"*\"]', '2025-10-03 00:21:00', NULL, '2025-10-03 00:21:00', '2025-10-03 00:21:00'),
(69, 'App\\Models\\AppUser', 3, 'app_user_token', '54c37ca790437e1c1b409e17167238a16885df8aac6902b96e280106ed6d8c66', '[\"*\"]', NULL, NULL, '2025-10-03 01:29:15', '2025-10-03 01:29:15'),
(70, 'App\\Models\\AppUser', 3, 'app_user_token', '4b5a4c4a5618c71697e6c6a01bc7ec36b41658c8ad49a4fe1b5372d2d3cc8c57', '[\"*\"]', NULL, NULL, '2025-10-03 01:38:12', '2025-10-03 01:38:12'),
(71, 'App\\Models\\AppUser', 3, 'app_user_token', '2e394137004a6f852760e2260a7cf9e71ce66bc564dd3161adedd6ae9109353b', '[\"*\"]', NULL, NULL, '2025-10-03 02:09:04', '2025-10-03 02:09:04'),
(72, 'App\\Models\\AppUser', 3, 'app_user_token', '50107204fb0ebde38e3a31454e7eed43e58f8503c2aec24d62da1813bc408e5a', '[\"*\"]', NULL, NULL, '2025-10-03 02:28:43', '2025-10-03 02:28:43'),
(73, 'App\\Models\\AppUser', 1, 'app_user_token', 'dd512c19620dac741653a6b3598d8d0e48314a2d74dd214c839f2559ef3b255e', '[\"*\"]', '2025-10-03 03:08:28', NULL, '2025-10-03 03:08:27', '2025-10-03 03:08:28'),
(74, 'App\\Models\\AppUser', 1, 'app_user_token', '26fc4d5877f5845729d3090c5386e9aaf5714197b318a96df32fed330d934689', '[\"*\"]', '2025-10-03 03:13:13', NULL, '2025-10-03 03:13:13', '2025-10-03 03:13:13'),
(75, 'App\\Models\\AppUser', 2, 'app_user_token', '2f376687dc0f5b9ce4873d6af35df218d814e7f382efb9c62201c37880bc66c2', '[\"*\"]', '2025-10-03 03:17:12', NULL, '2025-10-03 03:17:12', '2025-10-03 03:17:12'),
(76, 'App\\Models\\AppUser', 1, 'app_user_token', '0ad26cfde4f7676b327f913435559f244297f0435b18643b1cdc5ce8aeeada8c', '[\"*\"]', '2025-10-03 03:20:03', NULL, '2025-10-03 03:20:03', '2025-10-03 03:20:03'),
(77, 'App\\Models\\AppUser', 2, 'app_user_token', '524e8ce20e811c72cc5617370238af90a63c9940d58229b983c280ec00985923', '[\"*\"]', '2025-10-03 04:45:00', NULL, '2025-10-03 04:45:00', '2025-10-03 04:45:00'),
(78, 'App\\Models\\AppUser', 2, 'app_user_token', '6f6d7a341b56fba91953d2f54f6a47bb570b38edc833685230679635a8dcc0fd', '[\"*\"]', '2025-10-03 05:31:25', NULL, '2025-10-03 05:31:24', '2025-10-03 05:31:25'),
(79, 'App\\Models\\AppUser', 2, 'app_user_token', '285a0856839be2273594b4d866243a682c74bf9a79956a18569058698851fafd', '[\"*\"]', '2025-10-03 05:36:14', NULL, '2025-10-03 05:36:14', '2025-10-03 05:36:14'),
(80, 'App\\Models\\AppUser', 1, 'app_user_token', '2b992e8abc6a990d6994f43cba1182840acb2b849eb90396f0f11d8f75dea243', '[\"*\"]', '2025-10-03 05:47:43', NULL, '2025-10-03 05:47:42', '2025-10-03 05:47:43'),
(81, 'App\\Models\\AppUser', 2, 'app_user_token', 'd7795f4fa3fd5d7dfca09a15eb072e9aaaeb39ea0d5156f01e01d2623716499d', '[\"*\"]', '2025-10-03 05:48:19', NULL, '2025-10-03 05:48:18', '2025-10-03 05:48:19'),
(82, 'App\\Models\\AppUser', 1, 'app_user_token', 'a74e88e02b40f440abbd01f451119eb029c3877eb5c54d02930534920d578bc8', '[\"*\"]', '2025-10-03 05:56:10', NULL, '2025-10-03 05:56:09', '2025-10-03 05:56:10'),
(83, 'App\\Models\\AppUser', 2, 'app_user_token', '9a8b9c2a9b10b0cbcc8e542a204303c97c1bd988833d1004c35e475fd01ac9ec', '[\"*\"]', '2025-10-03 06:03:28', NULL, '2025-10-03 06:03:28', '2025-10-03 06:03:28'),
(84, 'App\\Models\\AppUser', 1, 'app_user_token', '481293792b9b3419e7a920cfcf8e950f7dffc433fb6217e4b6c10b599b8d70f0', '[\"*\"]', '2025-10-03 06:06:52', NULL, '2025-10-03 06:06:51', '2025-10-03 06:06:52'),
(85, 'App\\Models\\AppUser', 2, 'app_user_token', '08863d4c01de9db62f0165a19c943e3246bad4ad5dc081b58043b3fd4f47597f', '[\"*\"]', '2025-10-03 06:11:44', NULL, '2025-10-03 06:11:43', '2025-10-03 06:11:44'),
(86, 'App\\Models\\AppUser', 2, 'app_user_token', '31a56df125a2d51dcb173da0133bc920398adc98d47662e1b8196e6217934914', '[\"*\"]', '2025-10-03 06:12:28', NULL, '2025-10-03 06:12:28', '2025-10-03 06:12:28'),
(87, 'App\\Models\\AppUser', 2, 'app_user_token', '2cfe38eb14c5403fcacf5401ab2a7380c9b7ec529c9d3d313f8b36c3ada0b25e', '[\"*\"]', '2025-10-03 06:23:27', NULL, '2025-10-03 06:23:26', '2025-10-03 06:23:27'),
(88, 'App\\Models\\AppUser', 2, 'app_user_token', '55cd98a5590680039de4a0e6dbcd76545f0e9a4817d49e3e97e5dca707fb9f73', '[\"*\"]', '2025-10-03 06:27:50', NULL, '2025-10-03 06:27:50', '2025-10-03 06:27:50'),
(89, 'App\\Models\\AppUser', 2, 'app_user_token', 'c00ce780d102199be8fa97eab1cbd2b60b2c2a21a1d1985125be272b69954e52', '[\"*\"]', '2025-10-03 06:31:43', NULL, '2025-10-03 06:31:43', '2025-10-03 06:31:43'),
(90, 'App\\Models\\AppUser', 2, 'app_user_token', '89d7a8a0d5eed27475369a53ee0a3f6d1f77fa92ee1cefee281e5c836adf1321', '[\"*\"]', '2025-10-03 06:35:55', NULL, '2025-10-03 06:35:55', '2025-10-03 06:35:55'),
(91, 'App\\Models\\AppUser', 2, 'app_user_token', '3b85dbd1319ef160836d12e9f143dc95c1efdc6ff03954ae26e531d15cc31450', '[\"*\"]', '2025-10-03 06:36:33', NULL, '2025-10-03 06:36:32', '2025-10-03 06:36:33'),
(92, 'App\\Models\\AppUser', 2, 'app_user_token', 'e63cb160ec719700b49b446d19010387a826a5190e57d5b93646d7ab523627de', '[\"*\"]', '2025-10-03 06:44:00', NULL, '2025-10-03 06:43:59', '2025-10-03 06:44:00'),
(93, 'App\\Models\\AppUser', 2, 'app_user_token', '2adfe8d60b780eff41da4d1573df1c4f9e4330647f248d338d97bc62d5cad036', '[\"*\"]', '2025-10-03 06:48:19', NULL, '2025-10-03 06:48:18', '2025-10-03 06:48:19'),
(94, 'App\\Models\\AppUser', 2, 'app_user_token', '0edb69eb259b8ea392e624cb71fa047ef98032010d35202d50022e7c06e9cb0f', '[\"*\"]', '2025-10-03 07:36:16', NULL, '2025-10-03 07:36:14', '2025-10-03 07:36:16'),
(95, 'App\\Models\\AppUser', 2, 'app_user_token', '21d8f871b02c7f754ade08d11b100bb155f39e758fc41df78854eb37ed70e954', '[\"*\"]', '2025-10-05 09:02:22', NULL, '2025-10-05 09:02:21', '2025-10-05 09:02:22'),
(96, 'App\\Models\\AppUser', 2, 'app_user_token', 'f1c43ab2bfa3fa8d72503741f9e005acefb353eda28ffa5bfa23431488b98263', '[\"*\"]', '2025-10-05 09:22:16', NULL, '2025-10-05 09:22:16', '2025-10-05 09:22:16'),
(97, 'App\\Models\\AppUser', 1, 'app_user_token', '5147ecd045ddb18024d3e00fb7498563c9a602017453c4977ffc95b62efcf065', '[\"*\"]', '2025-10-05 09:23:34', NULL, '2025-10-05 09:23:33', '2025-10-05 09:23:34'),
(98, 'App\\Models\\AppUser', 2, 'app_user_token', '0d1aaf0e0757ffc77262cbd7b92407fbcda56971daa21fb88123dda8b62fe86d', '[\"*\"]', '2025-10-05 09:24:48', NULL, '2025-10-05 09:24:48', '2025-10-05 09:24:48'),
(99, 'App\\Models\\AppUser', 2, 'app_user_token', '21076b8580e96c44bd981cda499857e0ef3445bf3241b8a4376d237628ae2711', '[\"*\"]', '2025-10-05 09:39:48', NULL, '2025-10-05 09:39:48', '2025-10-05 09:39:48'),
(100, 'App\\Models\\AppUser', 2, 'app_user_token', '28f66ffe6d63747c68babe5abe54b968a14ff98aafa7af904752dd7a87af6876', '[\"*\"]', '2025-10-05 10:24:06', NULL, '2025-10-05 10:24:06', '2025-10-05 10:24:06'),
(101, 'App\\Models\\AppUser', 2, 'app_user_token', '02657057fcf59bc8f35d67c7aca55346230d42c0fe834571af09e59a5dbd2fa4', '[\"*\"]', '2025-10-05 10:37:09', NULL, '2025-10-05 10:37:09', '2025-10-05 10:37:09'),
(102, 'App\\Models\\AppUser', 1, 'app_user_token', '7fae658ba0234bc8cd5371a1b81ed73bd1918a5280636d033989fe732c944a49', '[\"*\"]', '2025-10-05 11:01:36', NULL, '2025-10-05 11:01:36', '2025-10-05 11:01:36'),
(103, 'App\\Models\\AppUser', 1, 'app_user_token', '0cd2e374fbe47f9b73c2038e4295e23883b864f627e91e4f314b52730de76d11', '[\"*\"]', '2025-10-05 11:53:23', NULL, '2025-10-05 11:53:22', '2025-10-05 11:53:23'),
(104, 'App\\Models\\AppUser', 2, 'app_user_token', '19819fab538f4079e607b9ef33e3e5c79bb5bc6c75af0e47ef78d720e4df8e8c', '[\"*\"]', '2025-10-06 06:28:18', NULL, '2025-10-06 06:28:15', '2025-10-06 06:28:18'),
(105, 'App\\Models\\AppUser', 2, 'app_user_token', '58438b18c3ecdb15ed7238b62466af59788b05ec9b7c5f9adc52bcbcd819f539', '[\"*\"]', '2025-10-06 08:40:31', NULL, '2025-10-06 08:40:30', '2025-10-06 08:40:31'),
(106, 'App\\Models\\AppUser', 2, 'app_user_token', 'f9ee25c79dd107d836022264b5c91361c6122ec1d2aa6214a7d7457c3871f170', '[\"*\"]', '2025-10-06 08:58:57', NULL, '2025-10-06 08:58:56', '2025-10-06 08:58:57'),
(107, 'App\\Models\\AppUser', 2, 'app_user_token', 'b3659eee0c1f7aa3119c613da88b901c42bbde695578b57afc60534d87b446c8', '[\"*\"]', '2025-10-06 16:56:19', NULL, '2025-10-06 16:56:18', '2025-10-06 16:56:19'),
(108, 'App\\Models\\AppUser', 2, 'app_user_token', 'e09183cf54216ed0db6973b20d5dfda43b17df70ad7548112b91908dec5d7914', '[\"*\"]', '2025-10-06 17:02:41', NULL, '2025-10-06 17:02:40', '2025-10-06 17:02:41'),
(109, 'App\\Models\\AppUser', 1, 'app_user_token', '2d3a18ae3b0182ca1dba0f229db748903023e0cb5d443c2039c121ae23ce25f8', '[\"*\"]', '2025-10-06 17:06:10', NULL, '2025-10-06 17:06:10', '2025-10-06 17:06:10'),
(110, 'App\\Models\\AppUser', 2, 'app_user_token', '2e68b8afc971b7559239da3eebbd3bfdb0cfb61029541a7e6508ebea10f344b3', '[\"*\"]', '2025-10-06 17:07:02', NULL, '2025-10-06 17:07:01', '2025-10-06 17:07:02'),
(111, 'App\\Models\\AppUser', 2, 'app_user_token', 'fd858c03dee9c3ba71d7f56aa1c93dad05abef540b5dac6b3bbb488c397ad4a4', '[\"*\"]', '2025-10-06 17:22:58', NULL, '2025-10-06 17:22:58', '2025-10-06 17:22:58'),
(112, 'App\\Models\\AppUser', 2, 'app_user_token', 'd5884014301040b2733d693124ba26ff0e95491365e40beaea5944217078b920', '[\"*\"]', '2025-10-06 17:32:16', NULL, '2025-10-06 17:32:16', '2025-10-06 17:32:16'),
(114, 'App\\Models\\AppUser', 2, 'app_user_token', '30ba8b844e3422ae5ddedd97e2328112f17024fa683fb9b55007845d64ec8905', '[\"*\"]', '2025-10-06 17:34:18', NULL, '2025-10-06 17:34:17', '2025-10-06 17:34:18'),
(115, 'App\\Models\\AppUser', 2, 'app_user_token', '986429afc1a35ab983029ba5225fc7290a214211e801a71c2b02ee046168ed35', '[\"*\"]', '2025-10-06 17:42:36', NULL, '2025-10-06 17:42:35', '2025-10-06 17:42:36'),
(116, 'App\\Models\\AppUser', 2, 'app_user_token', '85b408fb9ee69e1804eb924fa94bfcc4b290b0df74856073b61dafaaa3f77c6d', '[\"*\"]', '2025-10-06 17:43:00', NULL, '2025-10-06 17:43:00', '2025-10-06 17:43:00'),
(117, 'App\\Models\\AppUser', 2, 'app_user_token', '4b4afa3f2919027a8cb70317a27c6f75d14c9f86c094d73f65163e5ee9aad921', '[\"*\"]', '2025-10-06 17:49:53', NULL, '2025-10-06 17:49:52', '2025-10-06 17:49:53'),
(118, 'App\\Models\\AppUser', 2, 'app_user_token', 'ad3e204b4916883792739c46ca1fc5ae9bed23a91f35c380b82e1ded51c2087a', '[\"*\"]', '2025-10-06 18:04:35', NULL, '2025-10-06 18:04:35', '2025-10-06 18:04:35'),
(119, 'App\\Models\\AppUser', 2, 'app_user_token', 'ec12f453b9089120afb700709389a11df906284ab3cc706f85689044074df667', '[\"*\"]', '2025-10-06 18:15:45', NULL, '2025-10-06 18:15:45', '2025-10-06 18:15:45'),
(120, 'App\\Models\\AppUser', 2, 'app_user_token', '125e850776881075c2ed9ea4d3b08c573cae5cda4f8abad989534475be71fe17', '[\"*\"]', '2025-10-06 18:16:11', NULL, '2025-10-06 18:16:10', '2025-10-06 18:16:11'),
(121, 'App\\Models\\AppUser', 2, 'app_user_token', 'ea3fca220adf511fecca718fc20b9e31943fde10557499add92f69e87c04b65a', '[\"*\"]', '2025-10-07 01:50:34', NULL, '2025-10-07 01:50:33', '2025-10-07 01:50:34'),
(122, 'App\\Models\\AppUser', 2, 'app_user_token', '7a19eed1dfd0aa439d0c5ee8c99a6883051d56d4ffd3f6f09ef7a371a7304cc2', '[\"*\"]', '2025-10-07 02:04:30', NULL, '2025-10-07 02:04:30', '2025-10-07 02:04:30'),
(123, 'App\\Models\\AppUser', 2, 'app_user_token', '9de5d19d3eb66384efb1e6860f54d515a8e96aeb4ae035837276a656c32e66b3', '[\"*\"]', '2025-10-07 02:08:51', NULL, '2025-10-07 02:08:51', '2025-10-07 02:08:51'),
(124, 'App\\Models\\AppUser', 2, 'app_user_token', 'ae5880e24f07bbf0c7226df16974be834960227592354b31adc3156ccb803e37', '[\"*\"]', '2025-10-07 02:09:39', NULL, '2025-10-07 02:09:38', '2025-10-07 02:09:39'),
(125, 'App\\Models\\AppUser', 2, 'app_user_token', '486fb8c3e360ecf855bf88028962a161a381cc1f8fda56a90b61e9bd0b80ed41', '[\"*\"]', '2025-10-07 02:39:30', NULL, '2025-10-07 02:39:29', '2025-10-07 02:39:30'),
(126, 'App\\Models\\AppUser', 2, 'app_user_token', '2eb9445f9155eb6daf7864717a2d755d5711a45d17ea4ca6d4d4a8c7cd6547b5', '[\"*\"]', '2025-10-07 02:45:21', NULL, '2025-10-07 02:45:21', '2025-10-07 02:45:21'),
(127, 'App\\Models\\AppUser', 2, 'app_user_token', '4a1777a163f79aa135c7cf35834db64cbfe0a1a0d2ee6cd99c2a7a702b785030', '[\"*\"]', '2025-10-07 03:01:36', NULL, '2025-10-07 03:01:36', '2025-10-07 03:01:36'),
(128, 'App\\Models\\AppUser', 2, 'app_user_token', '582f1b9b70627dc521b1af674c55f371c81af38c62ce8acc1da5ca4eff88d2eb', '[\"*\"]', '2025-10-07 03:02:16', NULL, '2025-10-07 03:02:16', '2025-10-07 03:02:16'),
(129, 'App\\Models\\AppUser', 2, 'app_user_token', '5070fc4e2a2c2c631899d878dd8737bae6f77c04c3b8a7b48af2918d03db9c3c', '[\"*\"]', '2025-10-07 03:58:52', NULL, '2025-10-07 03:58:51', '2025-10-07 03:58:52'),
(130, 'App\\Models\\AppUser', 2, 'app_user_token', 'b3f8cc38e57b107662260612067252782d0dd1dcce8f4a6b54609648ebf62f8c', '[\"*\"]', '2025-10-07 04:03:06', NULL, '2025-10-07 04:03:06', '2025-10-07 04:03:06'),
(131, 'App\\Models\\AppUser', 2, 'app_user_token', '22a8ec723a08f0c08ed5132a4cc2b96ff2a64fa5dab7117577ad64068c79925a', '[\"*\"]', '2025-10-07 04:17:05', NULL, '2025-10-07 04:17:04', '2025-10-07 04:17:05'),
(132, 'App\\Models\\AppUser', 2, 'app_user_token', '2a9ec2615f6cfdf4bdb36f17d737d0fbdc222b85d84927870904ea29fa332d44', '[\"*\"]', '2025-10-07 04:23:24', NULL, '2025-10-07 04:23:24', '2025-10-07 04:23:24'),
(133, 'App\\Models\\AppUser', 2, 'app_user_token', 'f931ae95c36c945e38dbc610c8417bb6d3d1b4545e565be8f61f3356e993d987', '[\"*\"]', '2025-10-07 04:34:39', NULL, '2025-10-07 04:34:38', '2025-10-07 04:34:39'),
(134, 'App\\Models\\AppUser', 2, 'app_user_token', 'b0dce5455d4018e33c503f6d01665dec274e71f25fbdf82e3449cb6fe68a7f2a', '[\"*\"]', '2025-10-07 04:35:03', NULL, '2025-10-07 04:35:03', '2025-10-07 04:35:03'),
(135, 'App\\Models\\AppUser', 2, 'app_user_token', '3f8f459b8417dd39a9e5ed541b61409848a9ac3fc9f282cc9d376a9358af2d1b', '[\"*\"]', '2025-10-07 04:45:07', NULL, '2025-10-07 04:45:07', '2025-10-07 04:45:07'),
(136, 'App\\Models\\AppUser', 2, 'app_user_token', 'f411b38df2b300b47ceaff125a0ca2f7c74409b8d4af10f398776f839171f04a', '[\"*\"]', '2025-10-07 04:57:42', NULL, '2025-10-07 04:57:41', '2025-10-07 04:57:42'),
(137, 'App\\Models\\AppUser', 2, 'app_user_token', '4b735a53329a82d3721559fb36dab29abfcbce5cb14f70396123d4deed153ec7', '[\"*\"]', '2025-10-07 05:00:46', NULL, '2025-10-07 05:00:45', '2025-10-07 05:00:46'),
(138, 'App\\Models\\AppUser', 2, 'app_user_token', '47ed999942d9ecdf61bc07d6ecf7579b78318a3aabdfbcc69d5988e3a6a77743', '[\"*\"]', '2025-10-07 05:15:31', NULL, '2025-10-07 05:15:31', '2025-10-07 05:15:31'),
(139, 'App\\Models\\AppUser', 2, 'app_user_token', 'd9a8892185d3377a080b62d4abedf15453e9208de677d3dd7e8455cf56a11885', '[\"*\"]', '2025-10-07 05:39:18', NULL, '2025-10-07 05:39:17', '2025-10-07 05:39:18'),
(140, 'App\\Models\\AppUser', 2, 'app_user_token', '88bb3d785a587db9adf33c6ea68383c489148131caaca40f696a18a18eca0887', '[\"*\"]', '2025-10-07 05:41:16', NULL, '2025-10-07 05:41:16', '2025-10-07 05:41:16'),
(141, 'App\\Models\\AppUser', 2, 'app_user_token', 'be5a7c4c7a7e6ec195421061e3d91ab3988956215133bdb783bff926c7c16076', '[\"*\"]', '2025-10-07 05:44:09', NULL, '2025-10-07 05:44:09', '2025-10-07 05:44:09'),
(142, 'App\\Models\\AppUser', 2, 'app_user_token', 'e8a487de0acaa8904b2cda53e3632dc4dcf1265d2e75f5812016659853f2e871', '[\"*\"]', '2025-10-07 05:47:39', NULL, '2025-10-07 05:47:39', '2025-10-07 05:47:39'),
(143, 'App\\Models\\AppUser', 2, 'app_user_token', '4ce01180b3ecd6345d5215c0d1f821f08c77ddfe0c374bac466bc9e98b12f5e5', '[\"*\"]', '2025-10-07 05:57:24', NULL, '2025-10-07 05:57:23', '2025-10-07 05:57:24'),
(144, 'App\\Models\\AppUser', 2, 'app_user_token', '6e4fefbc0f40f9a7c342377cfd23872b95be383d5ede1bfb2a0ad834be4efeea', '[\"*\"]', '2025-10-07 05:58:34', NULL, '2025-10-07 05:58:33', '2025-10-07 05:58:34'),
(145, 'App\\Models\\AppUser', 2, 'app_user_token', '5f9ef5e019d9d1365738861e17fb129aecf45a66e9252e1975aa6358291ff08b', '[\"*\"]', '2025-10-07 06:00:54', NULL, '2025-10-07 06:00:54', '2025-10-07 06:00:54'),
(146, 'App\\Models\\AppUser', 3, 'app_user_token', '26809b2c189efd704529b6d3b39e1552159470182578f6ab1257c1257670164d', '[\"*\"]', '2025-10-07 06:53:30', NULL, '2025-10-07 06:53:30', '2025-10-07 06:53:30'),
(147, 'App\\Models\\AppUser', 3, 'app_user_token', '5aae667383d37f88f373526280162455c092f2524142ee30501807089e823040', '[\"*\"]', '2025-10-07 06:54:26', NULL, '2025-10-07 06:54:26', '2025-10-07 06:54:26'),
(148, 'App\\Models\\AppUser', 3, 'app_user_token', '53e57292117e273a030ffd8d473f589b0c4fcda12f7c0251dba41f5d71ea46dd', '[\"*\"]', NULL, NULL, '2025-10-07 06:58:08', '2025-10-07 06:58:08'),
(149, 'App\\Models\\AppUser', 3, 'app_user_token', '67080ad5c10e4334f3f89fc76d72cdb32b20147312dc4326a5060f43ccbda5b3', '[\"*\"]', '2025-10-07 07:08:31', NULL, '2025-10-07 07:08:00', '2025-10-07 07:08:31'),
(150, 'App\\Models\\AppUser', 2, 'app_user_token', '5a9396c84ddafe7a44b7252e6046d18f02493799b1ee99bc01730cdf38b00332', '[\"*\"]', '2025-10-07 07:13:18', NULL, '2025-10-07 07:13:17', '2025-10-07 07:13:18'),
(152, 'App\\Models\\AppUser', 2, 'app_user_token', '93a6fa0e773c4856f81dc4aebe9b8313d892516facc32e7880f2e0d1c6a9331f', '[\"*\"]', '2025-10-07 07:15:22', NULL, '2025-10-07 07:15:20', '2025-10-07 07:15:22'),
(153, 'App\\Models\\AppUser', 2, 'app_user_token', '3fa5cbefcee1b64ce538f50e71d8a6b3b5c9983c056ae5948c4056f677938876', '[\"*\"]', '2025-10-07 07:18:56', NULL, '2025-10-07 07:18:53', '2025-10-07 07:18:56'),
(155, 'App\\Models\\AppUser', 7, 'app_user_token', '5a3972c8df74b693173b53f5499dec8cbe9270367cd90cb5f290665b72af89e8', '[\"*\"]', '2025-10-07 07:41:36', NULL, '2025-10-07 07:41:30', '2025-10-07 07:41:36'),
(156, 'App\\Models\\AppUser', 7, 'app_user_token', 'f6dd3124bb004403c4a1bed866d362f008ef62366fbb3a616d5a0086c54fa9ad', '[\"*\"]', '2025-10-07 07:48:33', NULL, '2025-10-07 07:47:52', '2025-10-07 07:48:33'),
(158, 'App\\Models\\AppUser', 2, 'app_user_token', 'c174fb9651f87b8e33fa9d8cdda30d5e468a1892c18396eb3894ad390780e1bd', '[\"*\"]', '2025-10-07 08:05:46', NULL, '2025-10-07 08:04:32', '2025-10-07 08:05:46'),
(159, 'App\\Models\\AppUser', 8, 'app_user_token', '94e38dc2ed393d4a479a5c41fe6ee364d1fd98b3e367bc153c04aa5d16255383', '[\"*\"]', NULL, NULL, '2025-10-07 08:37:21', '2025-10-07 08:37:21'),
(161, 'App\\Models\\AppUser', 8, 'app_user_token', 'b2b4ecdf04be9faa38f61cb8f4175ade554ad6dbe2cf8dcfb16a85a31b53c402', '[\"*\"]', '2025-10-07 08:56:53', NULL, '2025-10-07 08:56:40', '2025-10-07 08:56:53'),
(163, 'App\\Models\\AppUser', 7, 'app_user_token', '57c2fc00a1d7881bc5a6f41e3ee75abf035f8f82f414b470fc91f278ec33d9da', '[\"*\"]', '2025-10-07 09:02:28', NULL, '2025-10-07 09:02:04', '2025-10-07 09:02:28'),
(164, 'App\\Models\\AppUser', 1, 'app_user_token', '879107d6ce79a0ddcd60a88bb05ea58fa91cfd69822dc3a7a9c88820ac916b41', '[\"*\"]', '2025-10-07 09:19:48', NULL, '2025-10-07 09:19:07', '2025-10-07 09:19:48'),
(166, 'App\\Models\\AppUser', 1, 'app_user_token', 'd7c39ae8627b55f27e44cde30cc66a5de4ac0aefefe9d81f53838941d5560823', '[\"*\"]', '2025-10-07 09:22:44', NULL, '2025-10-07 09:22:44', '2025-10-07 09:22:44'),
(167, 'App\\Models\\AppUser', 1, 'app_user_token', 'f7658db9ba9f910d969a05bbb999b7a2b3f97aa4d496c62f2865d40baae6390f', '[\"*\"]', '2025-10-07 09:25:49', NULL, '2025-10-07 09:25:19', '2025-10-07 09:25:49'),
(169, 'App\\Models\\AppUser', 2, 'app_user_token', '5a9caa0bcdf6852ab9ac50e26ca8f53292c1eb1ff611a1199e50ee04c8578d4c', '[\"*\"]', '2025-10-07 09:51:25', NULL, '2025-10-07 09:47:39', '2025-10-07 09:51:25'),
(170, 'App\\Models\\AppUser', 2, 'app_user_token', 'ca4a88ae4978c74289a9d82c7fe04509d60d1d2c30599576ae25202166c63ec5', '[\"*\"]', '2025-10-07 09:54:55', NULL, '2025-10-07 09:54:43', '2025-10-07 09:54:55'),
(171, 'App\\Models\\AppUser', 1, 'app_user_token', '0c5fe889633ba2e7f6d2b352aef5a96508faa041628d9d2b90b1cbbb93fe12fb', '[\"*\"]', '2025-10-07 09:55:25', NULL, '2025-10-07 09:55:12', '2025-10-07 09:55:25'),
(172, 'App\\Models\\AppUser', 2, 'app_user_token', '15b32929d20ac685da482172bbf65c6b2173c5298c59140aa5adb594a9591ba7', '[\"*\"]', '2025-10-07 09:59:17', NULL, '2025-10-07 09:59:16', '2025-10-07 09:59:17'),
(173, 'App\\Models\\AppUser', 1, 'app_user_token', '1fbb1647ccda3da90c75733d56256de21be75fe7e11c5f93163c38dbead7f810', '[\"*\"]', '2025-10-07 10:22:57', NULL, '2025-10-07 10:08:48', '2025-10-07 10:22:57'),
(174, 'App\\Models\\AppUser', 2, 'app_user_token', '78effbe5642f2c92a162252ab080c19366df061e08fedf964bedf58b84f13603', '[\"*\"]', '2025-10-07 10:11:32', NULL, '2025-10-07 10:10:16', '2025-10-07 10:11:32'),
(175, 'App\\Models\\AppUser', 1, 'app_user_token', 'b143c4a088118503e2b9f66e68415097894ed78b639ee9db7d3dacf5b047e3a1', '[\"*\"]', '2025-10-07 10:38:08', NULL, '2025-10-07 10:36:06', '2025-10-07 10:38:08'),
(176, 'App\\Models\\AppUser', 1, 'app_user_token', '5213bbe7e70ad2012e6b5e7c323fd0b7120fae9f6e4300a5e420ef1e6e5286d9', '[\"*\"]', '2025-10-07 10:45:38', NULL, '2025-10-07 10:45:27', '2025-10-07 10:45:38'),
(177, 'App\\Models\\AppUser', 2, 'app_user_token', '407d828500eb9b4c48b46807f449613bb8d60a932f03c67da894059e646331d3', '[\"*\"]', '2025-10-07 10:53:38', NULL, '2025-10-07 10:51:01', '2025-10-07 10:53:38'),
(178, 'App\\Models\\AppUser', 2, 'app_user_token', '93b87e6c7b4e363e907db7952922ff06537b938fb0a619abdb897e649c1047fc', '[\"*\"]', '2025-10-07 10:56:49', NULL, '2025-10-07 10:56:48', '2025-10-07 10:56:49'),
(179, 'App\\Models\\AppUser', 2, 'app_user_token', '19614f0c89e7cb893d6a2348b10d0e5927890163138939c2c29d62a290934696', '[\"*\"]', '2025-10-07 11:12:47', NULL, '2025-10-07 11:11:25', '2025-10-07 11:12:47'),
(180, 'App\\Models\\AppUser', 2, 'app_user_token', 'cdaa2625c52aedbc47b241645c84c7d873fbcbf75655b643f3df28cdb7da686d', '[\"*\"]', '2025-10-07 11:16:40', NULL, '2025-10-07 11:16:39', '2025-10-07 11:16:40'),
(181, 'App\\Models\\AppUser', 2, 'app_user_token', '93b03a14fa8d7daaf0c603390be0cdb13f85f2a4d4adb5c331723e24c876ddec', '[\"*\"]', '2025-10-07 11:27:38', NULL, '2025-10-07 11:27:37', '2025-10-07 11:27:38'),
(182, 'App\\Models\\AppUser', 2, 'app_user_token', 'ba7a2e7d644b502186a6584a8acc79b14e35eb263a139253c29a779378f996ee', '[\"*\"]', '2025-10-07 11:39:18', NULL, '2025-10-07 11:36:27', '2025-10-07 11:39:18'),
(183, 'App\\Models\\AppUser', 1, 'app_user_token', 'dfcf0e0b27ef022adf52c1f97fc4c08dc11ceb6fe81b3b18f84e78d91a78f96f', '[\"*\"]', '2025-10-07 11:41:39', NULL, '2025-10-07 11:41:31', '2025-10-07 11:41:39'),
(184, 'App\\Models\\AppUser', 1, 'app_user_token', '39e26570ba5d088cc283450a06c833183a901c70cced62672d0b2b1f100e4a5e', '[\"*\"]', '2025-10-07 11:46:50', NULL, '2025-10-07 11:42:41', '2025-10-07 11:46:50'),
(186, 'App\\Models\\AppUser', 1, 'app_user_token', 'b57f25cf584df3f0734e59476571da8900f70332f6bf10bf39cdf3e3d48579cd', '[\"*\"]', '2025-10-07 11:57:14', NULL, '2025-10-07 11:57:01', '2025-10-07 11:57:14'),
(187, 'App\\Models\\AppUser', 1, 'app_user_token', '36a4599e39037a18385a6a3c8fbf2b828bebac295c8de34e57ec7b6c1af1fa50', '[\"*\"]', '2025-10-07 11:57:37', NULL, '2025-10-07 11:57:36', '2025-10-07 11:57:37'),
(188, 'App\\Models\\AppUser', 1, 'app_user_token', 'dd4168c66c30dd74d4255ac092905f0ad731b1a09a0d767ddd09648ae77533c2', '[\"*\"]', '2025-10-07 19:36:59', NULL, '2025-10-07 19:36:07', '2025-10-07 19:36:59'),
(189, 'App\\Models\\AppUser', 1, 'app_user_token', '325c6d96be901e35b059b3867db0dbef96f1f59ddc09f2f65c4de754c61420cc', '[\"*\"]', '2025-10-07 20:45:49', NULL, '2025-10-07 19:51:58', '2025-10-07 20:45:49'),
(190, 'App\\Models\\AppUser', 1, 'app_user_token', 'fdd38826c39d012b980e5b57307c37f8de594fdfeb7057578ae339bbfcc3430b', '[\"*\"]', '2025-10-07 20:47:21', NULL, '2025-10-07 20:47:20', '2025-10-07 20:47:21'),
(193, 'App\\Models\\AppUser', 1, 'app_user_token', '3f6183e382132efefe5d1ac3ddc3483d3675bc1c71ec03e776b9c40c7fa618da', '[\"*\"]', '2025-10-08 01:17:09', NULL, '2025-10-07 21:01:26', '2025-10-08 01:17:09'),
(194, 'App\\Models\\AppUser', 1, 'app_user_token', 'c62454157a8602cfc19338a89c7fc5444d47439a5a7b59c2bf4110c7c4f85e36', '[\"*\"]', '2025-10-07 21:39:50', NULL, '2025-10-07 21:14:33', '2025-10-07 21:39:50'),
(196, 'App\\Models\\AppUser', 3, 'app_user_token', '184608756087b076dcdc6b7d8f216a1368270c1dd145738fba433dfb67677171', '[\"*\"]', NULL, NULL, '2025-10-08 00:49:58', '2025-10-08 00:49:58'),
(200, 'App\\Models\\AppUser', 3, 'app_user_token', '6845ff1e821c62eccd6fa023fed2e52fa1f2fe502f864086f8e9f7885a76eae7', '[\"*\"]', '2025-10-08 00:59:54', NULL, '2025-10-08 00:59:53', '2025-10-08 00:59:54'),
(202, 'App\\Models\\AppUser', 7, 'app_user_token', '6323442bee20bf28fee61c67d08d8608e242a6565c9def9b1d9a1133203485c4', '[\"*\"]', '2025-10-08 01:24:34', NULL, '2025-10-08 01:22:36', '2025-10-08 01:24:34'),
(203, 'App\\Models\\AppUser', 2, 'app_user_token', '06b88c62a5dc9913c65023bbf693133a8af45651d30ee934315fada49079be1f', '[\"*\"]', '2025-10-08 06:48:30', NULL, '2025-10-08 01:24:21', '2025-10-08 06:48:30'),
(204, 'App\\Models\\AppUser', 7, 'app_user_token', '626018408fab31a95b4e31cd1c07a17c688bf76d9a36dfbae9d51f2e8ef8f939', '[\"*\"]', '2025-10-08 06:54:42', NULL, '2025-10-08 01:30:32', '2025-10-08 06:54:42'),
(205, 'App\\Models\\AppUser', 1, 'app_user_token', '06085c58f58e2e5717696cee8d161d966b7f4316a3adcb6c254aab40874df90b', '[\"*\"]', '2025-10-08 02:06:47', NULL, '2025-10-08 02:06:46', '2025-10-08 02:06:47'),
(206, 'App\\Models\\AppUser', 3, 'app_user_token', '8fbbce0d7b9d8da5a963b649c20e1125a003323e5027478eaa08647d6f56076a', '[\"*\"]', '2025-10-08 03:33:01', NULL, '2025-10-08 03:04:00', '2025-10-08 03:33:01'),
(210, 'App\\Models\\AppUser', 7, 'app_user_token', 'f15ff6c1e96147e3deec2cd54c190716525a59ecd5ebc48765b20275de64f189', '[\"*\"]', '2025-10-08 10:03:06', NULL, '2025-10-08 10:02:36', '2025-10-08 10:03:06'),
(211, 'App\\Models\\AppUser', 7, 'app_user_token', '3c32cd2dad4341ac5c9ba68e110a72ffe8a48e8fc97aebe14c37a6ba39eae69c', '[\"*\"]', '2025-10-08 10:13:20', NULL, '2025-10-08 10:13:20', '2025-10-08 10:13:20'),
(212, 'App\\Models\\AppUser', 7, 'app_user_token', '59cf2aa6dbdb75d1c8385de9761ddb3369e6a9c7478bef32b28294f89ff7117b', '[\"*\"]', '2025-10-08 10:19:38', NULL, '2025-10-08 10:19:33', '2025-10-08 10:19:38'),
(213, 'App\\Models\\AppUser', 2, 'app_user_token', 'b266bb98b0b9962c1a120bcce73076cc206dc831b9d4120bc8abeb369bb71206', '[\"*\"]', '2025-10-08 10:22:28', NULL, '2025-10-08 10:22:03', '2025-10-08 10:22:28'),
(214, 'App\\Models\\AppUser', 7, 'app_user_token', '7c7bf98c9dace285dea2771a87c6ec4771f969586997237c561f59c36e7fc232', '[\"*\"]', '2025-10-08 10:26:52', NULL, '2025-10-08 10:25:05', '2025-10-08 10:26:52'),
(215, 'App\\Models\\AppUser', 2, 'app_user_token', '9bf17ddb45ffbc6dba54e7ae5b0c732d3f8dee6d2ad7864db77764ec9efb2860', '[\"*\"]', '2025-10-08 10:55:26', NULL, '2025-10-08 10:55:14', '2025-10-08 10:55:26'),
(217, 'App\\Models\\AppUser', 3, 'app_user_token', '5365241b98b533fd835794611395bb5cdae96bc24d44e638d5a9f64a74c9c7ec', '[\"*\"]', '2025-10-08 11:14:29', NULL, '2025-10-08 11:00:03', '2025-10-08 11:14:29'),
(218, 'App\\Models\\AppUser', 7, 'app_user_token', '98132092869b7e520a7104b8d6174b74ac98f6e81c24d0145431fc78a86a6bce', '[\"*\"]', '2025-10-08 11:30:59', NULL, '2025-10-08 11:30:56', '2025-10-08 11:30:59'),
(219, 'App\\Models\\AppUser', 2, 'app_user_token', '489219d4fd9a13747b15a5cc55a9a75267a8cf624bb298542f9e80878f5ce59f', '[\"*\"]', '2025-10-08 11:39:52', NULL, '2025-10-08 11:39:52', '2025-10-08 11:39:52'),
(220, 'App\\Models\\AppUser', 2, 'app_user_token', 'eb1c686e7ac868779f49868d9703abafd32ace1300aec8706a666192e41354a4', '[\"*\"]', '2025-10-08 11:42:14', NULL, '2025-10-08 11:42:13', '2025-10-08 11:42:14'),
(221, 'App\\Models\\AppUser', 7, 'app_user_token', '2bd84e7ac0abc607852ff30fbaedf6194929c2e4429f972417a2a4bcb4bd48a8', '[\"*\"]', '2025-10-08 11:48:01', NULL, '2025-10-08 11:48:00', '2025-10-08 11:48:01'),
(223, 'App\\Models\\AppUser', 2, 'app_user_token', '6826b9822f0dcb19374c7b6d140da00a6b2c4bb68889acc57522ee6b8744ed72', '[\"*\"]', '2025-10-08 11:55:43', NULL, '2025-10-08 11:52:35', '2025-10-08 11:55:43'),
(231, 'App\\Models\\AppUser', 7, 'app_user_token', 'de0ddbea238dce17c6d19f9d5814613c2d3922d79aacf957948636da928bd03a', '[\"*\"]', '2025-10-08 15:31:36', NULL, '2025-10-08 15:31:29', '2025-10-08 15:31:36'),
(232, 'App\\Models\\AppUser', 2, 'app_user_token', '48c1868cdfc6bbd9035b2bdcb7f1039a7823bff476231e597cd09319a60c5e9e', '[\"*\"]', '2025-10-08 15:33:27', NULL, '2025-10-08 15:33:06', '2025-10-08 15:33:27'),
(233, 'App\\Models\\AppUser', 1, 'app_user_token', '02820f01715e58bd114368ee306820010608066d9c09846f3198ef9903db416a', '[\"*\"]', '2025-10-08 21:10:17', NULL, '2025-10-08 21:09:53', '2025-10-08 21:10:17'),
(237, 'App\\Models\\AppUser', 7, 'app_user_token', 'b7a8508a3a5e599ef23cc988f0009f09e3447052ce011068b6ee5d1297ef9545', '[\"*\"]', '2025-10-12 07:29:42', NULL, '2025-10-08 23:06:52', '2025-10-12 07:29:42'),
(238, 'App\\Models\\AppUser', 7, 'app_user_token', '014548cad070d572f3c1ce7cbfff538db6f1e940803841b44688d5406edbf91c', '[\"*\"]', '2025-10-09 01:27:50', NULL, '2025-10-09 00:00:19', '2025-10-09 01:27:50'),
(239, 'App\\Models\\AppUser', 2, 'app_user_token', '3802d58c963c4a8a0174a31f98f1de5d78065ab23470f10417490bb4bd6c3a8e', '[\"*\"]', '2025-10-20 17:35:24', NULL, '2025-10-09 00:26:36', '2025-10-20 17:35:24'),
(240, 'App\\Models\\AppUser', 1, 'app_user_token', 'd3174798f4c0d233b52e23837c873c4ffdab21b1b718bf6e8013945460642ba9', '[\"*\"]', '2025-10-12 08:10:09', NULL, '2025-10-12 07:31:11', '2025-10-12 08:10:09'),
(241, 'App\\Models\\AppUser', 7, 'app_user_token', '2b42bb647a1323f125360e908bd1b530fae4c3a435eebe6d407afa7ab3a09f4f', '[\"*\"]', '2025-10-20 17:18:06', NULL, '2025-10-20 17:18:05', '2025-10-20 17:18:06'),
(242, 'App\\Models\\AppUser', 7, 'app_user_token', 'a4d38ea4f0c39df835f22bff132d65e76e7650fd8a76295ab7edaf67c1b59900', '[\"*\"]', '2025-10-20 17:46:57', NULL, '2025-10-20 17:18:51', '2025-10-20 17:46:57'),
(243, 'App\\Models\\AppUser', 7, 'app_user_token', 'afeb57ec2cfbb738db815f63948914a28a29901b673ed277ce99716ab5648f3a', '[\"*\"]', '2025-10-20 17:49:28', NULL, '2025-10-20 17:49:06', '2025-10-20 17:49:28'),
(244, 'App\\Models\\AppUser', 7, 'app_user_token', '004c68053a2cf805ac0f31d122ce7e69975ffadd3d6b56a2ec942a4949c2f61e', '[\"*\"]', '2025-10-20 17:52:57', NULL, '2025-10-20 17:52:44', '2025-10-20 17:52:57'),
(245, 'App\\Models\\AppUser', 7, 'app_user_token', '287688fe1c5291e8520eb2c24244660ea2bfb3914b6399d775589f1f292d5752', '[\"*\"]', '2025-11-01 06:04:33', NULL, '2025-11-01 06:04:20', '2025-11-01 06:04:33'),
(246, 'App\\Models\\AppUser', 7, 'app_user_token', '97884f28db7de2beca7e5d8c3d92aa1f0d278cf4adfba2514719afca06a7ff30', '[\"*\"]', NULL, NULL, '2025-11-05 06:18:32', '2025-11-05 06:18:32'),
(248, 'App\\Models\\AppUser', 7, 'app_user_token', 'a6295398ee4ff454596e01ec47bf5022f3173d955c9c859c02234964f6dde989', '[\"*\"]', '2025-11-14 10:20:26', NULL, '2025-11-14 08:46:17', '2025-11-14 10:20:26'),
(250, 'App\\Models\\AppUser', 7, 'app_user_token', '011aa6fa2fb734d54cf05dbac24ee5e4f416dd37a33ca1fe9996921ef49ea25e', '[\"*\"]', '2025-11-28 15:20:29', NULL, '2025-11-28 15:00:26', '2025-11-28 15:20:29'),
(255, 'App\\Models\\AppUser', 4, 'app_user_token', '7df9b480b7e6df88afa0bb444d0eb8ed3862d1269afce13999eeb1049f0dfac0', '[\"*\"]', '2025-11-28 16:59:19', NULL, '2025-11-28 16:30:25', '2025-11-28 16:59:19'),
(258, 'App\\Models\\AppUser', 7, 'app_user_token', 'b2587534aa03f313cfca02815b54a558c0f5ca8289c3fcc9ce4a62a3a1d31f12', '[\"*\"]', '2025-11-30 15:17:34', NULL, '2025-11-30 14:23:47', '2025-11-30 15:17:34'),
(259, 'App\\Models\\AppUser', 7, 'app_user_token', 'a07892a182919abf6cca6b960ec8bcbff7fcda755e6cb44bfd30b811f2d9a6c5', '[\"*\"]', '2025-11-30 17:03:17', NULL, '2025-11-30 16:30:11', '2025-11-30 17:03:17'),
(260, 'App\\Models\\AppUser', 7, 'app_user_token', '5181719994394b228b82e31553a54ed4a29c1874043c3436eaeb360b66b606ef', '[\"*\"]', '2025-12-02 03:23:02', NULL, '2025-11-30 16:49:59', '2025-12-02 03:23:02'),
(261, 'App\\Models\\AppUser', 7, 'app_user_token', 'ee7377a51cdd1f6eba9d5eda1bd1a2ea9d7bf722bc6bde59e46a28b83ceb3a69', '[\"*\"]', '2025-11-30 17:19:48', NULL, '2025-11-30 17:06:32', '2025-11-30 17:19:48'),
(262, 'App\\Models\\AppUser', 7, 'app_user_token', '799beb207b48ab163eee58d7645fee5472c99c87879e91a270b95eb41f3b8d2f', '[\"*\"]', '2025-11-30 17:40:30', NULL, '2025-11-30 17:40:12', '2025-11-30 17:40:30'),
(263, 'App\\Models\\AppUser', 7, 'app_user_token', '079e2e9efdb7f9874d6911ed62281addd4cf6d35978fe8b08d611b0e3782c23c', '[\"*\"]', '2025-11-30 17:45:15', NULL, '2025-11-30 17:44:36', '2025-11-30 17:45:15'),
(265, 'App\\Models\\AppUser', 7, 'app_user_token', '680e349636da30e1fd726f0b8dc588c3feea2a5f2dc176ad50850afe5b5c693f', '[\"*\"]', '2025-11-30 17:49:57', NULL, '2025-11-30 17:49:41', '2025-11-30 17:49:57'),
(266, 'App\\Models\\AppUser', 7, 'app_user_token', 'a3811120f948e9a383a4860c333187e617dbbda4648903d64e8d9d1993d1ba72', '[\"*\"]', '2025-12-01 01:43:23', NULL, '2025-11-30 17:52:51', '2025-12-01 01:43:23'),
(267, 'App\\Models\\AppUser', 7, 'app_user_token', 'efa4b798289439fed362ace0b867274105072bb318d68739d281d439b8795325', '[\"*\"]', '2025-12-01 01:52:08', NULL, '2025-12-01 01:52:05', '2025-12-01 01:52:08'),
(268, 'App\\Models\\AppUser', 7, 'app_user_token', '0688c6a33b21e768a34c3d2a82a833a3f46e9ec2fc1d1bedd6744ce624af7f10', '[\"*\"]', '2025-12-01 02:08:25', NULL, '2025-12-01 02:07:13', '2025-12-01 02:08:25'),
(269, 'App\\Models\\AppUser', 7, 'app_user_token', '5dc62d5226832f035dc3107d4852d2f86247372a24d966f38b7780d23d856ede', '[\"*\"]', '2025-12-01 13:06:12', NULL, '2025-12-01 02:14:49', '2025-12-01 13:06:12'),
(270, 'App\\Models\\AppUser', 7, 'app_user_token', '5827df9b128416a177509eeedad3b2cfc69bb63324d146582f6e0519d5d9ae16', '[\"*\"]', '2025-12-01 15:45:40', NULL, '2025-12-01 13:20:21', '2025-12-01 15:45:40'),
(278, 'App\\Models\\AppUser', 14, 'app_user_token', '1bc01922803781d1778fb5f96f17bbc92cf9ac3ca16264944c5088f95e22cbe7', '[\"*\"]', '2025-12-02 21:17:16', NULL, '2025-12-01 17:41:56', '2025-12-02 21:17:16'),
(280, 'App\\Models\\AppUser', 15, 'app_user_token', 'e0af3dea92ae64393e8b664798c71ad6c2eab6d812ffa92ce4847b0ffc009604', '[\"*\"]', '2025-12-02 21:50:55', NULL, '2025-12-02 21:22:30', '2025-12-02 21:50:55'),
(281, 'App\\Models\\AppUser', 4, 'app_user_token', '572f5dac8e996ed282225bf2b0bf7656f2c40b8f79c13a779e0f2747bcef3932', '[\"*\"]', '2025-12-03 05:45:22', NULL, '2025-12-03 05:44:50', '2025-12-03 05:45:22'),
(283, 'App\\Models\\AppUser', 4, 'app_user_token', '8994a529035fb74857de04668e1bad56a05321d0f43c1ac34f663324c3cc87b3', '[\"*\"]', '2025-12-03 15:34:46', NULL, '2025-12-03 06:18:29', '2025-12-03 15:34:46'),
(284, 'App\\Models\\AppUser', 4, 'app_user_token', '132743ea298810c5fe6f91cc753ab72d9d723e8b2082c7ab4cfae03a8cc3ed7f', '[\"*\"]', '2025-12-04 01:11:07', NULL, '2025-12-03 13:02:59', '2025-12-04 01:11:07'),
(289, 'App\\Models\\AppUser', 13, 'app_user_token', 'bd3640cd7a111df6c37e72d639ac3a717a518fba2ce3c3b1d3b9f3cacf56fae5', '[\"*\"]', '2025-12-03 23:17:22', NULL, '2025-12-03 23:16:33', '2025-12-03 23:17:22'),
(290, 'App\\Models\\AppUser', 4, 'app_user_token', '6c0202b655918b9d6895c1d8348089710886dfc44361c0deb7e20ee3d9b368e1', '[\"*\"]', '2025-12-04 01:19:50', NULL, '2025-12-03 23:38:21', '2025-12-04 01:19:50'),
(292, 'App\\Models\\AppUser', 13, 'app_user_token', 'e8a5addf4c708e4a8e72bc21385a75aec1ee0d83e0da9e89b6e0a9672c46a8b3', '[\"*\"]', '2025-12-04 01:25:00', NULL, '2025-12-04 01:08:06', '2025-12-04 01:25:00'),
(293, 'App\\Models\\AppUser', 13, 'app_user_token', '7caa016f8bc4f8aa02fe412ae4f84bac50c0a6555478a3d8f59889d633287878', '[\"*\"]', '2025-12-04 01:23:55', NULL, '2025-12-04 01:15:36', '2025-12-04 01:23:55'),
(294, 'App\\Models\\AppUser', 13, 'app_user_token', 'b8edbfa8798823f07c8ba3142fe634279e21be2062ecf172b53cdcb9227225cc', '[\"*\"]', '2026-01-01 12:42:48', NULL, '2025-12-04 01:17:19', '2026-01-01 12:42:48'),
(295, 'App\\Models\\AppUser', 13, 'app_user_token', 'ebf2a1e03ba4c0ddca2f3228825c4e37cb756545d97b3b7cfeb15bf92d5f6869', '[\"*\"]', '2025-12-04 01:18:44', NULL, '2025-12-04 01:18:15', '2025-12-04 01:18:44'),
(296, 'App\\Models\\AppUser', 13, 'app_user_token', '60349b5086a69e0fec95cd239958e0b5d5bc01845454119a1bb03488499c2083', '[\"*\"]', '2025-12-04 01:19:14', NULL, '2025-12-04 01:19:00', '2025-12-04 01:19:14'),
(297, 'App\\Models\\AppUser', 13, 'app_user_token', 'd119d9979648108f0d792b263ac23e147991fe25901f33eaf7bbc1dc3f634a70', '[\"*\"]', '2025-12-04 01:26:59', NULL, '2025-12-04 01:19:47', '2025-12-04 01:26:59'),
(298, 'App\\Models\\AppUser', 13, 'app_user_token', 'f20b62b76e3c1b7f0acf2d364a062b5a776d2da6b2b02ad0d4d89d2013ee5e45', '[\"*\"]', '2025-12-04 03:52:59', NULL, '2025-12-04 01:21:39', '2025-12-04 03:52:59'),
(299, 'App\\Models\\AppUser', 4, 'app_user_token', '1b387c5e48cfc783887dc728b363f6a4f9ecadf54387bb5f5856f3d49c2aedf8', '[\"*\"]', '2025-12-04 01:23:18', NULL, '2025-12-04 01:22:01', '2025-12-04 01:23:18'),
(300, 'App\\Models\\AppUser', 13, 'app_user_token', '2fb681f05263b26b07ad6bc174f83cb98bb3dc7870cfe34af61e6a68a0a36976', '[\"*\"]', '2025-12-04 01:26:28', NULL, '2025-12-04 01:23:54', '2025-12-04 01:26:28'),
(301, 'App\\Models\\AppUser', 7, 'app_user_token', '2586fe8d488e2d8e02e0172b996b2baa875a74645a98c96474b7d50555b43a82', '[\"*\"]', '2025-12-05 01:38:51', NULL, '2025-12-04 01:27:25', '2025-12-05 01:38:51'),
(302, 'App\\Models\\AppUser', 13, 'app_user_token', '33d19edb57ea33a7a1d5d8b435a2b5d07ef6925d2bc06e53b6e2502bdc9fe09f', '[\"*\"]', '2025-12-04 01:33:02', NULL, '2025-12-04 01:29:16', '2025-12-04 01:33:02'),
(303, 'App\\Models\\AppUser', 4, 'app_user_token', 'b198943638cbb30c5a36ca8d52ffe9a1d0b0e3bd33382d96360704551f77a86e', '[\"*\"]', '2025-12-04 01:40:38', NULL, '2025-12-04 01:35:10', '2025-12-04 01:40:38'),
(304, 'App\\Models\\AppUser', 13, 'app_user_token', 'caf6ab63de8a0e4d1e9d8b8b2a6ddf595e7659631752cd0ce514cd4dd7f4e32a', '[\"*\"]', '2025-12-04 01:38:05', NULL, '2025-12-04 01:35:20', '2025-12-04 01:38:05'),
(305, 'App\\Models\\AppUser', 4, 'app_user_token', 'fa5e3eb992562424b013b1c692a685bb7b744a2b42bc03935948660229690b07', '[\"*\"]', '2025-12-04 01:43:54', NULL, '2025-12-04 01:40:52', '2025-12-04 01:43:54'),
(306, 'App\\Models\\AppUser', 4, 'app_user_token', '5f31e6ee42c1690a585ff0ba35a886dd25741bb2c010ed2fab721494020ae01a', '[\"*\"]', '2025-12-04 01:50:41', NULL, '2025-12-04 01:48:06', '2025-12-04 01:50:41'),
(307, 'App\\Models\\AppUser', 4, 'app_user_token', '760dfc477e44f4e3ace267645d18091b0164c781e5af0b673c227521cede8466', '[\"*\"]', '2025-12-31 18:40:44', NULL, '2025-12-04 01:52:12', '2025-12-31 18:40:44'),
(309, 'App\\Models\\AppUser', 16, 'app_user_token', '34e4efda78f5abf6a6cf8f014ac21d077239ef6395aa565c238117d82f9ead1f', '[\"*\"]', '2025-12-04 14:08:06', NULL, '2025-12-04 14:01:20', '2025-12-04 14:08:06');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(310, 'App\\Models\\AppUser', 4, 'app_user_token', '80b67d63aa071e7c4f8316939aba92d2fca654bf7ee5d7121f362f9d9549ff20', '[\"*\"]', '2025-12-04 14:56:28', NULL, '2025-12-04 14:56:28', '2025-12-04 14:56:28'),
(311, 'App\\Models\\AppUser', 4, 'app_user_token', '4d9a11a0efd74dbe9b5adf442a8350c253f266be77ebefc65883016ceffa7d0d', '[\"*\"]', '2025-12-04 15:05:30', NULL, '2025-12-04 15:05:21', '2025-12-04 15:05:30'),
(312, 'App\\Models\\AppUser', 4, 'app_user_token', '7b88552df029583d677ff4e1e3e3d72ebc2d494c8e074d633b466ed87c5b539e', '[\"*\"]', '2025-12-08 16:04:35', NULL, '2025-12-04 15:48:47', '2025-12-08 16:04:35'),
(313, 'App\\Models\\AppUser', 4, 'app_user_token', '972c3eb9c6f2bcdd5b2d62a4f8b5f776fe02e19891fd5d78b6a838db3dfc738f', '[\"*\"]', '2025-12-04 16:39:27', NULL, '2025-12-04 16:39:27', '2025-12-04 16:39:27'),
(314, 'App\\Models\\AppUser', 4, 'app_user_token', 'fd9cb6a0e9777413a7e3c11fe5490229acd49f961eefbb0b35be54fe968e0a36', '[\"*\"]', '2025-12-04 16:43:17', NULL, '2025-12-04 16:43:16', '2025-12-04 16:43:17'),
(315, 'App\\Models\\AppUser', 4, 'app_user_token', '636452088c2ee7ac38dc9809eed25b23ae6d18494aba09ed2416195bb31667a3', '[\"*\"]', '2025-12-04 16:45:35', NULL, '2025-12-04 16:45:00', '2025-12-04 16:45:35'),
(316, 'App\\Models\\AppUser', 16, 'app_user_token', 'f7029e2d5a97bae42c376d8979885bdfef913c35abfa09a18faa3ea05cdf9df9', '[\"*\"]', '2025-12-04 23:40:24', NULL, '2025-12-04 23:40:17', '2025-12-04 23:40:24'),
(317, 'App\\Models\\AppUser', 16, 'app_user_token', '07892ac5e11081b692d0603e6b28c1a044aff7b2bb277ef69a628c8c7a773ff1', '[\"*\"]', '2025-12-05 04:45:47', NULL, '2025-12-04 23:42:25', '2025-12-05 04:45:47'),
(321, 'App\\Models\\AppUser', 16, 'app_user_token', 'd59fe3d64d6d3c0adc494641eb78cd6e89cc108d03a56d3c878d25ad1b771f97', '[\"*\"]', '2025-12-05 05:24:41', NULL, '2025-12-05 04:32:10', '2025-12-05 05:24:41'),
(322, 'App\\Models\\AppUser', 16, 'app_user_token', '9c84a5b4762c726452b4304ea6a37f7229fe961364efba74d820e779959e4332', '[\"*\"]', '2025-12-24 03:52:02', NULL, '2025-12-05 04:32:41', '2025-12-24 03:52:02'),
(323, 'App\\Models\\AppUser', 13, 'app_user_token', '200a082974da3ba8d08e077b36cad0b9a2d239095556ba8c86ba19a712977ea2', '[\"*\"]', '2026-01-01 16:16:35', NULL, '2025-12-05 04:38:31', '2026-01-01 16:16:35'),
(324, 'App\\Models\\AppUser', 16, 'app_user_token', '3a8d21220f926b691c52d1fca92b2b23416a661f1ddb7286409c05a27aaf7fbe', '[\"*\"]', '2025-12-22 02:46:22', NULL, '2025-12-09 11:53:35', '2025-12-22 02:46:22'),
(325, 'App\\Models\\AppUser', 7, 'app_user_token', '6275b3f10b56fbbe46eda7e2a75c87b18632cae57b66aa90b1db935bd927ac99', '[\"*\"]', '2025-12-22 08:44:54', NULL, '2025-12-22 08:44:42', '2025-12-22 08:44:54'),
(328, 'App\\Models\\AppUser', 18, 'app_user_token', '33379cee0f18ff6faf60aee13e1447e891197909bc11d479298df530994a5ff1', '[\"*\"]', '2026-01-13 16:38:45', NULL, '2026-01-13 16:25:09', '2026-01-13 16:38:45');

-- --------------------------------------------------------

--
-- Table structure for table `seniors`
--

CREATE TABLE `seniors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `osca_id` varchar(50) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `name_extension` varchar(10) DEFAULT NULL,
  `region` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `barangay` varchar(255) NOT NULL,
  `residence` varchar(255) NOT NULL,
  `street` varchar(255) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `birth_place` varchar(255) NOT NULL,
  `marital_status` enum('Single','Married','Widowed','Separated','Others') NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `ethnic_origin` varchar(255) DEFAULT NULL,
  `language` varchar(255) NOT NULL,
  `gsis_sss` varchar(50) DEFAULT NULL,
  `tin` varchar(50) DEFAULT NULL,
  `philhealth` varchar(50) DEFAULT NULL,
  `sc_association` varchar(50) DEFAULT NULL,
  `other_govt_id` varchar(50) DEFAULT NULL,
  `can_travel` tinyint(1) DEFAULT NULL,
  `employment` varchar(255) DEFAULT NULL,
  `has_pension` tinyint(1) DEFAULT NULL,
  `has_app_account` tinyint(1) NOT NULL DEFAULT 0,
  `pension_source` varchar(255) DEFAULT NULL,
  `ctc_number` varchar(50) DEFAULT NULL,
  `status` enum('active','deceased') NOT NULL DEFAULT 'active',
  `photo_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `spouse_last_name` varchar(255) DEFAULT NULL,
  `spouse_first_name` varchar(255) DEFAULT NULL,
  `spouse_middle_name` varchar(255) DEFAULT NULL,
  `spouse_extension` varchar(10) DEFAULT NULL,
  `father_last_name` varchar(255) DEFAULT NULL,
  `father_first_name` varchar(255) DEFAULT NULL,
  `father_middle_name` varchar(255) DEFAULT NULL,
  `father_extension` varchar(10) DEFAULT NULL,
  `mother_last_name` varchar(255) DEFAULT NULL,
  `mother_first_name` varchar(255) DEFAULT NULL,
  `mother_middle_name` varchar(255) DEFAULT NULL,
  `mother_extension` varchar(10) DEFAULT NULL,
  `education_level` varchar(255) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `shared_skills` text DEFAULT NULL,
  `community_activities` text DEFAULT NULL,
  `living_condition_primary` varchar(255) DEFAULT NULL,
  `living_with` text DEFAULT NULL,
  `household_condition` text DEFAULT NULL,
  `source_of_income` text DEFAULT NULL,
  `real_assets` text DEFAULT NULL,
  `personal_assets` text DEFAULT NULL,
  `monthly_income` varchar(255) DEFAULT NULL,
  `problems_needs` text DEFAULT NULL,
  `blood_type` varchar(10) DEFAULT NULL,
  `physical_disability` varchar(255) DEFAULT NULL,
  `health_problems` text DEFAULT NULL,
  `dental_concern` text DEFAULT NULL,
  `visual_concern` text DEFAULT NULL,
  `hearing_condition` text DEFAULT NULL,
  `social_emotional` text DEFAULT NULL,
  `area_difficulty` text DEFAULT NULL,
  `maintenance_medicines` text DEFAULT NULL,
  `scheduled_checkup` varchar(255) DEFAULT NULL,
  `checkup_frequency` varchar(255) DEFAULT NULL,
  `permanent_income` varchar(10) DEFAULT NULL,
  `income_amount` varchar(255) DEFAULT NULL,
  `income_source` varchar(255) DEFAULT NULL,
  `existing_illness` varchar(10) DEFAULT NULL,
  `illness_specify` text DEFAULT NULL,
  `with_disability` varchar(10) DEFAULT NULL,
  `disability_specify` text DEFAULT NULL,
  `certification` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seniors`
--

INSERT INTO `seniors` (`id`, `osca_id`, `last_name`, `first_name`, `middle_name`, `name_extension`, `region`, `province`, `city`, `barangay`, `residence`, `street`, `date_of_birth`, `birth_place`, `marital_status`, `sex`, `contact_number`, `email`, `religion`, `ethnic_origin`, `language`, `gsis_sss`, `tin`, `philhealth`, `sc_association`, `other_govt_id`, `can_travel`, `employment`, `has_pension`, `has_app_account`, `pension_source`, `ctc_number`, `status`, `photo_path`, `created_at`, `updated_at`, `deleted_at`, `spouse_last_name`, `spouse_first_name`, `spouse_middle_name`, `spouse_extension`, `father_last_name`, `father_first_name`, `father_middle_name`, `father_extension`, `mother_last_name`, `mother_first_name`, `mother_middle_name`, `mother_extension`, `education_level`, `skills`, `shared_skills`, `community_activities`, `living_condition_primary`, `living_with`, `household_condition`, `source_of_income`, `real_assets`, `personal_assets`, `monthly_income`, `problems_needs`, `blood_type`, `physical_disability`, `health_problems`, `dental_concern`, `visual_concern`, `hearing_condition`, `social_emotional`, `area_difficulty`, `maintenance_medicines`, `scheduled_checkup`, `checkup_frequency`, `permanent_income`, `income_amount`, `income_source`, `existing_illness`, `illness_specify`, `with_disability`, `disability_specify`, `certification`, `user_id`) VALUES
(1, '2025-001', 'Kuhn', 'Brannon', 'Tomasa', NULL, 'region-i', 'pangasinan', 'lingayen', 'maniboc', 'Zone 1, Purok 4', 'Street 40', '1935-01-31', 'Lingayen, Pangasinan', 'Married', 'Female', '0945644377', 'brannon.kuhn1@email.com', 'Catholic', 'Spanish', 'Filipino', '9524491077', '615-230-956', '87-239752406-7', 'Barangay Senior Group', '148416685', 0, 'Volunteer', 0, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-02 11:32:12', NULL, NULL, NULL, 'Dedric', NULL, 'Kuhn', 'Leopoldo', 'Austyn', NULL, 'Hammes', 'Herman', 'Martin', NULL, 'Elementary Level', NULL, 'Gardening', NULL, 'Living with', '[\"Spouse\",\"Children\",\"Relatives\"]', '[\"Overcrowded in home\"]', '[\"Own earnings, salary \\/ wages\"]', NULL, NULL, '181722', NULL, 'AB-', 'Mental Disability', '[\"Hypertension\"]', '[\"Needs Dental Care\"]', '[\"Eye impairment\"]', '[\"Aural impairment\"]', '[\"Feeling loneliness \\/ isolate\"]', '[\"Lack of medicines\"]', 'asdxdsxs', 'No', NULL, 'No', '20464', 'Business', NULL, NULL, NULL, 'Hearing Impairment', 1, NULL),
(2, '2025-002', 'Hansen', 'Nasir', 'Rosendo', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Zone 2, Purok 5', 'Street 5', '1938-04-11', 'Lingayen, Pangasinan', 'Separated', 'Female', '0953721186', 'nasir.hansen2@email.com', 'Protestant', 'Spanish', 'English', '5614920307', '075-015-141', NULL, 'Barangay Senior Group', NULL, 1, NULL, 0, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-29 06:06:05', NULL, 'Harber', NULL, NULL, 'Jr.', 'Hansen', 'Flossie', 'Soledad', 'III', 'Gislason', 'Terry', 'Jeramy', NULL, 'College', NULL, 'Sewing', NULL, 'Assisted Living', '\"[\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Good\\\"]\"', '\"[\\\"Pension\\\"]\"', NULL, NULL, '35458', NULL, 'O-', NULL, '\"[\\\"Cancer\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"Blindness\\\",\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[]\"', 'Blood Pressure Medicine', 'Monthly', NULL, 'No', NULL, 'Government Assistance', 'No', 'Hypertension', 'Yes', NULL, NULL, NULL),
(3, '2025-003', 'Crona', 'Jon', 'Jacky', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 4, Purok 2', 'Street 11', '1932-08-22', 'Lingayen, Pangasinan', 'Married', 'Female', '0947918017', 'jon.crona3@email.com', 'Islam', 'American', 'English', '0472664072', NULL, '32-234331481-1', NULL, '720879193', 1, 'awdawd', 0, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-29 06:56:26', NULL, 'Doyle', 'Nicholaus', 'Annabell', NULL, 'Crona', 'Alvera', 'Eden', NULL, 'Hermiston', 'Vilma', 'Melyna', NULL, 'Elementary', NULL, 'Art', NULL, 'With Family', '\"[\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Good\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '17987', NULL, 'AB-', NULL, '\"[\\\"None\\\",\\\"Arthritis\\\",\\\"Cancer\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"None\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', 'Vitamins', 'Bi-annually', 'As Needed', 'Yes', NULL, 'Pension', 'No', NULL, 'Yes', 'Hearing Impairment', NULL, NULL),
(4, '2025-004', 'Haag', 'Evalyn', 'Alphonso', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 6, Purok 2', 'Street 28', '1933-03-16', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0976397397', 'evalyn.haag4@email.com', NULL, 'American', 'Tagalog', '1387015631', '468-869-819', '63-901164807-1', NULL, '816103464', 0, NULL, 1, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-29 08:03:41', NULL, NULL, 'Brice', NULL, NULL, 'Haag', 'Kobe', 'Corine', NULL, 'Runolfsson', 'Kenya', 'Elvie', NULL, 'High School', NULL, 'Teaching', NULL, 'Assisted Living', '[\"Relatives\"]', '\"[\\\"Good\\\",\\\"Needs Improvement\\\"]\"', '[\"Savings\"]', NULL, NULL, '18839', NULL, 'A-', NULL, '[\"Diabetes\"]', '\"[]\"', '\"[\\\"Cataracts\\\"]\"', '\"[]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[]\"', 'Blood Pressure Medicine', NULL, NULL, 'Yes', '32571', NULL, 'No', NULL, 'Yes', NULL, 1, NULL),
(5, '2025-005', 'Kohler', 'Fleta', 'Adell', 'III', 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 1, Purok 4', 'Street 11', '1932-01-19', 'Lingayen, Pangasinan', 'Others', 'Female', '0912248320', 'fleta.kohler5@email.com', 'Other', 'Filipino', 'Filipino', '4974713994', '923-604-629', '77-561069555-8', NULL, NULL, 0, 'Part-time', 1, 1, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-30 03:21:30', NULL, 'Strosin', 'Everardo', NULL, NULL, 'Kohler', 'Ian', 'Kenyatta', NULL, 'Turner', 'Sigurd', 'Adell', NULL, 'Vocational', NULL, 'Teaching', NULL, 'With Family', '\"[\\\"Children\\\",\\\"Alone\\\",\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '39919', NULL, 'B-', NULL, '\"[\\\"None\\\",\\\"Heart Disease\\\"]\"', '\"[\\\"Gum Problems\\\",\\\"None\\\"]\"', '\"[\\\"Blindness\\\",\\\"None\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"Dressing\\\",\\\"Walking\\\"]\"', 'Diabetes Medicine', NULL, NULL, 'No', '22275', 'Business', 'No', 'Hypertension', 'No', NULL, NULL, NULL),
(6, '2025-006', 'Reynolds', 'Milan', 'Horace', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'estanza', 'Zone 7, Purok 1', 'Street 12', '1934-09-01', 'Lingayen, Pangasinan', 'Single', 'Male', '0918342658', 'milan.reynolds6@email.com', 'Buddhist', 'Filipino', 'Cebuano', '1084584334', '339-207-246', '36-254006137-2', NULL, NULL, 1, NULL, 0, 1, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-10-07 08:37:04', NULL, 'Johns', NULL, NULL, NULL, 'Reynolds', 'Marisa', 'Camron', NULL, 'Waelchi', 'Sheldon', 'Sibyl', NULL, 'Elementary', NULL, 'Art', NULL, 'Independent', '\"[\\\"Relatives\\\",\\\"Spouse\\\",\\\"Alone\\\"]\"', '\"[\\\"Good\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Pension\\\",\\\"Savings\\\"]\"', NULL, NULL, '35886', NULL, 'O+', NULL, '\"[\\\"Arthritis\\\",\\\"None\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"Bathing\\\",\\\"Climbing Stairs\\\"]\"', 'Vitamins', 'Annually', 'As Needed', 'No', NULL, NULL, 'No', 'Heart Disease', 'Yes', 'Mental Disability', NULL, NULL),
(7, '2025-007', 'Kuhlman', 'Valentine', 'Lora', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Zone 8, Purok 4', 'Street 33', '1931-03-30', 'Lingayen, Pangasinan', 'Separated', 'Female', '0999958600', 'valentine.kuhlman7@email.com', 'Protestant', 'Other', 'English', NULL, '858-566-182', '86-418957636-0', NULL, NULL, 0, 'Part-time', 1, 1, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-10-08 07:13:43', NULL, NULL, NULL, 'Darrick', NULL, 'Kuhlman', 'Bernhard', 'John', NULL, 'Nitzsche', 'Boyd', 'Cicero', NULL, 'High School', NULL, NULL, NULL, 'Independent', '\"[\\\"Alone\\\",\\\"Grandchildren\\\",\\\"Relatives\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Fair\\\"]\"', '\"[\\\"Savings\\\",\\\"Pension\\\"]\"', NULL, NULL, '4945', NULL, 'B-', 'Mobility Issues', '\"[]\"', '\"[]\"', '\"[]\"', '\"[]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Eating\\\"]\"', 'Diabetes Medicine', NULL, 'As Needed', 'No', '5355', NULL, 'Yes', NULL, 'No', 'Mental Disability', NULL, NULL),
(8, '2025-008', 'Larson', 'Maci', 'Humberto', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 2, Purok 1', 'Street 34', '1940-06-12', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0921154899', 'maci.larson8@email.com', 'Islam', 'Filipino', 'Tagalog', '6691573070', '075-340-821', '48-027929309-1', NULL, '519078652', 1, NULL, 0, 1, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-10-08 12:33:14', NULL, 'Smith', 'Vita', 'Mozelle', NULL, 'Larson', 'Manuela', 'Mariela', NULL, 'Mraz', 'Scarlett', 'Hank', NULL, 'No Formal Education', NULL, 'Art', NULL, 'Independent', '\"[\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Investments\\\",\\\"Business\\\"]\"', NULL, NULL, '3703', NULL, 'B+', NULL, '\"[]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"Glasses\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Depression\\\"]\"', '\"[\\\"Bathing\\\"]\"', 'Pain Relievers', 'Quarterly', 'As Needed', 'Yes', '39968', NULL, 'No', 'Arthritis', 'No', 'Visual Impairment', NULL, NULL),
(9, '2025-009', 'Abernathy', 'Theodora', 'Adrien', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 3, Purok 4', 'Street 37', '1931-09-15', 'Lingayen, Pangasinan', 'Others', 'Female', '0926495594', 'theodora.abernathy9@email.com', 'Protestant', 'Chinese', 'Filipino', NULL, '501-894-412', '63-669713437-9', NULL, NULL, 1, NULL, 0, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-06 09:03:23', NULL, NULL, NULL, NULL, 'II', 'Abernathy', 'Bettye', 'Antwon', NULL, 'Walter', 'Bonnie', 'Mercedes', NULL, 'College', NULL, 'Music', NULL, 'Assisted Living', '\"[\\\"Alone\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '39938', NULL, 'O-', 'Visual Impairment', '\"[\\\"Cancer\\\",\\\"Diabetes\\\"]\"', '\"[\\\"Gum Problems\\\",\\\"Missing Teeth\\\"]\"', '\"[\\\"Glasses\\\",\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Eating\\\",\\\"Walking\\\"]\"', NULL, 'Bi-annually', 'Regular', 'Yes', NULL, NULL, 'No', 'Arthritis', 'Yes', 'Mental Disability', NULL, NULL),
(10, '2025-010', 'Steuber', 'Yessenia', 'Valentine', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 3, Purok 2', 'Street 21', '1960-11-29', 'Lingayen, Pangasinan', 'Others', 'Female', '0957414186', 'yessenia.steuber10@email.com', 'Protestant', 'Other', 'Ilocano', NULL, NULL, '83-766905729-4', 'Church Senior Group', NULL, 0, NULL, 1, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-08 12:40:12', NULL, 'Larkin', NULL, NULL, NULL, 'Steuber', 'Verner', 'Stanton', NULL, 'Hansen', 'Citlalli', 'Maiya', NULL, 'No Formal Education', NULL, 'Music', NULL, 'With Family', '\"[\\\"Relatives\\\",\\\"Alone\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Poor\\\"]\"', '\"[\\\"Investments\\\",\\\"Family Support\\\",\\\"Pension\\\"]\"', NULL, NULL, '15302', NULL, 'A+', NULL, '\"[\\\"None\\\",\\\"Diabetes\\\"]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"Glasses\\\",\\\"Blindness\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"Climbing Stairs\\\",\\\"None\\\"]\"', 'None', NULL, 'Emergency Only', 'Yes', NULL, 'Business', 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(11, '2025-011', 'Cummings', 'Mario', 'Adell', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 6, Purok 2', 'Street 38', '1958-04-14', 'Lingayen, Pangasinan', 'Single', 'Male', '0993183465', 'mario.cummings11@email.com', 'Protestant', 'Other', 'Tagalog', NULL, '209-602-229', '45-929847395-4', NULL, '168189661', 1, 'Retired', 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Frami', NULL, NULL, NULL, 'Cummings', 'Arthur', 'Marcella', NULL, 'Okuneva', 'Jo', 'Colton', NULL, 'Elementary', NULL, 'Art', NULL, 'With Family', '\"[\\\"Spouse\\\",\\\"Children\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Savings\\\"]\"', NULL, NULL, '46928', NULL, 'A+', NULL, '\"[\\\"Cancer\\\"]\"', '\"[]\"', '\"[\\\"Blindness\\\",\\\"Glasses\\\"]\"', '\"[]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\",\\\"Climbing Stairs\\\"]\"', NULL, 'Monthly', 'Regular', 'Yes', NULL, NULL, 'Yes', 'Hypertension', 'No', NULL, NULL, NULL),
(12, '2025-012', 'Howell', 'Beryl', 'Alanna', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'quibaol', 'Zone 9, Purok 1', 'Street 43', '1949-03-23', 'Lingayen, Pangasinan', 'Separated', 'Female', '0954603595', 'beryl.howell12@email.com', 'Buddhist', 'American', 'Cebuano', '8691657393', NULL, '52-404069688-3', NULL, '758520355', 1, 'Self-employed', 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Ernestina', NULL, 'Howell', 'Raegan', 'Nolan', NULL, 'Kozey', 'Benton', 'Wilber', NULL, 'Vocational', NULL, 'Art', NULL, 'Assisted Living', '\"[\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\",\\\"Good\\\"]\"', '\"[\\\"Savings\\\"]\"', NULL, NULL, '11667', NULL, 'A-', NULL, '\"[]\"', '\"[]\"', '\"[]\"', '\"[]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"Dressing\\\",\\\"Eating\\\"]\"', 'Vitamins', 'Annually', NULL, 'Yes', '22416', 'Government Assistance', 'No', 'Heart Disease', 'No', NULL, NULL, NULL),
(13, '2025-013', 'King', 'Avis', 'Lauretta', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 3, Purok 1', 'Street 34', '1934-01-22', 'Lingayen, Pangasinan', 'Separated', 'Male', '0961963614', 'avis.king13@email.com', NULL, 'Other', 'Tagalog', '8290568135', '111-113-217', '68-474355369-5', NULL, NULL, 0, 'Part-time', 1, 1, NULL, NULL, 'active', 'senior-photos/BZRHwOWllc7np0MmRl2odRRZNPE3O7iA8AHWF6Tl.jpg', '2025-09-18 21:28:14', '2025-12-01 17:25:44', NULL, NULL, NULL, NULL, NULL, 'King', 'Mohamed', 'Gay', NULL, 'Breitenberg', 'Adolphus', 'Hillard', 'II', 'High School', '[]', 'Music', '[]', 'With Family', '[]', '[]', '[]', '[]', '[]', '18916', '[]', 'AB+', NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, 'No', NULL, 'Family Support', 'No', 'Hypertension', 'Yes', 'Mental Disability', 1, NULL),
(14, '2025-014', 'Gleichner', 'Lexie', 'Joanny', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Zone 4, Purok 1', 'Street 37', '1932-04-10', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0901274772', 'lexie.gleichner14@email.com', 'Catholic', 'Filipino', 'Cebuano', NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Grant', 'Cooper', NULL, 'Gleichner', 'Audie', 'Nasir', NULL, 'Torphy', 'Kira', 'Zelma', NULL, 'College', NULL, 'Sewing', NULL, 'Nursing Home', '\"[\\\"Relatives\\\",\\\"Spouse\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Government Assistance\\\"]\"', NULL, NULL, '41924', NULL, 'O-', NULL, '\"[\\\"Cancer\\\",\\\"Diabetes\\\"]\"', '\"[\\\"None\\\",\\\"Missing Teeth\\\"]\"', '\"[\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\",\\\"None\\\",\\\"Climbing Stairs\\\"]\"', NULL, 'Quarterly', 'As Needed', 'Yes', NULL, 'Government Assistance', 'No', 'Arthritis', 'No', 'Visual Impairment', NULL, NULL),
(15, '2025-015', 'Hettinger', 'Keeley', 'Sabrina', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-east', 'Zone 4, Purok 3', 'Street 33', '1947-02-22', 'Lingayen, Pangasinan', 'Single', 'Female', '0965618652', 'keeley.hettinger15@email.com', 'Catholic', 'Other', 'Cebuano', '0484254010', NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-02 06:31:52', NULL, 'Corwin', NULL, NULL, NULL, 'Hettinger', 'Dahlia', 'Whitney', NULL, 'Spinka', 'Yessenia', 'Chester', NULL, 'High School', NULL, 'Sewing', NULL, 'Assisted Living', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Good\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Business\\\",\\\"Investments\\\",\\\"Family Support\\\"]\"', NULL, NULL, '4509', NULL, 'B-', 'Mobility Issues', '\"[\\\"Arthritis\\\",\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[\\\"Gum Problems\\\",\\\"Missing Teeth\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Eating\\\",\\\"Bathing\\\",\\\"None\\\"]\"', NULL, NULL, NULL, 'No', NULL, 'Government Assistance', 'Yes', 'Hypertension', 'Yes', 'Mental Disability', NULL, NULL),
(16, '2025-016', 'Sawayn', 'Sandra', 'Alba', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-east', 'Zone 9, Purok 3', 'Street 34', '1945-11-07', 'Lingayen, Pangasinan', 'Others', 'Male', '0918373636', 'sandra.sawayn16@email.com', 'Buddhist', 'Filipino', 'Cebuano', '3937951726', '630-830-115', '80-405227717-1', 'Church Senior Group', NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, 'II', 'Sawayn', 'Korey', 'Krystel', NULL, 'Carroll', 'Jillian', 'Sammy', NULL, 'Graduate School', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Relatives\\\",\\\"Children\\\",\\\"Alone\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Business\\\"]\"', NULL, NULL, '30211', NULL, 'O+', 'Visual Impairment', '\"[\\\"Heart Disease\\\",\\\"Diabetes\\\"]\"', '\"[]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"Walking\\\"]\"', NULL, NULL, NULL, 'Yes', NULL, 'Business', 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(17, '2025-017', 'Padberg', 'Anthony', 'Keanu', 'II', 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Zone 7, Purok 1', 'Street 3', '1934-03-24', 'Lingayen, Pangasinan', 'Others', 'Male', '0922760655', 'anthony.padberg17@email.com', 'Catholic', 'Spanish', 'Cebuano', NULL, '819-608-971', '76-790569708-2', NULL, '648177101', 0, NULL, 0, 1, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-10-07 07:39:37', NULL, 'Schowalter', 'Talia', 'Bernhard', 'Sr.', 'Padberg', 'Kade', 'Fabiola', NULL, 'Mitchell', 'Alford', 'Zora', NULL, 'No Formal Education', NULL, 'Cooking', NULL, 'With Family', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Poor\\\"]\"', '\"[\\\"Family Support\\\"]\"', NULL, NULL, '26722', NULL, 'A+', NULL, '\"[\\\"Heart Disease\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"None\\\",\\\"Blindness\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Depression\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', 'Blood Pressure Medicine', 'Bi-annually', 'As Needed', 'No', '19999', 'Pension', 'Yes', NULL, 'Yes', NULL, NULL, NULL),
(18, '2025-018', 'Bode', 'Felicity', 'Garfield', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 5, Purok 3', 'Street 28', '1935-06-01', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0930699698', 'felicity.bode18@email.com', NULL, 'Other', 'Ilocano', '6553586317', NULL, '63-563890493-9', NULL, NULL, 0, NULL, 0, 1, NULL, NULL, 'active', 'senior-photos/2xVCFtj84pheAlUZtNBq2kAhxZqmx7rsdn4TSNQH.png', '2025-09-18 21:28:14', '2025-12-03 06:25:35', NULL, 'Schaden', NULL, NULL, NULL, 'Bode', 'Katrina', 'Dimitri', 'Sr.', 'Mante', 'Kyra', 'Emmalee', NULL, 'College', '[]', 'Teaching', '[]', 'Assisted Living', '[]', '[]', '[]', '[]', '[]', '28696', '[]', 'O-', NULL, '[]', '[]', '[]', '[]', '[]', '[]', 'Diabetes Medicine', NULL, NULL, 'No', NULL, 'Business', 'No', NULL, 'Yes', NULL, 1, NULL),
(19, '2025-019', 'Bosco', 'Cory', 'Beth', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 9, Purok 2', 'Street 6', '1935-10-20', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0982636770', 'cory.bosco19@email.com', NULL, 'American', 'Cebuano', '2251293271', '423-879-736', '47-823624668-4', NULL, NULL, 0, NULL, 0, 1, NULL, NULL, 'active', 'senior-photos/JYWzmu1V21YLIau9KzQEyBjVdeyiamss3RZA94PD.jpg', '2025-09-18 21:28:14', '2025-12-02 14:39:10', NULL, NULL, 'Eula', 'Haskell', NULL, 'Bosco', 'Daron', 'Boyd', NULL, 'Hodkiewicz', 'Dedrick', 'Jade', NULL, 'Vocational', '[]', 'Art', '[]', 'Assisted Living', '[]', '[]', '[]', '[]', '[]', '36505', '[]', 'AB+', NULL, '[]', '[]', '[]', '[]', '[]', '[]', 'None', NULL, NULL, 'No', '21064', 'Family Support', 'Yes', NULL, 'No', 'Hearing Impairment', 1, NULL),
(20, '2025-020', 'Bednar', 'Mckenna', 'Selina', NULL, 'region-i', 'pangasinan', 'lingayen', 'malimpuec', 'Zone 7, Purok 4', 'Street 34', '1947-04-27', 'Lingayen, Pangasinan', 'Separated', 'Male', '0926477622', 'mckenna.bednar20@email.com', 'Buddhist', 'Filipino', 'Cebuano', '3559350751', NULL, '64-906696186-0', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-12-05 02:12:05', NULL, NULL, NULL, NULL, NULL, 'Bednar', 'Isaac', 'Jarret', NULL, 'Jast', 'Candelario', 'Cynthia', NULL, 'High School', NULL, 'Cooking', NULL, 'With Family', '\"[\\\"Spouse\\\"]\"', '\"[\\\"Good\\\",\\\"Poor\\\"]\"', '\"[\\\"Family Support\\\",\\\"Investments\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '32723', NULL, 'B-', NULL, '\"[\\\"Diabetes\\\",\\\"Cancer\\\"]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"Blindness\\\",\\\"None\\\"]\"', '\"[]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"Bathing\\\"]\"', 'Vitamins', 'Quarterly', 'As Needed', 'No', NULL, NULL, 'no', NULL, 'no', NULL, NULL, NULL),
(21, '2025-021', 'Homenick', 'Claudie', 'Flavio', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 9, Purok 2', 'Street 50', '1962-11-17', 'Lingayen, Pangasinan', 'Married', 'Male', '0987068095', 'claudie.homenick21@email.com', 'Buddhist', 'American', 'Filipino', '4217635601', '757-541-906', '82-374539245-2', NULL, '010340648', 1, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Cassidy', NULL, NULL, 'Homenick', 'Annalise', 'Laurie', NULL, 'Wilderman', 'Modesta', 'Adaline', NULL, 'No Formal Education', NULL, NULL, NULL, 'Independent', '\"[\\\"Relatives\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Pension\\\",\\\"Savings\\\",\\\"Family Support\\\"]\"', NULL, NULL, '16133', NULL, 'B-', NULL, '\"[\\\"Diabetes\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"None\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[]\"', 'Blood Pressure Medicine', 'Bi-annually', NULL, 'Yes', NULL, 'Business', 'No', 'Diabetes', 'No', 'Mobility Issues', NULL, NULL),
(22, '2025-022', 'Wintheiser', 'Eloise', 'Emmie', NULL, 'region-i', 'pangasinan', 'lingayen', 'quibaol', 'Zone 6, Purok 3', 'Street 47', '1962-04-03', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0979887357', 'eloise.wintheiser22@email.com', 'Protestant', 'American', 'Ilocano', NULL, '958-002-095', '19-281146040-4', 'Senior Citizens Association', NULL, 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-12-05 02:13:13', NULL, 'Klein', 'Martin', NULL, NULL, 'Wintheiser', 'Jamaal', 'Piper', NULL, 'Weimann', 'Marquise', 'Torey', NULL, 'Elementary', NULL, 'Gardening', NULL, 'Assisted Living', '\"[\\\"Grandchildren\\\",\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '10119', NULL, 'A+', NULL, '\"[\\\"Arthritis\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"None\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Loneliness\\\",\\\"Good Mental Health\\\"]\"', '\"[\\\"Dressing\\\"]\"', 'Diabetes Medicine', 'Quarterly', 'As Needed', 'No', '6900', NULL, 'no', NULL, 'no', NULL, NULL, NULL),
(23, '2025-023', 'Bahringer', 'Claudia', 'Kamille', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'estanza', 'Zone 7, Purok 1', 'Street 50', '1959-09-11', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0978980791', 'claudia.bahringer23@email.com', 'Other', 'Filipino', 'Tagalog', '8050957015', NULL, '42-505036880-3', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Bahringer', 'Aubree', 'Marquise', NULL, 'Dickens', 'Gretchen', 'Mervin', 'II', 'Graduate School', NULL, 'Gardening', NULL, 'Nursing Home', '\"[\\\"Spouse\\\",\\\"Relatives\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Family Support\\\",\\\"Pension\\\"]\"', NULL, NULL, '19779', NULL, 'A-', NULL, '\"[\\\"Cancer\\\",\\\"Arthritis\\\"]\"', '\"[\\\"Dentures\\\",\\\"None\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Good Mental Health\\\"]\"', '\"[\\\"None\\\",\\\"Bathing\\\",\\\"Eating\\\"]\"', NULL, 'Annually', NULL, 'Yes', NULL, 'Business', 'No', NULL, 'No', 'Mental Disability', NULL, NULL),
(24, '2025-024', 'Okuneva', 'Maria', 'Jaclyn', 'II', 'Region I', 'Pangasinan', 'Lingayen', 'lasip', 'Zone 3, Purok 3', 'Street 2', '1935-11-05', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0998121817', 'maria.okuneva24@email.com', 'Other', 'Chinese', 'Tagalog', NULL, '618-866-322', '33-591091207-1', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Kilback', 'Erick', 'Loma', NULL, 'Okuneva', 'Morgan', 'Jay', NULL, 'Powlowski', 'Simeon', 'Santina', NULL, 'Elementary', NULL, NULL, NULL, 'Independent', '\"[\\\"Spouse\\\",\\\"Alone\\\",\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Investments\\\",\\\"Business\\\"]\"', NULL, NULL, '15728', NULL, 'AB+', NULL, '\"[\\\"Diabetes\\\"]\"', '\"[\\\"Gum Problems\\\",\\\"Dentures\\\"]\"', '\"[\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Depression\\\"]\"', '\"[\\\"Walking\\\",\\\"Climbing Stairs\\\"]\"', NULL, NULL, 'As Needed', 'No', '32056', 'Business', 'Yes', 'Cancer', 'Yes', 'Mobility Issues', NULL, NULL),
(25, '2025-025', 'Ebert', 'Genoveva', 'Garnet', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'quibaol', 'Zone 6, Purok 3', 'Street 48', '1964-06-07', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0941915699', 'genoveva.ebert25@email.com', 'Islam', 'Chinese', 'Filipino', '0310365712', NULL, '84-134055048-4', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Hickle', NULL, NULL, NULL, 'Ebert', 'Dameon', 'Ena', NULL, 'Roberts', 'Nellie', 'Otto', NULL, 'Graduate School', NULL, 'Gardening', NULL, 'With Family', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Good\\\",\\\"Poor\\\"]\"', '\"[\\\"Business\\\",\\\"Government Assistance\\\",\\\"Investments\\\"]\"', NULL, NULL, '22875', NULL, 'B+', NULL, '\"[\\\"None\\\",\\\"Cancer\\\",\\\"Hypertension\\\"]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[\\\"None\\\",\\\"Cataracts\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Depression\\\",\\\"Anxiety\\\"]\"', '\"[\\\"Bathing\\\"]\"', NULL, 'Bi-annually', NULL, 'Yes', '5940', 'Business', 'Yes', 'Cancer', 'No', NULL, NULL, NULL),
(26, '2025-026', 'Brakus', 'Roderick', 'Jacquelyn', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 1, Purok 1', 'Street 34', '1963-08-27', 'Lingayen, Pangasinan', 'Married', 'Female', '0919783222', 'roderick.brakus26@email.com', 'Buddhist', 'Other', 'Cebuano', '4317507692', '295-396-904', '39-237334484-4', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Bryon', NULL, 'Brakus', 'Amara', 'Aglae', NULL, 'Reynolds', 'Jace', 'Furman', NULL, 'College', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Family Support\\\"]\"', NULL, NULL, '20007', NULL, 'AB-', 'Hearing Impairment', '\"[]\"', '\"[]\"', '\"[]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Loneliness\\\",\\\"Depression\\\"]\"', '\"[]\"', NULL, NULL, 'As Needed', 'No', '12944', 'Business', 'Yes', NULL, 'No', 'Hearing Impairment', NULL, NULL),
(27, '2025-027', 'Kuhlman', 'Rene', 'Austen', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 2, Purok 2', 'Street 1', '1945-07-19', 'Lingayen, Pangasinan', 'Others', 'Female', '0942323693', 'rene.kuhlman27@email.com', 'Buddhist', 'Other', 'Cebuano', '8481381479', NULL, '62-002704525-5', NULL, NULL, 0, 'Retired', 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Hegmann', NULL, NULL, NULL, 'Kuhlman', 'Tia', 'Idella', NULL, 'Hudson', 'Dominique', 'Kristoffer', NULL, 'Graduate School', NULL, 'Teaching', NULL, 'Independent', '\"[\\\"Children\\\",\\\"Alone\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Family Support\\\"]\"', NULL, NULL, '34273', NULL, 'B+', 'Mental Disability', '\"[]\"', '\"[\\\"Dentures\\\",\\\"Missing Teeth\\\"]\"', '\"[]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"Walking\\\",\\\"Eating\\\"]\"', NULL, 'Bi-annually', 'Regular', 'Yes', NULL, 'Business', 'No', 'Arthritis', 'No', 'Mental Disability', NULL, NULL),
(28, '2025-028', 'Lehner', 'Marlene', 'Zoie', 'IV', 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Zone 5, Purok 5', 'Street 7', '1950-06-03', 'Lingayen, Pangasinan', 'Others', 'Male', '0942738595', 'marlene.lehner28@email.com', 'Islam', 'Chinese', 'Ilocano', '5874712810', '809-865-219', '20-170577527-3', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Amos', NULL, 'Lehner', 'Velma', 'Madilyn', 'II', 'Purdy', 'Irma', 'Zander', NULL, 'High School', NULL, 'Gardening', NULL, 'Independent', '\"[\\\"Alone\\\",\\\"Grandchildren\\\",\\\"Spouse\\\"]\"', '\"[\\\"Good\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Pension\\\"]\"', NULL, NULL, '41466', NULL, 'O+', NULL, '\"[\\\"Hypertension\\\",\\\"Heart Disease\\\",\\\"Diabetes\\\"]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\",\\\"Walking\\\",\\\"Eating\\\"]\"', NULL, 'Bi-annually', 'Emergency Only', 'Yes', NULL, NULL, 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(29, '2025-029', 'Cremin', 'Wallace', 'Liza', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 4, Purok 4', 'Street 21', '1948-12-21', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0913878027', 'wallace.cremin29@email.com', 'Other', 'Filipino', 'Cebuano', '7458272673', '443-813-200', '38-821173721-0', NULL, NULL, 0, 'Self-employed', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Skiles', NULL, NULL, NULL, 'Cremin', 'Brooke', 'Jakayla', NULL, 'Hessel', 'Barton', 'Gordon', NULL, 'High School', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Alone\\\",\\\"Spouse\\\"]\"', '\"[\\\"Fair\\\",\\\"Poor\\\"]\"', '\"[\\\"Investments\\\",\\\"Family Support\\\"]\"', NULL, NULL, '28005', NULL, 'O+', NULL, '\"[\\\"Cancer\\\",\\\"Diabetes\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"Cataracts\\\",\\\"Glasses\\\"]\"', '\"[\\\"None\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Depression\\\"]\"', '\"[\\\"Dressing\\\",\\\"Bathing\\\",\\\"Climbing Stairs\\\"]\"', 'Vitamins', 'Monthly', 'As Needed', 'Yes', '33019', 'Pension', 'Yes', NULL, 'Yes', NULL, NULL, NULL),
(30, '2025-030', 'Wisoky', 'Albertha', 'Elton', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Zone 5, Purok 1', 'Street 41', '1965-07-14', 'Lingayen, Pangasinan', 'Married', 'Female', '0934315966', 'albertha.wisoky30@email.com', 'Protestant', 'Chinese', 'English', '2072340749', NULL, '10-411552667-5', 'Senior Citizens Association', NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Niko', NULL, 'Wisoky', 'Dee', 'Laurence', NULL, 'Reichel', 'Arnulfo', 'Sherman', NULL, 'No Formal Education', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\"]\"', NULL, NULL, '18412', NULL, 'B-', NULL, '\"[]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[\\\"None\\\",\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"None\\\",\\\"Climbing Stairs\\\"]\"', 'Pain Relievers', 'Bi-annually', 'Emergency Only', 'No', NULL, NULL, 'Yes', NULL, 'No', 'Visual Impairment', NULL, NULL),
(31, '2025-031', 'Hill', 'Thurman', 'Winona', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 1, Purok 5', 'Street 20', '1953-12-16', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0944145405', 'thurman.hill31@email.com', 'Protestant', 'Filipino', 'English', '4249194125', NULL, '17-363527433-4', NULL, '279968500', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Kailyn', NULL, 'Hill', 'Caroline', 'Augustine', NULL, 'Witting', 'Jairo', 'Maureen', 'III', 'Vocational', NULL, 'Art', NULL, 'Independent', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Savings\\\",\\\"Investments\\\",\\\"Business\\\"]\"', NULL, NULL, '9018', NULL, 'O-', NULL, '\"[\\\"None\\\",\\\"Heart Disease\\\",\\\"Cancer\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Depression\\\",\\\"Loneliness\\\"]\"', '\"[]\"', 'Vitamins', 'Quarterly', NULL, 'Yes', NULL, NULL, 'No', 'Arthritis', 'No', NULL, NULL, NULL),
(32, '2025-032', 'Langworth', 'Isaias', 'Edgardo', 'V', 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 4, Purok 3', 'Street 5', '1943-05-05', 'Lingayen, Pangasinan', 'Others', 'Male', '0963145843', 'isaias.langworth32@email.com', 'Other', 'Other', 'Filipino', '4465224040', NULL, '71-984109593-8', 'Barangay Senior Group', '034539841', 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Langworth', 'Breanne', 'Jesus', NULL, 'Conroy', 'Joy', 'Natalie', NULL, 'College', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '26655', NULL, 'A+', NULL, '\"[\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Missing Teeth\\\"]\"', '\"[\\\"Cataracts\\\",\\\"None\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Loneliness\\\",\\\"Good Mental Health\\\"]\"', '\"[]\"', NULL, 'Annually', 'Emergency Only', 'Yes', '23709', 'Government Assistance', 'Yes', NULL, 'Yes', 'Hearing Impairment', NULL, NULL),
(33, '2025-033', 'Murphy', 'Julius', 'Mollie', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 7, Purok 3', 'Street 21', '1932-06-12', 'Lingayen, Pangasinan', 'Separated', 'Female', '0988293039', 'julius.murphy33@email.com', 'Other', 'American', 'Ilocano', '8820164158', NULL, NULL, NULL, '364881790', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Trace', NULL, NULL, 'Murphy', 'Broderick', 'Casandra', NULL, 'Bednar', 'Karina', 'Kaleb', NULL, 'High School', NULL, 'Cooking', NULL, 'Assisted Living', '\"[\\\"Spouse\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Good\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '8962', NULL, 'O-', 'Visual Impairment', '\"[]\"', '\"[\\\"Dentures\\\"]\"', '\"[]\"', '\"[\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"Walking\\\"]\"', 'Blood Pressure Medicine', 'Quarterly', NULL, 'Yes', '48214', 'Business', 'Yes', 'Hypertension', 'No', NULL, NULL, NULL),
(34, '2025-034', 'Rau', 'Orie', 'Shaylee', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 6, Purok 1', 'Street 42', '1964-01-01', 'Lingayen, Pangasinan', 'Single', 'Male', '0961533245', 'orie.rau34@email.com', 'Islam', 'Filipino', 'Filipino', NULL, '317-278-471', NULL, 'Church Senior Group', NULL, 1, 'Self-employed', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Russel', NULL, NULL, NULL, 'Rau', 'Shanel', 'Carey', NULL, 'Sawayn', 'Jalen', 'Hester', NULL, 'Vocational', NULL, 'Cooking', NULL, 'Nursing Home', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Good\\\",\\\"Fair\\\"]\"', '\"[\\\"Government Assistance\\\"]\"', NULL, NULL, '45637', NULL, 'O-', NULL, '\"[]\"', '\"[\\\"Missing Teeth\\\",\\\"Dentures\\\"]\"', '\"[\\\"Blindness\\\",\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Eating\\\",\\\"Bathing\\\",\\\"Walking\\\"]\"', 'Blood Pressure Medicine', 'Bi-annually', 'Emergency Only', 'No', '33826', 'Government Assistance', 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(35, '2025-035', 'Toy', 'Monty', 'Christ', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 4, Purok 5', 'Street 7', '1950-08-20', 'Lingayen, Pangasinan', 'Separated', 'Female', '0978665011', 'monty.toy35@email.com', 'Catholic', 'Spanish', 'English', '5818689955', '938-351-211', '23-581146255-8', NULL, '070092899', 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Jerde', 'Ivy', NULL, NULL, 'Toy', 'Rosa', 'Connie', NULL, 'Hickle', 'Sylvan', 'Maximillia', NULL, 'Vocational', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Relatives\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Family Support\\\",\\\"Savings\\\",\\\"Pension\\\"]\"', NULL, NULL, '9145', NULL, 'A+', NULL, '\"[\\\"Arthritis\\\",\\\"Hypertension\\\"]\"', '\"[\\\"Dentures\\\",\\\"None\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"None\\\",\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"None\\\",\\\"Bathing\\\",\\\"Dressing\\\"]\"', 'Blood Pressure Medicine', 'Monthly', NULL, 'No', NULL, NULL, 'Yes', 'Arthritis', 'Yes', NULL, NULL, NULL),
(36, '2025-036', 'VonRueden', 'Maxwell', 'Karen', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 8, Purok 5', 'Street 16', '1957-08-16', 'Lingayen, Pangasinan', 'Single', 'Female', '0923238364', 'maxwell.vonrueden36@email.com', 'Buddhist', 'American', 'Ilocano', '1290741879', '502-579-882', '37-500145140-3', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, 'III', 'VonRueden', 'Josh', 'Martine', NULL, 'Cronin', 'Hillard', 'Bella', NULL, 'Elementary', NULL, 'Sewing', NULL, 'Assisted Living', '\"[\\\"Grandchildren\\\",\\\"Alone\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Good\\\"]\"', '\"[\\\"Savings\\\",\\\"Investments\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '21407', NULL, 'A-', NULL, '\"[\\\"Cancer\\\",\\\"Heart Disease\\\",\\\"Hypertension\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"Blindness\\\",\\\"None\\\"]\"', '\"[\\\"Deafness\\\",\\\"None\\\"]\"', '\"[\\\"Depression\\\",\\\"Good Mental Health\\\"]\"', '\"[\\\"Bathing\\\",\\\"Climbing Stairs\\\",\\\"None\\\"]\"', 'None', 'Quarterly', NULL, 'No', NULL, 'Family Support', 'Yes', 'Hypertension', 'No', NULL, NULL, NULL),
(37, '2025-037', 'Fahey', 'Braxton', 'Giovani', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Zone 9, Purok 5', 'Street 23', '1962-06-19', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0901976410', 'braxton.fahey37@email.com', 'Buddhist', 'Other', 'Tagalog', '2769352570', NULL, NULL, NULL, '690723904', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Cormier', 'Lori', NULL, NULL, 'Fahey', 'Soledad', 'Kathleen', NULL, 'Okuneva', 'Emilia', 'Alec', NULL, 'Elementary', NULL, NULL, NULL, 'Independent', '\"[\\\"Spouse\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Savings\\\",\\\"Family Support\\\"]\"', NULL, NULL, '22221', NULL, 'AB+', NULL, '\"[\\\"Cancer\\\",\\\"Hypertension\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Loneliness\\\",\\\"Depression\\\"]\"', '\"[\\\"Dressing\\\",\\\"Walking\\\"]\"', NULL, 'Annually', 'Emergency Only', 'Yes', NULL, 'Pension', 'No', 'Heart Disease', 'Yes', NULL, NULL, NULL),
(38, '2025-038', 'Doyle', 'Hildegard', 'Justen', 'V', 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 5, Purok 3', 'Street 40', '1934-06-02', 'Lingayen, Pangasinan', 'Others', 'Male', '0923234793', 'hildegard.doyle38@email.com', 'Protestant', 'Other', 'English', '6368181541', '664-446-697', '63-681437254-4', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Boyer', 'Meredith', NULL, NULL, 'Doyle', 'Vincenza', 'Dillon', NULL, 'Wiza', 'Valentine', 'Freida', NULL, 'Elementary', NULL, 'Crafting', NULL, 'Assisted Living', '\"[\\\"Alone\\\",\\\"Relatives\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Poor\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '41904', NULL, 'A+', NULL, '\"[\\\"Heart Disease\\\",\\\"Diabetes\\\",\\\"None\\\"]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Depression\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Walking\\\",\\\"None\\\",\\\"Bathing\\\"]\"', 'Diabetes Medicine', 'Quarterly', 'Emergency Only', 'Yes', NULL, 'Family Support', 'No', 'Hypertension', 'Yes', NULL, NULL, NULL),
(39, '2025-039', 'Frami', 'Opal', 'Jabari', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 1, Purok 4', 'Street 5', '1941-07-30', 'Lingayen, Pangasinan', 'Single', 'Male', '0984700877', 'opal.frami39@email.com', 'Protestant', 'Other', 'Ilocano', '7955858759', '083-894-982', '06-419436054-7', NULL, NULL, 0, 'Retired', 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Josefa', NULL, 'Frami', 'Brett', 'Fermin', NULL, 'Swaniawski', 'Audie', 'Jackie', NULL, 'Vocational', NULL, 'Teaching', NULL, 'With Family', '\"[\\\"Alone\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Pension\\\",\\\"Business\\\"]\"', NULL, NULL, '48069', NULL, 'A+', NULL, '\"[\\\"Hypertension\\\",\\\"Heart Disease\\\",\\\"Arthritis\\\"]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"Blindness\\\",\\\"Cataracts\\\"]\"', '\"[\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\",\\\"Eating\\\"]\"', 'Diabetes Medicine', 'Quarterly', 'Emergency Only', 'No', '49632', NULL, 'Yes', 'Diabetes', 'Yes', 'Mobility Issues', NULL, NULL),
(40, '2025-040', 'Heidenreich', 'Taryn', 'Beaulah', 'V', 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 7, Purok 3', 'Street 7', '1944-01-18', 'Lingayen, Pangasinan', 'Married', 'Female', '0921975434', 'taryn.heidenreich40@email.com', 'Protestant', 'Other', 'English', '3507098090', '623-219-310', '22-780085275-0', NULL, '342619140', 1, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Olga', NULL, 'Sr.', 'Heidenreich', 'Lilyan', 'Armani', NULL, 'Schmidt', 'Elmira', 'Eino', NULL, 'Graduate School', NULL, 'Sewing', NULL, 'With Family', '\"[\\\"Grandchildren\\\",\\\"Relatives\\\",\\\"Alone\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Family Support\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '13117', NULL, 'AB-', NULL, '\"[\\\"Heart Disease\\\"]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[]\"', 'Blood Pressure Medicine', NULL, 'As Needed', 'No', NULL, 'Business', 'No', 'Arthritis', 'No', NULL, NULL, NULL),
(41, '2025-041', 'McLaughlin', 'Dudley', 'Johathan', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 3, Purok 4', 'Street 39', '1958-11-09', 'Lingayen, Pangasinan', 'Others', 'Female', '0963288992', 'dudley.mclaughlin41@email.com', 'Other', 'Spanish', 'English', '7487295462', '019-983-256', '51-007295521-4', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Zulauf', NULL, NULL, NULL, 'McLaughlin', 'Obie', 'Cornell', 'III', 'Upton', 'Lester', 'Wilbert', NULL, 'College', NULL, 'Teaching', NULL, 'Independent', '\"[\\\"Relatives\\\",\\\"Spouse\\\"]\"', '\"[\\\"Good\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Pension\\\",\\\"Investments\\\"]\"', NULL, NULL, '34383', NULL, 'O+', NULL, '\"[\\\"Arthritis\\\",\\\"Hypertension\\\"]\"', '\"[\\\"Dentures\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\"]\"', 'Vitamins', 'Bi-annually', 'Regular', 'No', NULL, 'Government Assistance', 'No', NULL, 'No', NULL, NULL, NULL),
(42, '2025-042', 'Padberg', 'Lilliana', 'Uriah', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 4, Purok 1', 'Street 3', '1948-12-18', 'Lingayen, Pangasinan', 'Married', 'Female', '0977010647', 'lilliana.padberg42@email.com', 'Other', 'Spanish', 'Filipino', '6717796815', '499-973-213', '43-940757937-2', NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Padberg', 'Richmond', 'Adriel', NULL, 'Moore', 'Dulce', 'Owen', NULL, 'High School', NULL, 'Teaching', NULL, 'With Family', '\"[\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Poor\\\",\\\"Good\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Savings\\\"]\"', NULL, NULL, '17409', NULL, 'A-', NULL, '\"[]\"', '\"[]\"', '\"[\\\"Cataracts\\\",\\\"None\\\"]\"', '\"[\\\"Deafness\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Loneliness\\\",\\\"Anxiety\\\"]\"', '\"[]\"', 'Pain Relievers', 'Annually', NULL, 'No', '12257', 'Pension', 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(43, '2025-043', 'Gerlach', 'Israel', 'Precious', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'lasip', 'Zone 8, Purok 1', 'Street 34', '1938-10-06', 'Lingayen, Pangasinan', 'Single', 'Male', '0976804167', 'israel.gerlach43@email.com', 'Protestant', 'Spanish', 'Ilocano', '6421668318', NULL, '45-243422038-7', NULL, '603372912', 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Eldora', NULL, 'Gerlach', 'Kieran', 'Lavina', NULL, 'Jacobi', 'Rowland', 'Teresa', NULL, 'Elementary', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Spouse\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Family Support\\\"]\"', NULL, NULL, '41585', NULL, 'B-', NULL, '\"[\\\"Cancer\\\"]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"Cataracts\\\",\\\"None\\\"]\"', '\"[\\\"Deafness\\\",\\\"None\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"None\\\",\\\"Climbing Stairs\\\",\\\"Bathing\\\"]\"', NULL, 'Annually', 'Regular', 'No', '28834', NULL, 'Yes', NULL, 'Yes', NULL, NULL, NULL),
(44, '2025-044', 'Zieme', 'Flo', 'Grace', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Zone 9, Purok 5', 'Street 9', '1941-08-17', 'Lingayen, Pangasinan', 'Separated', 'Male', '0981709248', 'flo.zieme44@email.com', 'Buddhist', 'Spanish', 'Tagalog', NULL, NULL, '03-246592400-2', NULL, NULL, 0, 'Self-employed', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Anastacio', 'Kayley', NULL, 'Zieme', 'Princess', 'Cornell', NULL, 'Brakus', 'Shania', 'Gardner', NULL, 'No Formal Education', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Relatives\\\",\\\"Alone\\\"]\"', '\"[\\\"Fair\\\",\\\"Good\\\"]\"', '\"[\\\"Investments\\\",\\\"Pension\\\",\\\"Savings\\\"]\"', NULL, NULL, '3425', NULL, 'O+', NULL, '\"[\\\"Hypertension\\\",\\\"Heart Disease\\\",\\\"Diabetes\\\"]\"', '\"[]\"', '\"[\\\"Cataracts\\\",\\\"Blindness\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"None\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\",\\\"Climbing Stairs\\\",\\\"None\\\"]\"', 'Blood Pressure Medicine', 'Quarterly', 'As Needed', 'Yes', NULL, NULL, 'Yes', 'Cancer', 'No', NULL, NULL, NULL),
(45, '2025-045', 'Steuber', 'Odessa', 'Brendan', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Zone 2, Purok 5', 'Street 31', '1936-09-16', 'Lingayen, Pangasinan', 'Married', 'Female', '0925636946', 'odessa.steuber45@email.com', 'Other', 'Filipino', 'English', NULL, '924-865-936', NULL, NULL, '503458948', 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Lennie', 'Francisco', NULL, 'Steuber', 'Margaret', 'Rowan', NULL, 'Beer', 'Orrin', 'Mandy', NULL, 'College', NULL, 'Teaching', NULL, 'With Family', '\"[\\\"Children\\\",\\\"Alone\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Business\\\",\\\"Family Support\\\"]\"', NULL, NULL, '47868', NULL, 'O+', NULL, '\"[\\\"Arthritis\\\",\\\"Cancer\\\"]\"', '\"[\\\"Gum Problems\\\",\\\"None\\\"]\"', '\"[\\\"Glasses\\\",\\\"None\\\"]\"', '\"[\\\"Deafness\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"Walking\\\",\\\"Climbing Stairs\\\"]\"', 'None', 'Bi-annually', 'As Needed', 'No', NULL, NULL, 'Yes', 'Arthritis', 'Yes', NULL, NULL, NULL),
(46, '2025-046', 'Ortiz', 'Kristian', 'Rebeka', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 9, Purok 3', 'Street 43', '1952-02-04', 'Lingayen, Pangasinan', 'Married', 'Female', '0907180694', 'kristian.ortiz46@email.com', 'Buddhist', 'Spanish', 'Cebuano', '9512857607', '629-687-687', '68-115028162-3', NULL, '837958625', 0, 'Part-time', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Anderson', NULL, 'Kale', NULL, 'Ortiz', 'Clementina', 'Rosendo', NULL, 'Schmeler', 'Nannie', 'Irma', 'II', 'Graduate School', NULL, NULL, NULL, 'Independent', '\"[\\\"Alone\\\"]\"', '\"[\\\"Good\\\",\\\"Poor\\\"]\"', '\"[\\\"Savings\\\"]\"', NULL, NULL, '31899', NULL, 'B+', NULL, '\"[\\\"Diabetes\\\",\\\"Arthritis\\\",\\\"Heart Disease\\\"]\"', '\"[]\"', '\"[\\\"Glasses\\\"]\"', '\"[]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\",\\\"Climbing Stairs\\\",\\\"Bathing\\\"]\"', 'Blood Pressure Medicine', 'Quarterly', 'Emergency Only', 'Yes', NULL, 'Pension', 'Yes', NULL, 'No', 'Visual Impairment', NULL, NULL);
INSERT INTO `seniors` (`id`, `osca_id`, `last_name`, `first_name`, `middle_name`, `name_extension`, `region`, `province`, `city`, `barangay`, `residence`, `street`, `date_of_birth`, `birth_place`, `marital_status`, `sex`, `contact_number`, `email`, `religion`, `ethnic_origin`, `language`, `gsis_sss`, `tin`, `philhealth`, `sc_association`, `other_govt_id`, `can_travel`, `employment`, `has_pension`, `has_app_account`, `pension_source`, `ctc_number`, `status`, `photo_path`, `created_at`, `updated_at`, `deleted_at`, `spouse_last_name`, `spouse_first_name`, `spouse_middle_name`, `spouse_extension`, `father_last_name`, `father_first_name`, `father_middle_name`, `father_extension`, `mother_last_name`, `mother_first_name`, `mother_middle_name`, `mother_extension`, `education_level`, `skills`, `shared_skills`, `community_activities`, `living_condition_primary`, `living_with`, `household_condition`, `source_of_income`, `real_assets`, `personal_assets`, `monthly_income`, `problems_needs`, `blood_type`, `physical_disability`, `health_problems`, `dental_concern`, `visual_concern`, `hearing_condition`, `social_emotional`, `area_difficulty`, `maintenance_medicines`, `scheduled_checkup`, `checkup_frequency`, `permanent_income`, `income_amount`, `income_source`, `existing_illness`, `illness_specify`, `with_disability`, `disability_specify`, `certification`, `user_id`) VALUES
(47, '2025-047', 'Schmeler', 'Dorcas', 'Marquise', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Zone 7, Purok 3', 'Street 20', '1963-07-31', 'Lingayen, Pangasinan', 'Others', 'Female', '0933335319', 'dorcas.schmeler47@email.com', 'Catholic', 'Filipino', 'Tagalog', NULL, NULL, '70-877659898-9', NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Carroll', 'Art', 'Elsie', NULL, 'Schmeler', 'Amelie', 'Orville', 'II', 'Rath', 'Audie', 'Rosanna', NULL, 'Vocational', NULL, 'Art', NULL, 'Independent', '\"[\\\"Alone\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Pension\\\",\\\"Investments\\\",\\\"Savings\\\"]\"', NULL, NULL, '32722', NULL, 'B+', NULL, '\"[]\"', '\"[]\"', '\"[\\\"Blindness\\\",\\\"Cataracts\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Anxiety\\\"]\"', '\"[\\\"Climbing Stairs\\\",\\\"Walking\\\"]\"', 'Pain Relievers', 'Quarterly', NULL, 'No', NULL, NULL, 'Yes', 'Hypertension', 'Yes', 'Hearing Impairment', NULL, NULL),
(48, '2025-048', 'Beer', 'Sierra', 'Blair', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'lasip', 'Zone 8, Purok 5', 'Street 28', '1949-01-14', 'Lingayen, Pangasinan', 'Single', 'Female', '0927303845', 'sierra.beer48@email.com', 'Islam', 'Chinese', 'English', NULL, NULL, NULL, 'Barangay Senior Group', NULL, 0, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Koelpin', NULL, 'Pascale', NULL, 'Beer', 'Jason', 'Cristobal', NULL, 'Koelpin', 'Selmer', 'Mireya', NULL, 'College', NULL, NULL, NULL, 'With Family', '\"[\\\"Alone\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '10576', NULL, 'A-', 'Visual Impairment', '\"[]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[\\\"Blindness\\\",\\\"Glasses\\\"]\"', '\"[\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Depression\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\",\\\"Eating\\\"]\"', 'Vitamins', 'Monthly', NULL, 'Yes', NULL, 'Pension', 'No', 'Heart Disease', 'No', NULL, NULL, NULL),
(49, '2025-049', 'Mayert', 'Thad', 'Meggie', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'quibaol', 'Zone 1, Purok 2', 'Street 19', '1939-11-19', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0944110966', 'thad.mayert49@email.com', 'Islam', 'Filipino', 'Filipino', NULL, '647-728-095', '28-062444360-8', NULL, '946948515', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Mayert', 'Brandon', 'Suzanne', NULL, 'King', 'Vicky', 'Deshawn', NULL, 'High School', NULL, NULL, NULL, 'With Family', '\"[\\\"Grandchildren\\\",\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Fair\\\",\\\"Good\\\"]\"', '\"[\\\"Savings\\\",\\\"Investments\\\"]\"', NULL, NULL, '49326', NULL, 'AB+', NULL, '\"[\\\"Hypertension\\\",\\\"None\\\",\\\"Heart Disease\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Glasses\\\"]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"Bathing\\\"]\"', 'Diabetes Medicine', 'Monthly', 'Emergency Only', 'Yes', NULL, 'Family Support', 'Yes', NULL, 'No', NULL, NULL, NULL),
(50, '2025-050', 'Leannon', 'Crystal', 'Waldo', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'quibaol', 'Zone 9, Purok 3', 'Street 16', '1958-02-25', 'Lingayen, Pangasinan', 'Single', 'Female', '0966650116', 'crystal.leannon50@email.com', 'Other', 'Filipino', 'Tagalog', '5371522762', NULL, '62-047132701-6', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Trudie', 'Darion', NULL, 'Leannon', 'Elizabeth', 'Elizabeth', NULL, 'Labadie', 'Chelsie', 'Velva', NULL, 'No Formal Education', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Children\\\",\\\"Relatives\\\",\\\"Spouse\\\"]\"', '\"[\\\"Poor\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Business\\\"]\"', NULL, NULL, '38343', NULL, 'A+', NULL, '\"[\\\"Diabetes\\\",\\\"None\\\",\\\"Cancer\\\"]\"', '\"[]\"', '\"[\\\"None\\\",\\\"Glasses\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"None\\\",\\\"Eating\\\"]\"', 'Blood Pressure Medicine', 'Quarterly', NULL, 'Yes', NULL, NULL, 'No', 'Diabetes', 'No', 'Mental Disability', NULL, NULL),
(51, '2025-051', 'Robel', 'Kraig', 'Wade', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'estanza', 'Zone 7, Purok 5', 'Street 10', '1935-01-24', 'Lingayen, Pangasinan', 'Single', 'Male', '0953390487', 'kraig.robel51@email.com', 'Islam', 'American', 'English', '4398861064', '137-120-776', '00-243848182-7', 'Church Senior Group', '882494577', 1, 'Volunteer', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Fritsch', 'Taylor', NULL, NULL, 'Robel', 'Zander', 'Reed', NULL, 'Rutherford', 'Retha', 'Graham', NULL, 'High School', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Children\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Family Support\\\",\\\"Investments\\\"]\"', NULL, NULL, '15504', NULL, 'O-', NULL, '\"[\\\"None\\\"]\"', '\"[]\"', '\"[\\\"Cataracts\\\",\\\"Glasses\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Depression\\\"]\"', '\"[]\"', 'Blood Pressure Medicine', 'Quarterly', 'As Needed', 'Yes', NULL, NULL, 'Yes', NULL, 'Yes', 'Hearing Impairment', NULL, NULL),
(52, '2025-052', 'Blick', 'Verona', 'Hailie', 'Jr.', 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 9, Purok 5', 'Street 7', '1952-02-15', 'Lingayen, Pangasinan', 'Separated', 'Female', '0960922807', 'verona.blick52@email.com', 'Buddhist', 'Spanish', 'Tagalog', '8973710849', '830-718-161', '41-727034468-0', 'Barangay Senior Group', NULL, 0, 'Self-employed', 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, 'II', 'Blick', 'Ephraim', 'Aylin', NULL, 'Leffler', 'Elmira', 'Flavie', NULL, 'Vocational', NULL, 'Cooking', NULL, 'Nursing Home', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Family Support\\\"]\"', NULL, NULL, '12882', NULL, 'AB+', NULL, '\"[\\\"Cancer\\\",\\\"Heart Disease\\\"]\"', '\"[]\"', '\"[\\\"Cataracts\\\",\\\"Glasses\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[]\"', NULL, 'Monthly', NULL, 'No', NULL, NULL, 'No', NULL, 'No', 'Mental Disability', NULL, NULL),
(53, '2025-053', 'Quitzon', 'Kelvin', 'Thurman', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 2, Purok 3', 'Street 9', '1948-10-28', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0952498040', 'kelvin.quitzon53@email.com', 'Islam', 'Filipino', 'Ilocano', NULL, '239-655-100', '46-769204356-1', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Purdy', 'Tyler', NULL, 'Jr.', 'Quitzon', 'Hal', 'Uriel', NULL, 'O\'Hara', 'Esmeralda', 'Annabell', NULL, 'High School', NULL, 'Art', NULL, 'Assisted Living', '\"[\\\"Spouse\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Savings\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '24416', NULL, 'B+', NULL, '\"[]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"Blindness\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\",\\\"None\\\"]\"', 'Pain Relievers', 'Annually', NULL, 'No', NULL, NULL, 'No', 'Arthritis', 'Yes', 'Mental Disability', NULL, NULL),
(54, '2025-054', 'Heidenreich', 'Art', 'Austin', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Zone 9, Purok 3', 'Street 25', '1948-06-18', 'Lingayen, Pangasinan', 'Single', 'Female', '0935217130', 'art.heidenreich54@email.com', 'Buddhist', 'Filipino', 'Cebuano', '5040988932', '850-820-122', '43-607704420-6', NULL, '374578228', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Raynor', NULL, 'Schuyler', NULL, 'Heidenreich', 'Madalyn', 'Lavina', NULL, 'Effertz', 'Bailey', 'Kacie', NULL, 'Graduate School', NULL, 'Gardening', NULL, 'Independent', '\"[\\\"Alone\\\",\\\"Relatives\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Pension\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '18683', NULL, 'A-', NULL, '\"[\\\"Heart Disease\\\",\\\"None\\\",\\\"Arthritis\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Cataracts\\\",\\\"Glasses\\\"]\"', '\"[]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Eating\\\",\\\"None\\\",\\\"Walking\\\"]\"', NULL, 'Quarterly', 'As Needed', 'Yes', '41985', NULL, 'No', NULL, 'No', NULL, NULL, NULL),
(55, '2025-055', 'Kilback', 'Marta', 'Judge', 'II', 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 2, Purok 4', 'Street 17', '1950-11-22', 'Lingayen, Pangasinan', 'Single', 'Female', '0995852591', 'marta.kilback55@email.com', 'Catholic', 'Other', 'English', '2466512731', '620-891-528', '84-188006141-1', 'Senior Citizens Association', NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Pfannerstill', NULL, NULL, 'III', 'Kilback', 'Yvonne', 'Katrina', NULL, 'Strosin', 'Willa', 'Misael', NULL, 'High School', NULL, 'Teaching', NULL, 'Assisted Living', '\"[\\\"Alone\\\",\\\"Grandchildren\\\",\\\"Children\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Savings\\\"]\"', NULL, NULL, '31876', NULL, 'O-', NULL, '\"[\\\"Cancer\\\"]\"', '\"[\\\"None\\\",\\\"Gum Problems\\\"]\"', '\"[]\"', '\"[\\\"None\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\"]\"', NULL, 'Bi-annually', NULL, 'No', '15758', 'Pension', 'No', 'Diabetes', 'Yes', NULL, NULL, NULL),
(56, '2025-056', 'Heller', 'Dillon', 'Kasandra', 'III', 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Zone 5, Purok 5', 'Street 20', '1931-09-07', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0943126451', 'dillon.heller56@email.com', 'Protestant', 'Filipino', 'Tagalog', '2363351554', NULL, NULL, NULL, '812106669', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Kayleigh', NULL, NULL, 'Heller', 'Angelo', 'Nadia', NULL, 'Effertz', 'Arianna', 'Ralph', NULL, 'Elementary', NULL, 'Music', NULL, 'Nursing Home', '\"[\\\"Relatives\\\",\\\"Spouse\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Business\\\",\\\"Savings\\\",\\\"Family Support\\\"]\"', NULL, NULL, '35285', NULL, 'O+', NULL, '\"[\\\"Heart Disease\\\",\\\"Diabetes\\\"]\"', '\"[\\\"None\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[]\"', 'Pain Relievers', 'Quarterly', NULL, 'Yes', '17749', 'Government Assistance', 'Yes', NULL, 'No', NULL, NULL, NULL),
(57, '2025-057', 'Abshire', 'Dedrick', 'Trace', 'II', 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 10, Purok 4', 'Street 46', '1959-06-27', 'Lingayen, Pangasinan', 'Separated', 'Male', '0979847210', 'dedrick.abshire57@email.com', 'Catholic', 'American', 'Filipino', '2621650979', '248-884-236', '35-936653937-9', NULL, NULL, 1, 'Volunteer', 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Miller', 'Anabelle', 'Makenna', NULL, 'Abshire', 'Tara', 'Annabelle', NULL, 'Wehner', 'Ottilie', 'Lucas', NULL, 'Vocational', NULL, NULL, NULL, 'With Family', '\"[\\\"Alone\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Good\\\"]\"', '\"[\\\"Government Assistance\\\"]\"', NULL, NULL, '34775', NULL, 'B+', NULL, '\"[]\"', '\"[]\"', '\"[]\"', '\"[]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"Dressing\\\"]\"', NULL, 'Monthly', NULL, 'Yes', '15374', NULL, 'No', 'Cancer', 'No', 'Hearing Impairment', NULL, NULL),
(58, '2025-058', 'Hettinger', 'River', 'Brennon', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 2, Purok 1', 'Street 2', '1953-11-03', 'Lingayen, Pangasinan', 'Married', 'Male', '0922621229', 'river.hettinger58@email.com', 'Buddhist', 'American', 'Filipino', NULL, '880-499-850', '61-474302326-6', NULL, '923399511', 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Richard', NULL, 'Hettinger', 'Fabiola', 'Lonnie', NULL, 'Zieme', 'Reba', 'Tess', NULL, 'No Formal Education', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Grandchildren\\\",\\\"Spouse\\\",\\\"Alone\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Pension\\\"]\"', NULL, NULL, '15793', NULL, 'O+', 'Hearing Impairment', '\"[\\\"Diabetes\\\",\\\"Heart Disease\\\",\\\"Arthritis\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Hearing Aid\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Depression\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', 'Blood Pressure Medicine', NULL, 'Regular', 'Yes', NULL, 'Pension', 'No', 'Heart Disease', 'No', NULL, NULL, NULL),
(59, '2025-059', 'Hyatt', 'Bud', 'Judah', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 10, Purok 5', 'Street 30', '1963-08-14', 'Lingayen, Pangasinan', 'Separated', 'Male', '0975284508', 'bud.hyatt59@email.com', 'Buddhist', 'Filipino', 'Cebuano', '8275076429', '711-815-391', '36-118353114-6', 'Church Senior Group', NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Powlowski', NULL, NULL, 'III', 'Hyatt', 'Angelo', 'Harry', NULL, 'Pollich', 'Savanah', 'Reese', NULL, 'High School', NULL, 'Cooking', NULL, 'Nursing Home', '\"[\\\"Relatives\\\",\\\"Children\\\",\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Family Support\\\"]\"', NULL, NULL, '43132', NULL, 'A+', 'Visual Impairment', '\"[]\"', '\"[\\\"Dentures\\\",\\\"Missing Teeth\\\"]\"', '\"[]\"', '\"[\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Depression\\\",\\\"Anxiety\\\"]\"', '\"[\\\"Walking\\\"]\"', 'Diabetes Medicine', 'Quarterly', 'Regular', 'Yes', NULL, 'Business', 'Yes', NULL, 'Yes', NULL, NULL, NULL),
(60, '2025-060', 'Schiller', 'Conor', 'Tristian', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Zone 8, Purok 2', 'Street 12', '1965-06-19', 'Lingayen, Pangasinan', 'Married', 'Male', '0934285868', 'conor.schiller60@email.com', 'Buddhist', 'American', 'English', '1872225682', '817-821-580', '58-568706994-4', NULL, NULL, 0, 'Retired', 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Schiller', 'Braden', 'Jasen', NULL, 'Keeling', 'Frankie', 'Rollin', 'II', 'Graduate School', NULL, 'Music', NULL, 'Nursing Home', '\"[\\\"Children\\\"]\"', '\"[\\\"Fair\\\",\\\"Poor\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Business\\\"]\"', NULL, NULL, '13292', NULL, 'A-', NULL, '\"[]\"', '\"[\\\"None\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"Glasses\\\"]\"', '\"[]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"Walking\\\",\\\"Bathing\\\"]\"', NULL, 'Annually', NULL, 'No', NULL, 'Business', 'Yes', 'Cancer', 'No', 'Mobility Issues', NULL, NULL),
(61, '2025-061', 'Skiles', 'Isobel', 'Cleve', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'lasip', 'Zone 4, Purok 3', 'Street 47', '1949-11-05', 'Lingayen, Pangasinan', 'Married', 'Male', '0969892281', 'isobel.skiles61@email.com', 'Islam', 'Spanish', 'Tagalog', NULL, '120-993-179', '33-493986980-8', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Eino', NULL, NULL, 'Skiles', 'Katharina', 'Davion', NULL, 'Torp', 'Lia', 'Will', NULL, 'Graduate School', NULL, 'Cooking', NULL, 'With Family', '\"[\\\"Alone\\\",\\\"Children\\\",\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\",\\\"Poor\\\"]\"', '\"[\\\"Government Assistance\\\"]\"', NULL, NULL, '15023', NULL, 'O-', 'Mobility Issues', '\"[\\\"Hypertension\\\",\\\"Cancer\\\",\\\"Heart Disease\\\"]\"', '\"[]\"', '\"[\\\"Glasses\\\",\\\"None\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Walking\\\"]\"', 'None', 'Monthly', 'Regular', 'Yes', NULL, 'Pension', 'No', 'Hypertension', 'No', 'Visual Impairment', NULL, NULL),
(62, '2025-062', 'D\'Amore', 'Norris', 'Rahsaan', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Zone 4, Purok 4', 'Street 41', '1954-04-15', 'Lingayen, Pangasinan', 'Separated', 'Female', '0997671052', 'norris.d\'amore62@email.com', 'Islam', 'Other', 'English', '8799341693', NULL, NULL, 'Barangay Senior Group', NULL, 1, 'Self-employed', 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Flossie', NULL, NULL, 'D\'Amore', 'Mervin', 'Marilou', NULL, 'Muller', 'Beryl', 'Mike', NULL, 'Graduate School', NULL, 'Art', NULL, 'Nursing Home', '\"[\\\"Spouse\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Fair\\\"]\"', '\"[\\\"Business\\\",\\\"Savings\\\",\\\"Investments\\\"]\"', NULL, NULL, '47350', NULL, 'B-', NULL, '\"[\\\"None\\\"]\"', '\"[\\\"Dentures\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Good Mental Health\\\"]\"', '\"[]\"', 'Vitamins', NULL, 'Emergency Only', 'No', '25923', NULL, 'No', NULL, 'No', NULL, NULL, NULL),
(63, '2025-063', 'Pfannerstill', 'Rosina', 'Jayda', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 5, Purok 4', 'Street 23', '1949-03-05', 'Lingayen, Pangasinan', 'Married', 'Female', '0908749133', 'rosina.pfannerstill63@email.com', 'Buddhist', 'Filipino', 'Cebuano', NULL, '503-371-852', '87-332611575-3', NULL, '950320427', 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Batz', NULL, 'Chauncey', NULL, 'Pfannerstill', 'Nella', 'Brenden', NULL, 'Wilkinson', 'Benton', 'Emmy', NULL, 'Elementary', NULL, 'Art', NULL, 'With Family', '\"[\\\"Alone\\\",\\\"Spouse\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '28797', NULL, 'O-', NULL, '\"[\\\"Hypertension\\\",\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[]\"', 'Diabetes Medicine', 'Monthly', NULL, 'Yes', NULL, NULL, 'Yes', NULL, 'No', NULL, NULL, NULL),
(64, '2025-064', 'Cole', 'Kirk', 'Hollis', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 5, Purok 2', 'Street 28', '1942-05-03', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0984416870', 'kirk.cole64@email.com', 'Catholic', 'Chinese', 'Tagalog', NULL, '876-578-092', '65-132990088-4', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Lavon', NULL, 'Cole', 'Krystina', 'Grant', 'Jr.', 'Waelchi', 'Shaniya', 'Jarrett', NULL, 'College', NULL, 'Crafting', NULL, 'Independent', '\"[\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Good\\\",\\\"Poor\\\"]\"', '\"[\\\"Business\\\",\\\"Pension\\\"]\"', NULL, NULL, '17708', NULL, 'AB-', NULL, '\"[\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"None\\\",\\\"Cataracts\\\"]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\",\\\"Eating\\\"]\"', 'Diabetes Medicine', 'Monthly', 'Regular', 'Yes', '33593', 'Business', 'Yes', 'Arthritis', 'Yes', NULL, NULL, NULL),
(65, '2025-065', 'Kuvalis', 'Oleta', 'Vergie', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 7, Purok 3', 'Street 9', '1943-12-29', 'Lingayen, Pangasinan', 'Others', 'Female', '0915920844', 'oleta.kuvalis65@email.com', 'Other', 'Other', 'Filipino', '9202916357', '754-160-527', NULL, 'Church Senior Group', NULL, 1, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Gudrun', NULL, NULL, 'Kuvalis', 'Remington', 'Chester', NULL, 'Howe', 'Candice', 'Lucious', NULL, 'Graduate School', NULL, 'Crafting', NULL, 'Independent', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Pension\\\",\\\"Business\\\"]\"', NULL, NULL, '46867', NULL, 'AB+', NULL, '\"[\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"Eating\\\",\\\"Dressing\\\"]\"', NULL, 'Quarterly', 'As Needed', 'No', NULL, NULL, 'No', NULL, 'No', 'Visual Impairment', NULL, NULL),
(66, '2025-066', 'Farrell', 'Dwight', 'Hattie', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 5, Purok 2', 'Street 31', '1933-11-15', 'Lingayen, Pangasinan', 'Single', 'Female', '0988043789', 'dwight.farrell66@email.com', 'Other', 'American', 'English', '8190433240', NULL, '40-466370569-3', 'Barangay Senior Group', NULL, 1, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Beatty', NULL, NULL, NULL, 'Farrell', 'Dorothy', 'Eliza', NULL, 'Jast', 'Margarette', 'Savannah', NULL, 'Elementary', NULL, 'Sewing', NULL, 'Nursing Home', '\"[\\\"Relatives\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Pension\\\",\\\"Government Assistance\\\",\\\"Family Support\\\"]\"', NULL, NULL, '42368', NULL, 'O-', NULL, '\"[\\\"Arthritis\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Loneliness\\\"]\"', '\"[]\"', 'Diabetes Medicine', 'Bi-annually', NULL, 'No', '36598', NULL, 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(67, '2025-067', 'Volkman', 'Lucile', 'Viola', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 6, Purok 5', 'Street 4', '1934-05-14', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0915962275', 'lucile.volkman67@email.com', 'Catholic', 'American', 'Tagalog', '9668344517', NULL, '37-627038718-8', NULL, '771911169', 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Wilderman', NULL, NULL, NULL, 'Volkman', 'Jettie', 'Delaney', NULL, 'Kuhic', 'Geraldine', 'Susanna', NULL, 'High School', NULL, NULL, NULL, 'Independent', '\"[\\\"Alone\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Family Support\\\",\\\"Investments\\\",\\\"Business\\\"]\"', NULL, NULL, '32461', NULL, 'AB-', 'Mobility Issues', '\"[\\\"Hypertension\\\",\\\"Cancer\\\",\\\"Heart Disease\\\"]\"', '\"[\\\"Dentures\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\",\\\"Climbing Stairs\\\"]\"', 'Blood Pressure Medicine', 'Quarterly', NULL, 'Yes', NULL, NULL, 'No', NULL, 'No', NULL, NULL, NULL),
(68, '2025-068', 'Wuckert', 'Eliza', 'Vincent', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'lasip', 'Zone 5, Purok 1', 'Street 27', '1935-06-20', 'Lingayen, Pangasinan', 'Married', 'Male', '0900761025', 'eliza.wuckert68@email.com', 'Catholic', 'American', 'Tagalog', '0916940721', '660-379-359', '47-516079436-9', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Cremin', NULL, NULL, NULL, 'Wuckert', 'Trystan', 'Kelsi', 'II', 'Brown', 'Pierre', 'Caesar', NULL, 'Elementary', NULL, 'Crafting', NULL, 'Independent', '\"[\\\"Grandchildren\\\",\\\"Children\\\",\\\"Relatives\\\"]\"', '\"[\\\"Good\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Business\\\"]\"', NULL, NULL, '46320', NULL, 'O-', NULL, '\"[\\\"Hypertension\\\"]\"', '\"[\\\"Dentures\\\",\\\"Gum Problems\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Depression\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', 'Pain Relievers', 'Quarterly', 'Regular', 'Yes', '21611', 'Business', 'No', 'Hypertension', 'No', NULL, NULL, NULL),
(69, '2025-069', 'Jaskolski', 'Will', 'Drake', 'Jr.', 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 9, Purok 2', 'Street 40', '1949-11-15', 'Lingayen, Pangasinan', 'Single', 'Male', '0908099478', 'will.jaskolski69@email.com', 'Catholic', 'Other', 'Filipino', '2480292602', NULL, '07-169955402-6', NULL, '200125198', 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Jaskolski', 'Gertrude', 'Myriam', NULL, 'Haley', 'Stanley', 'Blair', NULL, 'No Formal Education', NULL, 'Crafting', NULL, 'Independent', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '49135', NULL, 'A+', 'Hearing Impairment', '\"[\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[]\"', '\"[\\\"None\\\",\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', 'Diabetes Medicine', 'Bi-annually', 'Emergency Only', 'Yes', '41003', 'Government Assistance', 'No', 'Diabetes', 'No', NULL, NULL, NULL),
(70, '2025-070', 'Hyatt', 'Caitlyn', 'Felix', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-east', 'Zone 7, Purok 5', 'Street 12', '1940-11-15', 'Lingayen, Pangasinan', 'Single', 'Male', '0950253327', 'caitlyn.hyatt70@email.com', 'Buddhist', 'Other', 'English', '9327834119', NULL, '79-057433417-4', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Eulalia', 'Jeanne', NULL, 'Hyatt', 'Ona', 'Preston', NULL, 'Bartoletti', 'Gia', 'Julien', NULL, 'Graduate School', NULL, 'Crafting', NULL, 'Assisted Living', '\"[\\\"Alone\\\",\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '19219', NULL, 'O+', NULL, '\"[\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Anxiety\\\"]\"', '\"[\\\"Walking\\\"]\"', NULL, 'Quarterly', NULL, 'Yes', NULL, NULL, 'Yes', 'Hypertension', 'Yes', NULL, NULL, NULL),
(71, '2025-071', 'Kautzer', 'Desmond', 'Jackson', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 2, Purok 3', 'Street 30', '1954-09-01', 'Lingayen, Pangasinan', 'Single', 'Female', '0950427392', 'desmond.kautzer71@email.com', 'Buddhist', 'Spanish', 'English', '7319913177', '920-551-695', '12-473036821-4', 'Senior Citizens Association', NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Kautzer', 'Madelyn', 'Guadalupe', NULL, 'Upton', 'Alana', 'Lelia', NULL, 'Vocational', NULL, NULL, NULL, 'With Family', '\"[\\\"Grandchildren\\\",\\\"Relatives\\\"]\"', '\"[\\\"Good\\\",\\\"Poor\\\"]\"', '\"[\\\"Investments\\\",\\\"Savings\\\"]\"', NULL, NULL, '42500', NULL, 'B+', NULL, '\"[\\\"Arthritis\\\",\\\"Diabetes\\\",\\\"None\\\"]\"', '\"[\\\"Missing Teeth\\\",\\\"Dentures\\\"]\"', '\"[\\\"None\\\",\\\"Cataracts\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\",\\\"Bathing\\\",\\\"None\\\"]\"', 'Pain Relievers', 'Quarterly', NULL, 'Yes', NULL, 'Pension', 'Yes', NULL, 'No', 'Mental Disability', NULL, NULL),
(72, '2025-072', 'Kunde', 'Frederique', 'Carli', NULL, 'region-i', 'pangasinan', 'lingayen', 'poblacion', 'Zone 5, Purok 5', 'Street 24', '1932-07-22', 'Lingayen, Pangasinan', 'Separated', 'Female', '0929390669', 'frederique.kunde72@email.com', 'Islam', 'Filipino', 'Ilocano', NULL, NULL, '81-438697010-6', 'Church Senior Group', '495723679', 0, 'Self-employed', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-02 11:24:08', NULL, 'Langworth', 'Emely', NULL, NULL, 'Kunde', 'Marc', 'Pedro', 'Jr.', 'Waelchi', 'Hershel', 'Gabrielle', NULL, 'Vocational', NULL, 'Music', NULL, 'With Family', '\"[\\\"Grandchildren\\\",\\\"Relatives\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Fair\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Investments\\\"]\"', NULL, NULL, '25694', NULL, 'A+', NULL, '\"[\\\"None\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"Bathing\\\",\\\"Eating\\\",\\\"Climbing Stairs\\\"]\"', 'None', 'Bi-annually', NULL, 'No', '45624', 'Business', NULL, 'Arthritis', NULL, 'Mobility Issues', NULL, NULL),
(73, '2025-073', 'Hammes', 'Stephen', 'Ed', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 4, Purok 4', 'Street 13', '1960-10-07', 'Lingayen, Pangasinan', 'Married', 'Male', '0961781610', 'stephen.hammes73@email.com', 'Buddhist', 'Chinese', 'English', '0554333366', '347-335-277', '80-200301941-0', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Erika', NULL, 'Hammes', 'Marley', 'Jerad', NULL, 'Cassin', 'Mariah', 'Virgie', 'II', 'Elementary', NULL, 'Art', NULL, 'Assisted Living', '\"[\\\"Grandchildren\\\",\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Good\\\",\\\"Poor\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Investments\\\"]\"', NULL, NULL, '18848', NULL, 'B+', NULL, '\"[\\\"Arthritis\\\"]\"', '\"[\\\"Dentures\\\",\\\"Missing Teeth\\\"]\"', '\"[\\\"Cataracts\\\",\\\"Blindness\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Dressing\\\",\\\"Walking\\\"]\"', NULL, 'Monthly', 'As Needed', 'No', NULL, 'Pension', 'Yes', NULL, 'No', NULL, NULL, NULL),
(74, '2025-074', 'Yost', 'Zachary', 'Uriah', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 7, Purok 5', 'Street 33', '1946-06-16', 'Lingayen, Pangasinan', 'Others', 'Female', '0995210707', 'zachary.yost74@email.com', 'Buddhist', 'Spanish', 'Filipino', NULL, NULL, '56-004571422-8', 'Senior Citizens Association', NULL, 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Percy', 'II', 'Yost', 'Allan', 'Leonard', NULL, 'Mann', 'Raven', 'Fabian', NULL, 'High School', NULL, NULL, NULL, 'With Family', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Investments\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '6137', NULL, 'A+', NULL, '\"[\\\"Heart Disease\\\"]\"', '\"[]\"', '\"[\\\"Glasses\\\",\\\"Cataracts\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Depression\\\"]\"', '\"[\\\"Eating\\\"]\"', 'None', 'Monthly', 'Emergency Only', 'No', NULL, NULL, 'Yes', 'Heart Disease', 'No', NULL, NULL, NULL),
(75, '2025-075', 'Gerhold', 'Raoul', 'Rocio', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 9, Purok 2', 'Street 37', '1945-09-09', 'Lingayen, Pangasinan', 'Married', 'Female', '0934013799', 'raoul.gerhold75@email.com', 'Buddhist', 'Filipino', 'English', '0071294202', '943-651-390', NULL, NULL, '771481446', 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Mckenzie', NULL, NULL, 'Gerhold', 'Elise', 'Violette', NULL, 'Doyle', 'Robbie', 'Lamont', NULL, 'High School', NULL, 'Art', NULL, 'Assisted Living', '\"[\\\"Children\\\",\\\"Relatives\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\"]\"', '\"[\\\"Pension\\\",\\\"Savings\\\",\\\"Government Assistance\\\"]\"', NULL, NULL, '34418', NULL, 'A-', NULL, '\"[\\\"Heart Disease\\\",\\\"Arthritis\\\"]\"', '\"[\\\"Missing Teeth\\\",\\\"Dentures\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"None\\\",\\\"Deafness\\\"]\"', '\"[\\\"Depression\\\"]\"', '\"[\\\"Bathing\\\",\\\"Climbing Stairs\\\"]\"', 'Diabetes Medicine', 'Quarterly', 'As Needed', 'No', '16737', 'Business', 'No', 'Heart Disease', 'Yes', 'Mobility Issues', NULL, NULL),
(76, '2025-076', 'Beer', 'Camylle', 'Lavon', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 2, Purok 3', 'Street 26', '1947-08-04', 'Lingayen, Pangasinan', 'Single', 'Male', '0921751925', 'camylle.beer76@email.com', 'Catholic', 'Other', 'Cebuano', NULL, '091-643-613', NULL, NULL, '803360816', 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Zulauf', 'Iva', 'Eloy', NULL, 'Beer', 'Clementine', 'Elwyn', NULL, 'Wolf', 'Hilton', 'Faye', NULL, 'Elementary', NULL, 'Art', NULL, 'Nursing Home', '\"[\\\"Spouse\\\",\\\"Children\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Family Support\\\",\\\"Investments\\\"]\"', NULL, NULL, '15425', NULL, 'AB+', NULL, '\"[\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[\\\"Missing Teeth\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"Cataracts\\\",\\\"None\\\"]\"', '\"[\\\"Deafness\\\",\\\"None\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"Walking\\\",\\\"None\\\",\\\"Climbing Stairs\\\"]\"', 'None', NULL, NULL, 'No', NULL, NULL, 'No', 'Arthritis', 'No', NULL, NULL, NULL),
(77, '2025-077', 'Towne', 'Adrianna', 'Roger', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 9, Purok 2', 'Street 31', '1931-12-14', 'Lingayen, Pangasinan', 'Married', 'Female', '0975089217', 'adrianna.towne77@email.com', 'Catholic', 'Other', 'Cebuano', NULL, '069-933-848', '77-624650068-3', 'Barangay Senior Group', NULL, 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Kattie', NULL, NULL, 'Towne', 'Evangeline', 'Malcolm', NULL, 'Gorczany', 'Trent', 'Macie', NULL, 'High School', NULL, 'Art', NULL, 'Nursing Home', '\"[\\\"Grandchildren\\\",\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Pension\\\",\\\"Business\\\"]\"', NULL, NULL, '18808', NULL, 'A-', NULL, '\"[\\\"Hypertension\\\",\\\"Diabetes\\\",\\\"Heart Disease\\\"]\"', '\"[]\"', '\"[\\\"Glasses\\\",\\\"Cataracts\\\"]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Depression\\\"]\"', '\"[\\\"Bathing\\\"]\"', 'None', NULL, 'Emergency Only', 'No', '48349', NULL, 'Yes', NULL, 'No', NULL, NULL, NULL),
(78, '2025-078', 'Walter', 'Treva', 'Stephen', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'quibaol', 'Zone 9, Purok 5', 'Street 3', '1961-08-02', 'Lingayen, Pangasinan', 'Separated', 'Female', '0995905977', 'treva.walter78@email.com', 'Islam', 'American', 'Cebuano', '1952385360', NULL, '23-159396454-3', NULL, '424090207', 1, 'Part-time', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Missouri', NULL, 'Walter', 'Karolann', 'Alfonso', 'Sr.', 'Raynor', 'Gladyce', 'Kelli', NULL, 'High School', NULL, NULL, NULL, 'With Family', '\"[\\\"Alone\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Pension\\\",\\\"Family Support\\\"]\"', NULL, NULL, '26687', NULL, 'AB-', NULL, '\"[]\"', '\"[\\\"Dentures\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Depression\\\"]\"', '\"[]\"', NULL, 'Quarterly', 'Regular', 'No', NULL, NULL, 'Yes', 'Hypertension', 'Yes', 'Mobility Issues', NULL, NULL),
(79, '2025-079', 'Flatley', 'Freida', 'Rodrick', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 2, Purok 5', 'Street 49', '1943-04-03', 'Lingayen, Pangasinan', 'Widowed', 'Female', '0986786045', 'freida.flatley79@email.com', 'Buddhist', 'American', 'Cebuano', NULL, '155-426-432', '92-946789267-9', NULL, '568983845', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Flatley', 'Kyle', 'Leslie', NULL, 'McGlynn', 'Junius', 'Lou', NULL, 'Graduate School', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Alone\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Family Support\\\",\\\"Business\\\",\\\"Investments\\\"]\"', NULL, NULL, '4263', NULL, 'B-', NULL, '\"[\\\"Heart Disease\\\"]\"', '\"[\\\"None\\\"]\"', '\"[]\"', '\"[\\\"Hearing Aid\\\",\\\"None\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[]\"', 'Pain Relievers', 'Annually', NULL, 'Yes', '25511', NULL, 'No', NULL, 'Yes', 'Mental Disability', NULL, NULL),
(80, '2025-080', 'Howell', 'Bernice', 'Delbert', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Zone 2, Purok 5', 'Street 29', '1958-07-10', 'Lingayen, Pangasinan', 'Others', 'Male', '0920341505', 'bernice.howell80@email.com', 'Buddhist', 'Filipino', 'English', NULL, '731-758-791', NULL, NULL, '232149807', 0, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Margarita', 'Sierra', 'III', 'Howell', 'Lee', 'Victor', NULL, 'Mitchell', 'Gideon', 'Tatum', NULL, 'College', NULL, 'Art', NULL, 'Assisted Living', '\"[\\\"Children\\\",\\\"Alone\\\"]\"', '\"[\\\"Good\\\",\\\"Fair\\\"]\"', '\"[\\\"Investments\\\",\\\"Savings\\\"]\"', NULL, NULL, '47214', NULL, 'O-', NULL, '\"[\\\"Heart Disease\\\",\\\"Hypertension\\\",\\\"Diabetes\\\"]\"', '\"[]\"', '\"[\\\"None\\\",\\\"Blindness\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Climbing Stairs\\\",\\\"Walking\\\"]\"', NULL, 'Bi-annually', 'Emergency Only', 'No', NULL, 'Pension', 'Yes', NULL, 'No', NULL, NULL, NULL),
(81, '2025-081', 'Osinski', 'Benedict', 'Domenico', 'VI', 'Region I', 'Pangasinan', 'Lingayen', 'estanza', 'Zone 10, Purok 5', 'Street 1', '1964-11-14', 'Lingayen, Pangasinan', 'Single', 'Female', '0985545958', 'benedict.osinski81@email.com', 'Buddhist', 'Other', 'Ilocano', NULL, '862-045-245', '83-131138329-7', NULL, '018638040', 0, 'Volunteer', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Tom', NULL, NULL, 'Osinski', 'Laury', 'Waylon', NULL, 'Kerluke', 'Abigale', 'Camylle', NULL, 'Vocational', NULL, 'Teaching', NULL, 'With Family', '\"[\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Pension\\\",\\\"Savings\\\",\\\"Business\\\"]\"', NULL, NULL, '4863', NULL, 'AB-', NULL, '\"[\\\"Diabetes\\\",\\\"None\\\",\\\"Cancer\\\"]\"', '\"[]\"', '\"[\\\"Blindness\\\",\\\"Glasses\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"None\\\"]\"', NULL, 'Monthly', 'As Needed', 'Yes', NULL, NULL, 'Yes', 'Hypertension', 'No', 'Visual Impairment', NULL, NULL),
(82, '2025-082', 'Kemmer', 'Cathy', 'Hailey', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 8, Purok 4', 'Street 18', '1943-07-04', 'Lingayen, Pangasinan', 'Single', 'Male', '0953059137', 'cathy.kemmer82@email.com', 'Catholic', 'American', 'Ilocano', '7003707536', '602-376-911', '59-131560030-1', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Stoltenberg', 'Tre', 'Alanis', NULL, 'Kemmer', 'Monica', 'Selina', 'II', 'Robel', 'Roscoe', 'Jamaal', NULL, 'No Formal Education', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Alone\\\",\\\"Relatives\\\"]\"', '\"[\\\"Poor\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '32370', NULL, 'B-', NULL, '\"[\\\"Heart Disease\\\",\\\"Arthritis\\\"]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"Glasses\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"None\\\",\\\"Walking\\\",\\\"Climbing Stairs\\\"]\"', 'Pain Relievers', 'Bi-annually', NULL, 'No', NULL, 'Business', 'No', NULL, 'No', 'Mobility Issues', NULL, NULL),
(83, '2025-083', 'Ward', 'Enrico', 'Amani', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Zone 1, Purok 3', 'Street 6', '1941-11-30', 'Lingayen, Pangasinan', 'Married', 'Male', '0978677226', 'enrico.ward83@email.com', 'Islam', 'Chinese', 'Ilocano', '3783318513', NULL, '41-327233324-4', NULL, '709086698', 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Mazie', NULL, 'Ward', 'Lenny', 'Elizabeth', NULL, 'Quitzon', 'Kelley', 'Mya', NULL, 'Graduate School', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Relatives\\\",\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '44890', NULL, 'AB-', NULL, '\"[]\"', '\"[]\"', '\"[\\\"Blindness\\\"]\"', '\"[\\\"None\\\",\\\"Deafness\\\"]\"', '\"[\\\"Loneliness\\\"]\"', '\"[\\\"Walking\\\",\\\"Climbing Stairs\\\"]\"', 'Diabetes Medicine', 'Annually', 'Regular', 'No', '20799', 'Government Assistance', 'No', 'Cancer', 'No', NULL, NULL, NULL),
(84, '2025-084', 'Rodriguez', 'Jermaine', 'Florence', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 10, Purok 4', 'Street 9', '1960-04-30', 'Lingayen, Pangasinan', 'Single', 'Female', '0974999643', 'jermaine.rodriguez84@email.com', 'Catholic', 'American', 'Ilocano', '6108353559', NULL, '44-641282407-0', 'Church Senior Group', '229918477', 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Hoppe', 'Marlin', 'Immanuel', NULL, 'Rodriguez', 'Leta', 'Electa', NULL, 'Weber', 'Sim', 'Bessie', NULL, 'Graduate School', NULL, 'Crafting', NULL, 'With Family', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Fair\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Savings\\\",\\\"Investments\\\",\\\"Family Support\\\"]\"', NULL, NULL, '38582', NULL, 'O-', NULL, '\"[]\"', '\"[\\\"Dentures\\\"]\"', '\"[]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Depression\\\",\\\"Anxiety\\\"]\"', '\"[]\"', 'None', 'Quarterly', NULL, 'No', '22536', 'Pension', 'Yes', 'Hypertension', 'No', 'Hearing Impairment', NULL, NULL),
(85, '2025-085', 'Stamm', 'Maida', 'Marianna', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Zone 10, Purok 3', 'Street 45', '1944-12-02', 'Lingayen, Pangasinan', 'Married', 'Female', '0989830285', 'maida.stamm85@email.com', 'Catholic', 'Filipino', 'Tagalog', '4471574733', NULL, '55-495125063-0', NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Jast', NULL, 'Delmer', NULL, 'Stamm', 'Robbie', 'Josianne', NULL, 'Bartell', 'Jerrell', 'Krista', NULL, 'No Formal Education', NULL, 'Music', NULL, 'With Family', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\",\\\"Good\\\"]\"', '\"[\\\"Family Support\\\",\\\"Business\\\"]\"', NULL, NULL, '34737', NULL, 'AB-', NULL, '\"[\\\"Arthritis\\\",\\\"Heart Disease\\\"]\"', '\"[\\\"Dentures\\\",\\\"None\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[\\\"Partial Hearing Loss\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Depression\\\",\\\"Loneliness\\\"]\"', '\"[]\"', 'Diabetes Medicine', NULL, 'Emergency Only', 'No', NULL, 'Family Support', 'No', NULL, 'No', 'Visual Impairment', NULL, NULL),
(86, '2025-086', 'Abbott', 'Emanuel', 'Jeffrey', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Zone 10, Purok 4', 'Street 18', '1956-04-09', 'Lingayen, Pangasinan', 'Married', 'Male', '0966490573', 'emanuel.abbott86@email.com', 'Buddhist', 'Spanish', 'English', '8343809632', '068-506-381', '87-350508714-9', NULL, NULL, 0, 'Volunteer', 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Brielle', NULL, NULL, 'Abbott', 'Ivah', 'Lempi', NULL, 'Rodriguez', 'Annamarie', 'Claire', NULL, 'College', NULL, NULL, NULL, 'Nursing Home', '\"[\\\"Relatives\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Savings\\\",\\\"Investments\\\",\\\"Pension\\\"]\"', NULL, NULL, '20043', NULL, 'B+', NULL, '\"[\\\"Cancer\\\"]\"', '\"[\\\"Dentures\\\",\\\"Gum Problems\\\"]\"', '\"[\\\"Cataracts\\\"]\"', '\"[]\"', '\"[\\\"Depression\\\",\\\"Good Mental Health\\\"]\"', '\"[]\"', NULL, 'Quarterly', 'Emergency Only', 'No', NULL, 'Business', 'No', NULL, 'No', 'Mobility Issues', NULL, NULL),
(87, '2025-087', 'Hermann', 'Henderson', 'Sven', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 9, Purok 1', 'Street 15', '1945-02-17', 'Lingayen, Pangasinan', 'Married', 'Female', '0915565098', 'henderson.hermann87@email.com', 'Other', 'Filipino', 'Ilocano', '9766123951', '797-252-145', '87-243616238-1', 'Church Senior Group', '947987491', 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Erick', NULL, 'Hermann', 'Caterina', 'Isadore', NULL, 'Morissette', 'Candida', 'Coty', 'Jr.', 'Graduate School', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Relatives\\\",\\\"Alone\\\",\\\"Children\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Pension\\\",\\\"Investments\\\",\\\"Business\\\"]\"', NULL, NULL, '17406', NULL, 'O+', 'Mental Disability', '\"[]\"', '\"[\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Glasses\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Loneliness\\\"]\"', '\"[\\\"Bathing\\\"]\"', 'Vitamins', NULL, 'Emergency Only', 'Yes', NULL, 'Family Support', 'Yes', 'Heart Disease', 'Yes', NULL, NULL, NULL),
(88, '2025-088', 'Mohr', 'Kellen', 'Arnoldo', 'Sr.', 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Zone 10, Purok 3', 'Street 18', '1948-03-01', 'Lingayen, Pangasinan', 'Married', 'Female', '0902959192', 'kellen.mohr88@email.com', 'Other', 'Chinese', 'Cebuano', '4727525091', NULL, '05-297780663-4', 'Senior Citizens Association', '258868563', 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, 'Jr.', 'Mohr', 'Trevion', 'Travon', NULL, 'Simonis', 'Mafalda', 'Terry', 'Jr.', 'Graduate School', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Children\\\"]\"', '\"[\\\"Fair\\\",\\\"Good\\\"]\"', '\"[\\\"Family Support\\\",\\\"Savings\\\"]\"', NULL, NULL, '45490', NULL, 'B-', NULL, '\"[]\"', '\"[]\"', '\"[\\\"None\\\"]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[]\"', NULL, 'Monthly', NULL, 'Yes', '7409', NULL, 'Yes', 'Diabetes', 'No', 'Hearing Impairment', NULL, NULL),
(89, '2025-089', 'Runolfsdottir', 'Americo', 'Talia', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 7, Purok 5', 'Street 44', '1943-01-09', 'Lingayen, Pangasinan', 'Others', 'Male', '0979609526', 'americo.runolfsdottir89@email.com', 'Buddhist', 'Chinese', 'Ilocano', '3590924129', '903-141-740', '06-278561189-8', 'Senior Citizens Association', '483001968', 0, NULL, 1, 1, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-08 12:55:51', NULL, NULL, NULL, NULL, 'Jr.', 'Runolfsdottir', 'Sigurd', 'Greyson', NULL, 'Boyer', 'Eryn', 'Tremaine', NULL, 'No Formal Education', NULL, 'Cooking', NULL, 'With Family', '\"[\\\"Relatives\\\"]\"', '\"[\\\"Fair\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '15909', NULL, 'B+', NULL, '\"[]\"', '\"[]\"', '\"[\\\"None\\\",\\\"Blindness\\\"]\"', '\"[]\"', '\"[\\\"Depression\\\",\\\"Good Mental Health\\\"]\"', '\"[\\\"Climbing Stairs\\\",\\\"Eating\\\",\\\"Bathing\\\"]\"', 'Diabetes Medicine', NULL, NULL, 'No', NULL, NULL, 'Yes', NULL, 'Yes', NULL, NULL, NULL),
(90, '2025-090', 'Conroy', 'Arlie', 'Buddy', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Zone 8, Purok 3', 'Street 42', '1955-10-30', 'Lingayen, Pangasinan', 'Separated', 'Female', '0938916179', 'arlie.conroy90@email.com', 'Islam', 'Filipino', 'Filipino', '7600963687', '713-331-401', '53-975742914-4', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Arely', NULL, NULL, 'Conroy', 'Kaycee', 'Brielle', 'II', 'Watsica', 'Antwon', 'Xzavier', NULL, 'High School', NULL, 'Sewing', NULL, 'Independent', '\"[\\\"Spouse\\\",\\\"Grandchildren\\\",\\\"Relatives\\\"]\"', '\"[\\\"Needs Improvement\\\",\\\"Good\\\"]\"', '\"[\\\"Family Support\\\",\\\"Pension\\\"]\"', NULL, NULL, '42001', NULL, 'B+', NULL, '\"[\\\"Cancer\\\",\\\"Arthritis\\\"]\"', '\"[]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Deafness\\\"]\"', '\"[\\\"Good Mental Health\\\"]\"', '\"[\\\"Dressing\\\"]\"', 'Diabetes Medicine', 'Annually', 'As Needed', 'No', '23257', NULL, 'Yes', 'Arthritis', 'Yes', 'Visual Impairment', NULL, NULL),
(91, '2025-091', 'Trantow', 'Jarrod', 'Adelbert', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 4, Purok 4', 'Street 38', '1959-10-18', 'Lingayen, Pangasinan', 'Others', 'Male', '0991201733', 'jarrod.trantow91@email.com', 'Other', 'Other', 'English', '6586385307', NULL, '08-531116289-9', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Melyssa', NULL, NULL, 'Trantow', 'Hermina', 'David', NULL, 'Homenick', 'Makayla', 'Reanna', NULL, 'Elementary', NULL, NULL, NULL, 'With Family', '\"[\\\"Relatives\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Savings\\\"]\"', NULL, NULL, '41613', NULL, 'O+', NULL, '\"[]\"', '\"[\\\"Dentures\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Deafness\\\"]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"None\\\",\\\"Bathing\\\"]\"', 'None', NULL, 'Regular', 'Yes', NULL, 'Family Support', 'No', NULL, 'Yes', 'Visual Impairment', NULL, NULL),
(92, '2025-092', 'Balistreri', 'Halle', 'Vivien', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Zone 9, Purok 2', 'Street 48', '1946-10-30', 'Lingayen, Pangasinan', 'Widowed', 'Male', '0944062232', 'halle.balistreri92@email.com', 'Other', 'Spanish', 'English', '5096947545', '320-202-393', '73-937288414-0', 'Senior Citizens Association', NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Balistreri', 'Haven', 'Raleigh', NULL, 'Harris', 'Lonny', 'Katelynn', 'Jr.', 'No Formal Education', NULL, 'Crafting', NULL, 'Assisted Living', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Good\\\",\\\"Fair\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '49288', NULL, 'A+', NULL, '\"[\\\"Arthritis\\\",\\\"Heart Disease\\\",\\\"None\\\"]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Good Mental Health\\\",\\\"Anxiety\\\"]\"', '\"[\\\"None\\\",\\\"Eating\\\",\\\"Dressing\\\"]\"', NULL, NULL, NULL, 'Yes', '38461', 'Pension', 'No', 'Hypertension', 'No', NULL, NULL, NULL);
INSERT INTO `seniors` (`id`, `osca_id`, `last_name`, `first_name`, `middle_name`, `name_extension`, `region`, `province`, `city`, `barangay`, `residence`, `street`, `date_of_birth`, `birth_place`, `marital_status`, `sex`, `contact_number`, `email`, `religion`, `ethnic_origin`, `language`, `gsis_sss`, `tin`, `philhealth`, `sc_association`, `other_govt_id`, `can_travel`, `employment`, `has_pension`, `has_app_account`, `pension_source`, `ctc_number`, `status`, `photo_path`, `created_at`, `updated_at`, `deleted_at`, `spouse_last_name`, `spouse_first_name`, `spouse_middle_name`, `spouse_extension`, `father_last_name`, `father_first_name`, `father_middle_name`, `father_extension`, `mother_last_name`, `mother_first_name`, `mother_middle_name`, `mother_extension`, `education_level`, `skills`, `shared_skills`, `community_activities`, `living_condition_primary`, `living_with`, `household_condition`, `source_of_income`, `real_assets`, `personal_assets`, `monthly_income`, `problems_needs`, `blood_type`, `physical_disability`, `health_problems`, `dental_concern`, `visual_concern`, `hearing_condition`, `social_emotional`, `area_difficulty`, `maintenance_medicines`, `scheduled_checkup`, `checkup_frequency`, `permanent_income`, `income_amount`, `income_source`, `existing_illness`, `illness_specify`, `with_disability`, `disability_specify`, `certification`, `user_id`) VALUES
(93, '2025-093', 'Marks', 'Eden', 'Jazmin', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 7, Purok 3', 'Street 26', '1935-03-02', 'Lingayen, Pangasinan', 'Separated', 'Male', '0953214410', 'eden.marks93@email.com', 'Buddhist', 'American', 'Ilocano', NULL, NULL, '60-463463689-6', NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Marks', 'Yolanda', 'Monte', NULL, 'Rice', 'Edward', 'Aisha', NULL, 'High School', NULL, 'Cooking', NULL, 'With Family', '\"[\\\"Alone\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Pension\\\",\\\"Business\\\",\\\"Family Support\\\"]\"', NULL, NULL, '42942', NULL, 'B-', NULL, '\"[\\\"None\\\",\\\"Cancer\\\",\\\"Hypertension\\\"]\"', '\"[]\"', '\"[\\\"Cataracts\\\",\\\"Blindness\\\"]\"', '\"[\\\"Deafness\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\"]\"', '\"[\\\"None\\\"]\"', 'None', 'Bi-annually', 'Emergency Only', 'No', NULL, 'Family Support', 'No', NULL, 'Yes', 'Mobility Issues', NULL, NULL),
(94, '2025-094', 'Wolff', 'Arlie', 'Rolando', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Zone 7, Purok 2', 'Street 1', '1953-02-10', 'Lingayen, Pangasinan', 'Single', 'Male', '0992573610', 'arlie.wolff94@email.com', 'Islam', 'Spanish', 'Cebuano', '9000326169', '128-970-125', '99-680165232-6', 'Barangay Senior Group', NULL, 0, NULL, 0, 0, NULL, NULL, 'deceased', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, 'Zemlak', NULL, NULL, NULL, 'Wolff', 'Lorena', 'Morton', NULL, 'Kunde', 'Arjun', 'Otis', 'III', 'Vocational', NULL, NULL, NULL, 'Assisted Living', '\"[\\\"Alone\\\"]\"', '\"[\\\"Poor\\\",\\\"Fair\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Pension\\\"]\"', NULL, NULL, '18595', NULL, 'AB-', NULL, '\"[\\\"Cancer\\\",\\\"Diabetes\\\",\\\"Heart Disease\\\"]\"', '\"[\\\"Missing Teeth\\\",\\\"None\\\"]\"', '\"[\\\"Glasses\\\",\\\"Cataracts\\\"]\"', '\"[]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', 'Blood Pressure Medicine', 'Quarterly', 'Emergency Only', 'Yes', '20393', NULL, 'No', NULL, 'No', NULL, NULL, NULL),
(95, '2025-095', 'Christiansen', 'Jordon', 'Stephany', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 1, Purok 4', 'Street 3', '1935-03-10', 'Lingayen, Pangasinan', 'Others', 'Female', '0936299766', 'jordon.christiansen95@email.com', 'Protestant', 'Filipino', 'Filipino', '0638388886', '301-707-431', '05-789014920-6', NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Christiansen', 'Lavinia', 'Abigayle', NULL, 'Murazik', 'Hollie', 'Luna', NULL, 'College', NULL, 'Gardening', NULL, 'Independent', '\"[\\\"Children\\\",\\\"Alone\\\",\\\"Grandchildren\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Savings\\\",\\\"Government Assistance\\\",\\\"Investments\\\"]\"', NULL, NULL, '43473', NULL, 'AB+', NULL, '\"[\\\"None\\\",\\\"Arthritis\\\"]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[\\\"Blindness\\\",\\\"Glasses\\\"]\"', '\"[\\\"None\\\"]\"', '\"[\\\"Good Mental Health\\\",\\\"Anxiety\\\"]\"', '\"[\\\"Walking\\\",\\\"None\\\",\\\"Eating\\\"]\"', NULL, NULL, 'Emergency Only', 'Yes', '41274', 'Pension', 'Yes', NULL, 'Yes', 'Hearing Impairment', NULL, NULL),
(96, '2025-096', 'Beatty', 'Sharon', 'Mina', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Zone 7, Purok 4', 'Street 29', '1965-09-12', 'Lingayen, Pangasinan', 'Married', 'Female', '0962100910', 'sharon.beatty96@email.com', 'Islam', 'Chinese', 'Cebuano', '0310236879', '148-271-534', '22-453604158-3', 'Senior Citizens Association', NULL, 0, 'Part-time', 0, 1, NULL, NULL, 'active', 'senior-photos/ET0FRjX3qifQw9ERlvGJblPvUByV5vFg8tCQrH0J.jpg', '2025-09-18 21:28:14', '2025-12-01 17:45:03', NULL, 'Kreiger', 'Lilyan', 'Letha', NULL, 'Beatty', 'Cristopher', 'Manuel', NULL, 'Walsh', 'Mattie', 'Jaylen', NULL, 'Graduate School', '[]', 'Music', '[]', 'Independent', '[]', '[]', '[]', '[]', '[]', '31120', '[]', 'AB+', NULL, '[]', '[]', '[]', '[]', '[]', '[]', 'Vitamins', NULL, NULL, 'No', '28742', NULL, 'No', NULL, 'No', 'Hearing Impairment', 1, NULL),
(97, '2025-097', 'Yost', 'Tyson', 'Johann', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-east', 'Zone 5, Purok 3', 'Street 33', '1955-01-12', 'Lingayen, Pangasinan', 'Single', 'Female', '0973943532', 'tyson.yost97@email.com', 'Catholic', 'Other', 'Ilocano', NULL, '953-637-037', '05-782802685-6', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, 'Foster', 'Merlin', NULL, 'Yost', 'Josefina', 'Giovani', NULL, 'Sporer', 'Brandy', 'Jerod', NULL, 'No Formal Education', NULL, 'Sewing', NULL, 'Assisted Living', '\"[\\\"Children\\\"]\"', '\"[\\\"Poor\\\",\\\"Good\\\"]\"', '\"[\\\"Business\\\"]\"', NULL, NULL, '33224', NULL, 'A-', NULL, '\"[]\"', '\"[\\\"Gum Problems\\\",\\\"Missing Teeth\\\"]\"', '\"[]\"', '\"[\\\"Deafness\\\",\\\"Hearing Aid\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Depression\\\"]\"', '\"[]\"', 'None', 'Quarterly', NULL, 'No', '16430', 'Pension', 'No', 'Cancer', 'Yes', NULL, NULL, NULL),
(98, '2025-098', 'Schuppe', 'Sarah', 'Sydnee', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Zone 6, Purok 1', 'Street 15', '1940-09-30', 'Lingayen, Pangasinan', 'Others', 'Male', '0983277274', 'sarah.schuppe98@email.com', 'Protestant', 'Other', 'Tagalog', '8327136675', '719-118-724', NULL, 'Church Senior Group', '703598357', 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, 'Elva', NULL, 'Schuppe', 'Seamus', 'Kathleen', NULL, 'Daugherty', 'Felix', 'Caterina', NULL, 'Elementary', NULL, NULL, NULL, 'Independent', '\"[\\\"Grandchildren\\\"]\"', '\"[\\\"Fair\\\",\\\"Needs Improvement\\\"]\"', '\"[\\\"Pension\\\"]\"', NULL, NULL, '30051', NULL, 'O+', NULL, '\"[]\"', '\"[\\\"Missing Teeth\\\"]\"', '\"[]\"', '\"[]\"', '\"[\\\"Depression\\\",\\\"Anxiety\\\"]\"', '\"[\\\"Climbing Stairs\\\"]\"', NULL, 'Quarterly', NULL, 'Yes', '18016', 'Government Assistance', 'Yes', 'Heart Disease', 'No', 'Hearing Impairment', NULL, NULL),
(99, '2025-099', 'Raynor', 'Darrick', 'Mohammed', NULL, 'region-i', 'pangasinan', 'lingayen', 'domalandan-east', 'Zone 1, Purok 4', 'Street 38', '1939-07-08', 'Lingayen, Pangasinan', 'Single', 'Male', '0905103447', 'darrick.raynor99@email.com', 'Protestant', 'American', 'Cebuano', '2379461235', NULL, '33-416718141-4', NULL, '827887107', 1, 'Self-employed', 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-10-02 11:23:53', NULL, 'Walsh', 'Evert', NULL, NULL, 'Raynor', 'Albin', 'Vita', NULL, 'Fay', 'Glen', 'Alia', NULL, 'No Formal Education', NULL, 'Teaching', NULL, 'With Family', '\"[\\\"Alone\\\",\\\"Grandchildren\\\",\\\"Children\\\"]\"', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Government Assistance\\\",\\\"Savings\\\"]\"', NULL, NULL, '28725', NULL, 'AB+', NULL, '\"[\\\"Arthritis\\\",\\\"Cancer\\\"]\"', '\"[]\"', '\"[\\\"None\\\"]\"', '\"[\\\"None\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Depression\\\"]\"', '\"[\\\"None\\\",\\\"Bathing\\\"]\"', 'Blood Pressure Medicine', NULL, 'As Needed', 'Yes', NULL, NULL, NULL, 'Diabetes', NULL, 'Visual Impairment', NULL, NULL),
(100, '2025-100', 'Luettgen', 'Bud', 'Verner', NULL, 'region-i', 'pangasinan', 'lingayen', 'domalandan-east', 'Zone 7, Purok 5', 'Street 42', '1953-01-21', 'Lingayen, Pangasinan', 'Others', 'Female', '0972929468', 'bud.luettgen100@email.com', 'Protestant', 'Filipino', 'Tagalog', '6940585840', '071-582-893', '79-119120342-1', 'Barangay Senior Group', NULL, 1, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-09-18 21:28:14', '2025-09-26 09:13:53', NULL, NULL, NULL, NULL, NULL, 'Luettgen', 'Gardner', 'Ludie', NULL, 'Kunde', 'Arvid', 'Leopold', NULL, 'College', NULL, 'Art', NULL, 'With Family', '[\"living alone\"]', '\"[\\\"Needs Improvement\\\"]\"', '\"[\\\"Investments\\\"]\"', NULL, NULL, '9865', NULL, 'B-', NULL, '\"[\\\"Diabetes\\\"]\"', '\"[\\\"Gum Problems\\\"]\"', '\"[\\\"Glasses\\\"]\"', '\"[\\\"Hearing Aid\\\",\\\"Partial Hearing Loss\\\"]\"', '\"[\\\"Anxiety\\\",\\\"Good Mental Health\\\"]\"', '\"[\\\"Walking\\\",\\\"Bathing\\\"]\"', NULL, 'Monthly', 'As Needed', 'Yes', '2125123', 'Business', 'no', NULL, 'no', NULL, NULL, NULL),
(102, '2025-2674', 'Khan', 'Ginger', 'Lahh', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'capandanan', 'Sitio Cavite', NULL, '1959-05-30', 'Lingayen, Pangasinan', 'Married', 'Female', '09283492324', 'ging@gmail.com', NULL, NULL, 'Filipino', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 1, NULL, NULL, 'deceased', NULL, '2025-09-19 01:13:15', '2025-09-19 01:13:37', '2025-09-19 01:13:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'A+', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(104, '2025-123324', 'Domengo', 'Robert', 'Cruz', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malawa', 'Purok 3', 'Street 40', '1950-12-30', 'Lingayen, Pangasinan', 'Married', 'Male', '0989983264', 'roberto@gmail.com', NULL, 'Filipino', 'Filipino, English', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 1, NULL, NULL, 'active', 'senior-photos/wlyTxXldg5YJkfKyIvIIeC8ytoooZg3CRuWRDq5g.jpg', '2025-09-21 23:34:29', '2025-12-01 17:18:47', NULL, 'wfuerhfuehpirlfhe', 'Jfhjwefhuewvfvwf', 'hdsbchbafb;wfjewf', 'Jr', 'asfcsv', 'ewrwkrokogwgw', 'faerfreagae', 'Jr', 'cdsjiovfehifhearfnkrae', 'vdsfajviodfjajver', 'reajfnornf', 'sr', 'College Graduate', '[\"Chef\\/Cook\",\"Chef\\/Cook\"]', 'fwkefipaewji0foh34ifnkledncuidfiovnda,mnjoewhioafh[aeh;fnelrngkpergbpoeltmbnorakiyh-0rtkhrt[hp[hj0pbpfdkljbidjg0hrgnerkrngo', '[\"Medical\",\"Medical\"]', 'Living with', '[\"Grand Children\",\"Relatives\"]', '[\"Longing for independent living quiet atmosphere\"]', '[\"Own Pension\",\"Savings\"]', '[]', '[]', '0', '[\"Lack of income \\/ resources\",\"Livelihood Opportunities\"]', 'AB+', 'Mobility issues', '[\"Arthritis \\/ Gout\",\"Diabetes\"]', '[\"Needs Dental Care\"]', '[\"Needs eye care\"]', '[\"Aural impairment\"]', '[]', '[]', NULL, 'Yes', 'Semi-annually', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(105, '2025-333', 'Ramos', 'Warlito', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'quibaol', 'Not specified', NULL, '1948-11-05', 'Lingayen Pangasinan', 'Married', 'Male', '09455478269', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 11:21:59', '2025-12-04 11:21:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(106, '2025-334', 'Casaclang', 'John', 'Cruz', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'tonton', 'Not specified', NULL, '1951-09-09', 'Lingayen Pangasinan', 'Married', 'Male', '09246728282', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 11:44:32', '2025-12-04 11:44:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(107, '2025-335', 'Lomibao', 'Abraham', 'Casipit', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'aliwekwek', 'Not specified', NULL, '1960-03-27', 'Lingayen Pangasinan', 'Single', 'Male', '09837283723', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 11:52:03', '2025-12-04 11:52:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(108, '2025-336', 'Santos', 'Nieves', 'Malicdem', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'baay', 'Not specified', NULL, '1959-07-17', 'Lingayen Pangasinan', 'Widowed', 'Female', '09232534626', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 11:55:27', '2025-12-04 11:55:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(109, '2025-337', 'Santiago', 'Shiegfried', 'Ocampo', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'balangobong', 'Not specified', NULL, '1965-01-13', 'Lingayen Pangasinan', 'Single', 'Male', '09317361711', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 11:59:47', '2025-12-04 11:59:47', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(110, '2025-338', 'Sison', 'Teofilo', 'Fernandez', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'balococ', 'Not specified', NULL, '1958-04-19', 'Lingayen Pangasinan', 'Married', 'Male', '09374364723', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:04:09', '2025-12-04 12:04:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(111, '2025-339', 'Manuel', 'Rudy', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'basing', 'Not specified', NULL, '1961-06-22', 'Lingayen Pangasinan', 'Separated', 'Male', '09724262388', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:08:05', '2025-12-04 12:08:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(112, '2025-340', 'Austria', 'Adelaida', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'sabangan', 'Not specified', NULL, '1943-10-31', 'Lingayen Pangasinan', 'Widowed', 'Female', '09745638335', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:14:41', '2025-12-04 12:14:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(113, '2025-341', 'Arias', 'Frederico', 'Santos', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'tumbar', 'Not specified', NULL, '1940-02-25', 'Lingayen Pangasinan', 'Separated', 'Male', '09546352724', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:17:54', '2025-12-04 12:17:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(114, '2025-342', 'Ramos', 'Lambino', 'Ortiz', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'wawa', 'Not specified', NULL, '1960-11-08', 'Lingayen Pangasinan', 'Married', 'Male', '09274346273', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:22:09', '2025-12-04 12:22:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(115, '2025-343', 'De Guzman', 'Lilio', 'Santiago', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-west', 'Not specified', NULL, '1957-07-30', 'Lingayen Pangasinan', 'Married', 'Male', '09546435452', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:26:11', '2025-12-04 12:26:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(116, '2025-344', 'Vila', 'Delia', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'malimpuec', 'Not specified', NULL, '1963-04-01', 'Lingayen Pangasinan', 'Separated', 'Female', '09766352673', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:38:51', '2025-12-04 12:38:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(117, '2025-345', 'Lopez', 'Ragna', 'Cortez', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'talogtog', 'Not specified', NULL, '1951-10-31', 'Lingayen Pangasinan', 'Married', 'Male', '09642562323', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:43:07', '2025-12-04 12:43:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(118, '2025-346', 'Rosario', 'Jaime', 'Castro', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'bantayan', 'Not specified', NULL, '1955-05-26', 'Lingayen Pangasinan', 'Married', 'Male', '09973252832', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:45:24', '2025-12-04 12:45:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(119, '2025-347', 'De Leon', 'Benidicto', 'Dela Cruz', 'Sr.', 'Region I', 'Pangasinan', 'Lingayen', 'rosario', 'Not specified', NULL, '1962-05-20', 'Lingayen Pangasinan', 'Separated', 'Male', '09162883828', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:52:45', '2025-12-04 12:52:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(120, '2025-348', 'Jimenez', 'Delia', 'Duterte', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'poblacion', 'Not specified', NULL, '1961-08-04', 'Lingayen Pangasinan', 'Married', 'Female', '09426472424', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 12:57:11', '2025-12-04 12:57:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(121, '2025-349', 'Alvendia', 'Virgilio', 'Corpus', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-north', 'Not specified', NULL, '1949-06-29', 'Lingayen Pangasinan', 'Single', 'Male', '09854725312', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:00:11', '2025-12-04 13:00:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(122, '2025-350', 'Jimenez', 'Felicitas', 'Baltazar', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'pangapisan-sur', 'Not specified', NULL, '1940-06-06', 'Lingayen Pangasinan', 'Widowed', 'Female', '09994734283', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:03:42', '2025-12-04 13:03:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(123, '2025-351', 'Padlan', 'Myrna', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'matalava', 'Not specified', NULL, '1954-03-19', 'Lingayen Pangasinan', 'Single', 'Female', '09674829323', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:08:16', '2025-12-04 13:08:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(124, '2025-352', 'Cruz', 'Carmelito', 'Estrada', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'naguelguel', 'Not specified', NULL, '1958-11-12', 'Lingayen Pangasinan', 'Married', 'Female', '09263828321', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:11:18', '2025-12-04 13:11:18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(125, '2025-353', 'Ferrer', 'Romulo', 'Ocampo', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'namolan', 'Not specified', NULL, '1957-02-07', 'Lingayen Pangasinan', 'Single', 'Male', '09732242428', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:14:23', '2025-12-04 13:14:23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(126, '2025-354', 'Sison', 'Maria Teresa', 'Villanueva', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Not specified', NULL, '1965-02-11', 'Lingayen Pangasinan', 'Single', 'Female', '09131413131', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:17:30', '2025-12-04 13:17:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(127, '2025-355', 'Lobien', 'Edith', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'capandanan', 'Not specified', NULL, '1958-12-03', 'Lingayen Pangasinan', 'Separated', 'Female', '09473822323', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:19:32', '2025-12-04 13:19:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(128, '2025-356', 'Salinas', 'Avelino', 'Jacinto', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'lasip', '143', 'Avelino St.', '1959-04-07', 'Lingayen Pangasinan', 'Separated', 'Male', '09734535472', 'noemail@example.com', NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:24:13', '2025-12-04 15:11:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '250000', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, 'No', NULL, NULL, 'no', NULL, 'no', NULL, 1, NULL),
(129, '2025-357', 'Toringan', 'Teodora', 'Abalos', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'maniboc', 'Not specified', NULL, '1940-09-24', 'Lingayen Pangasinan', 'Widowed', 'Female', '09987643272', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:26:38', '2025-12-04 13:26:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(130, '2025-358', 'Albarida', 'Teofilo', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-center', 'Not specified', NULL, '1945-07-03', 'Lingayen Pangasinan', 'Widowed', 'Male', '09237622748', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:28:28', '2025-12-04 13:28:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(131, '2025-359', 'Quimson', 'Mario', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-west', 'Not specified', NULL, '1957-03-06', 'Lingayen Pangasinan', 'Married', 'Male', '09862452442', 'noemail@example.com', NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:30:04', '2025-12-04 14:14:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[\"living with children or relatives\"]', '[]', '[]', '[]', '[]', '20000', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, 'No', NULL, NULL, 'no', NULL, 'no', NULL, 0, NULL),
(133, '2025-361', 'Resultay', 'Nelia', NULL, NULL, 'Region I', 'Pangasinan', 'Lingayen', 'libsong-east', 'Not specified', NULL, '1952-01-29', 'Lingayen Pangasinan', 'Separated', 'Female', '09573284242', NULL, NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 0, NULL, NULL, 'active', NULL, '2025-12-04 13:33:40', '2025-12-04 13:33:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '0', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(134, '2025-362', 'Mendoza', 'Maria', 'Lopez', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'dulag', 'Not specified', NULL, '1953-07-30', 'Lingayen Pangasinan', 'Married', 'Female', '09315625457', 'noemail@example.com', NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL, 'active', 'senior-photos/K72M2RDdQBSoA8FBoRWw7DgKBaqcXoujmwX7xA1j.png', '2025-12-04 13:35:33', '2026-01-13 00:04:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '15000', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(135, '2025-363', 'Tandoc', 'Gerardo', 'Gomez', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'domalandan-east', 'Not specified', NULL, '1960-03-17', 'Lingayen Pangasinan', 'Married', 'Male', '09984634232', 'noemail@example.com', NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 1, NULL, NULL, 'active', NULL, '2025-12-04 13:37:24', '2025-12-05 02:24:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[]', '[]', '[]', '[]', '[]', '10000', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(136, '2025-364', 'Basilio', 'Virgillo', 'Bautista', NULL, 'Region I', 'Pangasinan', 'Lingayen', 'dorongan', 'Not specified', NULL, '1955-08-25', 'Lingayen Pangasinan', 'Single', 'Male', '09232425253', 'noemail@example.com', NULL, NULL, 'Not specified', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL, 'active', 'senior-photos/cot3yKk0fkzbOA8H6hi62bRtXUs7smcSenMfGu8n.png', '2025-12-04 13:40:03', '2025-12-04 15:09:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[]', NULL, '[]', NULL, '[\"living with children or relatives\"]', '[]', '[]', '[]', '[]', '5000000', '[]', NULL, NULL, '[]', '[]', '[]', '[]', '[]', '[]', NULL, NULL, NULL, 'No', NULL, NULL, 'no', NULL, 'no', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `senior_id_applications`
--

CREATE TABLE `senior_id_applications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `application_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `date_of_birth` date NOT NULL,
  `birth_place` varchar(255) NOT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `civil_status` varchar(50) NOT NULL,
  `annual_income` decimal(15,2) NOT NULL,
  `pension_source` varchar(255) DEFAULT NULL,
  `ctc_number` varchar(50) DEFAULT NULL,
  `place_of_issuance` varchar(255) DEFAULT NULL,
  `date_of_application` date DEFAULT NULL,
  `date_of_issued` date DEFAULT NULL,
  `date_of_received` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `senior_id_applications`
--

INSERT INTO `senior_id_applications` (`id`, `application_id`, `full_name`, `address`, `gender`, `date_of_birth`, `birth_place`, `occupation`, `civil_status`, `annual_income`, `pension_source`, `ctc_number`, `place_of_issuance`, `date_of_application`, `date_of_issued`, `date_of_received`, `created_at`, `updated_at`) VALUES
(1, 103, 'CRONA, JON J.', 'libsong-west', 'Female', '1932-08-22', 'Lingayen, Pangasinan', NULL, 'Married', 2220.00, 'SSS', '124123', 'Municipality of Lingayen, Pangasinan', '2025-09-19', '2025-09-19', '2025-09-19', '2025-09-19 01:19:58', '2025-09-21 03:40:29'),
(2, 105, 'ABSHIRE, DEDRICK T. II', 'libsong-west', 'Male', '1959-06-27', 'Lingayen, Pangasinan', NULL, 'Separated', 1000.00, 'SSS', NULL, 'Municipality of Lingayen, Pangasinan', '2025-09-22', '2025-09-22', '2025-09-22', '2025-09-21 22:27:14', '2025-09-21 22:27:14'),
(3, 106, 'UZUMAKI, MINATO S. Sr.', 'aliwekwek', 'Male', '1956-09-09', 'Lingayen, Pangasinan', NULL, 'Single', 5000000.00, 'SSS', NULL, 'Municipality of Lingayen, Pangasinan', '2025-09-22', '2025-09-22', '2025-09-22', '2025-09-21 22:30:49', '2025-09-21 22:30:49'),
(4, 107, 'HAAG, EVALYN A.', 'malawa', 'Female', '1933-03-16', 'Lingayen, Pangasinan', NULL, 'Widowed', 9000000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-09-22', '2025-09-22', '2025-09-22', '2025-09-21 22:35:48', '2025-09-21 22:35:48'),
(5, 108, 'BOSCO, CORY B.', 'maniboc', 'Male', '1935-10-20', 'Lingayen, Pangasinan', NULL, 'Widowed', 600000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-09-22', '2025-09-22', '2025-09-22', '2025-09-21 22:37:41', '2025-09-21 22:37:41'),
(6, 109, 'HETTINGER, KEELEY S.', 'domalandan-east', 'Female', '1947-02-22', 'Lingayen, Pangasinan', NULL, 'Single', 100000.00, 'SSS', '12212121312', 'Municipality of Lingayen, Pangasinan', '2025-10-01', '2025-10-01', '2025-10-01', '2025-10-01 11:31:21', '2025-10-01 11:31:21'),
(7, 110, 'ABERNATHY, THEODORA A.', 'malawa', 'Female', '1931-09-15', 'Lingayen, Pangasinan', NULL, 'Others', 479256.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-10-08', '2025-10-08', '2025-10-08', '2025-10-08 07:28:04', '2025-10-08 07:28:04'),
(8, 112, 'BODE, FELICITY G.', 'malawa', 'Female', '1935-06-01', 'Lingayen, Pangasinan', NULL, 'Widowed', 344352.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-03', '2025-12-03', '2025-12-03', '2025-12-03 13:37:47', '2025-12-03 13:37:47'),
(9, 113, 'CHRISTIANSEN, JORDON S.', 'maniboc', 'Female', '1935-03-10', 'Lingayen, Pangasinan', NULL, 'Others', 521676.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-03', '2025-12-03', '2025-12-03', '2025-12-03 13:45:09', '2025-12-03 13:45:09'),
(10, 117, 'DE GUZMAN, LILIO S.', 'libsong-west', 'Male', '1957-07-30', 'Lingayen Pangasinan', NULL, 'Married', 60000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 13:51:36', '2025-12-04 13:51:36'),
(11, 118, 'ALBARIDA, TEOFILO', 'domalandan-center', 'Male', '1945-07-03', 'Lingayen Pangasinan', NULL, 'Widowed', 84000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 13:52:51', '2025-12-04 13:52:51'),
(12, 119, 'CASACLANG, JOHN C.', 'tonton', 'Male', '1951-09-09', 'Lingayen Pangasinan', NULL, 'Married', 0.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 13:54:38', '2025-12-05 02:25:03'),
(14, 122, 'BASILIO, VIRGILLO B.', 'dorongan', 'Male', '1955-08-25', 'Lingayen Pangasinan', NULL, 'Single', 60000000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 14:05:39', '2025-12-04 14:05:39'),
(15, 126, 'QUIMSON, MARIO', 'domalandan-west', 'Male', '1957-03-06', 'Lingayen Pangasinan', NULL, 'Married', 240000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 14:15:32', '2025-12-04 14:15:32'),
(16, 127, 'JIMENEZ, FELICITAS B.', 'pangapisan-sur', 'Female', '1940-06-06', 'Lingayen Pangasinan', NULL, 'Widowed', 150000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 14:18:37', '2025-12-04 14:18:37'),
(17, 128, 'SALINAS, AVELINO J.', 'lasip', 'Male', '1959-04-07', 'Lingayen Pangasinan', NULL, 'Separated', 3000000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 14:22:05', '2025-12-04 15:11:39'),
(18, 129, 'ZIEME, FLO G.', 'libsong-east', 'Male', '1941-08-17', 'Lingayen, Pangasinan', NULL, 'Separated', 41100.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 14:28:20', '2025-12-04 14:28:20'),
(19, 130, 'MENDOZA, MARIA L.', 'dulag', 'Female', '1953-07-30', 'Lingayen Pangasinan', NULL, 'Married', 180000.00, NULL, NULL, 'Municipality of Lingayen, Pangasinan', '2025-12-04', '2025-12-04', '2025-12-04', '2025-12-04 14:29:15', '2025-12-05 02:13:53');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('03TBZPKzQg80cZBaVM8ZWADaRjojmlaxNVgJzG9Q', NULL, '203.23.179.24', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNHBvaEF1OGJnbGk3SHJ2TGdMUWpHc0pWSzFvZDhweWl6TzVYZ090ViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768785850),
('1eUQv7K7IOJq8I5OMsR9QLYOhXHOPU54nxZCHo9p', NULL, '142.93.69.100', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmJFajRIaWxwRWxVcEFJWVlITW5PY25ocVdnTmNLZnB2a05ZSEtBViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768670511),
('1KRMOjSRQd4Rbpgft6uNNDS0tWLJ0wPsbjrN092x', NULL, '138.124.66.79', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:146.0) Gecko/20100101 Firefox/146.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYlRCd1FyWEt3azVJd3lMZDhCeE16djNtNDlRVmlPVnd1RHQ3NEh5QSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768533425),
('2SM8ewfYwMmgfQ8eiV06rUqU2gOPvSkjwAvfkRVy', NULL, '5.133.192.166', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXNrdVdDa2w4OHZRQlVsVExNaGt4SXFzWlNrbDZvRmFJd250ak45MCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768680567),
('35l7ksHIumzreLknZTUqvDxZ5WQVht3cvQwKr2aA', NULL, '49.151.201.204', 'Dart/3.9 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWljR2tHMGhNTTBxMTQ1V3hzT1VLc1c2UGxZMER3d21HWG1PeTA1eCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768264076),
('5qF7PHarjd9ORb5d9nTkqYco52Ec97KwRqqKTDva', NULL, '152.32.173.219', 'Mozilla/5.0 (Android 8; Mobile; rv:135.0.0) Gecko/135.0.0 Firefox/135.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN3hEZm02MUxORjV5bWdUN2dTalBnanh5UmFNYWN0cDFzS3BEZGVYbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768609899),
('6OfZZlS5WPjASTtDNI1EAyN0wSoDpp7QFtXiP8P9', NULL, '46.138.250.165', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZnhBNFVCWGdaWUI4Y2lEeE1hR1RhdHZZU1hTZ2JhOVZZdUtzdHVHSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768304082),
('70z7ErKoeMc3E5jM6JsqNBnILcmKxqW76lX3BkEh', NULL, '51.195.215.12', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic21oSVdQQnBnTXBodzlFd0JiTmtKSmZpTVdOMEFQRmVTN1JrNVk1MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768519820),
('95XKTcMd8lNlr3hALy5LwFgd6VcJinwKzmO4KlnC', NULL, '66.249.74.32', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2FUbk1rbExTeG5maU04RTNUeHRhN3ZIaHdBdE5oWThHSzY0eGdmMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vd3d3LmVsZGVyYS1vc2NhLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768403211),
('9Co7CUCGfsnpKU2BSqVqUwI5pZatpmLex75MVwoI', NULL, '2600:3c06::f03c:95ff:feea:809f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWllkWTJsVHJqZ255dDJSSTRJVFNFNXg3UUJKZ0hTRURtWU1yV2w3VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768488737),
('a6kTffjOxhAwhzz6yayVI8YOcXFDz1fWWP6Ah0gj', NULL, '47.237.25.157', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieTNkMkRqVE42QlpLbEtKeUM2VGRvem9Yd21hbkJHbGdQeUFXZk53bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768579902),
('ABXci1eTgvIiA9fPeBAa1cK4L2b3NeAToEBQB9Ux', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicERkNDAyTHlQSERmNWp1STBMT3hwcmc5VTl2RFBydHI5Y09jSndPbiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768448914),
('aUxUl66FAfHBMw1wcILCG0MI0BoR6TeJZyMBesL7', NULL, '112.198.113.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZWZ4UEdkTjNOQVpETmFsSTYxczZPNDM5QmVSSzNmek1pSTFtMk9rRCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1MzoiaHR0cHM6Ly9lbGRlcmEtb3NjYS5jb20vYWRtaW4vcGFzc3dvcmQtcmVzZXQtcmVxdWVzdHMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyOToiaHR0cHM6Ly9lbGRlcmEtb3NjYS5jb20vTG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1768554459),
('Az6nRuumJDHYtps9EBSPpNjKENj7RdNsXu1MOIJu', NULL, '24.199.82.109', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjdMMjRmSVdkUmtOTWFrazZWeHJ3bUk1OFNqUnhIbUhSSXZhTVJvZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768660047),
('BlGvPCWBX6O5CbI7IMsxHMhG5HoQHqdeiaFtpju1', NULL, '152.53.244.123', 'MercuryLeads/1.0 (+https://mercuryleads.io/crawler/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQmJqNjY2Zkk2dkZkaGNmSVhXWTQ1em00TVhFNmZ0enMzaVNpWHdycyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768653100),
('c99uVR478sxmD7GXiaWxLcFAxfoJYoflU4XfIVgT', NULL, '52.167.144.212', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2dDcmRZemR3SG9Ec0F6cnZXdXhNdHIyU0hMNVVjOEUyMmQzZWV1NSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768354469),
('cI9NcUQfFJKjtVg1p5hEsuITsNNMwQAdWrCiJD7E', NULL, '138.246.253.7', 'quic-go-HTTP/3', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiN2tpRzkwd1NRdUxQaXFHMjYxUmV2eUhMZnY3TkpESXZKTmptY2MwRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768587548),
('cv7mSsnhLgPDmbFmlnW3oM4p7wsEZ9w0pq6jimH5', NULL, '49.151.201.204', 'Dart/3.9 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWllSno3dDZCbnlhbGVJeWhvaXVWRW9FdEtYNGhNWGEzZ2pWRjh0SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768322325),
('DWERkOkT6C4hUkrpYUmKeGf0HqniicF97cOWFO05', NULL, '2001:4ba0:cafe:b2c::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickZzcVhQRllzSmVpZ2RXaG1YRUM1YWJieTBjRjU1MHZqaFJRYjhrOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768700176),
('dWN4aOHzcYTwczT5wJDhE0smRxYtdu768kaAtY0F', NULL, '207.154.241.240', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieVZRd1NNRFZ3NDMxWXlpOHM3MVpEbGl0eFp5QllGRWVKd2lEY1Q2eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768310448),
('E9yQ4Su4awI6qy6ceNtD0ayFRpYnGeTTSxbCoHmM', NULL, '142.4.217.39', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_6_5; rv:102.0) Gecko/20100101 Firefox/102.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVR3S2xsWldJNDIxMnZhbEZ5T1ZWME9jSDRLRDZ0clA0ZmJjWkxIQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vd3d3LmVsZGVyYS1vc2NhLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768421901),
('ERiDMqPXoqAONRvTbDHxAT0pcIvxNa4FvUKDO1ah', NULL, '2001:4452:2d3:db00:796c:d5ae:cc1e:219', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDFqQWVLcHcxdjdTdE5ta0p6R2JMUWkwWU5uV1BEdWU0dnNaUmdqYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768799807),
('Fy5X7Atxe8fgymk354olH9jzjd2xTaR2TjFRF4Ib', NULL, '2001:4ca0:108:42::7', 'quic-go-HTTP/3', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiV2h4ZHZvaHpLc3U3ZHg2akpGelU2cE0zWU9hSHpWcHBsNGFnS2txMiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768777366),
('gbYfaJn3Z4fYE8ip29XjBG3QnV6RkxhTWD8B3oc1', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVNrcGJsOVRtdHZMZ1FidndtdGxra0hkd1o5NlNEVHJDTENyOHZlYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768373860),
('gKC5j2MuS7s2Xa6RepnBp7NyDbt2byj1czmy3sZ9', NULL, '46.138.250.165', 'Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTdhb1hPeWY4ZjhPc1lvaTF1ZllKdTNhc2huTDBUcHRDSG9HSkI5QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768304132),
('GyjATle7YEYVCpkXdCh9F9v0AYdPdE3hXyxd7ujr', NULL, '2001:4452:24c:f900:9d2a:202d:b84c:62a2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTTJOaVhJVDF0c1M4RlUxcEdaTWg3eklWV0pWUGJ2M3o0Q3pyM0tEVCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cHM6Ly9lbGRlcmEtb3NjYS5jb20vU2VuaW9ycyI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI5OiJodHRwczovL2VsZGVyYS1vc2NhLmNvbS9Mb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768373915),
('H1pqdVo030t2E54GPV6SafFHi8CrMMDu2aFg7EIB', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWjQ0MW9GQ0d3c1dCNkdybFFLVkRoQnd2dTR2RmY1eXZ4ZzhyM29uVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768612515),
('hJPRhIBf0UyK3Hr2j31cfqWwDjj9fgyjLFbey51j', NULL, '93.158.90.70', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidXNJaWJkdTVjTXRxWkRhbENSYXRsWjBuMlJoMndJdkZuTWtYUk5EMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768411029),
('HK7FDh1SC8azsC2gIlrHxtObtkEC4a2Ur3pWPy2c', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiREtXUkQ2bXRrRlpYcEN6aFg5cXVNMHpseUwxQVlYeW93N0g3alc4WSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768793315),
('HXBkhGKoa2vNbSATlX5xQw1ewi883vBXAyOJHsjA', NULL, '66.249.74.32', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.7499.192 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlE4Sk54ZXVFRThKZDN6MVpLajlmVEhabk0wS2pDdmNaVllyNjRobiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vd3d3LmVsZGVyYS1vc2NhLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768403200),
('i4HAnxnjAEAsLPqxFfO51bQBDYoD6qNShW5BZvGP', NULL, '198.244.168.78', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzUzTjFuanlscUtVT2lWOE1QWDBWdkZ1blg2ODZndkJVNVRBSVBpeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768653165),
('itdBiyTYbh5oPhnxiPfg6yDTpCnF3V6ifjNTlnlO', NULL, '23.20.109.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWmt2V1hvaDFUb3ZRVjhIdDJ5WHhXOHQ2emo1cms1SEY3Y1BFZHNlRiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768425974),
('JW3F5Aaro5usiyuwYTTSgPESktlgc3iWVLAjKpd5', NULL, '49.151.201.204', 'Dart/3.9 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1oyVjlHdktyOFdZZ2NjbHZXNEl2VTNXQnNjdlZNV3Z2Q3I3MzRtMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768263724),
('k1NZLeVB1MBMJoybUHtpsb3k6rUeu2CbrE2E756L', NULL, '23.20.109.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieEN4N3FCRndNWVBKTUc0SUljYnNlbXBtRmw1dHNGNUlnNnFKd1FTbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768425974),
('kfZCy19oulNEn9bpMrR94bvcdGaTL7ybYeLXatoz', NULL, '93.158.90.73', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkY1OWdSQVE0eHh3TWozM3JaZFVtUDdqalhvcVdpazFzRHNXTGdHNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768411030),
('l4o7WjMof9GoXUngXZWeOPw7d9KD5grMCSn5KcHO', NULL, '66.249.74.32', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoienYwVGtEN0lLUXBYMzFhVmd4OUR6ZzJDOTBzZG1QekY3bEFUdnNqbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vd3d3LmVsZGVyYS1vc2NhLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768403212),
('ljAcPb5s2OepxT4LaRhtiAoIILRhe7a0VN6LStIo', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUmFCQTRLVFB4MzhkVGJOb3RCVXBWb0F3dm56T2F5dFNYSzNISUJIUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768265548),
('lkSjLxcm2CqqUpepCVElZK9PelP1aFfsyJRB38aZ', NULL, '164.90.194.168', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRE5OSGN5RkhLMGpIOGpNYjZidlJpQmlnVVNYRFJjcTBkOWtaMnVsViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768485628),
('Lrs2wa1tBlRHjhI4Zf1bpz9GGvzbByNJasf48OmR', NULL, '198.244.183.194', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZWxvRm1IU1AyYnB1YTB1U3p4alVDOHJKMWxGZHNLWk9MME84TzRyViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768354349),
('MfyV7wK9pnMRvttXQYGyKUpjxZnaNZmoFFzwGVfI', NULL, '2001:4452:24c:f900:528:a085:2c14:712e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUphVFpXZWxoM3o2YWZ2UlQzUkNRM004RG1tR29aczZRVUlDUHVXVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768402959),
('n73oeIL3W8tP5UR0wtiWpwd7wpRWvJONTV4LFgGS', NULL, '93.158.127.79', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlAyMHZ6R1ZXWlpvTktlUmxQMXNjVTNEUTl5amtGOVRHWTNZc1owaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768436801),
('naijdEuRbU3Dmpc0WGGtIWUcHkJ608AoDa7fiuoa', NULL, '195.86.24.111', 'Mozilla/5.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUldPME5xRm1wS2VNQzV3ZzVNaGZRbWxWNk9xYUpvOWdaZjdaYWJ0MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768665942),
('NIoW09Eqmj0Uxeu3HDLRgxae5LlPGWU1dqfKnSqY', NULL, '124.115.170.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3o3aVdteTBuUnF6UmxVQkZVZE91MW1CaktoQnVRY0NOeWt4aXhhdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768382278),
('NmXEWmSnOanYAcrMvYduKOlKpsz0st7KWNHmFyWi', NULL, '66.249.73.1', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1RWSTJvZDlabUlpYjJ6TE9EN1B4RWdpdVFwQ1RDNUk1TzZEaU52USI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768334682),
('nUteZInGTKBA5JwXtmoKZ5pgTiOAwNzADkyGjGPZ', NULL, '192.36.207.10', 'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.6099.280 Mobile Safari/537.36 OPR/80.4.4244.7786', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU3V4RWZtN2xraVU4MXNWN2FUZFFraWVZM1k1Sk1jY3Q3MENLTHpscCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768516407),
('oi8EAHqMrZfa4lx7grpmMiOeBNVPFMnDd0BOCWQb', 6, '2001:4452:24c:f900:9d2a:202d:b84c:62a2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUVF5dnA3S25DTmFVVXVsNUNMVjRzVmVFaHdvbUt6cU55QlhjZVFRNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL1NlbmlvcnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo2O30=', 1768321495),
('oIPY9kKKZXSrN3ufeNRuWaRhnweSHmaItQp83yRv', NULL, '93.158.90.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVhuOFlvM2RKeDd2SkZxMnh5Y215amI4VjFvTnZLaGRiOGNZOG5CMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768689892),
('Po3W8iiR5EU4HIlIFAOfSiEfxLELAijTM4jWBlp9', NULL, '198.244.226.64', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjh1UUhPT2p6YmFneDNyUmtXaG9MeGpyODdCNkJhaXRCQnkxUlZxViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768410350),
('POsxdQxhBSZgLrheK46bfRCy5tUFDpTonK3Wl3Jq', NULL, '35.215.124.131', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BW/1.3; rb.gy/qyzae5) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzRSOGEyeWZuaXJQYVVOSGtudVFKd1Vna0tjTWRXcEtSdmozdm9xeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768746222),
('pUaASlKv1BC8YdwBUdJS0RRQzGXQeOqR12NlSKPP', NULL, '93.158.90.143', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Agency/93.8.2357.5', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmlSZWNlWTBuSVlRWWRDSnlSdFltcWRReDM3UEk5Y3F4UzZNbExONCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768719121),
('qhIaB9kASexZB2pJj8VdJr0ri98pLCElUyn9C98M', 6, '2001:4452:24c:f900:9d2a:202d:b84c:62a2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidTgzZWhscENud1FCSGpZbkhNVU9CMml5RFJselRXaFI2VVRMZVh4MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0V2ZW50cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjY7fQ==', 1768262967),
('qYeQALHARS6UpSA1QmKVk9psMpWPejIM7TwKdFCY', NULL, '66.249.73.1', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.7499.192 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3N2YkpSZXZLUFhRRXcydW9EcTB3T1d1dWF6M1FSVURhUFV0NFdlUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768334620),
('RClK6Pz6eyEwAeLqwveTJ8Uuivy0ErVUXZUFrR7m', NULL, '49.151.201.204', 'Dart/3.9 (dart:io)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEFPR3poVGk3eEw4SzlwVmtwZjJrUWlIcmo5SzRYcGNmN2l2S1c1SiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768263310),
('spnercqpK4SUjWT1cKZEuBw2nvzb57pMkZbstWRT', NULL, '34.90.66.217', 'Scrapy/2.13.4 (+https://scrapy.org)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSzRvbmI4ZDhGVkRCSzRWSktsOFYxMks4TzQwNEl3d1huS0EyQ1V2ViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vd3d3LmVsZGVyYS1vc2NhLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768620321),
('SYkqndhymFRyDfjd788L3y2VyeMz2BTqrEiLEEvd', NULL, '44.250.205.165', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTdtTkVBdXhSYzRrZVVNZFpMeFUzaFhwd3Jtb1BnSEpWT2F0Y1RGUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768304667),
('tCirqpUaNFOP3gfHzcciSiaDs5n0MgXTsirqr9hf', NULL, '66.249.73.14', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGY0VTRDZGREMG1yY3o1OHhEZHpSektScUt5cGJ6cEs2dGxoU0ZTQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768334681),
('tHhZwaKm1RhrZnrtl4SaMkD3muqTCRsApdwvhiXz', NULL, '2001:4ca0:108:42::7', 'quic-go-HTTP/3', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZm9SMVFiY2tlVFZkRnZrYzRRNXVjNmpwcmhHblp3VlZleFpiRUthbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768770538),
('TM8WRNZGsFDC9nSnil1agQE1lh49LNu0YAqwSa3w', NULL, '205.210.31.54', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFpzVTU0R0lTWGhmVllzRmpVREJBNlIyQThhSUdoVDlBbVVZOWdPdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768516569),
('uaunx9e5H6IPSGD31opSWV6ENNG0YmNqXK0RFS93', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiU1hSS3Z0cFA2RnVvYTlKUmRxeG9yb3NtQ2E0MXpTMTB2cHAzcUtocSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768360212),
('Uq9nbsM9YUdu4OcX3Rnt2BGZLly8mQ0mySvl1SXF', NULL, '34.91.212.219', 'Scrapy/2.13.4 (+https://scrapy.org)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWIzOG9ERW8xdGhuVGdaajNxVWFQaTNCblZRWmJYQjRzR0dETVVpNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768620335),
('Uv6eXMFfkNZB2gPIAcSkRZMhXY16DZ3ZBXvmJ6rr', NULL, '93.158.90.15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1dCZU1RaU9GcHVHTk16MUpvUXlQWHMxUlh6SGdaT1JhZno4alhoQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768689892),
('vld4ykOFvzkvu0eZjXPTwxvkbFWQJCEOSJDYKIKI', NULL, '142.4.217.39', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 13_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36 Edg/107.0.1418.24', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjA5ektrdnFZdkhzZFpHbWxzbkFqeUZ5dTV0bjNIcnRmOUQ1aGEzbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vd3d3LmVsZGVyYS1vc2NhLmNvbSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1768373444),
('W1hGyWifsLKoncSftEDJTz039dDzRUdI4GD8cRAi', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiMTB2WVJ6aEJwT3Bab21CbEFxUFowWkc4WTlRM1g2N2NPaTZsY21RMSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768528303),
('X8wOu9uH73gMkGWfjbjdeS8unW9eLGGQeEGiPG8Q', NULL, '138.246.253.7', 'quic-go-HTTP/3', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSHVoem9BbjgzVENrRjc1NUJuS0EwRXVVdUt0Z0FKVWlOVGVPYVRKNSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768582515),
('x9gWQgoBaFrvharIODLPtuhzWCKUxYWUazbEj2EL', NULL, '124.115.170.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHNpTjUxNHN5U0JsWkVORDZRY1F4U0lPZHpUZDhzcnB6VWNjYm5VTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768382217),
('XCzPSZSQ4lnNq6GB6OFEseXr3nK296s1VCLP0Du2', NULL, '185.12.150.17', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlBFbWY1VWdId3NxZm9xQU16NzhjcVhnMUtYaXg1VkJIZ2IxUm9RQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768436800),
('YfUUc75Hs7dRFB2PxnLQ2hpnSG3kQaCvR9q6VtHk', NULL, '51.89.129.237', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVGtnc1h6T3hNWHphUEJnNm10THp4R0tLc0h0cTJzNmNhcjdSZGVmeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768733233),
('YvaifRIeOgVNMi5zvpf0hQSOPDo0hberHuEN5825', NULL, '46.138.250.165', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVhYdmh0emZQeDdLZW1tN3FKSGl4WkNFQlpPZzdFNVY2WTBZRjZiMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768304080),
('ZaaroGCm0805QSJb8218n5neyybIWxsZM8QHClYj', NULL, '93.158.90.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Agency/93.8.2357.5', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkJTYm9SOVZ1OW5OTnppYkFNSHpkRGV0eTVFWmQ1ZllXSTZ6R1pESSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHBzOi8vZWxkZXJhLW9zY2EuY29tL0xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768719122),
('zEt0tP5x4PCamGhC1orlRxctTsjYimoWZniCpIRT', NULL, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRnhoN2hjajFUMHFuVWY4dXp6RGtjTld4T2ZlNjJSUmZtcmNUdWMycCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1768706636);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `google_id`, `avatar`, `role`) VALUES
(1, 'ELDERA Admin', 'admin@eldera.com', '2025-09-18 01:48:53', '$2y$12$e3VOShpjo/bPfhqo06fJNeSCQPitQEw7ypL24v.OjapDMaXz4CobW', NULL, '2025-09-18 01:48:53', '2025-09-18 01:48:53', NULL, NULL, NULL),
(2, 'OSCA Manager', 'osca@eldera.com', '2025-09-18 01:48:54', '$2y$12$mVBR5qHkr3LKvSwd70ZynuCNBQeg.oQ8GcgiB4qLwV5cl5dbOnc92', NULL, '2025-09-18 01:48:54', '2025-09-18 01:48:54', NULL, NULL, NULL),
(3, 'System Administrator', 'sysadmin@eldera.com', '2025-09-18 01:48:54', '$2y$12$y9KPZoF.hpIH4SHZNreMpupMLiuvR3h0CUroh7oC9MRYI1p4eoPMK', NULL, '2025-09-18 01:48:54', '2025-09-18 01:48:54', NULL, NULL, NULL),
(4, 'Admin User 1', 'tripwapakxd@gmail.com', '2025-09-18 21:16:12', '$2y$12$n57eDxVZoHMZ6aSShDNRs.5Q7bBa3G0Kxn5/60ecrfyy0Wgc0RQ5G', NULL, '2025-09-18 01:52:05', '2025-09-18 21:16:12', NULL, NULL, NULL),
(5, 'Admin User 2', 'aeronbautista32@gmail.com', '2025-09-18 21:16:12', '$2y$12$P/QLo7uiPwy2j4/vb4IT2O6nGMkDTY/t5DT8Olbp/CQHmfCejOEP6', NULL, '2025-09-18 01:52:05', '2025-09-18 21:16:12', NULL, NULL, NULL),
(6, 'adminPogi', 'revienortiz@gmail.com', NULL, '$2y$12$Wt4L0pRJsNuLqU9A1d0XRurIULOy.wEYlPsYgRshvE7GJoCv5MKN2', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'jilu', 'jieloucagampan21@gmail.com', NULL, '$2y$12$ZIyvBpNOAKCkpmMOeip7b.yOTO0UYG4NLY5asB851cqIMrjRHC0ri', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'babyjane', 'Babyjanedanas628@gmail.com', NULL, '$2y$12$quGA.pIil47gEw/zC5Ypc.g6/UzI5v.sIKJaJ80/8lOB7tzOTK0o.', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'eldera', 'elderacapstone@gmail.com', NULL, '$2y$12$Mzx1mCfmWZcz4XdXiBA.lu3Nw/GriGfhhurCwUJT5K8fEmNYK.OOC', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `verification_codes`
--

CREATE TABLE `verification_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `code` varchar(6) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `announcements_is_active_index` (`is_active`);

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `applications_submitted_by_foreign` (`submitted_by`),
  ADD KEY `applications_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `applications_senior_id_index` (`senior_id`),
  ADD KEY `applications_application_type_index` (`application_type`),
  ADD KEY `applications_status_index` (`status`),
  ADD KEY `applications_application_type_status_index` (`application_type`,`status`),
  ADD KEY `applications_submitted_at_index` (`submitted_at`),
  ADD KEY `applications_senior_id_type_index` (`senior_id`,`application_type`),
  ADD KEY `applications_created_at_index` (`created_at`),
  ADD KEY `applications_type_status_index` (`application_type`,`status`),
  ADD KEY `applications_senior_type_index` (`senior_id`,`application_type`),
  ADD KEY `applications_status_created_index` (`status`,`created_at`);

--
-- Indexes for table `app_users`
--
ALTER TABLE `app_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_users_osca_id_unique` (`osca_id`);

--
-- Indexes for table `barangays`
--
ALTER TABLE `barangays`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barangays_name_unique` (`name`),
  ADD UNIQUE KEY `barangays_code_unique` (`code`),
  ADD KEY `barangays_is_active_index` (`is_active`),
  ADD KEY `barangays_code_index` (`code`),
  ADD KEY `barangays_active_name_index` (`is_active`,`name`);

--
-- Indexes for table `benefits_applications`
--
ALTER TABLE `benefits_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `benefits_applications_senior_id_foreign` (`senior_id`),
  ADD KEY `benefits_applications_application_id_foreign` (`application_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_application_id_index` (`application_id`),
  ADD KEY `documents_event_id_index` (`event_id`),
  ADD KEY `documents_senior_id_index` (`senior_id`),
  ADD KEY `documents_document_type_index` (`document_type`),
  ADD KEY `documents_uploaded_by_index` (`uploaded_by`);

--
-- Indexes for table `eldera_users`
--
ALTER TABLE `eldera_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `events_event_date_index` (`event_date`),
  ADD KEY `events_event_type_index` (`event_type`),
  ADD KEY `events_status_index` (`status`),
  ADD KEY `events_event_date_status_index` (`event_date`,`status`),
  ADD KEY `events_created_by_index` (`created_by`),
  ADD KEY `events_date_time_index` (`event_date`,`start_time`),
  ADD KEY `events_type_date_index` (`event_type`,`event_date`);

--
-- Indexes for table `event_participants`
--
ALTER TABLE `event_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `event_participants_event_id_senior_id_unique` (`event_id`,`senior_id`),
  ADD KEY `event_participants_event_id_index` (`event_id`),
  ADD KEY `event_participants_senior_id_index` (`senior_id`),
  ADD KEY `event_participants_attended_index` (`attended`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_codes`
--
ALTER TABLE `login_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login_codes_email_code_index` (`email`,`code`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_index` (`user_id`),
  ADD KEY `notifications_senior_id_index` (`senior_id`),
  ADD KEY `notifications_is_read_index` (`is_read`),
  ADD KEY `notifications_type_index` (`type`),
  ADD KEY `notifications_user_id_is_read_index` (`user_id`,`is_read`),
  ADD KEY `notifications_senior_id_is_read_index` (`senior_id`,`is_read`);

--
-- Indexes for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pension_applications`
--
ALTER TABLE `pension_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pension_applications_application_id_index` (`application_id`),
  ADD KEY `pension_applications_rrn_index` (`rrn`),
  ADD KEY `pension_applications_has_pension_index` (`has_pension`),
  ADD KEY `pension_applications_senior_id_foreign` (`senior_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `seniors`
--
ALTER TABLE `seniors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `seniors_osca_id_unique` (`osca_id`),
  ADD KEY `seniors_osca_id_index` (`osca_id`),
  ADD KEY `seniors_barangay_index` (`barangay`),
  ADD KEY `seniors_status_index` (`status`),
  ADD KEY `seniors_date_of_birth_index` (`date_of_birth`),
  ADD KEY `seniors_barangay_status_index` (`barangay`,`status`),
  ADD KEY `seniors_name_search_index` (`first_name`,`last_name`),
  ADD KEY `seniors_created_at_index` (`created_at`),
  ADD KEY `seniors_status_barangay_index` (`status`,`barangay`),
  ADD KEY `seniors_sex_status_index` (`sex`,`status`),
  ADD KEY `seniors_pension_status_index` (`has_pension`,`status`),
  ADD KEY `seniors_barangay_status_sex_index` (`barangay`,`status`,`sex`),
  ADD KEY `seniors_user_id_foreign` (`user_id`);

--
-- Indexes for table `senior_id_applications`
--
ALTER TABLE `senior_id_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `senior_id_applications_application_id_index` (`application_id`),
  ADD KEY `senior_id_applications_full_name_index` (`full_name`),
  ADD KEY `senior_id_applications_ctc_number_index` (`ctc_number`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_google_id_unique` (`google_id`);

--
-- Indexes for table `verification_codes`
--
ALTER TABLE `verification_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verification_codes_email_code_index` (`email`,`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `barangays`
--
ALTER TABLE `barangays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `benefits_applications`
--
ALTER TABLE `benefits_applications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eldera_users`
--
ALTER TABLE `eldera_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `event_participants`
--
ALTER TABLE `event_participants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1887;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_codes`
--
ALTER TABLE `login_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `password_reset_requests`
--
ALTER TABLE `password_reset_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pension_applications`
--
ALTER TABLE `pension_applications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=329;

--
-- AUTO_INCREMENT for table `seniors`
--
ALTER TABLE `seniors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `senior_id_applications`
--
ALTER TABLE `senior_id_applications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `verification_codes`
--
ALTER TABLE `verification_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `applications_senior_id_foreign` FOREIGN KEY (`senior_id`) REFERENCES `seniors` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `applications_submitted_by_foreign` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `benefits_applications`
--
ALTER TABLE `benefits_applications`
  ADD CONSTRAINT `benefits_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `benefits_applications_senior_id_foreign` FOREIGN KEY (`senior_id`) REFERENCES `seniors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documents_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documents_senior_id_foreign` FOREIGN KEY (`senior_id`) REFERENCES `seniors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documents_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `event_participants`
--
ALTER TABLE `event_participants`
  ADD CONSTRAINT `event_participants_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_participants_senior_id_foreign` FOREIGN KEY (`senior_id`) REFERENCES `seniors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_senior_id_foreign` FOREIGN KEY (`senior_id`) REFERENCES `seniors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pension_applications`
--
ALTER TABLE `pension_applications`
  ADD CONSTRAINT `pension_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pension_applications_senior_id_foreign` FOREIGN KEY (`senior_id`) REFERENCES `seniors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seniors`
--
ALTER TABLE `seniors`
  ADD CONSTRAINT `seniors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `senior_id_applications`
--
ALTER TABLE `senior_id_applications`
  ADD CONSTRAINT `senior_id_applications_application_id_foreign` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
