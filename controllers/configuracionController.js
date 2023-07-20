const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');
const fs = require('fs');





const onGetConfiguracion = async (req = request, res = response) => {

  try {

    const db = req.db;
    const configBDNew = { ...configBD, database: db };

    const myquery = `SELECT [id], [valor]
                      FROM [dbo].[Configuracion]`;

    await sql.close();
    const pool = await sql.connect(configBDNew);
    const result = await pool.request().query(myquery);
    const recordset = result.recordset;

    if (recordset.length < 1) {
      return res.status(200).json({
        ok: false,
        msg: `No existe datos para la búsqueda proporcionada por = ${valor} en ${clave}`,
        usuario: recordset[0],
      });
    }

    return res.status(200).json({
      ok: true,
      msg: `Empresas seleccionadas`,
      configuracion: recordset,
    });

  } catch (error) {
    console.log(error.message);
    res.status(500).json({
      ok: false,
      msg: 'Error al procesar la selección del datos.',
      msgSystem: error.originalError.info.message
    });
  }
}

const onUpdateConfiguracion = async (req = request, res = response) => {


  return res.status(200).json({
    ok: true,
    msg: `onUpdateConfiguracion`    
  });

  const id = req.params.id;
  let { nombre, correo, telefonoUno, telefonoDos, paginaWeb, direccion, repNombre, repCedula, repTelefono, repCorreo } = req.body;

  telefonoUno = telefonoUno || '';
  telefonoDos = telefonoDos || '';
  paginaWeb = paginaWeb || '';
  direccion = direccion || '';
  repTelefono = repTelefono || '';

  if (!id) {
    return res.status(400).json({
      ok: false,
      msg: `EL id es requerido.`
    });
  }

  if (!await findEmpresaById(id)) {
    return res.status(404).json({
      ok: false,
      msg: `No se encuentran datos con el id ${id}`
    });
  }

  // sql connection
  await sql.close();
  const dbConn = new sql.ConnectionPool(configBD);
  await dbConn.connect();
  let transaction;

  try {

    transaction = new sql.Transaction(dbConn);
    await transaction.begin();
    const request = new sql.Request(transaction);

    request
      .input('pnombre', sql.VarChar, nombre)
      .input('pcorreo', sql.VarChar, correo)
      .input('ptelefonoUno', sql.VarChar, telefonoUno)
      .input('ptelefonoDos', sql.VarChar, telefonoDos)
      .input('ppaginaWeb', sql.VarChar, paginaWeb)
      .input('pdireccion', sql.VarChar, direccion)
      .input('prepNombre', sql.VarChar, repNombre)
      .input('prepCedula', sql.VarChar, repCedula)
      .input('prepTelefono', sql.VarChar, repTelefono)
      .input('prepCorreo', sql.VarChar, repCorreo)

    const result = await request
      .query(`UPDATE [dbo].[Empresa]
            SET [nombre] = @pnombre
              ,[correo] = @pcorreo
              ,[telefonoUno] = @ptelefonoUno
              ,[telefonoDos] = @ptelefonoDos
              ,[paginaWeb] = @ppaginaWeb
              ,[direccion] = @pdireccion
              ,[repNombre] = @prepNombre
              ,[repCedula] = @prepCedula
              ,[repTelefono] = @prepTelefono
              ,[repCorreo] =    @prepCorreo   
          WHERE id = ${id}`);


    if (result.rowsAffected != 1) {
      return res.status(400).json({
        ok: false,
        msg: `Se actualizaron registros en la base de datos para ${id}.`,
        empresa: newEmp,
      });
    }


    const myquery = `SELECT [id]
            ,[baseDatos]
            ,[cedula]
            ,[nombre]
            ,[correo]
            ,[telefonoUno]
            ,[telefonoDos]
            ,[paginaWeb]
            ,[direccion]
            ,[repNombre]
            ,[repCedula]
            ,[repTelefono]
            ,[repCorreo]
            ,[estado]
          FROM [dbo].[Empresa]
          WHERE id = ${id}`;


    const empUpdated = (await request.query(myquery)).recordset[0];

    await transaction.commit();

    return res.status(200).json({
      ok: true,
      msg: 'Empresa actualizada correctamente.',
      empUpdated: empUpdated,
    });

  } catch (error) {
    await transaction.rollback();
    console.log(error.message);
    res.status(500).json({
      ok: false,
      msg: 'Error al procesar actualización de empresa.',
      msgSystem: error.originalError.info.message
    });

  } finally {
    await dbConn.close();
  }
};


const findEmpresaById = async (id) => {
  const myquery = `SELECT 1 FROM Empresa WHERE id = '${id}'`;
  await sql.close();
  const pool = await sql.connect(configBD);
  const result = await pool.request().query(myquery);
  const { recordset } = result;

  if (recordset.length === 1)
    return true;
  else
    return false;
}

module.exports = { onGetConfiguracion, onUpdateConfiguracion };