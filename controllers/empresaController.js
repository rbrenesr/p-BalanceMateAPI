const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');



const nuevoEmpresa = async (req = request, res = response) => {

  const uid = req.id;
  let { cedula, nombre, direccion, baseDatos, estado } = req.body;
  if (!direccion) direccion = '';
  if (!estado) estado = 1;

  if (await existeEmpresa(cedula)) {
    return res.status(409).json({
      ok: false,
      msg: 'La empresa ya se encuentra registrada.'
    });
  }

  // sql connection
  const dbConn = new sql.ConnectionPool(configBD);
  await dbConn.connect();
  let transaction;

  try {

    transaction = new sql.Transaction(dbConn);
    await transaction.begin();
    const request = new sql.Request(transaction);

    const newId = await insertarEmpresa(request, { cedula, nombre, direccion, baseDatos, estado });
    const rowsAffected = await insertarUsuarioEmpresa(request, uid, newId); //* Retrona 1

    const myquery =
      `SELECT ` +
          `id ,cedula ,nombre ,direccion ,baseDatos ,estado ` +
      `FROM Empresa ` +
      `WHERE id = ${newId}`;
    const newEmp = (await request.query(myquery)).recordset[0];

    await transaction.commit();

    return res.status(200).json({
      ok: true,
      msg: 'Empresa ingresada correctamente.',
      empresa: newEmp,
    });

  } catch (error) {
    await transaction.rollback();
    console.log(error.message);
    res.status(500).json({
      ok: false,
      msg: 'Error al procesar nuevo ingreso.',
      msgSystem: error.originalError.info.message
    });

  } finally {
    await dbConn.close();
  }
};

const obtenerEmpresa = async (req = request, res = response) => {

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




    const uid = req.id;
    //TODO
    //* Validar que el usuario que realiza la solicitud tenga acceso al recurso

    const myquery =
      `SELECT id ` +
      `,cedula ` +
      `,nombre ` +
      `,direccion ` +
      `,baseDatos ` +
      `,estado ` +
      `FROM Empresa ` +
      `${where}`;

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
      msg: `Usuario seleccionado`,
      usuario: recordset,
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

const actualizarEmpresa = () => { }

const eliminarEmpresa = () => { }




const existeEmpresa = async (cedula) => {
  const myquery = `SELECT 1 FROM Empresa WHERE cedula = '${cedula}'`;
  const pool = await sql.connect(configBD);
  const result = await pool.request().query(myquery);
  const { recordset } = result;

  if (recordset.length === 1)
    return true;
  else
    return false;
}

const insertarEmpresa = async (request, emp) => {
  try {
    request
      .input('p1', sql.VarChar, emp.cedula)
      .input('p2', sql.VarChar, emp.nombre)
      .input('p3', sql.VarChar, emp.direccion)
      .input('p4', sql.VarChar, emp.baseDatos)
      .input('p5', sql.TinyInt, emp.estado);

    const result = await request
      .query('INSERT INTO Empresa ( cedula, nombre, direccion, baseDatos, estado ) ' +
        'OUTPUT inserted.id VALUES ( @p1, @p2, @p3, @p4, @p5 )');

    const recordset = result.recordset;
    return recordset[0].id;
  } catch (error) {
    console.log(`Error insertarEmpresa= ${error.message}`);
    throw (error);
  }

}

const insertarUsuarioEmpresa = async (request, usuarioId, empresaId) => {
  try {
    request
      .input('p50', sql.Int, usuarioId)
      .input('p51', sql.Int, empresaId);

    const result = await request
      .query('INSERT INTO UsuarioEmpresa ( usuarioId, empresaId ) ' +
        'VALUES ( @p50, @p51 )');

    return result.rowsAffected[0];
  } catch (error) {
    console.log(`Error insertarUsuarioEmpresa= ${error.message}`);
    throw (error);
  }

}

module.exports = { nuevoEmpresa, obtenerEmpresa, actualizarEmpresa, eliminarEmpresa };