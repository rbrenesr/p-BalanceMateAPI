SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Configuracion](
	[clave] [varchar](50) NOT NULL,
	[valor] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Configuracion] PRIMARY KEY CLUSTERED 
(
	[clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Configuracion] ADD  CONSTRAINT [DF_Configuracion_valor]  DEFAULT ('') FOR [valor]

INSERT INTO [dbo].[Configuracion]
SELECT 'CtaActivoCirculante', '' UNION ALL
SELECT 'CtaActivoTotal', '' UNION ALL
SELECT 'CtaCapital', '' UNION ALL
SELECT 'CtaCostoVentas', '' UNION ALL
SELECT 'CtaInventario', '' UNION ALL
SELECT 'CtaPasivoLargoPlazo', '' UNION ALL
SELECT 'CtaPasivoTotal', '' UNION ALL
SELECT 'CtaUtilPerdida', '' UNION ALL
SELECT 'CtaUtilPerdidaAcumulada', '' UNION ALL
SELECT 'PerFecFin', '' UNION ALL
SELECT 'PerFecInactividad', '' UNION ALL
SELECT 'PerFecIni', ''


SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Catalogo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cuenta] [varchar](50) NOT NULL,
	[tipo] [varchar](3) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Catalogo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Catalogo] ADD  CONSTRAINT [DF_Catalogo_cuenta]  DEFAULT ('') FOR [cuenta]
ALTER TABLE [dbo].[Catalogo] ADD  CONSTRAINT [DF_Catalogo_tipo]  DEFAULT ('ACT') FOR [tipo]
ALTER TABLE [dbo].[Catalogo] ADD  CONSTRAINT [DF_Catalogo_descripcion]  DEFAULT ('') FOR [descripcion]
ALTER TABLE [dbo].[Catalogo]  WITH CHECK ADD CHECK  (([tipo]='ORD' OR [tipo]='GAS' OR [tipo]='COT' OR [tipo]='ING' OR [tipo]='PAT' OR [tipo]='PAS' OR [tipo]='ACT'))


INSERT INTO [dbo].[Catalogo] ([cuenta], [tipo], [descripcion])
VALUES
  ('Cuenta1', 'ORD', 'Descripción 1'),
  ('Cuenta2', 'GAS', 'Descripción 2'),
  ('Cuenta3', 'COT', 'Descripción 3'),
  ('Cuenta4', 'ING', 'Descripción 4'),
  ('Cuenta5', 'PAT', 'Descripción 5'),
  ('Cuenta6', 'PAS', 'Descripción 6'),
  ('Cuenta7', 'ACT', 'Descripción 7'),
  ('Cuenta8', 'ORD', 'Descripción 8'),
  ('Cuenta9', 'GAS', 'Descripción 9'),
  ('Cuenta10', 'COT', 'Descripción 10'),
  ('Cuenta11', 'ING', 'Descripción 11'),
  ('Cuenta12', 'PAT', 'Descripción 12'),
  ('Cuenta13', 'PAS', 'Descripción 13'),
  ('Cuenta14', 'ACT', 'Descripción 14'),
  ('Cuenta15', 'ORD', 'Descripción 15');




SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TipoAsiento](
	[TAS_ChrCodigo] [varchar](10) NOT NULL,
	[TAS_ChrNombre] [varchar](250) NOT NULL,
 CONSTRAINT [PK_TipoAsiento] PRIMARY KEY CLUSTERED 
(
	[TAS_ChrCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[TipoAsiento] ADD  CONSTRAINT [DF_TipoAsiento_TAS_ChrNombre]  DEFAULT ('') FOR [TAS_ChrNombre]

SET QUOTED_IDENTIFIER ON

-- Insertar los registros utilizando una sentencia INSERT INTO con valores múltiples
INSERT INTO [dbo].[TipoAsiento] ([TAS_ChrCodigo], [TAS_ChrNombre])
VALUES
    ('Codigo1', 'Nombre1'),
    ('Codigo2', 'Nombre2'),
    ('Codigo3', 'Nombre3'),
    ('Codigo4', 'Nombre4'),
    ('Codigo5', 'Nombre5'),
    ('Codigo6', 'Nombre6'),
    ('Codigo7', 'Nombre7'),
    ('Codigo8', 'Nombre8'),
    ('Codigo9', 'Nombre9'),
    ('Codigo10', 'Nombre10'),
    ('Codigo11', 'Nombre11'),
    ('Codigo12', 'Nombre12'),
    ('Codigo13', 'Nombre13'),
    ('Codigo14', 'Nombre14'),
    ('Codigo15', 'Nombre15');



SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TipoDocumento](
	[TDC_ChrCodigo] [varchar](10) NOT NULL,
	[TDC_ChrNombre] [varchar](250) NOT NULL,
 CONSTRAINT [PK_TipoDocumento] PRIMARY KEY CLUSTERED 
(
	[TDC_ChrCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[TipoDocumento] ADD  CONSTRAINT [DF_TipoDocumento_TDC_ChrNombre]  DEFAULT ('') FOR [TDC_ChrNombre]

SET QUOTED_IDENTIFIER ON

-- Insertar los registros utilizando una sentencia INSERT INTO con valores múltiples
INSERT INTO [dbo].[TipoDocumento] ([TDC_ChrCodigo], [TDC_ChrNombre])
VALUES
    ('Codigo1', 'Nombre1'),
    ('Codigo2', 'Nombre2'),
    ('Codigo3', 'Nombre3'),
    ('Codigo4', 'Nombre4'),
    ('Codigo5', 'Nombre5'),
    ('Codigo6', 'Nombre6'),
    ('Codigo7', 'Nombre7'),
    ('Codigo8', 'Nombre8'),
    ('Codigo9', 'Nombre9'),
    ('Codigo10', 'Nombre10'),
    ('Codigo11', 'Nombre11'),
    ('Codigo12', 'Nombre12'),
    ('Codigo13', 'Nombre13'),
    ('Codigo14', 'Nombre14'),
    ('Codigo15', 'Nombre15');





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



