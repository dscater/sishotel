-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-12-2025 a las 15:25:50
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

--
-- Volcado de datos para la tabla `cajas`
--

INSERT INTO `cajas` (`id`, `monto_inicial`, `monto_final`, `monto_efectivo_inicial`, `monto_efectivo_final`, `monto_banco_inicial`, `monto_banco_final`, `fecha_apertura`, `hora_apertura`, `fecha_cierre`, `hora_cierre`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 0.00, 5504.00, 0.00, 4101.50, 0.00, 1402.50, '2025-12-22', '20:42:27', NULL, NULL, 1, 1, '2025-12-23 00:42:27', '2025-12-24 15:23:29');

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

--
-- Volcado de datos para la tabla `egreso_productos`
--

INSERT INTO `egreso_productos` (`id`, `producto_id`, `cantidad`, `motivo`, `fecha_egreso`, `created_at`, `updated_at`) VALUES
(3, 1, 1, 'SALIDA POR ROTURA', '2025-12-23', '2025-12-23 22:47:14', '2025-12-23 22:47:14');

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
(1, 'H-001', 1, 0, 1, 300.00, 0.00, 1, 1, '2025-11-24 21:08:48', '2025-12-23 23:34:53'),
(2, 'H-002', 2, 1, 2, 500.00, 0.00, 4, 1, '2025-11-24 21:17:59', '2025-12-24 15:04:40'),
(3, 'H-003', 3, 1, 2, 800.00, 200.00, 3, 1, '2025-11-24 21:23:46', '2025-12-24 15:23:37'),
(4, 'H-004', 4, 1, 3, 800.00, 250.00, 3, 1, '2025-11-24 21:30:34', '2025-12-24 15:23:17');

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
(60, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": 123131, \"id\": 22, \"dir\": \"\", \"edad\": null, \"fono\": \"3434\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEXANDER\", \"materno\": \"\", \"paterno\": \"SURCO\", \"user_id\": 1, \"created_at\": \"2025-11-28T16:07:05.000000Z\", \"updated_at\": \"2025-11-28T16:07:05.000000Z\", \"nacionalidad\": \"\"}', NULL, 'CLIENTES', '2025-11-28', '12:07:05', '2025-11-28 16:07:05', '2025-11-28 16:07:05'),
(61, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"800\", \"id\": 1, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0\", \"total\": \"800\", \"user_id\": 1, \"adelanto\": \"800\", \"desayuno\": \"1\", \"garantia\": \"0\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"7\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T19:06:58.000000Z\", \"adelanto_tc\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00\", \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50\", \"moneda_id_tc\": \"1\", \"fecha_entrada\": \"2025-12-03\", \"habitacion_id\": \"4\"}', NULL, 'REGISTROS', '2025-12-03', '15:06:58', '2025-12-03 19:06:58', '2025-12-03 19:06:58'),
(62, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 2, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"2400\", \"total\": \"2400\", \"user_id\": 1, \"adelanto\": \"0\", \"desayuno\": \"1\", \"garantia\": \"0\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"11\", \"created_at\": \"2025-12-03T19:08:25.000000Z\", \"updated_at\": \"2025-12-03T19:08:25.000000Z\", \"adelanto_tc\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00\", \"dias_estadia\": \"3\", \"fecha_salida\": \"2025-12-06\", \"hora_entrada\": \"15:08\", \"moneda_id_tc\": \"1\", \"fecha_entrada\": \"2025-12-03\", \"habitacion_id\": \"3\"}', NULL, 'REGISTROS', '2025-12-03', '15:08:25', '2025-12-03 19:08:25', '2025-12-03 19:08:25'),
(63, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"12313123\", \"id\": 7, \"dir\": \"\", \"edad\": null, \"fono\": \"234234243\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:21:35.000000Z\", \"updated_at\": \"2025-11-28T15:21:35.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 7, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T19:06:58.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 1, \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0\", \"total\": \"800\", \"status\": 1, \"cliente\": {\"ci\": \"123456\", \"id\": 1, \"dir\": \"\", \"edad\": null, \"fono\": \"777777\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"EDUARDO\", \"status\": 1, \"materno\": \"\", \"paterno\": \"CONDORI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T14:58:29.000000Z\", \"updated_at\": \"2025-11-28T14:58:29.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"1\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T20:27:41.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '16:27:41', '2025-12-03 20:27:41', '2025-12-03 20:27:41'),
(64, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"123456\", \"id\": 1, \"dir\": \"\", \"edad\": null, \"fono\": \"777777\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"EDUARDO\", \"status\": 1, \"materno\": \"\", \"paterno\": \"CONDORI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T14:58:29.000000Z\", \"updated_at\": \"2025-11-28T14:58:29.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 1, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T20:27:41.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 1, \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0\", \"total\": \"800\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T20:29:41.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '16:29:41', '2025-12-03 20:29:42', '2025-12-03 20:29:42'),
(65, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 2, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"2400.00\", \"total\": \"2400.00\", \"status\": 1, \"cliente\": {\"ci\": \"1234567\", \"id\": 11, \"dir\": \"\", \"edad\": null, \"fono\": \"23424223\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:30:35.000000Z\", \"updated_at\": \"2025-11-28T15:31:11.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"0.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 11, \"created_at\": \"2025-12-03T19:08:25.000000Z\", \"updated_at\": \"2025-12-03T19:08:25.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 3, \"fecha_salida\": \"2025-12-06\", \"hora_entrada\": \"15:08:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 3, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 2, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"2400\", \"total\": \"2400\", \"status\": 1, \"cliente\": {\"ci\": \"3222323\", \"id\": 8, \"dir\": \"\", \"edad\": null, \"fono\": \"234234234\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"DANITZ\", \"status\": 1, \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:23:45.000000Z\", \"updated_at\": \"2025-11-28T15:23:45.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"0.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"8\", \"created_at\": \"2025-12-03T19:08:25.000000Z\", \"updated_at\": \"2025-12-03T20:30:10.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"3\", \"fecha_salida\": \"2025-12-06\", \"hora_entrada\": \"15:08:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 3, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '16:30:10', '2025-12-03 20:30:10', '2025-12-03 20:30:10');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(66, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T20:29:41.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 1, \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800\", \"total\": \"1600\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T20:30:20.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '16:30:20', '2025-12-03 20:30:20', '2025-12-03 20:30:20'),
(67, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T20:30:20.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0\", \"total\": \"800\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:19:52.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '18:19:52', '2025-12-03 22:19:52', '2025-12-03 22:19:52'),
(68, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:19:52.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 1, \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800\", \"total\": \"1600\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:20:20.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '18:20:20', '2025-12-03 22:20:20', '2025-12-03 22:20:20'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:20:20.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0\", \"total\": \"800\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:20:33.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '18:20:33', '2025-12-03 22:20:33', '2025-12-03 22:20:33'),
(70, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:20:33.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 1, \"fecha_salida\": \"2025-12-04\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800\", \"total\": \"1600\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:20:41.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '18:20:41', '2025-12-03 22:20:41', '2025-12-03 22:20:41'),
(71, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UNA TRANSFERENCIA DE HABITACIÓN', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T22:20:41.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T23:08:59.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": \"1\", \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '19:08:59', '2025-12-03 23:08:59', '2025-12-03 23:08:59'),
(72, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UNA TRANSFERENCIA DE HABITACIÓN', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T23:08:59.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 1, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T23:11:34.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": \"2\", \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '19:11:34', '2025-12-03 23:11:34', '2025-12-03 23:11:34'),
(73, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 2, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"2400.00\", \"total\": \"2400.00\", \"status\": 1, \"cliente\": {\"ci\": \"3222323\", \"id\": 8, \"dir\": \"\", \"edad\": null, \"fono\": \"234234234\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"DANITZ\", \"status\": 1, \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:23:45.000000Z\", \"updated_at\": \"2025-11-28T15:23:45.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"0.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 8, \"created_at\": \"2025-12-03T19:08:25.000000Z\", \"updated_at\": \"2025-12-03T20:30:10.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 3, \"fecha_salida\": \"2025-12-06\", \"hora_entrada\": \"15:08:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 3, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 2, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"2400\", \"total\": \"2400\", \"status\": 1, \"cliente\": {\"ci\": \"3222323\", \"id\": 8, \"dir\": \"\", \"edad\": null, \"fono\": \"234234234\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"DANITZ\", \"status\": 1, \"materno\": \"\", \"paterno\": \"GONZALES\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:23:45.000000Z\", \"updated_at\": \"2025-11-28T15:23:45.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"0.00\", \"desayuno\": \"0\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"8\", \"created_at\": \"2025-12-03T19:08:25.000000Z\", \"updated_at\": \"2025-12-03T23:15:38.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"3\", \"fecha_salida\": \"2025-12-06\", \"hora_entrada\": \"15:08:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 3, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-03', '19:15:38', '2025-12-03 23:15:38', '2025-12-03 23:15:38'),
(74, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE PRODUCTO', '{\"id\": 1, \"nombre\": \"Tipo Producto 1\", \"created_at\": \"2025-12-03T23:33:56.000000Z\", \"updated_at\": \"2025-12-03T23:33:56.000000Z\", \"descripcion\": null}', NULL, 'TIPO DE PRODUCTOS', '2025-12-03', '19:33:56', '2025-12-03 23:33:56', '2025-12-03 23:33:56'),
(75, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO', '{\"id\": 1, \"nombre\": \"Tipo Producto 1\", \"created_at\": \"2025-12-03T23:33:56.000000Z\", \"updated_at\": \"2025-12-03T23:33:56.000000Z\", \"descripcion\": null}', '{\"id\": 1, \"nombre\": \"TIPO PRODUCTO 1\", \"created_at\": \"2025-12-03T23:33:56.000000Z\", \"updated_at\": \"2025-12-03T23:36:48.000000Z\", \"descripcion\": \"\"}', 'TIPO DE PRODUCTOS', '2025-12-03', '19:36:48', '2025-12-03 23:36:48', '2025-12-03 23:36:48'),
(76, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE PRODUCTO', '{\"id\": 2, \"nombre\": \"TIPO PRODUCTO 2\", \"created_at\": \"2025-12-03T23:37:37.000000Z\", \"updated_at\": \"2025-12-03T23:37:37.000000Z\", \"descripcion\": \"DESC\"}', NULL, 'TIPO DE PRODUCTOS', '2025-12-03', '19:37:37', '2025-12-03 23:37:37', '2025-12-03 23:37:37'),
(77, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 1, \"nombre\": \"PRODUCTO 1\", \"precio\": \"200\", \"created_at\": \"2025-12-03T23:54:15.000000Z\", \"updated_at\": \"2025-12-03T23:54:15.000000Z\", \"descripcion\": \"DESC\", \"tipo_producto_id\": \"1\"}', NULL, 'PRODUCTOS', '2025-12-03', '19:54:15', '2025-12-03 23:54:15', '2025-12-03 23:54:15'),
(78, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 2, \"nombre\": \"PRODUCTO 2\", \"precio\": \"80.5\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-03T23:55:06.000000Z\", \"descripcion\": \"DESC\", \"tipo_producto_id\": \"2\"}', NULL, 'PRODUCTOS', '2025-12-03', '19:55:06', '2025-12-03 23:55:06', '2025-12-03 23:55:06'),
(79, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN PRODUCTO', '{\"id\": 2, \"stock\": 0, \"imagen\": null, \"nombre\": \"PRODUCTO 2\", \"precio\": \"80.50\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-03T23:55:06.000000Z\", \"descripcion\": \"DESC\", \"tipo_producto_id\": 2}', '{\"id\": 2, \"stock\": 0, \"imagen\": \"21764806641.png\", \"nombre\": \"PRODUCTO 2\", \"precio\": \"80.50\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-04T00:04:01.000000Z\", \"descripcion\": \"DESC\", \"tipo_producto_id\": \"2\"}', 'PRODUCTOS', '2025-12-03', '20:04:01', '2025-12-04 00:04:01', '2025-12-04 00:04:01'),
(80, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN PRODUCTO', '{\"id\": 2, \"stock\": 0, \"imagen\": \"21764806641.png\", \"nombre\": \"PRODUCTO 2\", \"precio\": \"80.50\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-04T00:04:01.000000Z\", \"descripcion\": \"DESC\", \"tipo_producto_id\": 2}', '{\"id\": 2, \"stock\": 0, \"imagen\": \"21764806725.jpeg\", \"nombre\": \"PRODUCTO 2\", \"precio\": \"80.50\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-04T00:05:25.000000Z\", \"descripcion\": \"DESC\", \"tipo_producto_id\": \"2\"}', 'PRODUCTOS', '2025-12-03', '20:05:25', '2025-12-04 00:05:25', '2025-12-04 00:05:25'),
(81, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 1, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": 2, \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-03T23:11:34.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 2, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"800\", \"total\": \"1600\", \"status\": 1, \"cliente\": {\"ci\": \"56565656\", \"id\": 2, \"dir\": \"\", \"edad\": null, \"fono\": \"6767676767\", \"pais\": \"\", \"ci_exp\": null, \"correo\": null, \"nombre\": \"ALEX\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:07:12.000000Z\", \"updated_at\": \"2025-11-28T15:07:12.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"2\", \"created_at\": \"2025-12-03T19:06:58.000000Z\", \"updated_at\": \"2025-12-16T19:41:00.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-05\", \"hora_entrada\": \"14:50:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"1\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-03\", \"fecha_reserva\": null, \"habitacion_id\": 2, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-16', '15:41:00', '2025-12-16 19:41:00', '2025-12-16 19:41:00'),
(82, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE CAMBIO', '{\"id\": 3, \"fecha\": \"2025-12-16\", \"valor\": \"6.98\", \"moneda_id\": \"2\", \"created_at\": \"2025-12-16T19:59:31.000000Z\", \"updated_at\": \"2025-12-16T19:59:31.000000Z\"}', NULL, 'TIPO DE CAMBIO', '2025-12-16', '15:59:31', '2025-12-16 19:59:31', '2025-12-16 19:59:31'),
(83, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 3, \"tc\": \"1\", \"tipo\": \"NORMAL\", \"cd_tc\": \"114.61\", \"saldo\": \"0\", \"total\": \"2400\", \"user_id\": 1, \"adelanto\": \"2400\", \"desayuno\": \"0\", \"garantia\": \"349\", \"saldo_tc\": \"0\", \"total_tc\": \"343.84\", \"moneda_id\": 1, \"cliente_id\": \"3\", \"created_at\": \"2025-12-16T21:21:51.000000Z\", \"updated_at\": \"2025-12-16T21:21:51.000000Z\", \"adelanto_tc\": \"343.84\", \"garantia_tc\": \"50\", \"hora_salida\": \"12:00\", \"dias_estadia\": \"3\", \"fecha_salida\": \"2025-12-19\", \"hora_entrada\": \"17:21\", \"moneda_id_tc\": \"2\", \"fecha_entrada\": \"2025-12-16\", \"habitacion_id\": \"4\"}', NULL, 'REGISTROS', '2025-12-16', '17:21:51', '2025-12-16 21:21:51', '2025-12-16 21:21:51'),
(84, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 3, \"tc\": 1, \"tipo\": \"NORMAL\", \"cd_tc\": \"114.61\", \"saldo\": \"0.00\", \"total\": \"2400.00\", \"status\": 1, \"cliente\": {\"ci\": \"345345354\", \"id\": 3, \"dir\": \"\", \"edad\": null, \"fono\": \"676767\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:09:10.000000Z\", \"updated_at\": \"2025-11-28T15:09:10.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"2400.00\", \"desayuno\": 0, \"garantia\": \"349.00\", \"saldo_tc\": \"0.00\", \"total_tc\": \"343.84\", \"valor_tc\": null, \"moneda_id\": 1, \"cliente_id\": 3, \"created_at\": \"2025-12-16T21:21:51.000000Z\", \"updated_at\": \"2025-12-16T21:21:51.000000Z\", \"adelanto_tc\": \"343.84\", \"cod_reserva\": null, \"garantia_tc\": \"50.00\", \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 3, \"fecha_salida\": \"2025-12-19\", \"hora_entrada\": \"17:21:00\", \"hora_reserva\": null, \"moneda_id_tc\": 2, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-16\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 3, \"tc\": \"1\", \"tipo\": \"NORMAL\", \"cd_tc\": \"114.61\", \"saldo\": \"0\", \"total\": \"2400\", \"status\": 1, \"cliente\": {\"ci\": \"345345354\", \"id\": 3, \"dir\": \"\", \"edad\": null, \"fono\": \"676767\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:09:10.000000Z\", \"updated_at\": \"2025-11-28T15:09:10.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"2400.00\", \"desayuno\": \"1\", \"garantia\": \"349.00\", \"saldo_tc\": \"0\", \"total_tc\": \"343.84\", \"valor_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"3\", \"created_at\": \"2025-12-16T21:21:51.000000Z\", \"updated_at\": \"2025-12-16T21:25:35.000000Z\", \"adelanto_tc\": \"343.84\", \"cod_reserva\": null, \"garantia_tc\": \"50\", \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"3\", \"fecha_salida\": \"2025-12-19\", \"hora_entrada\": \"17:21:00\", \"hora_reserva\": null, \"moneda_id_tc\": \"2\", \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-16\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-16', '17:25:35', '2025-12-16 21:25:35', '2025-12-16 21:25:35'),
(85, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE PRODUCTO', '{\"id\": 3, \"tipo\": \"SERVICIO\", \"nombre\": \"SERVICIO 1\", \"created_at\": \"2025-12-17T19:26:30.000000Z\", \"updated_at\": \"2025-12-17T19:26:30.000000Z\", \"descripcion\": \"DESC\"}', NULL, 'TIPO DE PRODUCTOS', '2025-12-17', '15:26:30', '2025-12-17 19:26:30', '2025-12-17 19:26:30'),
(86, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 3, \"nombre\": \"SERVICIO PROD\", \"precio\": \"190\", \"created_at\": \"2025-12-17T19:33:36.000000Z\", \"updated_at\": \"2025-12-17T19:33:36.000000Z\", \"descripcion\": \"\", \"control_stock\": 0, \"tipo_producto_id\": \"3\"}', NULL, 'PRODUCTOS', '2025-12-17', '15:33:36', '2025-12-17 19:33:36', '2025-12-17 19:33:36'),
(87, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO', '{\"id\": 1, \"tipo\": \"PRODUCTO\", \"nombre\": \"TIPO PRODUCTO 1\", \"created_at\": \"2025-12-03T23:33:56.000000Z\", \"updated_at\": \"2025-12-03T23:36:48.000000Z\", \"descripcion\": \"\"}', '{\"id\": 1, \"tipo\": \"PRODUCTO\", \"nombre\": \"BEBIDAS\", \"created_at\": \"2025-12-03T23:33:56.000000Z\", \"updated_at\": \"2025-12-17T19:36:14.000000Z\", \"descripcion\": \"\"}', 'TIPO DE PRODUCTOS', '2025-12-17', '15:36:14', '2025-12-17 19:36:14', '2025-12-17 19:36:14'),
(88, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO', '{\"id\": 2, \"tipo\": \"PRODUCTO\", \"nombre\": \"TIPO PRODUCTO 2\", \"created_at\": \"2025-12-03T23:37:37.000000Z\", \"updated_at\": \"2025-12-03T23:37:37.000000Z\", \"descripcion\": \"DESC\"}', '{\"id\": 2, \"tipo\": \"PRODUCTO\", \"nombre\": \"COMIDAS\", \"created_at\": \"2025-12-03T23:37:37.000000Z\", \"updated_at\": \"2025-12-17T19:36:22.000000Z\", \"descripcion\": \"DESC\"}', 'TIPO DE PRODUCTOS', '2025-12-17', '15:36:22', '2025-12-17 19:36:22', '2025-12-17 19:36:22'),
(89, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE PRODUCTO', '{\"id\": 4, \"tipo\": \"PRODUCTO\", \"nombre\": \"DESAYUNO\", \"created_at\": \"2025-12-17T19:36:34.000000Z\", \"updated_at\": \"2025-12-17T19:36:34.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE PRODUCTOS', '2025-12-17', '15:36:34', '2025-12-17 19:36:34', '2025-12-17 19:36:34'),
(90, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE PRODUCTO', '{\"id\": 5, \"tipo\": \"SERVICIO\", \"nombre\": \"RUPTURA DE VAJILLAS\", \"created_at\": \"2025-12-17T19:36:49.000000Z\", \"updated_at\": \"2025-12-17T19:36:49.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE PRODUCTOS', '2025-12-17', '15:36:49', '2025-12-17 19:36:49', '2025-12-17 19:36:49'),
(91, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE PRODUCTO', '{\"id\": 6, \"tipo\": \"SERVICIO\", \"nombre\": \"OTROS SERVICIOS\", \"created_at\": \"2025-12-17T19:37:00.000000Z\", \"updated_at\": \"2025-12-17T19:37:00.000000Z\", \"descripcion\": \"\"}', NULL, 'TIPO DE PRODUCTOS', '2025-12-17', '15:37:00', '2025-12-17 19:37:00', '2025-12-17 19:37:00'),
(92, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO', '{\"id\": 5, \"tipo\": \"SERVICIO\", \"nombre\": \"RUPTURA DE VAJILLAS\", \"created_at\": \"2025-12-17T19:36:49.000000Z\", \"updated_at\": \"2025-12-17T19:36:49.000000Z\", \"descripcion\": \"\"}', '{\"id\": 5, \"tipo\": \"SERVICIO\", \"nombre\": \"OTROS\", \"created_at\": \"2025-12-17T19:36:49.000000Z\", \"updated_at\": \"2025-12-17T19:37:41.000000Z\", \"descripcion\": \"\"}', 'TIPO DE PRODUCTOS', '2025-12-17', '15:37:41', '2025-12-17 19:37:41', '2025-12-17 19:37:41'),
(93, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO', '{\"id\": 3, \"tipo\": \"SERVICIO\", \"nombre\": \"SERVICIO 1\", \"created_at\": \"2025-12-17T19:26:30.000000Z\", \"updated_at\": \"2025-12-17T19:26:30.000000Z\", \"descripcion\": \"DESC\"}', '{\"id\": 3, \"tipo\": \"SERVICIO\", \"nombre\": \"RUPTURA DE VAJILLAS\", \"created_at\": \"2025-12-17T19:26:30.000000Z\", \"updated_at\": \"2025-12-17T19:37:47.000000Z\", \"descripcion\": \"DESC\"}', 'TIPO DE PRODUCTOS', '2025-12-17', '15:37:47', '2025-12-17 19:37:47', '2025-12-17 19:37:47'),
(94, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN TIPO DE PRODUCTO', '{\"id\": 6, \"tipo\": \"SERVICIO\", \"nombre\": \"OTROS SERVICIOS\", \"created_at\": \"2025-12-17T19:37:00.000000Z\", \"updated_at\": \"2025-12-17T19:37:00.000000Z\", \"descripcion\": \"\"}', '{\"id\": 6, \"tipo\": \"SERVICIO\", \"nombre\": \"MOMENTANEOS\", \"created_at\": \"2025-12-17T19:37:00.000000Z\", \"updated_at\": \"2025-12-17T19:38:05.000000Z\", \"descripcion\": \"\"}', 'TIPO DE PRODUCTOS', '2025-12-17', '15:38:05', '2025-12-17 19:38:05', '2025-12-17 19:38:05'),
(95, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN PRODUCTO', '{\"id\": 1, \"stock\": 0, \"imagen\": null, \"nombre\": \"PRODUCTO 1\", \"precio\": \"200.00\", \"created_at\": \"2025-12-03T23:54:15.000000Z\", \"updated_at\": \"2025-12-03T23:54:15.000000Z\", \"descripcion\": \"DESC\", \"control_stock\": 1, \"tipo_producto_id\": 1}', '{\"id\": 1, \"stock\": 0, \"imagen\": null, \"nombre\": \"VINO\", \"precio\": \"200.00\", \"created_at\": \"2025-12-03T23:54:15.000000Z\", \"updated_at\": \"2025-12-17T19:39:25.000000Z\", \"descripcion\": \"DESC\", \"control_stock\": 1, \"tipo_producto_id\": \"1\"}', 'PRODUCTOS', '2025-12-17', '15:39:25', '2025-12-17 19:39:25', '2025-12-17 19:39:25'),
(96, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN PRODUCTO', '{\"id\": 2, \"stock\": 0, \"imagen\": \"21764806725.jpeg\", \"nombre\": \"PRODUCTO 2\", \"precio\": \"80.50\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-04T00:05:25.000000Z\", \"descripcion\": \"DESC\", \"control_stock\": 1, \"tipo_producto_id\": 2}', '{\"id\": 2, \"stock\": 0, \"imagen\": \"21764806725.jpeg\", \"nombre\": \"POLLO FRITO\", \"precio\": \"80.50\", \"created_at\": \"2025-12-03T23:55:06.000000Z\", \"updated_at\": \"2025-12-17T19:39:35.000000Z\", \"descripcion\": \"DESC\", \"control_stock\": 1, \"tipo_producto_id\": \"2\"}', 'PRODUCTOS', '2025-12-17', '15:39:35', '2025-12-17 19:39:35', '2025-12-17 19:39:35'),
(97, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN PRODUCTO', '{\"id\": 3, \"stock\": 0, \"imagen\": null, \"nombre\": \"SERVICIO PROD\", \"precio\": \"190.00\", \"created_at\": \"2025-12-17T19:33:36.000000Z\", \"updated_at\": \"2025-12-17T19:33:36.000000Z\", \"descripcion\": \"\", \"control_stock\": 0, \"tipo_producto_id\": 3}', '{\"id\": 3, \"stock\": 0, \"imagen\": null, \"nombre\": \"DAÑOS MUEBLE\", \"precio\": \"190.00\", \"created_at\": \"2025-12-17T19:33:36.000000Z\", \"updated_at\": \"2025-12-17T19:39:50.000000Z\", \"descripcion\": \"\", \"control_stock\": 0, \"tipo_producto_id\": \"3\"}', 'PRODUCTOS', '2025-12-17', '15:39:50', '2025-12-17 19:39:50', '2025-12-17 19:39:50'),
(98, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 4, \"nombre\": \"LECHE\", \"precio\": \"20\", \"created_at\": \"2025-12-17T19:40:06.000000Z\", \"updated_at\": \"2025-12-17T19:40:06.000000Z\", \"descripcion\": \"\", \"control_stock\": 1, \"tipo_producto_id\": \"4\"}', NULL, 'PRODUCTOS', '2025-12-17', '15:40:06', '2025-12-17 19:40:06', '2025-12-17 19:40:06'),
(99, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 5, \"nombre\": \"CAFE\", \"precio\": \"0\", \"created_at\": \"2025-12-17T19:40:16.000000Z\", \"updated_at\": \"2025-12-17T19:40:16.000000Z\", \"descripcion\": \"\", \"control_stock\": 1, \"tipo_producto_id\": \"4\"}', NULL, 'PRODUCTOS', '2025-12-17', '15:40:16', '2025-12-17 19:40:16', '2025-12-17 19:40:16'),
(100, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN PRODUCTO', '{\"id\": 5, \"stock\": 0, \"imagen\": null, \"nombre\": \"CAFE\", \"precio\": \"0.00\", \"created_at\": \"2025-12-17T19:40:16.000000Z\", \"updated_at\": \"2025-12-17T19:40:16.000000Z\", \"descripcion\": \"\", \"control_stock\": 1, \"tipo_producto_id\": 4}', '{\"id\": 5, \"stock\": 0, \"imagen\": null, \"nombre\": \"CAFE\", \"precio\": \"45.5\", \"created_at\": \"2025-12-17T19:40:16.000000Z\", \"updated_at\": \"2025-12-17T19:40:26.000000Z\", \"descripcion\": \"\", \"control_stock\": 1, \"tipo_producto_id\": \"4\"}', 'PRODUCTOS', '2025-12-17', '15:40:26', '2025-12-17 19:40:26', '2025-12-17 19:40:26'),
(101, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 5, \"saldo\": \"0\", \"total\": \"522\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"522\", \"moneda_id\": 1, \"created_at\": \"2025-12-17T21:23:23.000000Z\", \"updated_at\": \"2025-12-17T21:23:23.000000Z\", \"registro_id\": \"3\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-17', '17:23:23', '2025-12-17 21:23:23', '2025-12-17 21:23:23'),
(102, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 6, \"saldo\": \"200\", \"total\": \"200\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-22T22:39:32.000000Z\", \"updated_at\": \"2025-12-22T22:39:32.000000Z\", \"registro_id\": \"2\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '18:39:32', '2025-12-22 22:39:32', '2025-12-22 22:39:32'),
(103, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 7, \"saldo\": \"200\", \"total\": \"200\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-22T22:41:46.000000Z\", \"updated_at\": \"2025-12-22T22:41:46.000000Z\", \"registro_id\": \"3\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '18:41:46', '2025-12-22 22:41:46', '2025-12-22 22:41:46'),
(104, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 1, \"tc\": \"0\", \"tipo\": \"HOSPEDAJE\", \"saldo\": \"1600\", \"total\": \"1600\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-22T23:26:34.000000Z\", \"updated_at\": \"2025-12-22T23:26:34.000000Z\", \"registro_id\": 1, \"cancelado_tc\": null, \"moneda_id_tc\": \"1\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '19:26:34', '2025-12-22 23:26:34', '2025-12-22 23:26:34'),
(105, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": \"0\", \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"1600\", \"total\": \"1600\", \"user_id\": 1, \"adelanto\": \"0\", \"desayuno\": \"0\", \"garantia\": \"0\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"3\", \"created_at\": \"2025-12-22T23:26:34.000000Z\", \"updated_at\": \"2025-12-22T23:26:34.000000Z\", \"adelanto_tc\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00\", \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-24\", \"hora_entrada\": \"19:25\", \"moneda_id_tc\": null, \"fecha_entrada\": \"2025-12-22\", \"habitacion_id\": \"4\"}', NULL, 'REGISTROS', '2025-12-22', '19:26:34', '2025-12-22 23:26:34', '2025-12-22 23:26:34'),
(106, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"1600.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"345345354\", \"id\": 3, \"dir\": \"\", \"edad\": null, \"fono\": \"676767\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:09:10.000000Z\", \"updated_at\": \"2025-11-28T15:09:10.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"0.00\", \"desayuno\": 0, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"valor_tc\": null, \"moneda_id\": 1, \"cliente_id\": 3, \"created_at\": \"2025-12-22T23:26:34.000000Z\", \"updated_at\": \"2025-12-22T23:26:34.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 2, \"fecha_salida\": \"2025-12-24\", \"hora_entrada\": \"19:25:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-22\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 1, \"tc\": \"0\", \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"1600.00\", \"total\": \"1600.00\", \"status\": 1, \"cliente\": {\"ci\": \"345345354\", \"id\": 3, \"dir\": \"\", \"edad\": null, \"fono\": \"676767\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MAMANI\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:09:10.000000Z\", \"updated_at\": \"2025-11-28T15:09:10.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"0.00\", \"desayuno\": \"1\", \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"valor_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"3\", \"created_at\": \"2025-12-22T23:26:34.000000Z\", \"updated_at\": \"2025-12-23T00:11:25.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-24\", \"hora_entrada\": \"19:25:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-22\", \"fecha_reserva\": null, \"habitacion_id\": 4, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-22', '20:11:25', '2025-12-23 00:11:25', '2025-12-23 00:11:25'),
(107, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 1, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"800\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 7, \"moneda_id\": 1, \"created_at\": \"2025-12-23T00:49:51.000000Z\", \"updated_at\": \"2025-12-23T00:49:51.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado ID: 7\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"20:49:51\", \"fecha_movimiento\": \"2025-12-22\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-22', '20:49:51', '2025-12-23 00:49:51', '2025-12-23 00:49:51'),
(108, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 7, \"tc\": \"0\", \"tipo\": \"HOSPEDAJE\", \"saldo\": \"0\", \"total\": \"800\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"800\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T00:49:51.000000Z\", \"updated_at\": \"2025-12-23T00:49:51.000000Z\", \"registro_id\": 7, \"cancelado_tc\": null, \"moneda_id_tc\": \"1\", \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '20:49:51', '2025-12-23 00:49:51', '2025-12-23 00:49:51'),
(109, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 7, \"tc\": \"0\", \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0\", \"total\": \"800\", \"user_id\": 1, \"adelanto\": \"800\", \"desayuno\": \"0\", \"garantia\": \"0\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"7\", \"created_at\": \"2025-12-23T00:49:51.000000Z\", \"updated_at\": \"2025-12-23T00:49:51.000000Z\", \"adelanto_tc\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00\", \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-23\", \"hora_entrada\": \"20:45\", \"moneda_id_tc\": 1, \"fecha_entrada\": \"2025-12-22\", \"habitacion_id\": \"3\"}', NULL, 'REGISTROS', '2025-12-22', '20:49:51', '2025-12-23 00:49:51', '2025-12-23 00:49:51'),
(110, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 2, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"500\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 8, \"moneda_id\": 1, \"created_at\": \"2025-12-23T00:52:53.000000Z\", \"updated_at\": \"2025-12-23T00:52:53.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado ID: 8\", \"moneda_id_tc\": null, \"efectivo_banco\": \"BANCO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"20:52:53\", \"fecha_movimiento\": \"2025-12-22\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-22', '20:52:53', '2025-12-23 00:52:53', '2025-12-23 00:52:53'),
(111, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 8, \"tc\": \"0\", \"tipo\": \"HOSPEDAJE\", \"saldo\": \"250\", \"total\": \"500\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"250\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T00:52:53.000000Z\", \"updated_at\": \"2025-12-23T00:52:53.000000Z\", \"registro_id\": 8, \"cancelado_tc\": null, \"moneda_id_tc\": \"1\", \"efectivo_banco\": \"BANCO\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '20:52:53', '2025-12-23 00:52:53', '2025-12-23 00:52:53'),
(112, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"500.00\", \"id\": 8, \"tc\": \"0\", \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"250\", \"total\": \"500\", \"user_id\": 1, \"adelanto\": \"250\", \"desayuno\": \"1\", \"garantia\": \"0\", \"saldo_tc\": null, \"total_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"16\", \"created_at\": \"2025-12-23T00:52:53.000000Z\", \"updated_at\": \"2025-12-23T00:52:53.000000Z\", \"adelanto_tc\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00\", \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-23\", \"hora_entrada\": \"20:52\", \"moneda_id_tc\": 1, \"fecha_entrada\": \"2025-12-22\", \"habitacion_id\": \"2\"}', NULL, 'REGISTROS', '2025-12-22', '20:52:53', '2025-12-23 00:52:53', '2025-12-23 00:52:53');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(113, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 9, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"522\", \"total\": \"522\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T00:59:10.000000Z\", \"updated_at\": \"2025-12-23T00:59:10.000000Z\", \"registro_id\": \"1\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '20:59:10', '2025-12-23 00:59:10', '2025-12-23 00:59:10'),
(114, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 3, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"65.5\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 10, \"moneda_id\": 1, \"created_at\": \"2025-12-23T01:01:25.000000Z\", \"updated_at\": \"2025-12-23T01:01:25.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado ID: 10\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"21:01:25\", \"fecha_movimiento\": \"2025-12-22\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-22', '21:01:25', '2025-12-23 01:01:25', '2025-12-23 01:01:25'),
(115, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 10, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"0\", \"total\": \"65.5\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"65.5\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T01:01:25.000000Z\", \"updated_at\": \"2025-12-23T01:01:25.000000Z\", \"registro_id\": \"1\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '21:01:25', '2025-12-23 01:01:25', '2025-12-23 01:01:25'),
(116, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 11, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"200\", \"total\": \"200\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T01:07:15.000000Z\", \"updated_at\": \"2025-12-23T01:07:15.000000Z\", \"registro_id\": \"7\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '21:07:15', '2025-12-23 01:07:15', '2025-12-23 01:07:15'),
(117, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 4, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"80.5\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 12, \"moneda_id\": 1, \"created_at\": \"2025-12-23T01:07:29.000000Z\", \"updated_at\": \"2025-12-23T01:07:29.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado ID: 12\", \"moneda_id_tc\": null, \"efectivo_banco\": \"BANCO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"21:07:29\", \"fecha_movimiento\": \"2025-12-22\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-22', '21:07:29', '2025-12-23 01:07:29', '2025-12-23 01:07:29'),
(118, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 12, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"0\", \"total\": \"80.5\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"80.5\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T01:07:29.000000Z\", \"updated_at\": \"2025-12-23T01:07:29.000000Z\", \"registro_id\": \"8\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"BANCO\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-22', '21:07:29', '2025-12-23 01:07:29', '2025-12-23 01:07:29'),
(119, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 5, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"1600.00\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 1, \"moneda_id\": 1, \"created_at\": \"2025-12-23T20:47:47.000000Z\", \"updated_at\": \"2025-12-23T20:47:47.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 1\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"16:47:47\", \"fecha_movimiento\": \"2025-12-23\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-23', '16:47:47', '2025-12-23 20:47:47', '2025-12-23 20:47:47'),
(120, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 6, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"522.00\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 9, \"moneda_id\": 1, \"created_at\": \"2025-12-23T20:48:54.000000Z\", \"updated_at\": \"2025-12-23T20:48:54.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 9\", \"moneda_id_tc\": null, \"efectivo_banco\": \"BANCO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"16:48:54\", \"fecha_movimiento\": \"2025-12-23\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-23', '16:48:54', '2025-12-23 20:48:54', '2025-12-23 20:48:54'),
(121, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 14, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"400\", \"total\": \"400\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T20:49:23.000000Z\", \"updated_at\": \"2025-12-23T20:49:23.000000Z\", \"registro_id\": \"1\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-23', '16:49:23', '2025-12-23 20:49:23', '2025-12-23 20:49:23'),
(122, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 13, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"400\", \"total\": \"400\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T20:49:23.000000Z\", \"updated_at\": \"2025-12-23T20:49:23.000000Z\", \"registro_id\": \"1\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-23', '16:49:23', '2025-12-23 20:49:23', '2025-12-23 20:49:23'),
(123, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 15, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"146\", \"total\": \"146\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T20:49:30.000000Z\", \"updated_at\": \"2025-12-23T20:49:30.000000Z\", \"registro_id\": \"1\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-23', '16:49:30', '2025-12-23 20:49:30', '2025-12-23 20:49:30'),
(124, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 7, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"400.00\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 13, \"moneda_id\": 1, \"created_at\": \"2025-12-23T20:49:55.000000Z\", \"updated_at\": \"2025-12-23T20:49:55.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 13\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"16:49:55\", \"fecha_movimiento\": \"2025-12-23\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-23', '16:49:55', '2025-12-23 20:49:55', '2025-12-23 20:49:55'),
(125, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 8, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 100, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 14, \"moneda_id\": 1, \"created_at\": \"2025-12-23T21:29:31.000000Z\", \"updated_at\": \"2025-12-23T21:29:31.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 14\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"17:29:31\", \"fecha_movimiento\": \"2025-12-23\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-23', '17:29:31', '2025-12-23 21:29:31', '2025-12-23 21:29:31'),
(126, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 9, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 300, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 14, \"moneda_id\": 1, \"created_at\": \"2025-12-23T21:33:05.000000Z\", \"updated_at\": \"2025-12-23T21:33:05.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 14\", \"moneda_id_tc\": null, \"efectivo_banco\": \"BANCO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"17:33:05\", \"fecha_movimiento\": \"2025-12-23\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-23', '17:33:05', '2025-12-23 21:33:05', '2025-12-23 21:33:05'),
(127, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 18, \"tc\": 0, \"tipo\": \"PRODUCTO/SERVICIO\", \"saldo\": \"190\", \"total\": \"190\", \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": \"0\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T21:53:28.000000Z\", \"updated_at\": \"2025-12-23T21:53:28.000000Z\", \"registro_id\": \"1\", \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-23', '17:53:28', '2025-12-23 21:53:28', '2025-12-23 21:53:28'),
(128, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', '{\"id\": 3, \"total\": 2700, \"cantidad\": \"30\", \"created_at\": \"2025-12-23T22:21:28.000000Z\", \"updated_at\": \"2025-12-23T22:21:28.000000Z\", \"producto_id\": \"1\", \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"90\"}', NULL, 'INGRESO DE PRODUCTOS', '2025-12-23', '18:21:28', '2025-12-23 22:21:28', '2025-12-23 22:21:28'),
(129, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN INGRESO DE PRODUCTO', '{\"id\": 3, \"total\": \"2700.00\", \"cantidad\": 30, \"created_at\": \"2025-12-23T22:21:28.000000Z\", \"updated_at\": \"2025-12-23T22:21:28.000000Z\", \"producto_id\": 1, \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"90.00\"}', '{\"id\": 3, \"total\": 2850, \"cantidad\": \"30\", \"created_at\": \"2025-12-23T22:21:28.000000Z\", \"updated_at\": \"2025-12-23T22:23:52.000000Z\", \"producto_id\": \"1\", \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"95\"}', 'INGRESO DE PRODUCTOS', '2025-12-23', '18:23:52', '2025-12-23 22:23:52', '2025-12-23 22:23:52'),
(130, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ EL REGISTRO DE UN INGRESO DE PRODUCTO', '{\"id\": 3, \"total\": \"2850.00\", \"cantidad\": 30, \"created_at\": \"2025-12-23T22:21:28.000000Z\", \"updated_at\": \"2025-12-23T22:23:52.000000Z\", \"producto_id\": 1, \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"95.00\"}', '{\"id\": 3, \"total\": 2850, \"cantidad\": \"30\", \"created_at\": \"2025-12-23T22:21:28.000000Z\", \"updated_at\": \"2025-12-23T22:24:13.000000Z\", \"producto_id\": \"1\", \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"95.00\"}', 'INGRESO DE PRODUCTOS', '2025-12-23', '18:24:13', '2025-12-23 22:24:13', '2025-12-23 22:24:13'),
(131, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ EL REGISTRO DE UN INGRESO DE PRODUCTO', '{\"id\": 3, \"total\": \"2850.00\", \"cantidad\": 30, \"created_at\": \"2025-12-23T22:21:28.000000Z\", \"updated_at\": \"2025-12-23T22:24:13.000000Z\", \"producto_id\": 1, \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"95.00\"}', NULL, 'INGRESO DE PRODUCTOS', '2025-12-23', '18:25:39', '2025-12-23 22:25:39', '2025-12-23 22:25:39'),
(132, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', '{\"id\": 4, \"total\": 2835, \"cantidad\": \"30\", \"created_at\": \"2025-12-23T22:27:30.000000Z\", \"updated_at\": \"2025-12-23T22:27:30.000000Z\", \"producto_id\": \"1\", \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"94.5\"}', NULL, 'INGRESO DE PRODUCTOS', '2025-12-23', '18:27:30', '2025-12-23 22:27:30', '2025-12-23 22:27:30'),
(133, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', '{\"id\": 5, \"total\": 80, \"cantidad\": \"4\", \"created_at\": \"2025-12-23T22:27:55.000000Z\", \"updated_at\": \"2025-12-23T22:27:55.000000Z\", \"producto_id\": \"2\", \"fecha_ingreso\": \"2025-12-23\", \"precio_compra\": \"20\"}', NULL, 'INGRESO DE PRODUCTOS', '2025-12-23', '18:27:55', '2025-12-23 22:27:55', '2025-12-23 22:27:55'),
(134, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN EGRESO DE PRODUCTO', '{\"id\": 3, \"motivo\": \"SALIDA POR ROTURA\", \"cantidad\": \"1\", \"created_at\": \"2025-12-23T22:47:14.000000Z\", \"updated_at\": \"2025-12-23T22:47:14.000000Z\", \"producto_id\": \"1\", \"fecha_egreso\": \"2025-12-23\"}', NULL, 'EGRESO DE PRODUCTOS', '2025-12-23', '18:47:14', '2025-12-23 22:47:14', '2025-12-23 22:47:14'),
(135, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 10, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"600\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 19, \"moneda_id\": 1, \"created_at\": \"2025-12-23T23:34:53.000000Z\", \"updated_at\": \"2025-12-23T23:34:53.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 19\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"19:34:53\", \"fecha_movimiento\": \"2025-12-23\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-23', '19:34:53', '2025-12-23 23:34:53', '2025-12-23 23:34:53'),
(136, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 19, \"tc\": \"1\", \"tipo\": \"HOSPEDAJE\", \"saldo\": \"0\", \"total\": \"600\", \"user_id\": 1, \"saldo_tc\": \"0\", \"total_tc\": \"85.96\", \"cancelado\": \"600\", \"moneda_id\": 1, \"created_at\": \"2025-12-23T23:34:53.000000Z\", \"updated_at\": \"2025-12-23T23:34:53.000000Z\", \"registro_id\": 9, \"cancelado_tc\": \"85.96\", \"moneda_id_tc\": \"2\", \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-23', '19:34:53', '2025-12-23 23:34:53', '2025-12-23 23:34:53'),
(137, 1, 'CREACIÓN', 'EL USUARIO admin REALIZÓ UN REGISTRO', '{\"cd\": \"300.00\", \"id\": 9, \"tc\": \"1\", \"tipo\": \"NORMAL\", \"cd_tc\": \"42.98\", \"saldo\": \"0\", \"total\": \"600\", \"user_id\": 1, \"adelanto\": \"600\", \"desayuno\": \"1\", \"garantia\": \"0\", \"saldo_tc\": \"0\", \"total_tc\": \"85.96\", \"moneda_id\": 1, \"cliente_id\": \"15\", \"created_at\": \"2025-12-23T23:34:53.000000Z\", \"updated_at\": \"2025-12-23T23:34:53.000000Z\", \"adelanto_tc\": \"85.96\", \"garantia_tc\": \"0\", \"hora_salida\": \"12:00\", \"dias_estadia\": \"2\", \"fecha_salida\": \"2025-12-25\", \"hora_entrada\": \"19:34\", \"moneda_id_tc\": \"2\", \"fecha_entrada\": \"2025-12-23\", \"habitacion_id\": \"1\"}', NULL, 'REGISTROS', '2025-12-23', '19:34:53', '2025-12-23 23:34:53', '2025-12-23 23:34:53'),
(138, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 11, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 50, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T13:58:35.000000Z\", \"updated_at\": \"2025-12-24T13:58:35.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"09:58:35\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '09:58:35', '2025-12-24 13:58:35', '2025-12-24 13:58:35'),
(139, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 12, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 25, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T13:59:55.000000Z\", \"updated_at\": \"2025-12-24T13:59:55.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"09:59:55\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '09:59:55', '2025-12-24 13:59:55', '2025-12-24 13:59:55'),
(140, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 13, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:07:54.000000Z\", \"updated_at\": \"2025-12-24T14:07:54.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:07:54\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:07:54', '2025-12-24 14:07:54', '2025-12-24 14:07:54'),
(141, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 14, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:08:39.000000Z\", \"updated_at\": \"2025-12-24T14:08:39.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:08:39\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:08:39', '2025-12-24 14:08:39', '2025-12-24 14:08:39'),
(142, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 15, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:10:16.000000Z\", \"updated_at\": \"2025-12-24T14:10:16.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:10:16\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:10:16', '2025-12-24 14:10:16', '2025-12-24 14:10:16'),
(143, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 16, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:12:42.000000Z\", \"updated_at\": \"2025-12-24T14:12:42.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:12:42\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:12:42', '2025-12-24 14:12:42', '2025-12-24 14:12:42'),
(144, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 17, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:14:54.000000Z\", \"updated_at\": \"2025-12-24T14:14:54.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:14:54\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:14:54', '2025-12-24 14:14:54', '2025-12-24 14:14:54'),
(145, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 18, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:15:46.000000Z\", \"updated_at\": \"2025-12-24T14:15:46.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:15:46\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:15:46', '2025-12-24 14:15:46', '2025-12-24 14:15:46'),
(146, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 19, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:17:34.000000Z\", \"updated_at\": \"2025-12-24T14:17:34.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:17:34\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:17:34', '2025-12-24 14:17:34', '2025-12-24 14:17:34'),
(147, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 20, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:18:04.000000Z\", \"updated_at\": \"2025-12-24T14:18:04.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:18:04\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:18:04', '2025-12-24 14:18:04', '2025-12-24 14:18:04'),
(148, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 21, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": 5, \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:19:07.000000Z\", \"updated_at\": \"2025-12-24T14:19:07.000000Z\", \"descripcion\": \"Pago parcial por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"10:19:07\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '10:19:07', '2025-12-24 14:19:07', '2025-12-24 14:19:07'),
(149, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN REGISTRO', '{\"cd\": \"800.00\", \"id\": 7, \"tc\": 0, \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"12313123\", \"id\": 7, \"dir\": \"\", \"edad\": null, \"fono\": \"234234243\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:21:35.000000Z\", \"updated_at\": \"2025-11-28T15:21:35.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": 0, \"garantia\": \"0.00\", \"saldo_tc\": null, \"total_tc\": null, \"valor_tc\": null, \"moneda_id\": 1, \"cliente_id\": 7, \"created_at\": \"2025-12-23T00:49:51.000000Z\", \"updated_at\": \"2025-12-23T00:49:51.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": 1, \"fecha_salida\": \"2025-12-23\", \"hora_entrada\": \"20:45:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-22\", \"fecha_reserva\": null, \"habitacion_id\": 3, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', '{\"cd\": \"800.00\", \"id\": 7, \"tc\": \"0\", \"tipo\": \"NORMAL\", \"cd_tc\": null, \"saldo\": \"0.00\", \"total\": \"800.00\", \"status\": 1, \"cliente\": {\"ci\": \"12313123\", \"id\": 7, \"dir\": \"\", \"edad\": null, \"fono\": \"234234243\", \"pais\": \"\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"user_id\": 1, \"fecha_nac\": null, \"created_at\": \"2025-11-28T15:21:35.000000Z\", \"updated_at\": \"2025-11-28T15:21:35.000000Z\", \"nacionalidad\": \"\"}, \"user_id\": 1, \"adelanto\": \"800.00\", \"desayuno\": \"0\", \"garantia\": \"50\", \"saldo_tc\": null, \"total_tc\": null, \"valor_tc\": null, \"moneda_id\": 1, \"cliente_id\": \"7\", \"created_at\": \"2025-12-23T00:49:51.000000Z\", \"updated_at\": \"2025-12-24T14:21:35.000000Z\", \"adelanto_tc\": null, \"cod_reserva\": null, \"garantia_tc\": null, \"hora_salida\": \"12:00:00\", \"nro_reserva\": null, \"dev_garantia\": 0, \"dias_estadia\": \"1\", \"fecha_salida\": \"2025-12-23\", \"hora_entrada\": \"20:45:00\", \"hora_reserva\": null, \"moneda_id_tc\": 1, \"tipo_reserva\": null, \"fecha_entrada\": \"2025-12-22\", \"fecha_reserva\": null, \"habitacion_id\": 3, \"motivo_salida\": null, \"tipo_cambio_id\": null, \"hora_salida_reg\": null}', 'REGISTROS', '2025-12-24', '10:21:35', '2025-12-24 14:21:35', '2025-12-24 14:21:35'),
(150, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 20, \"tc\": 0, \"hora\": \"10:54:19\", \"tipo\": \"HOSPEDAJE\", \"fecha\": \"2025-12-24\", \"saldo\": 800, \"total\": 800, \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": 0, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:54:19.000000Z\", \"updated_at\": \"2025-12-24T14:54:19.000000Z\", \"registro_id\": 7, \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-24', '10:54:19', '2025-12-24 14:54:19', '2025-12-24 14:54:19'),
(151, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 21, \"tc\": 0, \"hora\": \"10:54:45\", \"tipo\": \"HOSPEDAJE\", \"fecha\": \"2025-12-24\", \"saldo\": 800, \"total\": 800, \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": 0, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:54:45.000000Z\", \"updated_at\": \"2025-12-24T14:54:45.000000Z\", \"registro_id\": 7, \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-24', '10:54:45', '2025-12-24 14:54:45', '2025-12-24 14:54:45'),
(152, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 22, \"tc\": 0, \"hora\": \"10:55:59\", \"tipo\": \"HOSPEDAJE\", \"fecha\": \"2025-12-24\", \"saldo\": 800, \"total\": 800, \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": 0, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:55:59.000000Z\", \"updated_at\": \"2025-12-24T14:55:59.000000Z\", \"registro_id\": 7, \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-24', '10:55:59', '2025-12-24 14:55:59', '2025-12-24 14:55:59'),
(153, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 23, \"tc\": 0, \"hora\": \"10:58:24\", \"tipo\": \"HOSPEDAJE\", \"fecha\": \"2025-12-24\", \"saldo\": 500, \"total\": 500, \"user_id\": 1, \"saldo_tc\": null, \"total_tc\": null, \"cancelado\": 0, \"moneda_id\": 1, \"created_at\": \"2025-12-24T14:58:24.000000Z\", \"updated_at\": \"2025-12-24T14:58:24.000000Z\", \"registro_id\": 8, \"cancelado_tc\": null, \"moneda_id_tc\": null, \"efectivo_banco\": \"\", \"tipo_cambio_id\": null}', NULL, 'REGISTRO SERVICIOS', '2025-12-24', '10:58:24', '2025-12-24 14:58:24', '2025-12-24 14:58:24'),
(154, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 22, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"146.00\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 15, \"moneda_id\": 1, \"created_at\": \"2025-12-24T15:21:44.000000Z\", \"updated_at\": \"2025-12-24T15:21:44.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 15\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"11:21:44\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '11:21:44', '2025-12-24 15:21:44', '2025-12-24 15:21:44'),
(155, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 23, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"190.00\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 18, \"moneda_id\": 1, \"created_at\": \"2025-12-24T15:21:47.000000Z\", \"updated_at\": \"2025-12-24T15:21:47.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 18\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"11:21:47\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '11:21:47', '2025-12-24 15:21:47', '2025-12-24 15:21:47'),
(156, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN SERVICIO', '{\"id\": 24, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"80.00\", \"modelo\": \"RegistroServicio\", \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": null, \"modelo_id\": 11, \"moneda_id\": 1, \"created_at\": \"2025-12-24T15:23:29.000000Z\", \"updated_at\": \"2025-12-24T15:23:29.000000Z\", \"descripcion\": \"Pago por servicio/producto registrado con nro. de recibo 11\", \"moneda_id_tc\": null, \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"11:23:29\", \"fecha_movimiento\": \"2025-12-24\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-24', '11:23:29', '2025-12-24 15:23:29', '2025-12-24 15:23:29');

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

--
-- Volcado de datos para la tabla `ingreso_productos`
--

INSERT INTO `ingreso_productos` (`id`, `producto_id`, `cantidad`, `precio_compra`, `total`, `fecha_ingreso`, `created_at`, `updated_at`) VALUES
(4, 1, 30, 94.50, 2835.00, '2025-12-23', '2025-12-23 22:27:30', '2025-12-23 22:27:30'),
(5, 2, 4, 20.00, 80.00, '2025-12-23', '2025-12-23 22:27:55', '2025-12-23 22:27:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex_productos`
--

CREATE TABLE `kardex_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo_registro` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registro_id` bigint UNSIGNED DEFAULT NULL,
  `modulo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) DEFAULT NULL,
  `tipo_is` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_ingreso` double DEFAULT NULL,
  `cantidad_salida` double DEFAULT NULL,
  `cantidad_saldo` double NOT NULL,
  `cu` decimal(24,2) NOT NULL,
  `monto_ingreso` decimal(24,2) DEFAULT NULL,
  `monto_salida` decimal(24,2) DEFAULT NULL,
  `monto_saldo` decimal(24,2) NOT NULL,
  `fecha` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `kardex_productos`
--

INSERT INTO `kardex_productos` (`id`, `tipo_registro`, `registro_id`, `modulo`, `producto_id`, `detalle`, `precio`, `tipo_is`, `cantidad_ingreso`, `cantidad_salida`, `cantidad_saldo`, `cu`, `monto_ingreso`, `monto_salida`, `monto_saldo`, `fecha`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'INGRESO DE PRODUCTO', 3, 'IngresoProducto', 1, 'VALOR INICIAL', 90.00, 'INGRESO', 30, NULL, 30, 200.00, 2700.00, NULL, 2700.00, '2025-12-23', 1, 1, '2025-12-23 22:21:28', '2025-12-23 22:21:28'),
(2, 'INGRESO DE PRODUCTO', 3, 'IngresoProducto', 1, 'SALIDA POR MODIFICACIÓN', 90.00, 'EGRESO', NULL, 30, 0, 200.00, NULL, 2700.00, 0.00, '2025-12-23', 1, 1, '2025-12-23 22:23:52', '2025-12-23 22:23:52'),
(3, 'INGRESO DE PRODUCTO', 3, 'IngresoProducto', 1, 'INGRESO POR COMPRA', 95.00, 'INGRESO', 30, NULL, 30, 200.00, 2850.00, NULL, 2850.00, '2025-12-23', 1, 1, '2025-12-23 22:23:52', '2025-12-23 22:23:52'),
(4, 'INGRESO DE PRODUCTO', 3, 'IngresoProducto', 1, 'SALIDA POR MODIFICACIÓN', 95.00, 'EGRESO', NULL, 30, 0, 200.00, NULL, 2850.00, 0.00, '2025-12-23', 1, 1, '2025-12-23 22:24:13', '2025-12-23 22:24:13'),
(5, 'INGRESO DE PRODUCTO', 3, 'IngresoProducto', 1, 'INGRESO POR COMPRA', 95.00, 'INGRESO', 30, NULL, 30, 200.00, 2850.00, NULL, 2850.00, '2025-12-23', 1, 1, '2025-12-23 22:24:13', '2025-12-23 22:24:13'),
(6, 'INGRESO DE PRODUCTO', 3, 'IngresoProducto', 1, 'SALIDA POR ELIMINACIÓN DE INGRESO', 95.00, 'EGRESO', NULL, 30, 0, 200.00, NULL, 2850.00, 0.00, '2025-12-23', 1, 1, '2025-12-23 22:25:39', '2025-12-23 22:25:39'),
(7, 'INGRESO DE PRODUCTO', 4, 'IngresoProducto', 1, 'INGRESO POR COMPRA', 94.50, 'INGRESO', 30, NULL, 30, 200.00, 2835.00, NULL, 2835.00, '2025-12-23', 1, 1, '2025-12-23 22:27:30', '2025-12-23 22:27:30'),
(8, 'INGRESO DE PRODUCTO', 5, 'IngresoProducto', 2, 'VALOR INICIAL', 20.00, 'INGRESO', 4, NULL, 4, 80.50, 80.00, NULL, 80.00, '2025-12-23', 1, 1, '2025-12-23 22:27:55', '2025-12-23 22:27:55'),
(9, 'EGRESO DE PRODUCTO', 3, 'EgresoProducto', 1, 'SALIDA POR REGISTRO DE EGRESO', 200.00, 'EGRESO', NULL, 1, 29, 200.00, NULL, 200.00, 2635.00, '2025-12-23', 1, 1, '2025-12-23 22:47:14', '2025-12-23 22:47:14');

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
(18, '2025_11_23_105258_create_habitacion_fotos_table', 1),
(19, '2025_12_03_163556_create_transferencias_table', 2),
(20, '2025_12_05_104619_create_kardex_productos_table', 3);

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
  `tc` int NOT NULL DEFAULT '0',
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

--
-- Volcado de datos para la tabla `movimiento_cajas`
--

INSERT INTO `movimiento_cajas` (`id`, `caja_id`, `modelo_id`, `modelo`, `monto`, `moneda_id`, `tc`, `monto_tc`, `moneda_id_tc`, `tipo_cambio_id`, `tipo`, `efectivo_banco`, `descripcion`, `fecha_movimiento`, `hora_movimiento`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 7, 'RegistroServicio', 800.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado ID: 7', '2025-12-22', '20:49:51', 1, '2025-12-23 00:49:51', '2025-12-23 00:49:51'),
(2, 1, 8, 'RegistroServicio', 500.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'BANCO', 'Pago por servicio/producto registrado ID: 8', '2025-12-22', '20:52:53', 1, '2025-12-23 00:52:53', '2025-12-23 00:52:53'),
(3, 1, 10, 'RegistroServicio', 65.50, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado ID: 10', '2025-12-22', '21:01:25', 1, '2025-12-23 01:01:25', '2025-12-23 01:01:25'),
(4, 1, 12, 'RegistroServicio', 80.50, 1, 0, NULL, NULL, NULL, 'INGRESO', 'BANCO', 'Pago por servicio/producto registrado ID: 12', '2025-12-22', '21:07:29', 1, '2025-12-23 01:07:29', '2025-12-23 01:07:29'),
(5, 1, 1, 'RegistroServicio', 1600.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado con nro. de recibo 1', '2025-12-23', '16:47:47', 1, '2025-12-23 20:47:47', '2025-12-23 20:47:47'),
(6, 1, 9, 'RegistroServicio', 522.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'BANCO', 'Pago por servicio/producto registrado con nro. de recibo 9', '2025-12-23', '16:48:54', 1, '2025-12-23 20:48:54', '2025-12-23 20:48:54'),
(7, 1, 13, 'RegistroServicio', 400.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado con nro. de recibo 13', '2025-12-23', '16:49:55', 1, '2025-12-23 20:49:55', '2025-12-23 20:49:55'),
(8, 1, 14, 'RegistroServicio', 100.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 14', '2025-12-23', '17:29:31', 1, '2025-12-23 21:29:31', '2025-12-23 21:29:31'),
(9, 1, 14, 'RegistroServicio', 300.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'BANCO', 'Pago parcial por servicio/producto registrado con nro. de recibo 14', '2025-12-23', '17:33:05', 1, '2025-12-23 21:33:05', '2025-12-23 21:33:05'),
(10, 1, 19, 'RegistroServicio', 600.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado con nro. de recibo 19', '2025-12-23', '19:34:53', 1, '2025-12-23 23:34:53', '2025-12-23 23:34:53'),
(11, 1, 11, 'RegistroServicio', 50.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '09:58:35', 1, '2025-12-24 13:58:35', '2025-12-24 13:58:35'),
(12, 1, 11, 'RegistroServicio', 25.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '09:59:55', 1, '2025-12-24 13:59:55', '2025-12-24 13:59:55'),
(13, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:07:54', 1, '2025-12-24 14:07:54', '2025-12-24 14:07:54'),
(14, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:08:39', 1, '2025-12-24 14:08:39', '2025-12-24 14:08:39'),
(15, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:10:16', 1, '2025-12-24 14:10:16', '2025-12-24 14:10:16'),
(16, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:12:42', 1, '2025-12-24 14:12:42', '2025-12-24 14:12:42'),
(17, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:14:54', 1, '2025-12-24 14:14:54', '2025-12-24 14:14:54'),
(18, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:15:46', 1, '2025-12-24 14:15:46', '2025-12-24 14:15:46'),
(19, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:17:34', 1, '2025-12-24 14:17:34', '2025-12-24 14:17:34'),
(20, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:18:04', 1, '2025-12-24 14:18:04', '2025-12-24 14:18:04'),
(21, 1, 11, 'RegistroServicio', 5.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago parcial por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '10:19:07', 1, '2025-12-24 14:19:07', '2025-12-24 14:19:07'),
(22, 1, 15, 'RegistroServicio', 146.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado con nro. de recibo 15', '2025-12-24', '11:21:44', 1, '2025-12-24 15:21:44', '2025-12-24 15:21:44'),
(23, 1, 18, 'RegistroServicio', 190.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado con nro. de recibo 18', '2025-12-24', '11:21:47', 1, '2025-12-24 15:21:47', '2025-12-24 15:21:47'),
(24, 1, 11, 'RegistroServicio', 80.00, 1, 0, NULL, NULL, NULL, 'INGRESO', 'EFECTIVO', 'Pago por servicio/producto registrado con nro. de recibo 11', '2025-12-24', '11:23:29', 1, '2025-12-24 15:23:29', '2025-12-24 15:23:29');

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
  `stock` double DEFAULT '0',
  `control_stock` int NOT NULL DEFAULT '1',
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `tipo_producto_id`, `stock`, `control_stock`, `imagen`, `created_at`, `updated_at`) VALUES
(1, 'VINO', 'DESC', 200.00, 1, 29, 1, NULL, '2025-12-03 23:54:15', '2025-12-23 22:47:14'),
(2, 'POLLO FRITO', 'DESC', 80.50, 2, 4, 1, '21764806725.jpeg', '2025-12-03 23:55:06', '2025-12-23 22:27:55'),
(3, 'DAÑOS MUEBLE', '', 190.00, 3, 0, 0, NULL, '2025-12-17 19:33:36', '2025-12-17 19:39:50'),
(4, 'LECHE', '', 20.00, 4, 0, 1, NULL, '2025-12-17 19:40:06', '2025-12-17 19:40:06'),
(5, 'CAFE', '', 45.50, 4, 0, 1, NULL, '2025-12-17 19:40:16', '2025-12-17 19:40:26');

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
  `valor_tc` decimal(24,2) DEFAULT NULL,
  `motivo_salida` text COLLATE utf8mb4_unicode_ci,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `fecha_reserva` date DEFAULT NULL,
  `hora_reserva` time DEFAULT NULL,
  `nro_reserva` bigint DEFAULT NULL,
  `cod_reserva` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_reserva` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dev_garantia` int DEFAULT '0',
  `estado` int NOT NULL DEFAULT '1',
  `status` int NOT NULL DEFAULT '1',
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `registros`
--

INSERT INTO `registros` (`id`, `habitacion_id`, `cliente_id`, `desayuno`, `fecha_entrada`, `hora_entrada`, `dias_estadia`, `fecha_salida`, `hora_salida`, `hora_salida_reg`, `cd`, `total`, `adelanto`, `saldo`, `garantia`, `moneda_id`, `tc`, `cd_tc`, `total_tc`, `adelanto_tc`, `saldo_tc`, `garantia_tc`, `moneda_id_tc`, `tipo_cambio_id`, `valor_tc`, `motivo_salida`, `tipo`, `fecha_reserva`, `hora_reserva`, `nro_reserva`, `cod_reserva`, `tipo_reserva`, `dev_garantia`, `estado`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 4, 3, 1, '2025-12-22', '19:25:00', 2, '2025-12-24', '12:00:00', NULL, 800.00, 1600.00, 0.00, 1600.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 'NORMAL', NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, '2025-12-22 23:26:34', '2025-12-24 15:23:17'),
(7, 3, 7, 0, '2025-12-22', '20:45:00', 2, '2025-12-24', '10:55:59', NULL, 800.00, 800.00, 800.00, 0.00, 50.00, 1, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 'NORMAL', NULL, NULL, NULL, NULL, NULL, 1, 0, 1, 1, '2025-12-23 00:49:51', '2025-12-24 15:23:37'),
(8, 2, 16, 1, '2025-12-22', '20:52:00', 2, '2025-12-24', '10:58:24', NULL, 500.00, 500.00, 250.00, 250.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 'NORMAL', NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 1, '2025-12-23 00:52:53', '2025-12-24 14:58:24'),
(9, 1, 15, 1, '2025-12-23', '19:34:00', 2, '2025-12-25', '12:00:00', NULL, 300.00, 600.00, 600.00, 0.00, 0.00, 1, 1, 42.98, 85.96, 85.96, 0.00, 0.00, 2, NULL, NULL, NULL, 'NORMAL', NULL, NULL, NULL, NULL, NULL, 0, 1, 1, 1, '2025-12-23 23:34:53', '2025-12-23 23:34:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_servicios`
--

CREATE TABLE `registro_servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `cancelado` decimal(24,2) NOT NULL DEFAULT '0.00',
  `saldo` decimal(24,2) NOT NULL,
  `moneda_id` bigint UNSIGNED NOT NULL,
  `tc` int NOT NULL DEFAULT '0',
  `total_tc` decimal(24,2) DEFAULT '0.00',
  `cancelado_tc` decimal(24,2) DEFAULT '0.00',
  `saldo_tc` decimal(24,2) DEFAULT NULL,
  `moneda_id_tc` bigint UNSIGNED DEFAULT NULL,
  `tipo_cambio_id` bigint UNSIGNED DEFAULT NULL,
  `efectivo_banco` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `registro_servicios`
--

INSERT INTO `registro_servicios` (`id`, `registro_id`, `tipo`, `total`, `cancelado`, `saldo`, `moneda_id`, `tc`, `total_tc`, `cancelado_tc`, `saldo_tc`, `moneda_id_tc`, `tipo_cambio_id`, `efectivo_banco`, `fecha`, `hora`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'HOSPEDAJE', 1600.00, 1600.00, 0.00, 1, 0, NULL, NULL, NULL, 1, NULL, '', '2025-12-22', '19:26:34', 1, '2025-12-22 23:26:34', '2025-12-23 20:47:47'),
(7, 7, 'HOSPEDAJE', 800.00, 800.00, 0.00, 1, 0, NULL, NULL, NULL, 1, NULL, 'EFECTIVO', '2025-12-22', '20:49:51', 1, '2025-12-23 00:49:51', '2025-12-23 00:49:51'),
(8, 8, 'HOSPEDAJE', 500.00, 250.00, 250.00, 1, 0, NULL, NULL, NULL, 1, NULL, 'BANCO', '2025-12-22', '20:52:53', 1, '2025-12-23 00:52:53', '2025-12-23 00:52:53'),
(9, 1, 'PRODUCTO/SERVICIO', 522.00, 522.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-22', '20:59:10', 1, '2025-12-23 00:59:10', '2025-12-23 20:48:54'),
(10, 1, 'PRODUCTO/SERVICIO', 65.50, 65.50, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, 'EFECTIVO', '2025-12-22', '21:01:25', 1, '2025-12-23 01:01:25', '2025-12-23 01:01:25'),
(11, 7, 'PRODUCTO/SERVICIO', 200.00, 200.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-22', '21:07:15', 1, '2025-12-23 01:07:15', '2025-12-24 15:23:29'),
(12, 8, 'PRODUCTO/SERVICIO', 80.50, 80.50, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, 'BANCO', '2025-12-22', '21:07:29', 1, '2025-12-23 01:07:29', '2025-12-23 01:07:29'),
(13, 1, 'PRODUCTO/SERVICIO', 400.00, 400.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-23', '16:49:23', 1, '2025-12-23 20:49:23', '2025-12-23 20:49:55'),
(14, 1, 'PRODUCTO/SERVICIO', 400.00, 400.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-23', '16:49:23', 1, '2025-12-23 20:49:23', '2025-12-23 21:33:05'),
(15, 1, 'PRODUCTO/SERVICIO', 146.00, 146.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-23', '16:49:30', 1, '2025-12-23 20:49:30', '2025-12-24 15:21:44'),
(18, 1, 'PRODUCTO/SERVICIO', 190.00, 190.00, 0.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-23', '17:53:28', 1, '2025-12-23 21:53:28', '2025-12-24 15:21:47'),
(19, 9, 'HOSPEDAJE', 600.00, 600.00, 0.00, 1, 1, 85.96, 85.96, 0.00, 2, NULL, 'EFECTIVO', '2025-12-23', '19:34:53', 1, '2025-12-23 23:34:53', '2025-12-23 23:34:53'),
(23, 8, 'HOSPEDAJE', 500.00, 0.00, 500.00, 1, 0, NULL, NULL, NULL, NULL, NULL, '', '2025-12-24', '10:58:24', 1, '2025-12-24 14:58:24', '2025-12-24 14:58:24');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicio_detalles`
--

INSERT INTO `servicio_detalles` (`id`, `registro_servicio_id`, `registro_id`, `producto_id`, `tipo`, `descripcion_externo`, `cantidad`, `precio_unitario`, `total`, `created_at`, `updated_at`) VALUES
(1, 9, 1, 1, 'INTERNO', NULL, 1, 200.00, 200.00, '2025-12-23 00:59:10', '2025-12-23 00:59:10'),
(2, 9, 1, 2, 'INTERNO', NULL, 4, 80.50, 322.00, '2025-12-23 00:59:10', '2025-12-23 00:59:10'),
(3, 10, 1, 4, 'INTERNO', NULL, 1, 20.00, 20.00, '2025-12-23 01:01:25', '2025-12-23 01:01:25'),
(4, 10, 1, 5, 'INTERNO', NULL, 1, 45.50, 45.50, '2025-12-23 01:01:25', '2025-12-23 01:01:25'),
(5, 11, 7, 1, 'INTERNO', NULL, 1, 200.00, 200.00, '2025-12-23 01:07:15', '2025-12-23 01:07:15'),
(6, 12, 8, 2, 'INTERNO', NULL, 1, 80.50, 80.50, '2025-12-23 01:07:29', '2025-12-23 01:07:29'),
(7, 13, 1, 1, 'INTERNO', NULL, 2, 200.00, 400.00, '2025-12-23 20:49:23', '2025-12-23 20:49:23'),
(8, 14, 1, 1, 'INTERNO', NULL, 2, 200.00, 400.00, '2025-12-23 20:49:23', '2025-12-23 20:49:23'),
(9, 15, 1, 5, 'INTERNO', NULL, 1, 45.50, 45.50, '2025-12-23 20:49:30', '2025-12-23 20:49:30'),
(10, 15, 1, 4, 'INTERNO', NULL, 1, 20.00, 20.00, '2025-12-23 20:49:30', '2025-12-23 20:49:30'),
(11, 15, 1, 2, 'INTERNO', NULL, 1, 80.50, 80.50, '2025-12-23 20:49:30', '2025-12-23 20:49:30'),
(12, 18, 1, 3, 'INTERNO', NULL, 1, 190.00, 190.00, '2025-12-23 21:53:28', '2025-12-23 21:53:28');

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
(2, 3, '2025-11-26', 8.00, '2025-11-26 13:39:41', '2025-11-26 13:39:41'),
(3, 2, '2025-12-16', 6.98, '2025-12-16 19:59:31', '2025-12-16 19:59:31');

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
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_productos`
--

INSERT INTO `tipo_productos` (`id`, `nombre`, `tipo`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'BEBIDAS', 'PRODUCTO', '', '2025-12-03 23:33:56', '2025-12-17 19:36:14'),
(2, 'COMIDAS', 'PRODUCTO', 'DESC', '2025-12-03 23:37:37', '2025-12-17 19:36:22'),
(3, 'RUPTURA DE VAJILLAS', 'SERVICIO', 'DESC', '2025-12-17 19:26:30', '2025-12-17 19:37:47'),
(4, 'DESAYUNO', 'PRODUCTO', '', '2025-12-17 19:36:34', '2025-12-17 19:36:34'),
(5, 'OTROS', 'SERVICIO', '', '2025-12-17 19:36:49', '2025-12-17 19:37:41'),
(6, 'MOMENTANEOS', 'SERVICIO', '', '2025-12-17 19:37:00', '2025-12-17 19:38:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transferencias`
--

CREATE TABLE `transferencias` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `habitacion_id` bigint UNSIGNED NOT NULL,
  `habitacion_destino_id` bigint UNSIGNED NOT NULL,
  `motivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
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
-- Indices de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kardex_productos_producto_id_foreign` (`producto_id`);

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
  ADD KEY `servicio_detalles_producto_id_foreign` (`producto_id`);

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
-- Indices de la tabla `transferencias`
--
ALTER TABLE `transferencias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transferencias_registro_id_foreign` (`registro_id`),
  ADD KEY `transferencias_habitacion_id_foreign` (`habitacion_id`),
  ADD KEY `transferencias_habitacion_destino_id_foreign` (`habitacion_destino_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `monedas`
--
ALTER TABLE `monedas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `movimiento_cajas`
--
ALTER TABLE `movimiento_cajas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `registros`
--
ALTER TABLE `registros`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `registro_servicios`
--
ALTER TABLE `registro_servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `servicio_detalles`
--
ALTER TABLE `servicio_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tipo_cambios`
--
ALTER TABLE `tipo_cambios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_habitacions`
--
ALTER TABLE `tipo_habitacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_productos`
--
ALTER TABLE `tipo_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `transferencias`
--
ALTER TABLE `transferencias`
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
-- Filtros para la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  ADD CONSTRAINT `kardex_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

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
  ADD CONSTRAINT `servicio_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `servicio_detalles_registro_id_foreign` FOREIGN KEY (`registro_id`) REFERENCES `registros` (`id`),
  ADD CONSTRAINT `servicio_detalles_registro_servicio_id_foreign` FOREIGN KEY (`registro_servicio_id`) REFERENCES `registro_servicios` (`id`);

--
-- Filtros para la tabla `transferencias`
--
ALTER TABLE `transferencias`
  ADD CONSTRAINT `transferencias_habitacion_destino_id_foreign` FOREIGN KEY (`habitacion_destino_id`) REFERENCES `habitacions` (`id`),
  ADD CONSTRAINT `transferencias_habitacion_id_foreign` FOREIGN KEY (`habitacion_id`) REFERENCES `habitacions` (`id`),
  ADD CONSTRAINT `transferencias_registro_id_foreign` FOREIGN KEY (`registro_id`) REFERENCES `registros` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
