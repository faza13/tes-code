/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rows` int(10) unsigned NOT NULL,
  `columns` int(10) unsigned NOT NULL,
  `total_slots` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `slots`;
CREATE TABLE `slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` tinyint(3) unsigned NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id_no_index` (`id_no`),
  KEY `users_name_index` (`name`),
  KEY `users_username_index` (`username`),
  KEY `users_password_index` (`password`),
  KEY `users_role_index` (`role`),
  KEY `users_token_index` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `class` (`id`, `rows`, `columns`, `total_slots`, `created_at`, `updated_at`) VALUES
(1, 3, 2, 6, '2022-01-05 04:08:40', '2022-01-05 04:08:40');
INSERT INTO `class` (`id`, `rows`, `columns`, `total_slots`, `created_at`, `updated_at`) VALUES
(2, 3, 2, 6, '2022-01-05 05:25:02', '2022-01-05 05:25:02');
INSERT INTO `class` (`id`, `rows`, `columns`, `total_slots`, `created_at`, `updated_at`) VALUES
(3, 3, 2, 6, '2022-01-05 05:27:03', '2022-01-05 05:27:03');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(20, '2022_01_04_071735_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(21, '2022_01_04_171649_create_class_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(22, '2022_01_04_171958_create_slots_table', 1);

INSERT INTO `slots` (`id`, `class_id`, `user_id`, `seat`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, 'teacher', '2022-01-05 04:08:40', '2022-01-05 04:45:47');
INSERT INTO `slots` (`id`, `class_id`, `user_id`, `seat`, `created_at`, `updated_at`) VALUES
(2, '1', '3', '1A', '2022-01-05 04:08:40', '2022-01-05 05:37:47');
INSERT INTO `slots` (`id`, `class_id`, `user_id`, `seat`, `created_at`, `updated_at`) VALUES
(3, '1', NULL, '1B', '2022-01-05 04:08:40', '2022-01-05 04:10:54');
INSERT INTO `slots` (`id`, `class_id`, `user_id`, `seat`, `created_at`, `updated_at`) VALUES
(4, '1', NULL, '2A', '2022-01-05 04:08:40', '2022-01-05 04:20:38'),
(5, '1', NULL, '2B', '2022-01-05 04:08:40', '2022-01-05 04:20:59'),
(6, '1', NULL, '3A', '2022-01-05 04:08:40', '2022-01-05 04:21:33'),
(7, '1', NULL, '3B', '2022-01-05 04:08:40', '2022-01-05 04:22:22'),
(8, '2', NULL, 'teacher', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(9, '2', NULL, '1A', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(10, '2', NULL, '1B', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(11, '2', NULL, '2A', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(12, '2', NULL, '2B', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(13, '2', NULL, '3A', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(14, '2', NULL, '3B', '2022-01-05 05:25:02', '2022-01-05 05:25:02'),
(15, '3', NULL, 'teacher', '2022-01-05 05:27:03', '2022-01-05 05:27:03'),
(16, '3', NULL, '1A', '2022-01-05 05:27:03', '2022-01-05 05:27:03'),
(17, '3', NULL, '1B', '2022-01-05 05:27:03', '2022-01-05 05:27:03'),
(18, '3', NULL, '2A', '2022-01-05 05:27:03', '2022-01-05 05:27:03'),
(19, '3', NULL, '2B', '2022-01-05 05:27:03', '2022-01-05 05:27:03'),
(20, '3', NULL, '3A', '2022-01-05 05:27:03', '2022-01-05 05:27:03'),
(21, '3', NULL, '3B', '2022-01-05 05:27:03', '2022-01-05 05:27:03');

INSERT INTO `users` (`id`, `id_no`, `name`, `username`, `password`, `role`, `token`, `created_at`, `updated_at`) VALUES
(1, '201', 'teacher', 'teacher', '$2y$10$CVDHgG.xReotbM3jQgPIPuCWBAdBNRjZOGKZ3aVMuTmJiyH8o8IM.', 2, '0d1d6847-822c-48eb-a421-e4a54e4e45d3', '2022-01-05 03:40:40', '2022-01-05 05:24:55');
INSERT INTO `users` (`id`, `id_no`, `name`, `username`, `password`, `role`, `token`, `created_at`, `updated_at`) VALUES
(2, '101', 'admin', 'admin', '$2y$10$gFBu5mYikVi1eq86nwuthu8x8e.6YOqvIo47nvoUxxvZTPHsw44rW', 1, '2272fa27-222b-452d-8191-cf123788ae31', '2022-01-05 03:41:04', '2022-01-05 05:39:35');
INSERT INTO `users` (`id`, `id_no`, `name`, `username`, `password`, `role`, `token`, `created_at`, `updated_at`) VALUES
(3, '301', 'student', 'student', '$2y$10$By0A5J0JBR/nyFBQhCB5S.Y2Hw3/WxDqJ39t53leTDz9ldTcvBoQK', 3, '3681599d-a08c-4cb1-adcc-939c8e6c3310', '2022-01-05 05:37:08', '2022-01-05 05:37:14');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;