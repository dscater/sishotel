-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 28-11-2025 a las 16:41:49
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sishotel_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

CREATE TABLE `cajas` (
  `id` bigint UNSIGNED NOT NULL,
  `monto_inicial` decimal(24,2) NOT NULL,
  `monto_final` decimal(24,2) DEFAULT NULL,
  `monto_efectivo_inicial` decimal(24,2) NOT NULL,
  `monto_efectivo_final` decimal(24,2) DEFAULT NULL,
  `monto_banco_inicial` decimal(24,2) NOT NULL,
  `monto_banco_final` decimal(24,2) DEFAULT NULL,
  `fecha_apertura` date NOT NULL,
  `hora_apertura` time NOT NULL,
  `fecha_cierre` date DEFAULT NULL,
  `hora_cierre` time DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(800) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `nacionalidad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `fono`, `fecha_nac`, `correo`, `edad`, `nacionalidad`, `pais`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'EDUARDO', 'CONDORI', '', '123456', 'LP', '', '777777', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 14:58:29', '2025-11-28 14:58:29'),
(2, 'ALEX', 'MAMANI', '', '56565656', NULL, '', '6767676767', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:07:12', '2025-11-28 15:07:12'),
(3, 'MARIA', 'MAMANI', '', '345345354', 'LP', '', '676767', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:09:10', '2025-11-28 15:09:10'),
(4, 'FRANZ', 'GONZALES', '', '3453453', NULL, '', '345345345', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:09:26', '2025-11-28 15:10:56'),
(5, 'FELIX', 'MARTINEZ', '', '12313132', 'CB', '', '546456546', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:11:11', '2025-11-28 15:11:11'),
(6, 'ALEJANDRA', 'PALACIOS', '', '433433434', NULL, '', '676767676', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:18:18', '2025-11-28 15:18:18'),
(7, 'JUAN', 'MARTINEZ', '', '12313123', 'LP', '', '234234243', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:21:35', '2025-11-28 15:21:35'),
(8, 'DANITZ', 'GONZALES', '', '3222323', NULL, '', '234234234', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:23:45', '2025-11-28 15:23:45'),
(9, 'ALICIA', 'GUTIERREZ', '', '34343434', NULL, '', '6767676767', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:28:24', '2025-11-28 15:28:24'),
(10, 'JOSE', 'PALACIOS', '', '43343434', 'LP', '', '76767676', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:29:14', '2025-11-28 15:29:14'),
(11, 'JUAN', 'CARVAJAL', '', '1234567', NULL, '', '23424223', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:30:35', '2025-11-28 15:31:11'),
(12, 'ALBERTO', 'SURCO', '', '12345678', NULL, '', '768787878', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:31:34', '2025-11-28 15:31:34'),
(13, 'ALVARO', 'CHOQUEHUANCA', '', '3131313123', NULL, '', '456456456', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:52:50', '2025-11-28 15:52:50'),
(14, 'SANDRA', 'ALVARES', '', '3223232', NULL, '', '234234243234', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:53:14', '2025-11-28 15:53:14'),
(15, 'ESTHER', 'MARTINEZ', '', '433434', NULL, '', '6556657567', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:55:14', '2025-11-28 15:55:14'),
(16, 'JORGE', 'CALLISAYA', '', '3456456465', NULL, '', '67676767', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:56:35', '2025-11-28 15:56:35'),
(17, 'GROVER', 'SOLIZ', '', '535345', NULL, '', '345345345', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:57:15', '2025-11-28 15:57:15'),
(18, 'AFDSF', 'ASDFASDF', '', '3423456', 'LP', '', '546456456', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 15:59:29', '2025-11-28 15:59:29'),
(19, 'ERERERER', 'ERERER', '', '1213233', NULL, '', '123123', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 16:04:49', '2025-11-28 16:04:49'),
(20, 'ELVIS', 'SANTA CRUZ', '', '1231313', NULL, '', '1321313', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 16:06:16', '2025-11-28 16:06:16'),
(21, 'JOSUE', 'AGUIRRE', '', '4535345', NULL, '', '1321312', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 16:06:48', '2025-11-28 16:06:48'),
(22, 'ALEXANDER', 'SURCO', '', '123131', NULL, '', '3434', NULL, NULL, NULL, '', '', 1, 1, '2025-11-28 16:07:05', '2025-11-28 16:07:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `razon_social`, `alias`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SISHOTEL', 'SISHOTEL S.A.', 'I', 'logo.png', '2025-11-24 20:04:52', '2025-11-24 20:04:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egreso_productos`
--

CREATE TABLE `egreso_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `motivo` text COLLATE utf8mb4_unicode_ci,
  `fecha_egreso` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacions`
--

CREATE TABLE `habitacions` (
  `id` bigint UNSIGNED NOT NULL,
  `numero_habitacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_habitacion_id` bigint UNSIGNED NOT NULL,
  `piso` int NOT NULL DEFAULT '0',
  `capacidad` int NOT NULL DEFAULT '1',
  `precio` decimal(24,2) NOT NULL,
  `precio_temp` decimal(24,2) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `habitacions`
--

INSERT INTO `habitacions` (`id`, `numero_habitacion`, `tipo_habitacion_id`, `piso`, `capacidad`, `precio`, `precio_temp`, `estado`, `status`, `created_at`, `updated_at`) VALUES
(1, 'H-001', 1, 0, 1, 300.00, 0.00, 0, 1, '2025-11-24 21:08:48', '2025-11-24 21:08:48'),
(2, 'H-002', 2, 1, 2, 500.00, 0.00, 0, 1, '2025-11-24 21:17:59', '2025-11-24 21:26:51'),
(3, 'H-003', 3, 1, 2, 800.00, 200.00, 0, 1, '2025-11-24 21:23:46', '2025-11-24 21:26:43'),
(4, 'H-004', 4, 1, 3, 800.00, 250.00, 0, 1, '2025-11-24 21:30:34', '2025-11-28 14:33:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitacion_fotos`
--

CREATE TABLE `habitacion_fotos` (
  `id` bigint UNSIGNED NOT NULL,
  `habitacion_id` bigint UNSIGNED NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `habitacion_fotos`
--

INSERT INTO `habitacion_fotos` (`id`, `habitacion_id`, `foto`, `created_at`, `updated_at`) VALUES
(1, 1, '011764018528.jpeg', '2025-11-24 21:08:48', '2025-11-24 21:08:48'),
(2, 1, '111764018528.jpeg', '2025-11-24 21:08:48', '2025-11-24 21:08:48'),
(3, 4, '041764019834.webp', '2025-11-24 21:30:34', '2025-11-24 21:30:34'),
(4, 4, '141764019834.jpg', '2025-11-24 21:30:34', '2025-11-24 21:30:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": \"1\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:26:26.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE HABITACIÓN', '2025-11-24', '16:26:26', '2025-11-24 20:26:26', '2025-11-24 20:26:26'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": 1, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:26:26.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:27:50.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:27:50', '2025-11-24 20:27:50', '2025-11-24 20:27:50'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:27:50.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:27:58.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:27:58', '2025-11-24 20:27:58', '2025-11-24 20:27:58'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:27:58.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:28:19.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:28:19', '2025-11-24 20:28:19', '2025-11-24 20:28:19'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:28:19.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:28:28.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:28:28', '2025-11-24 20:28:28', '2025-11-24 20:28:28'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:28:28.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:28:42.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:28:42', '2025-11-24 20:28:42', '2025-11-24 20:28:42'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:28:42.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:30:58.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:30:58', '2025-11-24 20:30:58', '2025-11-24 20:30:58'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:30:58.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:32:15.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:32:15', '2025-11-24 20:32:15', '2025-11-24 20:32:15'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:32:15.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:32:21.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:32:21', '2025-11-24 20:32:21', '2025-11-24 20:32:21'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:32:21.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:33:55.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:33:55', '2025-11-24 20:33:55', '2025-11-24 20:33:55'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:33:55.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:36:29.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:36:29', '2025-11-24 20:36:29', '2025-11-24 20:36:29'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:36:29.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:38:56.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:38:56', '2025-11-24 20:38:56', '2025-11-24 20:38:56'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:38:56.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:39:02.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:39:02', '2025-11-24 20:39:02', '2025-11-24 20:39:02'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 1, \"nombre\": \"DOBLE\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:39:02.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"nombre\": \"SIMPLE\", \"capacidad\": null, \"created_at\": \"2025-11-24T20:26:26.000000Z\", \"updated_at\": \"2025-11-24T20:39:44.000000Z\", \"descripcion\": \"\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:39:44', '2025-11-24 20:39:44', '2025-11-24 20:39:44'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE HABITACIÓN', '{\"id\": 2, \"nombre\": \"DOBLE\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:42:10.000000Z\", \"updated_at\": \"2025-11-24T20:42:10.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE HABITACIÓN', '2025-11-24', '16:42:10', '2025-11-24 20:42:10', '2025-11-24 20:42:10'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE HABITACIÓN', '{\"id\": 3, \"nombre\": \"MATRIMONIAL\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:43:24.000000Z\", \"updated_at\": \"2025-11-24T20:43:24.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE HABITACIÓN', '2025-11-24', '16:43:24', '2025-11-24 20:43:24', '2025-11-24 20:43:24'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE HABITACIÓN', '{\"id\": 3, \"nombre\": \"MATRIMONIAL\", \"capacidad\": 2, \"created_at\": \"2025-11-24T20:43:24.000000Z\", \"updated_at\": \"2025-11-24T20:43:24.000000Z\", \"descripcion\": \"\"}', '{\"id\": 3, \"nombre\": \"MATRIMONIAL\", \"capacidad\": \"2\", \"created_at\": \"2025-11-24T20:43:24.000000Z\", \"updated_at\": \"2025-11-24T20:44:38.000000Z\", \"descripcion\": \"MATRIMONIAL\"}', 'TIPO DE HABITACIÓN', '2025-11-24', '16:44:38', '2025-11-24 20:44:38', '2025-11-24 20:44:38'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE HABITACIÓN', '{\"id\": 4, \"nombre\": \"FAMILIAR 1\", \"capacidad\": \"3\", \"created_at\": \"2025-11-24T20:47:31.000000Z\", \"updated_at\": \"2025-11-24T20:47:31.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE HABITACIÓN', '2025-11-24', '16:47:31', '2025-11-24 20:47:31', '2025-11-24 20:47:31'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE HABITACIÓN', '{\"id\": 5, \"nombre\": \"FAMILIAR 2\", \"capacidad\": \"5\", \"created_at\": \"2025-11-24T20:47:36.000000Z\", \"updated_at\": \"2025-11-24T20:47:36.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE HABITACIÓN', '2025-11-24', '16:47:36', '2025-11-24 20:47:36', '2025-11-24 20:47:36'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA HABITACIÓN', '{\"id\": 1, \"piso\": \"0\", \"estado\": \"0\", \"precio\": \"300\", \"created_at\": \"2025-11-24T21:08:48.000000Z\", \"updated_at\": \"2025-11-24T21:08:48.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [{\"id\": 1, \"ext\": \"jpeg\", \"foto\": \"011764018528.jpeg\", \"name\": \"011764018528.jpeg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/011764018528.jpeg\", \"created_at\": \"2025-11-24T21:08:48.000000Z\", \"updated_at\": \"2025-11-24T21:08:48.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/011764018528.jpeg\", \"habitacion_id\": 1}, {\"id\": 2, \"ext\": \"jpeg\", \"foto\": \"111764018528.jpeg\", \"name\": \"111764018528.jpeg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/111764018528.jpeg\", \"created_at\": \"2025-11-24T21:08:48.000000Z\", \"updated_at\": \"2025-11-24T21:08:48.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/111764018528.jpeg\", \"habitacion_id\": 1}], \"numero_habitacion\": \"H-001\", \"tipo_habitacion_id\": \"1\"}', NULL, 'HABITACIONES', '2025-11-24', '17:08:48', '2025-11-24 21:08:48', '2025-11-24 21:08:48'),
(21, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA HABITACIÓN', '{\"id\": 2, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"500\", \"created_at\": \"2025-11-24T21:17:59.000000Z\", \"updated_at\": \"2025-11-24T21:17:59.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H001\", \"tipo_habitacion_id\": \"2\"}', NULL, 'HABITACIONES', '2025-11-24', '17:17:59', '2025-11-24 21:17:59', '2025-11-24 21:17:59'),
(22, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 2, \"piso\": 1, \"estado\": 0, \"precio\": \"500.00\", \"status\": 1, \"capacidad\": 1, \"created_at\": \"2025-11-24T21:17:59.000000Z\", \"updated_at\": \"2025-11-24T21:17:59.000000Z\", \"precio_temp\": \"0.00\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H001\", \"tipo_habitacion_id\": 2}', '{\"id\": 2, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"500\", \"status\": 1, \"capacidad\": 1, \"created_at\": \"2025-11-24T21:17:59.000000Z\", \"updated_at\": \"2025-11-24T21:23:07.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-002\", \"tipo_habitacion_id\": \"2\"}', 'HABITACIONES', '2025-11-24', '17:23:07', '2025-11-24 21:23:07', '2025-11-24 21:23:07'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA HABITACIÓN', '{\"id\": 3, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"800\", \"created_at\": \"2025-11-24T21:23:46.000000Z\", \"updated_at\": \"2025-11-24T21:23:46.000000Z\", \"precio_temp\": \"200\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-003\", \"tipo_habitacion_id\": \"3\"}', NULL, 'HABITACIONES', '2025-11-24', '17:23:46', '2025-11-24 21:23:46', '2025-11-24 21:23:46'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 3, \"piso\": 1, \"estado\": 0, \"precio\": \"800.00\", \"status\": 1, \"capacidad\": 1, \"created_at\": \"2025-11-24T21:23:46.000000Z\", \"updated_at\": \"2025-11-24T21:23:46.000000Z\", \"precio_temp\": \"200.00\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-003\", \"tipo_habitacion_id\": 3}', '{\"id\": 3, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"800\", \"status\": 1, \"capacidad\": 1, \"created_at\": \"2025-11-24T21:23:46.000000Z\", \"updated_at\": \"2025-11-24T21:26:25.000000Z\", \"precio_temp\": \"200\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-003\", \"tipo_habitacion_id\": \"3\"}', 'HABITACIONES', '2025-11-24', '17:26:25', '2025-11-24 21:26:25', '2025-11-24 21:26:25'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 3, \"piso\": 1, \"estado\": 0, \"precio\": \"800.00\", \"status\": 1, \"capacidad\": 1, \"created_at\": \"2025-11-24T21:23:46.000000Z\", \"updated_at\": \"2025-11-24T21:26:25.000000Z\", \"precio_temp\": \"200.00\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-003\", \"tipo_habitacion_id\": 3}', '{\"id\": 3, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"800\", \"status\": 1, \"capacidad\": \"2\", \"created_at\": \"2025-11-24T21:23:46.000000Z\", \"updated_at\": \"2025-11-24T21:26:43.000000Z\", \"precio_temp\": \"200\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-003\", \"tipo_habitacion_id\": \"3\"}', 'HABITACIONES', '2025-11-24', '17:26:43', '2025-11-24 21:26:43', '2025-11-24 21:26:43'),
(26, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 2, \"piso\": 1, \"estado\": 0, \"precio\": \"500.00\", \"status\": 1, \"capacidad\": 1, \"created_at\": \"2025-11-24T21:17:59.000000Z\", \"updated_at\": \"2025-11-24T21:23:07.000000Z\", \"precio_temp\": \"0.00\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-002\", \"tipo_habitacion_id\": 2}', '{\"id\": 2, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"500\", \"status\": 1, \"capacidad\": \"2\", \"created_at\": \"2025-11-24T21:17:59.000000Z\", \"updated_at\": \"2025-11-24T21:26:51.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [], \"numero_habitacion\": \"H-002\", \"tipo_habitacion_id\": \"2\"}', 'HABITACIONES', '2025-11-24', '17:26:51', '2025-11-24 21:26:51', '2025-11-24 21:26:51'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA HABITACIÓN', '{\"id\": 4, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"800\", \"capacidad\": \"3\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": \"4\"}', NULL, 'HABITACIONES', '2025-11-24', '17:30:34', '2025-11-24 21:30:34', '2025-11-24 21:30:34'),
(28, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 4, \"piso\": 1, \"estado\": 0, \"precio\": \"800.00\", \"status\": 1, \"capacidad\": 3, \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"precio_temp\": \"0.00\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": 4}', '{\"id\": 4, \"piso\": \"1\", \"estado\": \"1\", \"precio\": \"800\", \"status\": 1, \"capacidad\": \"3\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:46.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": \"4\"}', 'HABITACIONES', '2025-11-24', '17:30:46', '2025-11-24 21:30:46', '2025-11-24 21:30:46'),
(29, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 4, \"piso\": 1, \"estado\": 1, \"precio\": \"800.00\", \"status\": 1, \"capacidad\": 3, \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:46.000000Z\", \"precio_temp\": \"0.00\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": 4}', '{\"id\": 4, \"piso\": \"1\", \"estado\": \"2\", \"precio\": \"800\", \"status\": 1, \"capacidad\": \"3\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:49.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": \"4\"}', 'HABITACIONES', '2025-11-24', '17:30:49', '2025-11-24 21:30:49', '2025-11-24 21:30:49'),
(30, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 4, \"piso\": 1, \"estado\": 2, \"precio\": \"800.00\", \"status\": 1, \"capacidad\": 3, \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:49.000000Z\", \"precio_temp\": \"0.00\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": 4}', '{\"id\": 4, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"800\", \"status\": 1, \"capacidad\": \"3\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:56.000000Z\", \"precio_temp\": \"0\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": \"4\"}', 'HABITACIONES', '2025-11-24', '17:30:56', '2025-11-24 21:30:56', '2025-11-24 21:30:56'),
(31, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA MONEDA', '{\"id\": 1, \"codigo\": \"BOB\", \"nombre\": \"Bolivianos\", \"simbolo\": \"Bs\", \"created_at\": \"2025-11-25T20:41:17.000000Z\", \"updated_at\": \"2025-11-25T20:41:17.000000Z\"}', NULL, 'MONEDAS', '2025-11-25', '16:41:17', '2025-11-25 20:41:17', '2025-11-25 20:41:17'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA MONEDA', '{\"id\": 2, \"codigo\": \"USD\", \"nombre\": \"Dólares\", \"simbolo\": \"$us\", \"created_at\": \"2025-11-25T20:42:42.000000Z\", \"updated_at\": \"2025-11-25T20:42:42.000000Z\"}', NULL, 'MONEDAS', '2025-11-25', '16:42:42', '2025-11-25 20:42:42', '2025-11-25 20:42:42'),
(33, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA MONEDA', '{\"id\": 3, \"codigo\": \"EUR\", \"nombre\": \"Euros\", \"simbolo\": \"€\", \"created_at\": \"2025-11-25T20:42:49.000000Z\", \"updated_at\": \"2025-11-25T20:42:49.000000Z\"}', NULL, 'MONEDAS', '2025-11-25', '16:42:50', '2025-11-25 20:42:50', '2025-11-25 20:42:50'),
(34, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE CAMBIO', '{\"id\": 1, \"fecha\": \"2025-11-26\", \"valor\": \"6.91\", \"moneda_id\": \"2\", \"created_at\": \"2025-11-26T13:28:22.000000Z\", \"updated_at\": \"2025-11-26T13:28:22.000000Z\"}', NULL, 'TIPO DE CAMBIO', '2025-11-26', '09:28:22', '2025-11-26 13:28:22', '2025-11-26 13:28:22'),
(35, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE CAMBIO', '{\"id\": 2, \"fecha\": \"2025-11-26\", \"valor\": \"8\", \"moneda_id\": \"3\", \"created_at\": \"2025-11-26T13:39:41.000000Z\", \"updated_at\": \"2025-11-26T13:39:41.000000Z\"}', NULL, 'TIPO DE CAMBIO', '2025-11-26', '09:39:41', '2025-11-26 13:39:41', '2025-11-26 13:39:41'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN HABITACIÓN', '{\"id\": 4, \"piso\": 1, \"estado\": 0, \"precio\": \"800.00\", \"status\": 1, \"capacidad\": 3, \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:56.000000Z\", \"precio_temp\": \"0.00\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": 4}', '{\"id\": 4, \"piso\": \"1\", \"estado\": \"0\", \"precio\": \"800\", \"status\": 1, \"capacidad\": \"3\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-28T14:33:24.000000Z\", \"precio_temp\": \"250\", \"habitacion_fotos\": [{\"id\": 3, \"ext\": \"webp\", \"foto\": \"041764019834.webp\", \"name\": \"041764019834.webp\", \"url_file\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/041764019834.webp\", \"habitacion_id\": 4}, {\"id\": 4, \"ext\": \"jpg\", \"foto\": \"141764019834.jpg\", \"name\": \"141764019834.jpg\", \"url_file\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"created_at\": \"2025-11-24T21:30:34.000000Z\", \"updated_at\": \"2025-11-24T21:30:34.000000Z\", \"url_archivo\": \"http://sishotel.test/imgs/habitacions/141764019834.jpg\", \"habitacion_id\": 4}], \"numero_habitacion\": \"H-004\", \"tipo_habitacion_id\": \"4\"}', 'HABITACIONES', '2025-11-28', '10:33:24', '2025-11-28 14:33:24', '2025-11-28 14:33:24'),
(37, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"123456\", \"id\": 1, \"dir\": \"\", \"edad\": null, \"fono\": \"777777\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"EDUARDO\", \"materno\": \"\", \"paterno\": \"CONDORI\", \"user_id\": 1, \"created_at\": \"2025-11-28T14:58:29.000000Z\", \"updated_at\": \"2025-11-28T14:58:29.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '10:58:29', '2025-11-28 14:58:29', '2025-11-28 14:58:29'),
(38, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:07:12', '2025-11-28 15:07:12', '2025-11-28 15:07:12'),
(39, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"345345354\", \"id\": 3, \"dir\": \"\", \"edad\": null, \"fono\": \"676767\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:09:10.000000Z\", \"updated_at\": \"2025-11-28T15:09:10.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:09:10', '2025-11-28 15:09:10', '2025-11-28 15:09:10'),
(40, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"3453453\", \"id\": 4, \"dir\": \"\", \"edad\": null, \"fono\": \"345345345\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"EDUARDO\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:09:26.000000Z\", \"updated_at\": \"2025-11-28T15:09:26.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:09:26', '2025-11-28 15:09:26', '2025-11-28 15:09:26'),
(41, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN CLIENTE', '{\"ci\": \"3453453\", \"id\": 4, \"dir\": \"\", \"edad\": null, \"fono\": \"345345345\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"EDUARDO\", \"status\": 1, \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:09:26.000000Z\", \"updated_at\": \"2025-11-28T15:09:26.000000Z\", \"nacionalidad\": \"\"}', '{\"ci\": \"3453453\", \"id\": 4, \"dir\": \"\", \"edad\": null, \"fono\": \"345345345\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"FRANZ\", \"status\": 1, \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:09:26.000000Z\", \"updated_at\": \"2025-11-28T15:10:56.000000Z\", \"nacionalidad\": \"\"}', 'CLIENTES', '2025-11-28', '11:10:56', '2025-11-28 15:10:56', '2025-11-28 15:10:56'),
(42, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 12313132, \"id\": 5, \"dir\": \"\", \"edad\": null, \"fono\": \"546456546\", \"pais\": \"\", \"ci_exp\": \"CB\", \"correo\": null, \"nombre\": \"FELIX\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:11:11.000000Z\", \"updated_at\": \"2025-11-28T15:11:11.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:11:11', '2025-11-28 15:11:11', '2025-11-28 15:11:11'),
(43, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 433433434, \"id\": 6, \"dir\": \"\", \"edad\": null, \"fono\": \"676767676\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEJANDRA\", \"materno\": \"\", \"paterno\": \"PALACIOS\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:18:18.000000Z\", \"updated_at\": \"2025-11-28T15:18:18.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:18:18', '2025-11-28 15:18:18', '2025-11-28 15:18:18'),
(44, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 12313123, \"id\": 7, \"dir\": \"\", \"edad\": null, \"fono\": \"234234243\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"JUAN\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:21:35.000000Z\", \"updated_at\": \"2025-11-28T15:21:35.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:21:35', '2025-11-28 15:21:35', '2025-11-28 15:21:35'),
(45, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 3222323, \"id\": 8, \"dir\": \"\", \"edad\": null, \"fono\": \"234234234\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"DANITZ\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:23:45.000000Z\", \"updated_at\": \"2025-11-28T15:23:45.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:23:45', '2025-11-28 15:23:45', '2025-11-28 15:23:45'),
(46, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 34343434, \"id\": 9, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALICIA\", \"materno\": \"\", \"paterno\": \"GUTIERREZ\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:28:24.000000Z\", \"updated_at\": \"2025-11-28T15:28:24.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:28:24', '2025-11-28 15:28:24', '2025-11-28 15:28:24'),
(47, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 43343434, \"id\": 10, \"dir\": \"\", \"edad\": null, \"fono\": \"76767676\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"JOSE\", \"materno\": \"\", \"paterno\": \"PALACIOS\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:29:14.000000Z\", \"updated_at\": \"2025-11-28T15:29:14.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:29:14', '2025-11-28 15:29:14', '2025-11-28 15:29:14'),
(48, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 123456, \"id\": 11, \"dir\": \"\", \"edad\": null, \"fono\": \"23424223\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"JUAN\", \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:30:35.000000Z\", \"updated_at\": \"2025-11-28T15:30:35.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:30:35', '2025-11-28 15:30:35', '2025-11-28 15:30:35'),
(49, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN CLIENTE', '{\"ci\": \"123456\", \"id\": 11, \"dir\": \"\", \"edad\": null, \"fono\": \"23424223\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:30:35.000000Z\", \"updated_at\": \"2025-11-28T15:30:35.000000Z\", \"nacionalidad\": \"\"}', '{\"ci\": \"1234567\", \"id\": 11, \"dir\": \"\", \"edad\": null, \"fono\": \"23424223\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:30:35.000000Z\", \"updated_at\": \"2025-11-28T15:31:11.000000Z\", \"nacionalidad\": \"\"}', 'CLIENTES', '2025-11-28', '11:31:11', '2025-11-28 15:31:11', '2025-11-28 15:31:11'),
(50, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 12345678, \"id\": 12, \"dir\": \"\", \"edad\": null, \"fono\": \"768787878\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALBERTO\", \"materno\": \"\", \"paterno\": \"SURCO\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:31:34.000000Z\", \"updated_at\": \"2025-11-28T15:31:34.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:31:34', '2025-11-28 15:31:34', '2025-11-28 15:31:34'),
(51, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 3131313123, \"id\": 13, \"dir\": \"\", \"edad\": null, \"fono\": \"456456456\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALVARO\", \"materno\": \"\", \"paterno\": \"CHOQUEHUANCA\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:52:50.000000Z\", \"updated_at\": \"2025-11-28T15:52:50.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:52:50', '2025-11-28 15:52:50', '2025-11-28 15:52:50'),
(52, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 3223232, \"id\": 14, \"dir\": \"\", \"edad\": null, \"fono\": \"234234243234\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"SANDRA\", \"materno\": \"\", \"paterno\": \"ALVARES\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:53:14.000000Z\", \"updated_at\": \"2025-11-28T15:53:14.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:53:14', '2025-11-28 15:53:14', '2025-11-28 15:53:14'),
(53, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 433434, \"id\": 15, \"dir\": \"\", \"edad\": null, \"fono\": \"6556657567\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ESTHER\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:55:14.000000Z\", \"updated_at\": \"2025-11-28T15:55:14.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:55:14', '2025-11-28 15:55:14', '2025-11-28 15:55:14'),
(54, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 3456456465, \"id\": 16, \"dir\": \"\", \"edad\": null, \"fono\": \"67676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"JORGE\", \"materno\": \"\", \"paterno\": \"CALLISAYA\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:56:35.000000Z\", \"updated_at\": \"2025-11-28T15:56:35.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:56:35', '2025-11-28 15:56:35', '2025-11-28 15:56:35'),
(55, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 535345, \"id\": 17, \"dir\": \"\", \"edad\": null, \"fono\": \"345345345\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"GROVER\", \"materno\": \"\", \"paterno\": \"SOLIZ\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:57:15.000000Z\", \"updated_at\": \"2025-11-28T15:57:15.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:57:15', '2025-11-28 15:57:15', '2025-11-28 15:57:15'),
(56, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 3423456, \"id\": 18, \"dir\": \"\", \"edad\": null, \"fono\": \"546456456\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"AFDSF\", \"materno\": \"\", \"paterno\": \"ASDFASDF\", \"user_id\": 1, \"created_at\": \"2025-11-28T15:59:29.000000Z\", \"updated_at\": \"2025-11-28T15:59:29.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '11:59:29', '2025-11-28 15:59:29', '2025-11-28 15:59:29'),
(57, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 1213233, \"id\": 19, \"dir\": \"\", \"edad\": null, \"fono\": \"123123\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ERERERER\", \"materno\": \"\", \"paterno\": \"ERERER\", \"user_id\": 1, \"created_at\": \"2025-11-28T16:04:49.000000Z\", \"updated_at\": \"2025-11-28T16:04:49.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '12:04:49', '2025-11-28 16:04:49', '2025-11-28 16:04:49'),
(58, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 1231313, \"id\": 20, \"dir\": \"\", \"edad\": null, \"fono\": \"1321313\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ELVIS\", \"materno\": \"\", \"paterno\": \"SANTA CRUZ\", \"user_id\": 1, \"created_at\": \"2025-11-28T16:06:16.000000Z\", \"updated_at\": \"2025-11-28T16:06:16.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '12:06:16', '2025-11-28 16:06:16', '2025-11-28 16:06:16'),
(59, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 4535345, \"id\": 21, \"dir\": \"\", \"edad\": null, \"fono\": \"1321312\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"JOSUE\", \"materno\": \"\", \"paterno\": \"AGUIRRE\", \"user_id\": 1, \"created_at\": \"2025-11-28T16:06:48.000000Z\", \"updated_at\": \"2025-11-28T16:06:48.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '12:06:48', '2025-11-28 16:06:48', '2025-11-28 16:06:48'),
(60, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 123131, \"id\": 22, \"dir\": \"\", \"edad\": null, \"fono\": \"3434\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEXANDER\", \"materno\": \"\", \"paterno\": \"SURCO\", \"user_id\": 1, \"created_at\": \"2025-11-28T16:07:05.000000Z\", \"updated_at\": \"2025-11-28T16:07:05.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '12:07:05', '2025-11-28 16:07:05', '2025-11-28 16:07:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso_productos`
--

CREATE TABLE `ingreso_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `precio_compra` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_01_31_165641_create_configuracions_table', 1),
(2, '2025_09_21_105915_create_users_table', 1),
(3, '2025_09_21_105919_create_clientes_table', 1),
(4, '2025_09_21_106000_create_historial_accions_table', 1),
(5, '2025_11_21_115140_create_monedas_table', 1),
(6, '2025_11_21_115141_create_tipo_cambios_table', 1),
(7, '2025_11_21_115144_create_tipo_habitacions_table', 1),
(8, '2025_11_21_115149_create_habitacions_table', 1),
(9, '2025_11_21_115151_create_registros_table', 1),
(10, '2025_11_21_115208_create_tipo_productos_table', 1),
(11, '2025_11_21_115211_create_productos_table', 1),
(12, '2025_11_21_115215_create_ingreso_productos_table', 1),
(13, '2025_11_21_115219_create_egreso_productos_table', 1),
(14, '2025_11_21_115246_create_cajas_table', 1),
(15, '2025_11_21_115252_create_movimiento_cajas_table', 1),
(16, '2025_11_21_120947_create_registro_servicios_table', 1),
(17, '2025_11_22_135016_create_servicio_detalles_table', 1),
(18, '2025_11_23_105258_create_habitacion_fotos_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `monedas`
--

CREATE TABLE `monedas` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `simbolo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `oficial` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `monedas`
--

INSERT INTO `monedas` (`id`, `codigo`, `nombre`, `simbolo`, `oficial`, `created_at`, `updated_at`) VALUES
(1, 'BOB', 'Bolivianos', 'Bs', 1, '2025-11-25 20:41:17', '2025-11-25 20:41:17'),
(2, 'USD', 'Dólares', '$us', 0, '2025-11-25 20:42:42', '2025-11-25 20:42:42'),
(3, 'EUR', 'Euros', '€', 0, '2025-11-25 20:42:49', '2025-11-25 20:42:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento_cajas`
--

CREATE TABLE `movimiento_cajas` (
  `id` bigint UNSIGNED NOT NULL,
  `caja_id` bigint UNSIGNED NOT NULL,
  `modelo_id` bigint UNSIGNED DEFAULT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto` decimal(24,2) NOT NULL,
  `moneda_id` bigint UNSIGNED NOT NULL,
  `monto_tc` decimal(24,2) DEFAULT '0.00',
  `moneda_id_tc` bigint UNSIGNED DEFAULT NULL,
  `tipo_cambio_id` bigint UNSIGNED DEFAULT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `efectivo_banco` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_movimiento` date NOT NULL,
  `hora_movimiento` time NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio` decimal(24,2) NOT NULL,
  `tipo_producto_id` bigint UNSIGNED NOT NULL,
  `stock` double NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros`
--

CREATE TABLE `registros` (
  `id` bigint UNSIGNED NOT NULL,
  `habitacion_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `desayuno` int NOT NULL DEFAULT '0',
  `fecha_entrada` date NOT NULL,
  `hora_entrada` time NOT NULL,
  `dias_estadia` int DEFAULT '0',
  `fecha_salida` date DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `hora_salida_reg` time DEFAULT NULL,
  `cd` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `adelanto` decimal(24,2) DEFAULT '0.00',
  `saldo` decimal(24,2) DEFAULT '0.00',
  `garantia` decimal(24,2) DEFAULT '0.00',
  `moneda_id` bigint UNSIGNED NOT NULL,
  `tc` int NOT NULL DEFAULT '0',
  `cd_tc` decimal(24,2) DEFAULT NULL,
  `total_tc` decimal(24,2) DEFAULT '0.00',
  `adelanto_tc` decimal(24,2) DEFAULT '0.00',
  `saldo_tc` decimal(24,2) DEFAULT '0.00',
  `garantia_tc` decimal(24,2) DEFAULT '0.00',
  `moneda_id_tc` bigint UNSIGNED DEFAULT NULL,
  `tipo_cambio_id` bigint UNSIGNED DEFAULT NULL,
  `motivo_salida` text COLLATE utf8mb4_unicode_ci,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `fecha_reserva` date DEFAULT NULL,
  `hora_reserva` time DEFAULT NULL,
  `nro_reserva` bigint DEFAULT NULL,
  `cod_reserva` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_reserva` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dev_garantia` int DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_servicios`
--

CREATE TABLE `registro_servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `cancelado` decimal(24,2) NOT NULL DEFAULT '0.00',
  `saldo` decimal(24,2) NOT NULL,
  `moneda_id` bigint UNSIGNED NOT NULL,
  `total_tc` decimal(24,2) DEFAULT '0.00',
  `cancelado_tc` decimal(24,2) NOT NULL DEFAULT '0.00',
  `saldo_tc` decimal(24,2) NOT NULL,
  `moneda_id_tc` bigint UNSIGNED DEFAULT NULL,
  `tipo_cambio_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_detalles`
--

CREATE TABLE `servicio_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_servicio_id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_externo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(24,2) NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `cancelado` decimal(24,2) NOT NULL DEFAULT '0.00',
  `saldo` decimal(24,2) NOT NULL,
  `moneda_id` bigint UNSIGNED NOT NULL,
  `total_tc` decimal(24,2) DEFAULT '0.00',
  `cancelado_tc` decimal(24,2) NOT NULL DEFAULT '0.00',
  `saldo_tc` decimal(24,2) NOT NULL,
  `moneda_id_tc` bigint UNSIGNED DEFAULT NULL,
  `tipo_cambio_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cambios`
--

CREATE TABLE `tipo_cambios` (
  `id` bigint UNSIGNED NOT NULL,
  `moneda_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `valor` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_cambios`
--

INSERT INTO `tipo_cambios` (`id`, `moneda_id`, `fecha`, `valor`, `created_at`, `updated_at`) VALUES
(1, 2, '2025-11-26', 6.91, '2025-11-26 13:28:22', '2025-11-26 13:28:22'),
(2, 3, '2025-11-26', 8.00, '2025-11-26 13:39:41', '2025-11-26 13:39:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_habitacions`
--

CREATE TABLE `tipo_habitacions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacidad` int DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_habitacions`
--

INSERT INTO `tipo_habitacions` (`id`, `nombre`, `capacidad`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'SIMPLE', NULL, '', '2025-11-24 20:26:26', '2025-11-24 20:39:44'),
(2, 'DOBLE', 2, '', '2025-11-24 20:42:10', '2025-11-24 20:42:10'),
(3, 'MATRIMONIAL', 2, 'MATRIMONIAL', '2025-11-24 20:43:24', '2025-11-24 20:44:38'),
(4, 'FAMILIAR 1', 3, '', '2025-11-24 20:47:31', '2025-11-24 20:47:31'),
(5, 'FAMILIAR 2', 5, '', '2025-11-24 20:47:36', '2025-11-24 20:47:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_productos`
--

CREATE TABLE `tipo_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(800) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `fono`, `fecha_nac`, `correo`, `usuario`, `password`, `acceso`, `tipo`, `foto`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 1, 'ADMINISTRADOR', NULL, '2025-11-24', 1, '2025-11-24 20:04:52', '2025-11-24 20:04:52');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cajas_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientes_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `egreso_productos`
--
ALTER TABLE `egreso_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `egreso_productos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `habitacions`
--
ALTER TABLE `habitacions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `habitacions_numero_habitacion_unique` (`numero_habitacion`),
  ADD KEY `habitacions_tipo_habitacion_id_foreign` (`tipo_habitacion_id`);

--
-- Indices de la tabla `habitacion_fotos`
--
ALTER TABLE `habitacion_fotos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `habitacion_fotos_habitacion_id_foreign` (`habitacion_id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_accions_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingreso_productos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `monedas`
--
ALTER TABLE `monedas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `movimiento_cajas`
--
ALTER TABLE `movimiento_cajas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movimiento_cajas_caja_id_foreign` (`caja_id`),
  ADD KEY `movimiento_cajas_user_id_foreign` (`user_id`),
  ADD KEY `movimiento_cajas_moneda_id_foreign` (`moneda_id`),
  ADD KEY `movimiento_cajas_moneda_id_tc_foreign` (`moneda_id_tc`),
  ADD KEY `movimiento_cajas_tipo_cambio_id_foreign` (`tipo_cambio_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_tipo_producto_id_foreign` (`tipo_producto_id`);

--
-- Indices de la tabla `registros`
--
ALTER TABLE `registros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registros_habitacion_id_foreign` (`habitacion_id`),
  ADD KEY `registros_cliente_id_foreign` (`cliente_id`),
  ADD KEY `registros_moneda_id_foreign` (`moneda_id`),
  ADD KEY `registros_moneda_id_tc_foreign` (`moneda_id_tc`),
  ADD KEY `registros_tipo_cambio_id_foreign` (`tipo_cambio_id`),
  ADD KEY `registros_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `registro_servicios`
--
ALTER TABLE `registro_servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registro_servicios_registro_id_foreign` (`registro_id`),
  ADD KEY `registro_servicios_moneda_id_foreign` (`moneda_id`),
  ADD KEY `registro_servicios_moneda_id_tc_foreign` (`moneda_id_tc`),
  ADD KEY `registro_servicios_tipo_cambio_id_foreign` (`tipo_cambio_id`);

--
-- Indices de la tabla `servicio_detalles`
--
ALTER TABLE `servicio_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servicio_detalles_registro_servicio_id_foreign` (`registro_servicio_id`),
  ADD KEY `servicio_detalles_registro_id_foreign` (`registro_id`),
  ADD KEY `servicio_detalles_producto_id_foreign` (`producto_id`),
  ADD KEY `servicio_detalles_moneda_id_foreign` (`moneda_id`),
  ADD KEY `servicio_detalles_moneda_id_tc_foreign` (`moneda_id_tc`),
  ADD KEY `servicio_detalles_tipo_cambio_id_foreign` (`tipo_cambio_id`);

--
-- Indices de la tabla `tipo_cambios`
--
ALTER TABLE `tipo_cambios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_habitacions`
--
ALTER TABLE `tipo_habitacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_productos`
--
ALTER TABLE `tipo_productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cajas`
--
ALTER TABLE `cajas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `egreso_productos`
--
ALTER TABLE `egreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habitacions`
--
ALTER TABLE `habitacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `habitacion_fotos`
--
ALTER TABLE `habitacion_fotos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `monedas`
--
ALTER TABLE `monedas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `movimiento_cajas`
--
ALTER TABLE `movimiento_cajas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registros`
--
ALTER TABLE `registros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registro_servicios`
--
ALTER TABLE `registro_servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicio_detalles`
--
ALTER TABLE `servicio_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_cambios`
--
ALTER TABLE `tipo_cambios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_habitacions`
--
ALTER TABLE `tipo_habitacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_productos`
--
ALTER TABLE `tipo_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD CONSTRAINT `cajas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `egreso_productos`
--
ALTER TABLE `egreso_productos`
  ADD CONSTRAINT `egreso_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `habitacions`
--
ALTER TABLE `habitacions`
  ADD CONSTRAINT `habitacions_tipo_habitacion_id_foreign` FOREIGN KEY (`tipo_habitacion_id`) REFERENCES `tipo_habitacions` (`id`);

--
-- Filtros para la tabla `habitacion_fotos`
--
ALTER TABLE `habitacion_fotos`
  ADD CONSTRAINT `habitacion_fotos_habitacion_id_foreign` FOREIGN KEY (`habitacion_id`) REFERENCES `habitacions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD CONSTRAINT `historial_accions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  ADD CONSTRAINT `ingreso_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `movimiento_cajas`
--
ALTER TABLE `movimiento_cajas`
  ADD CONSTRAINT `movimiento_cajas_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`),
  ADD CONSTRAINT `movimiento_cajas_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `movimiento_cajas_moneda_id_tc_foreign` FOREIGN KEY (`moneda_id_tc`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `movimiento_cajas_tipo_cambio_id_foreign` FOREIGN KEY (`tipo_cambio_id`) REFERENCES `tipo_cambios` (`id`),
  ADD CONSTRAINT `movimiento_cajas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_tipo_producto_id_foreign` FOREIGN KEY (`tipo_producto_id`) REFERENCES `tipo_productos` (`id`);

--
-- Filtros para la tabla `registros`
--
ALTER TABLE `registros`
  ADD CONSTRAINT `registros_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `registros_habitacion_id_foreign` FOREIGN KEY (`habitacion_id`) REFERENCES `habitacions` (`id`),
  ADD CONSTRAINT `registros_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `registros_moneda_id_tc_foreign` FOREIGN KEY (`moneda_id_tc`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `registros_tipo_cambio_id_foreign` FOREIGN KEY (`tipo_cambio_id`) REFERENCES `tipo_cambios` (`id`),
  ADD CONSTRAINT `registros_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `registro_servicios`
--
ALTER TABLE `registro_servicios`
  ADD CONSTRAINT `registro_servicios_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `registro_servicios_moneda_id_tc_foreign` FOREIGN KEY (`moneda_id_tc`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `registro_servicios_registro_id_foreign` FOREIGN KEY (`registro_id`) REFERENCES `registros` (`id`),
  ADD CONSTRAINT `registro_servicios_tipo_cambio_id_foreign` FOREIGN KEY (`tipo_cambio_id`) REFERENCES `tipo_cambios` (`id`);

--
-- Filtros para la tabla `servicio_detalles`
--
ALTER TABLE `servicio_detalles`
  ADD CONSTRAINT `servicio_detalles_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `servicio_detalles_moneda_id_tc_foreign` FOREIGN KEY (`moneda_id_tc`) REFERENCES `monedas` (`id`),
  ADD CONSTRAINT `servicio_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `servicio_detalles_registro_id_foreign` FOREIGN KEY (`registro_id`) REFERENCES `registros` (`id`),
  ADD CONSTRAINT `servicio_detalles_registro_servicio_id_foreign` FOREIGN KEY (`registro_servicio_id`) REFERENCES `registro_servicios` (`id`),
  ADD CONSTRAINT `servicio_detalles_tipo_cambio_id_foreign` FOREIGN KEY (`tipo_cambio_id`) REFERENCES `tipo_cambios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
