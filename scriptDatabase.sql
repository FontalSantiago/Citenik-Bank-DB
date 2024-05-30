CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador incremental del registro de cliente en la BD',
  `legajo` int(11) NOT NULL COMMENT 'número identificador del cliente',
  `nombre` varchar(50) NOT NULL COMMENT 'nombre y apellido del cliente',
  `CUIT` varchar(30) NOT NULL COMMENT 'clave de identificación tributaria / laboral',
  `fecha_nacimiento` date NOT NULL COMMENT 'fecha de nacimiento anterior a la actual',
  `estado` tinyint(1) DEFAULT '1' COMMENT 'bandera de cliente habilitado o deshabilitado',
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientes_uk_cuit` (`CUIT`),
  UNIQUE KEY `clientes_uk_legajo` (`legajo`)
);

CREATE TABLE `planes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador incremental del registro de plan en la BD',
  `nombre` varchar(50) NOT NULL COMMENT 'nombre del plan',
  `TNA` double NOT NULL COMMENT 'tasa nominal anual del plan',
  `cuotasMax` int(11) NOT NULL COMMENT 'cuotas máximas',
  `cuotasMin` int(11) NOT NULL COMMENT 'cuotas mínimas',
  `montoMax` double NOT NULL COMMENT 'monto maximo del plan',
  `montoMin` double NOT NULL COMMENT 'monto mínimo del plan',
  `edadMax` int(11) DEFAULT NULL COMMENT 'edad maxima permitida',
  `precanCuota` int(11) DEFAULT NULL COMMENT 'cuota en la que se puede precancelar el plan',
  `precanMulta` double DEFAULT NULL COMMENT 'porcentaje de multa de precancelacion del plan',
  `costoOtorgamiento` double DEFAULT NULL COMMENT 'costo de otorgamiento del plan',
  `vigenciaDesde` date NOT NULL COMMENT 'fecha de vigencia inicio del plan',
  `vigenciaHasta` date DEFAULT NULL COMMENT 'fecha de vigencia final del plan',
  PRIMARY KEY (`id`)
); 

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador incremental del registro de usuario en la BD',
  `usuario` varchar(50) NOT NULL COMMENT 'nombre de usuario',
  `password` varchar(50) NOT NULL COMMENT 'contraseña de usuario',
  PRIMARY KEY (`id`)
);

CREATE TABLE `prestamos` (
  `id` int(11) NOT NULL COMMENT 'identificador incremental de los prestamos otorgados en la BD',
  `idPlan` int(11) NOT NULL COMMENT 'id del registro de plan relacionado con el prestamo otorgado',
  `idCliente` int(11) NOT NULL COMMENT 'id del registro de cliente relacionado con el prestamo otorgado',
  `capital` float NOT NULL COMMENT 'monto solicitado como préstamo',
  `cantidadCuotas` int(11) DEFAULT NULL COMMENT 'cantidad de cuotas del prestamo otorgado',  
  `fechaOtorgamiento` date NOT NULL COMMENT 'fecha en la que se otorgo el prestamo',
  `diaVencimiento` int(11) NOT NULL COMMENT 'día de vencimiento de las cuotas asociadas al prestamo otorgado',
  `estado` varchar(50) NOT NULL COMMENT 'estado en el que se encuentra el prestamo otorgado',
  PRIMARY KEY (`id`),
  KEY `prestamos_FK` (`idPlan`),
  KEY `prestamos_FK_1` (`idCliente`),
  CONSTRAINT `prestamos_FK` FOREIGN KEY (`idPlan`) REFERENCES `planes` (`id`),
  CONSTRAINT `prestamos_FK_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`id`)
);

CREATE TABLE `cuotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador incremental de las cuotas en la BD',
  `idPrestamo` int(11) NOT NULL COMMENT 'id del registro de prestamo relacionado con la cuota',
  `nroCuota` int(11) NOT NULL COMMENT 'numero de cuota de un prestamo',
  `fechaPago` date DEFAULT NULL COMMENT 'fecha en la que se pago la cuota',
  `fechaVencimiento` date NOT NULL COMMENT 'fecha en la que se vence la cuota',
  PRIMARY KEY (`id`),
  KEY `cuotas_FK` (`idPrestamo`),
  CONSTRAINT `cuotas_FK` FOREIGN KEY (`idPrestamo`) REFERENCES `prestamos` (`id`)
);

CREATE TABLE `composiciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador incremental de la composición de una cuota en la BD',
  `idCuota` int(11) NOT NULL COMMENT 'id del registro de cuota relacionado con la composición',
  `idConcepto` int(11) NOT NULL COMMENT 'id del registro de concepto relacionad con la composición',
  `monto` float NOT NULL COMMENT 'monto final de la composición',
  PRIMARY KEY (`id`),
  KEY `composiciones_FK` (`idConcepto`),
  KEY `composiciones_FK_1` (`idCuota`),
  CONSTRAINT `composiciones_FK` FOREIGN KEY (`idConcepto`) REFERENCES `conceptos` (`idConcepto`),
  CONSTRAINT `composiciones_FK_1` FOREIGN KEY (`idCuota`) REFERENCES `cuotas` (`id`)
);

CREATE TABLE `conceptos` (
  `idConcepto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador incremental del concepto en la BD',
  `nombre` varchar(50) NOT NULL COMMENT 'nombre del concepto',
  PRIMARY KEY (`idConcepto`)
)