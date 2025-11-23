-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 23-11-2025 a las 15:36:08
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
  `edad` int NOT NULL,
  `nacionalidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pais` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'SISHOTEL', 'SISHOTEL S.A.', 'I', 'logo.png', '2025-11-23 15:10:27', '2025-11-23 15:10:27');

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
  `precio_actual` decimal(24,2) NOT NULL,
  `precio_temp` decimal(24,2) DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `fecha_entrada` date NOT NULL,
  `hora_entrada` time NOT NULL,
  `dias_estadia` int DEFAULT '0',
  `fecha_salida` date DEFAULT NULL,
  `hora_salida` time DEFAULT NULL,
  `hora_salida_reg` time DEFAULT NULL,
  `total` decimal(24,2) NOT NULL,
  `adelanto` decimal(24,2) DEFAULT '0.00',
  `saldo` decimal(24,2) DEFAULT '0.00',
  `garantia` decimal(24,2) DEFAULT '0.00',
  `moneda_id` bigint UNSIGNED NOT NULL,
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
  `fecha` bigint UNSIGNED NOT NULL,
  `valor` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_habitacions`
--

CREATE TABLE `tipo_habitacions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `piso` int NOT NULL,
  `capacidad` int NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `precio` decimal(24,2) DEFAULT NULL,
  `precio_temp` decimal(24,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 1, 'ADMINISTRADOR', NULL, '2025-11-23', 1, '2025-11-23 15:10:27', '2025-11-23 15:10:27');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habitacion_fotos`
--
ALTER TABLE `habitacion_fotos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_habitacions`
--
ALTER TABLE `tipo_habitacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
