-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 25, 2024 at 04:28 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `delivery`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `total_price` int(11) NOT NULL,
  `delivery_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `total_price`, `delivery_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 300, 1, 'pending', '2024-10-25 14:18:58', '2024-10-25 14:18:58'),
(2, 1, 300, 1, 'pending', '2024-10-25 14:22:00', '2024-10-25 14:22:00'),
(3, 1, 300, 1, 'pending', '2024-10-25 14:22:04', '2024-10-25 14:22:04'),
(4, 1, 300, 1, 'pending', '2024-10-25 14:22:46', '2024-10-25 14:22:46'),
(5, 1, 300, 1, 'pending', '2024-10-25 14:25:23', '2024-10-25 14:25:23'),
(6, 1, 300, 1, 'pending', '2024-10-25 14:25:26', '2024-10-25 14:25:26'),
(7, 1, 300, 1, 'pending', '2024-10-25 14:26:35', '2024-10-25 14:26:35'),
(8, 1, 300, 1, 'pending', '2024-10-25 14:26:38', '2024-10-25 14:26:38'),
(9, 1, 300, 1, 'pending', '2024-10-25 14:27:01', '2024-10-25 14:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `import_price` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `import_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 3, 100, '100', '2024-10-25 14:18:58', '2024-10-25 14:18:58'),
(2, 2, 1, 3, 100, '100', '2024-10-25 14:22:00', '2024-10-25 14:22:00'),
(3, 3, 1, 3, 100, '100', '2024-10-25 14:22:04', '2024-10-25 14:22:04'),
(4, 4, 1, 3, 100, '100', '2024-10-25 14:22:46', '2024-10-25 14:22:46'),
(5, 5, 1, 3, 100, '100', '2024-10-25 14:25:23', '2024-10-25 14:25:23'),
(6, 6, 1, 3, 100, '100', '2024-10-25 14:25:26', '2024-10-25 14:25:26'),
(7, 7, 1, 3, 100, '100', '2024-10-25 14:26:35', '2024-10-25 14:26:35'),
(8, 8, 1, 3, 100, '100', '2024-10-25 14:26:38', '2024-10-25 14:26:38'),
(9, 9, 1, 3, 100, '100', '2024-10-25 14:27:01', '2024-10-25 14:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `import_price` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `promotional_price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `image` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `import_price`, `price`, `promotional_price`, `quantity`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Cơm Phúc Lộc Thọ', 'description', 100, 100, 100, 100, 'imageLink', '2024-10-25 07:02:42', '2024-10-25 07:31:42');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `picture` longtext DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `otp_code` varchar(255) NOT NULL,
  `otp_expired` datetime NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `fullname`, `picture`, `role`, `otp_code`, `otp_expired`, `is_verified`, `created_at`, `updated_at`) VALUES
(1, 'keganvn2@gmail.com', '$2a$10$6/OGSFh4xVhnLSuqtVTake9.vzlseQFetEE3JZcTOxaW7T/zjr9.S', 'Mr A', NULL, 'admin', '208156', '2024-10-25 03:10:50', 0, '2024-10-25 03:00:53', '2024-10-25 03:00:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
