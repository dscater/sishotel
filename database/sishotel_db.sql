-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-12-2025 a las 00:20:59
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
(1, 0.00, 1100.00, 0.00, 1100.00, 0.00, NULL, '2025-12-26', '20:16:46', NULL, NULL, 1, 1, '2025-12-27 00:16:46', '2025-12-27 00:17:21');

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
(1, 'H-001', 1, 0, 1, 300.00, 0.00, 0, 1, '2025-11-24 21:08:48', '2025-12-23 23:34:53'),
(2, 'H-002', 2, 1, 2, 500.00, 0.00, 0, 1, '2025-11-24 21:17:59', '2025-12-24 22:33:41'),
(3, 'H-003', 3, 1, 2, 800.00, 200.00, 0, 1, '2025-11-24 21:23:46', '2025-12-26 14:22:31'),
(4, 'H-004', 4, 1, 3, 800.00, 250.00, 0, 1, '2025-11-24 21:30:34', '2025-12-24 23:10:43');

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
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MOVIMIENTO DE CAJA', '{\"id\": 1, \"tc\": 0, \"tipo\": \"INGRESO\", \"monto\": \"1000\", \"modelo\": null, \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": \"1000\", \"modelo_id\": null, \"moneda_id\": 1, \"created_at\": \"2025-12-27T00:16:57.000000Z\", \"updated_at\": \"2025-12-27T00:16:57.000000Z\", \"descripcion\": \"INICIO DE CAJA EFECTIVO\", \"moneda_id_tc\": \"1\", \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": null, \"hora_movimiento\": \"20:16\", \"fecha_movimiento\": \"2025-12-26\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-26', '20:16:57', '2025-12-27 00:16:57', '2025-12-27 00:16:57'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN MOVIMIENTO DE CAJA', '{\"id\": 2, \"tc\": \"1\", \"tipo\": \"INGRESO\", \"monto\": \"100\", \"modelo\": null, \"caja_id\": 1, \"user_id\": 1, \"monto_tc\": \"100\", \"modelo_id\": null, \"moneda_id\": 1, \"created_at\": \"2025-12-27T00:17:21.000000Z\", \"updated_at\": \"2025-12-27T00:17:21.000000Z\", \"descripcion\": \"INGRESO DOLARES\", \"moneda_id_tc\": \"2\", \"efectivo_banco\": \"EFECTIVO\", \"tipo_cambio_id\": \"3\", \"hora_movimiento\": \"20:17\", \"fecha_movimiento\": \"2025-12-26\"}', NULL, 'MOVIMIENTO DE CAJA', '2025-12-26', '20:17:21', '2025-12-27 00:17:21', '2025-12-27 00:17:21');

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
  `valor_tc` decimal(24,2) DEFAULT NULL,
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

INSERT INTO `movimiento_cajas` (`id`, `caja_id`, `modelo_id`, `modelo`, `monto`, `moneda_id`, `tc`, `monto_tc`, `moneda_id_tc`, `tipo_cambio_id`, `valor_tc`, `tipo`, `efectivo_banco`, `descripcion`, `fecha_movimiento`, `hora_movimiento`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 1000.00, 1, 0, 1000.00, 1, NULL, NULL, 'INGRESO', 'EFECTIVO', 'INICIO DE CAJA EFECTIVO', '2025-12-26', '20:16:00', 1, '2025-12-27 00:16:57', '2025-12-27 00:16:57'),
(2, 1, NULL, NULL, 100.00, 1, 1, 100.00, 2, 3, NULL, 'INGRESO', 'EFECTIVO', 'INGRESO DOLARES', '2025-12-26', '20:17:00', 1, '2025-12-27 00:17:21', '2025-12-27 00:17:21');

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
(1, 'VINO', 'DESC', 200.00, 1, 28, 1, NULL, '2025-12-03 23:54:15', '2025-12-24 23:45:04'),
(2, 'POLLO FRITO', 'DESC', 80.50, 2, 2, 1, '21764806725.jpeg', '2025-12-03 23:55:06', '2025-12-24 23:43:49'),
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
  `desc_garantia` varchar(900) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_servicios`
--

CREATE TABLE `registro_servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` double(8,2) NOT NULL,
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
  `valor_tc` decimal(24,2) DEFAULT NULL,
  `efectivo_banco` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
