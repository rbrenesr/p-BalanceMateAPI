SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Configuracion](
	[id] [varchar](50) NOT NULL,
	[valor] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Configuracion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Configuracion] ADD  CONSTRAINT [DF_Configuracion_valor]  DEFAULT ('') FOR [valor]


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Catalogo](
	[id] [varchar](50) NOT NULL,
	[tipo] [varchar](3) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Catalogo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Catalogo] ADD  CONSTRAINT [DF_Catalogo_id]  DEFAULT ('') FOR [id]
ALTER TABLE [dbo].[Catalogo] ADD  CONSTRAINT [DF_Catalogo_tipo]  DEFAULT ('ACT') FOR [tipo]
ALTER TABLE [dbo].[Catalogo] ADD  CONSTRAINT [DF_Catalogo_descripcion]  DEFAULT ('') FOR [descripcion]
ALTER TABLE [dbo].[Catalogo]  WITH CHECK ADD CHECK  (([tipo]='ORD' OR [tipo]='GAS' OR [tipo]='COS' OR [tipo]='ING' OR [tipo]='PAT' OR [tipo]='PAS' OR [tipo]='ACT'))


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TipoAsiento](
	[id] [varchar](10) NOT NULL,
	[nombre] [varchar](250) NOT NULL,
 CONSTRAINT [PK_TipoAsiento] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[TipoAsiento] ADD  CONSTRAINT [DF_TipoAsiento_nombre]  DEFAULT ('') FOR [nombre]


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TipoDocumento](
	[id] [varchar](10) NOT NULL,
	[nombre] [varchar](250) NOT NULL,
 CONSTRAINT [PK_TipoDocumento] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[TipoDocumento] ADD  CONSTRAINT [DF_TipoDocumento_nombre]  DEFAULT ('') FOR [nombre]


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Tercero](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](3) NOT NULL,
	[nit] [varchar](50) NOT NULL,
	[nombre] [varchar](150) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[telefono] [varchar](50) NOT NULL,
	[direccion] [varchar](250) NOT NULL,
	[observacion] [varchar](500) NOT NULL,
	[estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Tercero] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_tipo]  DEFAULT ('CLI') FOR [tipo]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_nit]  DEFAULT ('') FOR [nit]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_nombre]  DEFAULT ('') FOR [nombre]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_email]  DEFAULT ('') FOR [email]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_telefono]  DEFAULT ('') FOR [telefono]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_direccion]  DEFAULT ('') FOR [direccion]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_observacion]  DEFAULT ('') FOR [observacion]
ALTER TABLE [dbo].[Tercero] ADD  CONSTRAINT [DF_Tercero_estado]  DEFAULT ('ACTIVO') FOR [estado]
ALTER TABLE [dbo].[Tercero]  WITH CHECK ADD CHECK  (([tipo]='CLI' OR [tipo]='PRV' OR [tipo]='OTR'))


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Asiento](
	[id] [varchar](25) NOT NULL,
	[idTipoAsiento] [varchar](10) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[concepto] [varchar](250) NOT NULL,
	[moneda] [varchar](3) NOT NULL,
	[tipoTasa] [varchar](1) NOT NULL,
	[tasa] [decimal](20, 2) NOT NULL,
	[totalDebe] [decimal](20, 2) NOT NULL,
	[totalHaber] [decimal](20, 2) NOT NULL,
	[totalDebeL] [decimal](20, 2) NOT NULL,
	[totalHaberL] [decimal](20, 2) NOT NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_Asiento] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_fecha]  DEFAULT (getdate()) FOR [fecha]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_concepto]  DEFAULT ('') FOR [concepto]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_moneda]  DEFAULT ('') FOR [moneda]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_tipoTasa]  DEFAULT ('V') FOR [tipoTasa]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_tasa]  DEFAULT ((1.00)) FOR [tasa]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_totalDebe]  DEFAULT ((0.00)) FOR [totalDebe]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_totalHaber]  DEFAULT ((0.00)) FOR [totalHaber]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_totalDebeL]  DEFAULT ((0.00)) FOR [totalDebeL]
ALTER TABLE [dbo].[Asiento] ADD  CONSTRAINT [DF_Asiento_totalHaberL]  DEFAULT ((0.00)) FOR [totalHaberL]
ALTER TABLE [dbo].[Asiento]  WITH CHECK ADD  CONSTRAINT [FK_Asiento_TipoAsiento] FOREIGN KEY([idTipoAsiento])
REFERENCES [dbo].[TipoAsiento] ([id])
ALTER TABLE [dbo].[Asiento] CHECK CONSTRAINT [FK_Asiento_TipoAsiento]
ALTER TABLE [dbo].[Asiento]  WITH CHECK ADD CHECK  (([tipoTasa]='V' OR [tipoTasa]='C'))


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AsientoDetalle](
	[id] [int] NOT NULL,
	[idAsiento] [varchar](25) NOT NULL,
	[idCatalogo] [varchar](50) NOT NULL,
	[observaciones] [varchar](250) NOT NULL,
	[idTipoDocumento] [varchar](10) NOT NULL,
	[numeroDocumento] [varchar](50) NOT NULL,
	[idTercero] [int] NOT NULL,
	[moneda] [varchar](3) NOT NULL,
	[tipoTasa] [varchar](1) NOT NULL,
	[tasa] [decimal](20, 2) NOT NULL,
	[totalDebe] [decimal](20, 2) NOT NULL,
	[totalHaber] [decimal](20, 2) NOT NULL,
	[totalDebeL] [decimal](20, 2) NOT NULL,
	[totalHaberL] [decimal](20, 2) NOT NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_AsientoDetalle] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[idAsiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_numeroDocumento]  DEFAULT ('') FOR [numeroDocumento]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_moneda]  DEFAULT ('') FOR [moneda]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_tipoTasa]  DEFAULT ('V') FOR [tipoTasa]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_tasa]  DEFAULT ((1.00)) FOR [tasa]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_totalDebe]  DEFAULT ((0.00)) FOR [totalDebe]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_totalHaber]  DEFAULT ((0.00)) FOR [totalHaber]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_totalDebeL]  DEFAULT ((0.00)) FOR [totalDebeL]
ALTER TABLE [dbo].[AsientoDetalle] ADD  CONSTRAINT [DF_AsientoDetalle_totalHaberL]  DEFAULT ((0.00)) FOR [totalHaberL]
ALTER TABLE [dbo].[AsientoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_AsientoDetalle_Asiento] FOREIGN KEY([idAsiento])
REFERENCES [dbo].[Asiento] ([id])
ALTER TABLE [dbo].[AsientoDetalle] CHECK CONSTRAINT [FK_AsientoDetalle_Asiento]
ALTER TABLE [dbo].[AsientoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_AsientoDetalle_Catalogo] FOREIGN KEY([idCatalogo])
REFERENCES [dbo].[Catalogo] ([id])
ALTER TABLE [dbo].[AsientoDetalle] CHECK CONSTRAINT [FK_AsientoDetalle_Catalogo]
ALTER TABLE [dbo].[AsientoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_AsientoDetalle_Tercero] FOREIGN KEY([idTercero])
REFERENCES [dbo].[Tercero] ([id])
ALTER TABLE [dbo].[AsientoDetalle] CHECK CONSTRAINT [FK_AsientoDetalle_Tercero]
ALTER TABLE [dbo].[AsientoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_AsientoDetalle_TipoDocumento] FOREIGN KEY([idTipoDocumento])
REFERENCES [dbo].[TipoDocumento] ([id])
ALTER TABLE [dbo].[AsientoDetalle] CHECK CONSTRAINT [FK_AsientoDetalle_TipoDocumento]
ALTER TABLE [dbo].[AsientoDetalle]  WITH CHECK ADD CHECK  (([tipoTasa]='V' OR [tipoTasa]='C'))




INSERT INTO [dbo].[Configuracion] ([id], [valor])
VALUES 
	('CtaActivoCirculante', ''),
	('CtaActivoTotal', ''),
	('CtaCapital', ''),
	('CtaCostoVentas', ''),
	('CtaInventario', ''),
	('CtaPasivoLargoPlazo', ''),
	('CtaPasivoTotal', ''),
	('CtaUtilPerdida', ''),
	('CtaUtilPerdidaAcumulada', ''),
	('PerFecFin', '' ),
	('PerFecInactividad', ''),
	('PerFecIni', '')


INSERT INTO [dbo].[Catalogo]  ([id],[tipo],[descripcion])
VALUES 
	('1000000','ACT','ACTIVO TOTAL'),
    ('1100000','ACT','ACTIVO CORRIENTE'),
    ('1101000','ACT','CAJAS'),
    ('1101001','ACT','Caja Chica Proveduría'),
    ('1101002','ACT','Caja Chica'),
    ('1101003','ACT','Depositos en transito'),
    ('1101004','ACT','Dep. en tránsito Centro Radiológico ASESA'),
    ('1101005','ACT','Caja Chica Centro Radiológico ASESA'),
    ('1102000','ACT','BANCOS Y FINANCIERAS'),
    ('1102001','ACT','BNCR # 147-0631-6 Colones'),
    ('1102002','ACT','BNCR # 204-254-6  Dolares'),
    ('1102003','ACT','DESYFIN # 126401 Colones'),
    ('1102004','ACT','DESYFIN # 126402 Dólares'),
    ('1102005','ACT','BAC 934475963 Colones'),
    ('1102006','ACT','BAC 938373859 dólares'),
    ('1102007','ACT','BN Fondos Colones'),
    ('1102008','ACT','BN Fondos Super $ Plus'),
    ('1102009','ACT','BN- Ahorro Programado Aguinaldo'),
    ('1102010','ACT','BN- Ahorro Programado Imp. Renta'),
    ('1102011','ACT','BAC CR44010201204500370348 DOLARES'),
    ('1102015','ACT','DESYFIN CDP Colones'),
    ('1102016','ACT','DESYFIN CDP Dólares'),
    ('1102019','ACT','ALDESA A LA VISTA Dólares'),
    ('1102020','ACT','ALDESA CDP Colones'),
    ('1102021','ACT','ALDESA CDP Dólares'),
    ('1102022','ACT','Estimación perdida inversion ALDESA'),
    ('1103000','ACT','CUENTAS POR COBRAR'),
    ('1103001','ACT','C x C Asembis'),
    ('1103002','ACT','C x C Biocomercio'),
    ('1103003','ACT','Terceros'),
    ('1103004','ACT','C x C Deduccion Colaborador'),
    ('1103010','ACT','C x C Proveedores'),
    ('1103011','ACT','C X C Salud Integral Montecarlo'),
    ('1103012','ACT','Laboratorio Hector Alonso Orozco Salas'),
    ('1103013','ACT','Laboratorio AJ Experts Dental Designers S. A.'),
    ('1103014','ACT','Préstamo de Corto Plazo Dr. Montiel'),
    ('1103015','ACT','Cuenta por Cobrar Clientes'),
    ('1103016','ACT','CXC Comercio Versatil S. A.'),
    ('1104000','ACT','INVENTARIO PARA CONSUMO INTERNO'),
    ('1104001','ACT','Inv.  de Material Odontologico'),
    ('1104002','ACT','Inventario en tránsito'),
    ('1104003','ACT','Inv.  de Equipo Odontología General'),
    ('1104004','ACT','Inv. de Repuestos Odontología General'),
    ('1104005','ACT','Inv. Material Laboratorio CAD CAM'),
    ('1104006','ACT','Inv. Instrumental Odontológico'),
    ('1104007','ACT','Inventario de Servicios'),
    ('1104008','ACT','Inv. Material Centro Radiologico'),
    ('1104009','ACT','Inv. de Suministros'),
    ('1104010','ACT','Inv. Material Implantes Dentales'),
    ('1105000','ACT','CARGOS DIFERIDOS'),
    ('1105001','ACT','Seguro Riesgos del Trabajo'),
    ('1105002','ACT','Seguro Responsabilidad Civil'),
    ('1105003','ACT','Seguro de vehículos'),
    ('1105004','ACT','Sistemas Informáticos Softdial'),
    ('1105005','ACT','Seguro de Equipo Electrónico'),
    ('1105006','ACT','Servicios Profesionales'),
    ('1200000','ACT','ACTIVO DE LARGO PLAZO'),
    ('1202000','ACT','PROPIEDAD PLANTA Y EQUIPO'),
    ('1202001','ACT','Mobiliario y Equipo de Clínica'),
    ('1202002','ACT','Equipo de Oficina'),
    ('1202003','ACT','Equipo de Computo'),
    ('1202004','ACT','Vehículos'),
    ('1202005','ACT','Licencias Informáticas'),
    ('1202006','ACT','Equipo Centro Radiológico'),
    ('1202007','ACT','MOBILIARIO Y EQUIPO DE LABORATORIO'),
    ('1203000','ACT','DEPRECIACIONES ACUMULADAS'),
    ('1203001','ACT','Dep. Acum. Mobiliario y Equipo de Clínica'),
    ('1203002','ACT','Dep. Acum. Equipo de oficina'),
    ('1203003','ACT','Dep. Acum. Eq. de Computo'),
    ('1203004','ACT','Dep. Acum. Vehiculos'),
    ('1203005','ACT','Amort. Licencias Informáticas'),
    ('1203006','ACT','Dep. Acumulada equipo Centro radiológico'),
    ('1203007','ACT','Dep. Acumulada mobiliario y Equipo Laboratorio'),
    ('1204000','ACT','OTROS ACTIVOS'),
    ('1204001','ACT','Terreno Grecia Lote 26'),
    ('1204002','ACT','Adelantos de Renta'),
    ('1204003','ACT','Depósito de Garantía'),
    ('1204004','ACT','Retencion,  2% impuesto de renta'),
    ('1204005','ACT','Adelantos para Mobiliario y Equipo'),
    ('1204006','ACT','Retencion 8% renta s/intereses ganados'),
    ('1204007','ACT','Adelantos para Uniformes'),
    ('2000000','PAS','PASIVO TOTAL'),
    ('2100000','PAS','PASIVOS CORRIENTES'),
    ('2101000','PAS','CUENTAS A PAGAR'),
    ('2101001','PAS','C x P Proveedores Nacionales'),
    ('2101002','PAS','C x Proveedores Diversos'),
    ('2101005','PAS','Cuentas por pagar ALQUIMIA'),
    ('2101010','PAS','C x  P Clientes'),
    ('2101011','PAS','Proveedor Generico MOTIVOS'),
    ('2101012','PAS','Cuentas por pagar Otros'),
    ('2101013','PAS','Umpuesto de Renta por pagar'),
    ('2101014','PAS','C x P Salud Integral Montecarlo S. A.'),
    ('2101015','PAS','Anticipo de Clientes'),
    ('2101016','PAS','IVA Repercutido 4%'),
    ('2101017','PAS','IVA Repercutido 13%'),
    ('2101019','PAS','Cuenta por pagar asociado'),
    ('2101020','PAS','IVA Soportado 4%'),
    ('2101021','PAS','IVA Soportado 13%'),
    ('2101022','PAS','IVA Soportado 2%'),
    ('2101023','PAS','C X P Verónica Montiel Arias'),
    ('2102000','PAS','PASIVOS DE PLANILLA'),
    ('2102001','PAS','Planilla por pagar'),
    ('2102002','PAS','Cuotas Obrero Patronal CCSS'),
    ('2102003','PAS','Aguinaldo'),
    ('2102004','PAS','Vacaciones'),
    ('2102005','PAS','Cesantía'),
    ('2102006','PAS','Retenciones de Renta X Pagar'),
    ('2102007','PAS','RETENCIONES DE EMBARGO POR PAGAR'),
    ('2102008','PAS','Riesgos del Trabajo'),
    ('2103000','PAS','GASTOS ACUMULADOS'),
    ('2103001','PAS','Servicios Profesionales'),
    ('2103002','PAS','Servicios y Productos Varios'),
    ('2103003','PAS','Servicios de Laboratorio'),
    ('2103004','PAS','IVA REPERCUTIDO MARZO 2020'),
    ('2104000','PAS','TARJETAS DE CREDITO'),
    ('2104001','PAS','BNCR 7834 Empresarial colones'),
    ('2104002','PAS','BNCR 7834 Empresarial dolares'),
    ('2104005','PAS','BAC 0777 - 0736 Colones Visa E'),
    ('2104006','PAS','BAC 0777 - 0736 Dolares Visa E'),
    ('2104007','PAS','BAC 0785 - 0751 Colones Visa V'),
    ('2104008','PAS','BAC 0785 - 0751 Dolares Visa V'),
    ('2104009','PAS','BAC 0793 - 0769 Colones Visa K'),
    ('2104010','PAS','BAC 0793 0769  Dolares Visa K'),
    ('2104011','PAS','BAC 0801 - 0744 Colones Visa C'),
    ('2104012','PAS','BAC 0801 - 0744 Dolares Visa C'),
    ('2104013','PAS','BAC 5379 - 5356 Colones AMEX'),
    ('2104014','PAS','BAC 5379 - 5356 Dolares AMEX'),
    ('2200000','PAS','PASIVO DE LARGO PLAZO'),
    ('2201000','PAS','PRESTAMOS BANCARIOS'),
    ('2201001','PAS','BNCR. OP # 204-15-20806212 $'),
    ('2201002','PAS','Scotia  Leasing Contrato 13796'),
    ('2201003','PAS','BNCR - Op 80-14-20908912'),
    ('2201004','PAS','DESYFIN CONTRATO DE ARRENDAMIENTO'),
    ('2201005','PAS','BAC Arrendamiento Operativo en Función Financiera'),
    ('2201006','PAS','Bac Leasing # 450037034'),
    ('2205000','PAS','OTROS PASIVOS'),
    ('2205001','PAS','Provision para Cesantia'),
    ('3000000','PAT','PATRIMONIO'),
    ('3100000','PAT','PATRIMONIO'),
    ('3101000','PAT','APORTES DE ASOCIOS'),
    ('3101001','PAT','Cuotas de Asociados'),
    ('3104000','PAT','UTILIDADES'),
    ('3104001','PAT','Utilidades Acumuladas'),
    ('3104002','PAT','Utilidad del período actual'),
    ('4000000','ING','INGRESOS'),
    ('4100000','ING','VENTAS'),
    ('4101000','ING','VENTA DE SERVICIOS'),
    ('4101001','ING','Servicios Odontológicos'),
    ('4101002','ING','Especialidades Ortodoncia'),
    ('4101003','ING','Especialidad Maxilofacial'),
    ('4101004','ING','Especialidad Periodoncia'),
    ('4101005','ING','Especialidad Endodoncia'),
    ('4101006','ING','Especialidad Dolor Orofacial'),
    ('4101010','ING','Ingresos de servicios por distribuir'),
    ('4102000','ING','DESCUENTOS Y DEVOLUCIONES'),
    ('4102001','ING','Descuentos Sobre Ventas'),
    ('4102002','ING','Devoluciones por Garantia de Servicio'),
    ('4103000','ING','OTROS INGRESOS'),
    ('4103001','ING','Descuentos Sobre Compras'),
    ('4103002','ING','Intereses Ganados BN Fondos'),
    ('4103003','ING','Ingreso X Diferencial Cambiario'),
    ('4103004','ING','Ingresos Diversos'),
    ('4103005','ING','Intereses Ahorro Programado Aguinaldo'),
    ('4103006','ING','Intereses Ahorro Programado Imp. Renta'),
    ('4103007','ING','Subarriendo de Laboratorio'),
    ('4103009','ING','Intereses ganados Desyfin'),
    ('4103010','ING','Intereses ganados BAC San José'),
    ('4103011','ING','Intereses ganados ALDESA VALORES'),
    ('4103012','ING','Ganancia en Venta de Activos'),
    ('4104000','ING','VENTAS CENTRO RADIOLOGICO ASESA'),
    ('4104001','ING','Radiografía Panorámica'),
    ('4104002','ING','Radiografía Cefalométrica'),
    ('4104003','ING','Paquete para Ortodoncia'),
    ('4104004','ING','Tomografía una Arcada'),
    ('4104005','ING','Tomografía Completa'),
    ('4104006','ING','Radiografia ATM'),
    ('4104007','ING','Ventas Centro Radiologico'),
    ('4105000','ING','SERVICIOS DE LABORATORIO'),
    ('4105001','ING','Corona de Zirconio'),
    ('4105002','ING','Cofia Zirconio para Laboratorio'),
    ('4105003','ING','Corona sobre implante Emax'),
    ('4105004','ING','Incrustacion Emax'),
    ('4105005','ING','Fundas de Blanqueamiento'),
    ('4105006','ING','Provisional sobre implante'),
    ('4105007','ING','Provisional PMMA por Unidad'),
    ('4105008','ING','Encerado Diagnóstico por Unidad'),
    ('4105009','ING','Impresión en modelo 3D'),
    ('4105010','ING','Servicios Laboratorio CAD CAM'),
    ('5000000','COS','COSTO'),
    ('5100000','COS','COSTO'),
    ('5101000','COS','COSTO'),
    ('5101001','COS','Costo de Inventario General'),
    ('6000000','GAS','GASTOS'),
    ('6100000','GAS','GASTOS GENERALES Y ADMINISTRACION'),
    ('6101000','GAS','DIRECCION DE TALENTO HUMANO'),
    ('6101001','GAS','Salario Ordinario'),
    ('6101002','GAS','Salario extraordinario'),
    ('6101003','GAS','Salario Hora sencilla'),
    ('6101004','GAS','Cuota Patronal CCSS'),
    ('6101005','GAS','Aguinaldo'),
    ('6101006','GAS','Vacaciones'),
    ('6101007','GAS','Cesantia'),
    ('6101008','GAS','Seguro Riesgos del Trabajo'),
    ('6101009','GAS','Seguro Responsabilidad Civil'),
    ('6101010','GAS','Servicios Profesionales'),
    ('6101011','GAS','Servicios Profesionales Especialistas'),
    ('6101013','GAS','Subsidio'),
    ('6101014','GAS','Incentivos'),
    ('6102000','GAS','SERVICIOS PUBLICOS'),
    ('6102001','GAS','Servicios Telefónicos'),
    ('6102002','GAS','Servicios de Electricidad'),
    ('6102003','GAS','Servicios de Agua'),
    ('6102004','GAS','Servicios Internet y Cable'),
    ('6102005','GAS','Patente Municipal'),
    ('6102006','GAS','Bienes Inmuebles Municipalidad Grecia'),
    ('6103000','GAS','GASTO FINANCIERO'),
    ('6103001','GAS','INTERESES BNCR'),
    ('6103002','GAS','Intereses Scotia Leasing # 4033'),
    ('6103003','GAS','Comisiones Bancarias'),
    ('6103004','GAS','Diferencial Cambiario Gasto'),
    ('6103005','GAS','Intereses Desyfin'),
    ('6103006','GAS','Intereses BAC San José Tarjetas de Crédito'),
    ('6103007','GAS','Intereses  Leasing BAC San José'),
    ('6104000','GAS','ALQUILERES'),
    ('6104001','GAS','Alquiler de Edificio Principal'),
    ('6104002','GAS','Alquiler de Instalaciones'),
    ('6104003','GAS','Alquiler de Aula Colegio Ciencias Económicas'),
    ('6104004','GAS','Alquiler Tecnología Informática Softdial'),
    ('6104005','GAS','Alquiler equipo médico.'),
    ('6104006','GAS','alquiler de Laboratorio'),
    ('6104007','GAS','Renting Toyota'),
    ('6104008','GAS','Aula Colegio de Cirujanos Dentistas'),
    ('6104009','GAS','Alquiler Tecnología Informática Softland'),
    ('6104010','GAS','Espacio de Almacenamiento en la nube'),
    ('6105000','GAS','MATERIALES Y SUMINISTROS'),
    ('6105001','GAS','Material Odontología General'),
    ('6105002','GAS','Material Odontológico Especialidades'),
    ('6105003','GAS','Servicios de Laboratorios Externos'),
    ('6105004','GAS','Papelería y ütiles de Oficina'),
    ('6105005','GAS','Suministros de Limpieza'),
    ('6105006','GAS','Gasolina'),
    ('6105007','GAS','Diesel'),
    ('6105008','GAS','Material de Empaque y Alistado'),
    ('6105009','GAS','Faltantes de inventario'),
    ('6105010','GAS','Diferencias de Inventario'),
    ('6105011','GAS','Material Centro Radiológico'),
    ('6105012','GAS','Instrumental Odontología General'),
    ('6105013','GAS','Material Implantes Dentales'),
    ('6105014','GAS','Material Laboratorio CAD CAM'),
    ('6105015','GAS','Timbre Odontológico'),
    ('6107000','GAS','REPARACIONES Y MANTENIMIENTO'),
    ('6107001','GAS','Rep y Mant Mobiliario y Equipo de Oficina'),
    ('6107002','GAS','Rep. y Mant. Equipo de Cómputo'),
    ('6107003','GAS','Rep. Mant. Edificio e Instalaciones'),
    ('6107004','GAS','Rep. y Mant. Equipo odontología General'),
    ('6107005','GAS','Rep y Mant. de Vehículos'),
    ('6107006','GAS','Mant. y Limpieza Zonas Verdes'),
    ('6107007','GAS','Rep. y Mant. Equipo Centro Radiológico'),
    ('6107008','GAS','Rep. y Mant. Equipo Laboratorio CAD CAM'),
    ('6107009','GAS','Rep. y Mantenimiento Equipo de Seguridad'),
    ('6108000','GAS','GASTO POR DEPRECIACION'),
    ('6108001','GAS','DEP,  Mobiliario y Equipo de Clínica'),
    ('6108002','GAS','DEP. Equipo de Oficina'),
    ('6108003','GAS','DEP. EQUIPO DE COMPUTO'),
    ('6108004','GAS','DEP. VEHICULOS'),
    ('6108005','GAS','Amortizacion Licencias CAD - CAM'),
    ('6108006','GAS','Dep. Equipo Radiológico'),
    ('6108007','GAS','Dep. Equipo Laboratorio CAD- CAM'),
    ('6109000','GAS','ATENCION A COLABORADORES'),
    ('6109001','GAS','Productos Alimenticios'),
    ('6109002','GAS','Uniformes'),
    ('6109003','GAS','CAPACITACION'),
    ('6109004','GAS','Viaticos Administrativos'),
    ('6109005','GAS','Viaticos Colaboradores'),
    ('6109006','GAS','Cuota Cámara y Colegios Profesionales'),
    ('6109007','GAS','CLUBES DE VIAJE Y RECREACION'),
    ('6109008','GAS','OTROS BENEFICIOS ESPECIALES'),
    ('6109009','GAS','SEGUROS Y GASTOS MEDICOS'),
    ('6109010','GAS','Reunión General de Personal, mensual'),
    ('6109011','GAS','ACTIVIDADES DE MOTIVACION'),
    ('6109012','GAS','OTROS GASTOS  RRHH'),
    ('6109013','GAS','Medicamentos'),
    ('6109014','GAS','Capacitación contínua'),
    ('6110000','GAS','GASTOS DIVERSOS'),
    ('6110001','GAS','Servicio de Taxi'),
    ('6110002','GAS','Monitoreo y Vigilancia'),
    ('6110003','GAS','SEGURO DE VEHICULOS'),
    ('6110004','GAS','GASTOS LEGALES OTROS'),
    ('6110005','GAS','Peajes y parqueos'),
    ('6110006','GAS','MARCHAMOS Y REVISION TECNICA'),
    ('6110007','GAS','Publicidad'),
    ('6110008','GAS','Servicio de Mensajeria'),
    ('6110009','GAS','Servicio de Encomiendas'),
    ('6110010','GAS','Viaticos Clinica Movil'),
    ('6110011','GAS','Aplicaciones Microsoft'),
    ('6110012','GAS','Cuota Condominio Grecia'),
    ('6110013','GAS','Perdida en venta de Activos de Uso'),
    ('6110014','GAS','Suscripciones'),
    ('6110015','GAS','Seguro Equipo Electrónico'),
    ('6110016','GAS','Donaciones'),
    ('6110017','GAS','Sistema Facturacion Electronica ARGUS'),
    ('6110018','GAS','Permisos Ministerio de Salud'),
    ('6110019','GAS','Otros gastos'),
    ('6110020','GAS','Iva Soportado No Acreditable'),
    ('6110021','GAS','Fletes'),
    ('6110022','GAS','Perdida en inversion ALDESA'),
    ('6110023','GAS','Dominio asesa.co.cr'),
    ('6200000','GAS','LABORATORIO ASESA CAD-CAM'),
    ('6201000','GAS','TALENTO HUMANO'),
    ('6201001','GAS','Salario Ordinario'),
    ('6201002','GAS','Salario Extraordinario'),
    ('6201004','GAS','Cuota Patronal CCSS'),
    ('6201005','GAS','Aguinaldo'),
    ('6201006','GAS','Vacaciones'),
    ('6201007','GAS','Cesantia'),
    ('6205000','GAS','Materiales y Suministros'),
    ('6205001','GAS','Material Laboratorio CAD-CAM'),
    ('6205002','GAS','Papeleria y materiales'),
    ('6206000','GAS','ALQUILERES'),
    ('6206001','GAS','Alquiler equipo médico. Desyfin'),
    ('6207000','GAS','Otros gastos de Operación'),
    ('6207001','GAS','Mantenimiento Equipo Tecnológico'),
    ('6207002','GAS','Gastos Diversos de Laboratorio'),
    ('6208000','GAS','GASTO DE DEPRECIACION'),
    ('6208001','GAS','Dep. Equipo Laboratorio CAD-CAM'),
    ('6208002','GAS','Amortización Licencias de Equipo Tecnológico'),
    ('6209000','GAS','Beneficios a Colaboradores'),
    ('6209003','GAS','Capacitación'),
    ('6300000','GAS','CENTRO RADIOLOGICO ASESA'),
    ('6305000','GAS','Materiales y Suministros'),
    ('6305001','GAS','Material Centro Radiológico Asesa'),
    ('6500000','GAS','GASTOS NO DEDUCIBLES'),
    ('6501000','GAS','OTROS GASTOS NO DEDUCIBLES'),
    ('6501001','GAS','Alquiler de Instalaciones'),
    ('6501002','GAS','Obsequios día de la Madre'),
    ('6501003','GAS','Obsequios día del Padre'),
    ('6501004','GAS','Convivio Navideño'),
    ('6501005','GAS','Servicio Social'),
    ('6501006','GAS','Intereses y Multas Tributación Directa'),
    ('6501007','GAS','Gastos Médicos'),
    ('6501008','GAS','Cumpleaños Colaboradores'),
    ('6501009','GAS','Otros grastos no deducibles'),
    ('8000000','ORD','PRUEBA'),
    ('8100000','ORD','PRUEBA 1'),
    ('8101000','ORD','PRUEBA 2'),
    ('8101001','ORD','PRUEBA 3')


INSERT INTO [dbo].[TipoAsiento] ([id], [nombre])
VALUES
	('111','INV  - (111) - Instrumental C. Radiológico'),
	('112','INV  - (112) -  Material C. Radiológico'),
	('113','INV  - (113) - Material Implantes'),
	('114','INV - (114) - Papelería'),
	('115','INV - (115) - Artículos de Oficina'),
	('116','INV - (116) - Instrumental Odontología General'),
	('117','INV - (117) -  Repuestos Centro Radiológico'),
	('118','INV - (118) -  Instrumental Laboratorio CAD CAM'),
	('119','INV - (119) - Repuestos Laboratorio CAD CAM'),
	('120','INV - (120) - Material de Limpieza'),
	('A01','CON - (C01) - Asiento de diario'),
	('A02','CON - (C02) - Asiento gastos'),
	('A03','CON - (C03) - Asiento de ajuste'),
	('A04','CON - (A04) - Ajustes por dif. cambiario'),
	('A05','CON - (A05) - Ajustes Planillas'),
	('A06','CON - (A06) - Asiento pago especialistas'),
	('A07','CON - (C07) - Asiento de viaticos'),
	('ABC','APERTURA BANCO CREDITOS'),
	('ABD','APERTURA BANCO DEBITOS'),
	('ACC','APERTURA CXC NCM'),
	('ACD','APERTURA CXC NDM'),
	('ACT','ACT - Depreciacion'),
	('APC','APERTURA CXP NCM'),
	('APD','APERTURA CXP NDM'),
	('APE','APERTURA SALDOS INICIALES'),
	('API','APERTURA INVENTARIOS'),
	('C01','CLI - (C01) - Cotización'),
	('C02','CLI - (C02) - Pedido'),
	('C03','CLI - (C03) - Venta'),
	('C04','CLI - (C04) - Nota de crédito x dev'),
	('C05','CLI - (C05) - Nota de crédito x monto'),
	('C06','CLI - (C06) - Nota de débito x monto'),
	('C07','CLI - (C07) - Recibos'),
	('C08','CLI - (C08) - Saldos a favor'),
	('C09','CLI - (C09) - Ajustes de caja'),
	('C10','CLI-C10 Ajuste diferencial cambiario'),
	('C11','CLI - (C11) - Nota de crédito abierta'),
	('C12','CLI - (FAC) Factura'),
	('CDO','Control de documentos'),
	('CIE','CIERRES DE SISTEMA'),
	('CII','CIERRE INVENTARIOS'),
	('CLI','CLI  -  (CL1) - Anulacion venta'),
	('CX1','CXP - CX1) - Gasto acumulado Laboratorios'),
	('CXP','PRV - (CXP) - Registro de cuentas por pagar'),
	('D01','DSP - (D01) - Bitácora'),
	('D02','DSP - (D02) - Despacho Cliente'),
	('F01','FNC - (F01) - Depósito bancario'),
	('F02','FNC - (F02) - Nota de crédito bancaria'),
	('F03','FNC - (F03) - Nota de débito bancaria'),
	('F04','FNC - (F04) - Conciliación bancaria'),
	('F05','FNC - (F05) - Solicitud de pago'),
	('F06','FNC - (F06) - Cheque'),
	('F07','FNC - (F07) - Transferencias'),
	('F08','FNC - (F08) - Lote de medio de pago'),
	('F09','FNC - (F09) - Caja Chica'),
	('F10','FACTURA'),
	('F11','FNC - (F11) - Transferencias 2'),
	('F12','FNC - (F12) - Transferencias 3'),
	('F13','FNC - (FNC) - Transferencia'),
	('I01','INV - (I01) - Actualización de inv'),
	('I02','INV - (I02) - Ajuste positivo'),
	('I03','INV - (I03) - Ajuste negativo'),
	('I04','INV - (I04) - Requisición'),
	('I05','INV - (I05) - Toma física'),
	('I06','INV - (I06) - Traslado de bodega'),
	('I07','INV - (I07) - Entradas de inv'),
	('I08','INV - (I08) - Salidas de inv'),
	('I09','INV - (I09) -  Repuestos Salida de Inventario'),
	('I10','INV - (I10) - Salida a Bodega General'),
	('NCR','CLI -  (NCR) - Nota credito referenciada client'),
	('NDB','FNC - (NDB) - Nota de débito bancaria'),
	('NRP','PRV - (NRP) - Nota Credito Referenciada proveed'),
	('P01','PRV - (P01) - Orden de compra'),
	('P02','PRV - (P02) - Compra'),
	('P03','PRV - (P03) - Importación'),
	('P04','PRV - (P04) - Concolidación de documento'),
	('P05','PRV - (P05) - Nota crédito x monto'),
	('P06','PRV - (P06) - Nota débito x monto'),
	('P07','PRV - (P07) - Nota crédito abierta'),
	('P08','PRV - (P08) - Consolidacion IMP'),
	('P09','PRV -  (P09) - Ajuste Diferencial Cambiario'),
	('P10','PRV - (P10) - Transferencias1'),
	('P11','PRV - (P11) - Servicios Profesionales'),
	('PED','Pedidos'),
	('R01','RHU - (R01) - PLANILLA ADMINISTRATIVA-QUI'),
	('R02','RHU - (R02) - PLANILLA OPERATIVA-QUI'),
	('R03','RHU - (R03) - PLANILLA SEMANAL'),
	('R04','RHU - (R04) - PLANILLA LABORES - SEM'),
	('TFI','INV - (TFI) - Toma Física'),
	('TRA','TRA TRANSFERENCIAS5'),
	('TRB','Traslados de Bodega')


INSERT INTO [dbo].[TipoDocumento] ([id], [nombre])
VALUES
	('111','INV  - (111) - Instrumental C. Radiológico'),
	('112','INV  - (112) -  Material C. Radiológico'),
	('113','INV  - (113) - Material Implantes'),
	('114','INV - (114) - Papelería'),
	('115','INV - (115) - Artículos de Oficina'),
	('116','INV - (116) - Instrumental Odontología General'),
	('117','INV - (117) -  Repuestos Centro Radiológico'),
	('118','INV - (118) -  Instrumental Laboratorio CAD CAM'),
	('119','INV - (119) - Repuestos Laboratorio CAD CAM'),
	('120','INV - (120) - Material de Limpieza'),
	('A01','CON - (C01) - Asiento de diario'),
	('A02','CON - (C02) - Asiento gastos'),
	('A03','CON - (C03) - Asiento de ajuste'),
	('A04','CON - (A04) - Ajustes por dif. cambiario'),
	('A05','CON - (A05) - Ajustes Planillas'),
	('A06','CON - (A06) - Asiento pago especialistas'),
	('A07','CON - (C07) - Asiento de viaticos'),
	('ABC','APERTURA BANCO CREDITOS'),
	('ABD','APERTURA BANCO DEBITOS'),
	('ACC','APERTURA CXC NCM'),
	('ACD','APERTURA CXC NDM'),
	('ACT','ACT - Depreciacion'),
	('APC','APERTURA CXP NCM'),
	('APD','APERTURA CXP NDM'),
	('APE','APERTURA SALDOS INICIALES'),
	('API','APERTURA INVENTARIOS'),
	('C01','CLI - (C01) - Cotización'),
	('C02','CLI - (C02) - Pedido'),
	('C03','CLI - (C03) - Venta'),
	('C04','CLI - (C04) - Nota de crédito x dev'),
	('C05','CLI - (C05) - Nota de crédito x monto'),
	('C06','CLI - (C06) - Nota de débito x monto'),
	('C07','CLI - (C07) - Recibos'),
	('C08','CLI - (C08) - Saldos a favor'),
	('C09','CLI - (C09) - Ajustes de caja'),
	('C10','CLI-C10 Ajuste diferencial cambiario'),
	('C11','CLI - (C11) - Nota de crédito abierta'),
	('C12','CLI - (FAC) Factura'),
	('CDO','Control de documentos'),
	('CIE','CIERRES DE SISTEMA'),
	('CII','CIERRE INVENTARIOS'),
	('CLI','CLI  -  (CL1) - Anulacion venta'),
	('CX1','CXP - CX1) - Gasto acumulado Laboratorios'),
	('CXP','PRV - (CXP) - Registro de cuentas por pagar'),
	('D01','DSP - (D01) - Bitácora'),
	('D02','DSP - (D02) - Despacho Cliente'),
	('F01','FNC - (F01) - Depósito bancario'),
	('F02','FNC - (F02) - Nota de crédito bancaria'),
	('F03','FNC - (F03) - Nota de débito bancaria'),
	('F04','FNC - (F04) - Conciliación bancaria'),
	('F05','FNC - (F05) - Solicitud de pago'),
	('F06','FNC - (F06) - Cheque'),
	('F07','FNC - (F07) - Transferencias'),
	('F08','FNC - (F08) - Lote de medio de pago'),
	('F09','FNC - (F09) - Caja Chica'),
	('F10','FACTURA'),
	('F11','FNC - (F11) - Transferencias 2'),
	('F12','FNC - (F12) - Transferencias 3'),
	('F13','FNC - (FNC) - Transferencia'),
	('I01','INV - (I01) - Actualización de inv'),
	('I02','INV - (I02) - Ajuste positivo'),
	('I03','INV - (I03) - Ajuste negativo'),
	('I04','INV - (I04) - Requisición'),
	('I05','INV - (I05) - Toma física'),
	('I06','INV - (I06) - Traslado de bodega'),
	('I07','INV - (I07) - Entradas de inv'),
	('I08','INV - (I08) - Salidas de inv'),
	('I09','INV - (I09) -  Repuestos Salida de Inventario'),
	('I10','INV - (I10) - Salida a Bodega General'),
	('NCR','CLI -  (NCR) - Nota credito referenciada client'),
	('NDB','FNC - (NDB) - Nota de débito bancaria'),
	('NRP','PRV - (NRP) - Nota Credito Referenciada proveed'),
	('P01','PRV - (P01) - Orden de compra'),
	('P02','PRV - (P02) - Compra'),
	('P03','PRV - (P03) - Importación'),
	('P04','PRV - (P04) - Concolidación de documento'),
	('P05','PRV - (P05) - Nota crédito x monto'),
	('P06','PRV - (P06) - Nota débito x monto'),
	('P07','PRV - (P07) - Nota crédito abierta'),
	('P08','PRV - (P08) - Consolidacion IMP'),
	('P09','PRV -  (P09) - Ajuste Diferencial Cambiario'),
	('P10','PRV - (P10) - Transferencias1'),
	('P11','PRV - (P11) - Servicios Profesionales'),
	('PED','Pedidos'),
	('R01','RHU - (R01) - PLANILLA ADMINISTRATIVA-QUI'),
	('R02','RHU - (R02) - PLANILLA OPERATIVA-QUI'),
	('R03','RHU - (R03) - PLANILLA SEMANAL'),
	('R04','RHU - (R04) - PLANILLA LABORES - SEM'),
	('TFI','INV - (TFI) - Toma Física'),
	('TRA','TRA TRANSFERENCIAS5'),
	('TRB','Traslados de Bodega')











INSERT INTO [dbo].[Tercero] ([tipo], [nit], [nombre], [email], [telefono], [direccion], [observacion], [estado])
VALUES
    ('CLI', '123456789', 'Cliente 1', 'cliente1@example.com', '123-456-7890', 'Calle 1, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('CLI', '987654321', 'Cliente 2', 'cliente2@example.com', '987-654-3210', 'Avenida 2, Ciudad', 'Observación 1', 'ACTIVO'),
    ('PRV', '789456123', 'Proveedor 1', 'proveedor1@example.com', '789-456-1230', 'Carretera 3, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('PRV', '654123789', 'Proveedor 2', 'proveedor2@example.com', '654-123-7890', 'Plaza 4, Ciudad', 'Observación 2', 'ACTIVO'),
    ('OTR', '321456987', 'Otro 1', 'otro1@example.com', '321-456-9870', 'Calle Principal, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('OTR', '456789321', 'Otro 2', 'otro2@example.com', '456-789-3210', 'Avenida Central, Ciudad', 'Observación 3', 'ACTIVO'),
    ('CLI', '987123654', 'Cliente 3', 'cliente3@example.com', '987-123-6540', 'Calle Secundaria, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('CLI', '654789123', 'Cliente 4', 'cliente4@example.com', '654-789-1230', 'Avenida Periférica, Ciudad', 'Observación 4', 'ACTIVO'),
    ('PRV', '321789456', 'Proveedor 3', 'proveedor3@example.com', '321-789-4560', 'Carretera Principal, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('PRV', '456123987', 'Proveedor 4', 'proveedor4@example.com', '456-123-9870', 'Plaza Central, Ciudad', 'Observación 5', 'ACTIVO'),
    ('OTR', '789321654', 'Otro 3', 'otro3@example.com', '789-321-6540', 'Calle Norte, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('OTR', '123987456', 'Otro 4', 'otro4@example.com', '123-987-4560', 'Avenida Sur, Ciudad', 'Observación 6', 'ACTIVO'),
    ('CLI', '321654987', 'Cliente 5', 'cliente5@example.com', '321-654-9870', 'Calle Este, Ciudad', 'Sin observaciones', 'ACTIVO'),
    ('CLI', '456987321', 'Cliente 6', 'cliente6@example.com', '456-987-3210', 'Avenida Oeste, Ciudad', 'Observación 7', 'ACTIVO'),
    ('PRV', '789321654', 'Proveedor 5', 'proveedor5@example.com', '789-321-6540', 'Carretera Este, Ciudad', 'Sin observaciones', 'ACTIVO');


