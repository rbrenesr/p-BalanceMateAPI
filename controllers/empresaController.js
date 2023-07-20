const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');
const fs = require('fs');




const onNewEmpresa = async (req = request, res = response) => {

  const uid = req.id;
  let { baseDatos, cedula, nombre, correo, telefonoUno, telefonoDos, paginaWeb, direccion, repNombre, repCedula, repTelefono, repCorreo, estado } = req.body;

  baseDatos = baseDatos || '';
  telefonoUno = telefonoUno || '';
  telefonoDos = telefonoDos || '';
  paginaWeb = paginaWeb || '';
  direccion = direccion || '';
  repTelefono = repTelefono || '';
  estado = estado || '1';

  if (await findEmpresaByCedula(cedula)) {
    return res.status(409).json({
      ok: false,
      msg: 'La empresa ya se encuentra registrada.'
    });
  }

  await sql.close();
  const dbConn = new sql.ConnectionPool(configBD);
  await dbConn.connect();

  try {

    const transaction = new sql.Transaction(dbConn);
    await transaction.begin();

    const empresaResult = await new sql.Request(transaction)
      .input('baseDatos', sql.VarChar, baseDatos)
      .input('cedula', sql.VarChar, cedula)
      .input('nombre', sql.VarChar, nombre)
      .input('correo', sql.VarChar, correo)
      .input('telefonoUno', sql.VarChar, telefonoUno)
      .input('telefonoDos', sql.VarChar, telefonoDos)
      .input('paginaWeb', sql.VarChar, paginaWeb)
      .input('direccion', sql.VarChar, direccion)
      .input('repNombre', sql.VarChar, repNombre)
      .input('repCedula', sql.VarChar, repCedula)
      .input('repTelefono', sql.VarChar, repTelefono)
      .input('repCorreo', sql.VarChar, repCorreo)
      .input('estado', sql.VarChar, estado)
      .query('INSERT INTO Empresa ( baseDatos, cedula, nombre, correo, telefonoUno, telefonoDos, paginaWeb, direccion, repNombre, repCedula, repTelefono, repCorreo, estado ) ' +
        'OUTPUT inserted.id VALUES ( @baseDatos, @cedula,@nombre,@correo,@telefonoUno,@telefonoDos,@paginaWeb,@direccion,@repNombre,@repCedula,@repTelefono,@repCorreo,@estado )');

    const recordset = empresaResult.recordset;
    const newId = recordset[0].id;

    /**Insert UsuarioEmpresa */
    const usuarioEmpresaResult = await new sql.Request(transaction)
      .input('usuarioId', sql.Int, uid)
      .input('empresaId', sql.Int, newId)
      .query('INSERT INTO UsuarioEmpresa ( usuarioId, empresaId ) ' +
        'VALUES ( @usuarioId, @empresaId )');

    await transaction.commit();


    const newbaseDatosResult = await dbConn.request()
      .input('id', sql.Int, newId)
      .input('cedula', sql.VarChar, cedula)
      .execute(`SPCrearEmpresa`);
    const newbaseDatos = newbaseDatosResult.recordset[0].nombre;


    const updateEmpresaResult = await dbConn.request()
      .query(`UPDATE dbo.Empresa set baseDatos = '${newbaseDatos}' where id = ${newId}`);


    const newEmp = (await dbConn.request().query(
      `SELECT [id],[baseDatos],[cedula],[nombre],[correo],[telefonoUno],[telefonoDos],[paginaWeb],[direccion],[repNombre],
      [repCedula],[repTelefono],[repCorreo],[estado]
      FROM Empresa WHERE id = ${newId}`
    )).recordset[0];



    //Nuevo contexto
    const configBDNew = { ...configBD, database: newbaseDatos };
    await sql.close();
    const dbConnNew = new sql.ConnectionPool(configBDNew);
    await dbConnNew.connect();

    const sqlBatch = fs.readFileSync("./database/scripts/createDataBase.sql", "utf-8");

    await dbConnNew.request()
      .batch(sqlBatch);


    return res.status(200).json({
      ok: true,
      msg: 'Empresa ingresada correctamente',
      newbaseDatos,
      newEmp
    });

  } catch (error) {

    console.log(error.message);
    await transaction.rollback();
    res.status(500).json({
      ok: false,
      msg: 'Error al procesar nuevo ingreso.',
      msgSystem: error.originalError.info.message
    });

  }
  finally {
    await dbConn.close();
  }

};

const onGetEmpresa = async (req = request, res = response) => {

  try {

    let clave = req.params.clave;
    let valor = req.params.valor;
    let where = '';

    if (!valor) valor = '';
    if (!clave) clave = 'nombre';

    const cols = ['id', 'cedula', 'nombre', 'direccion', 'baseDatos', 'estado'];
    if (!cols.includes(clave)) {
      return res.status(422).json({
        ok: false,
        msg: 'Es requerido una clave de búsqueda válida.',
      });
    }

    if (clave === 'id') {
      if (valor == '') {
        return res.status(422).json({
          ok: false,
          msg: 'El código de id es requerido.',
        });
      }
      where = `WHERE ${clave} = ${valor}`;
    }
    else
      where = `WHERE ${clave} like '%${valor}%'`;


    const myquery = `SELECT [id],[baseDatos],[cedula],[nombre],[correo],[telefonoUno],[telefonoDos],[paginaWeb],
                        [direccion],[repNombre],[repCedula],[repTelefono],[repCorreo],[estado]
                      FROM [dbo].[Empresa] ${where}`;

    await sql.close();
    const pool = await sql.connect(configBD);
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
      empresa: recordset,
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

const onUpdateEmpresa = async (req = request, res = response) => {

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


    const myquery = `SELECT [id],[baseDatos],[cedula],[nombre],[correo],[telefonoUno],[telefonoDos],[paginaWeb],
                        [direccion],[repNombre],[repCedula],[repTelefono],[repCorreo],[estado]
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


const findEmpresaByCedula = async (cedula) => {
  const query = `SELECT 1 FROM Empresa WHERE cedula = '${cedula}'`;
  await sql.close();
  const pool = await sql.connect(configBD);
  const result = await pool.request().query(query);
  const { recordset } = result;

  if (recordset.length === 1)
    return true;
  else
    return false;
}

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

module.exports = { onNewEmpresa, onGetEmpresa, onUpdateEmpresa };