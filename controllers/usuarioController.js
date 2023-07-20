const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');


const nuevoUsuario = async (req = request, res = response) => {

  let { correo, contrasena, nombre, direccion, telefono, estado } = req.body;

  if (!direccion) direccion = '';
  if (!telefono) telefono = '';
  if (!estado) estado = 1;

  try {

    if (await existeElUsuario(correo)) {
      return res.status(409).json({
        ok: false,
        msg: 'La cuenta ya se encuentra registrada.'
      });
    }

    await sql.close();
    const pool = await sql.connect(configBD);
    let result = await pool.request()
      .input('p1', sql.VarChar, correo)
      .input('p2', sql.VarChar, contrasena)
      .input('p3', sql.VarChar, nombre)
      .input('p4', sql.VarChar, direccion)
      .input('p5', sql.VarChar, telefono)
      .input('p6', sql.TinyInt, estado)
      .query('INSERT INTO Usuario ( correo, contrasena, nombre, direccion, telefono, estado ) ' +
        'OUTPUT inserted.id VALUES ( @p1, @p2, @p3, @p4, @p5, @p6 )');


    let recordset = result.recordset;
    const newId = recordset[0].id;

    const myquery =`SELECT id ,correo ,nombre ,direccion ,telefono ,estado FROM Usuario 
                    WHERE id = ${newId}`;

    result = await pool.request().query(myquery);
    recordset = result.recordset;

    const _id = recordset[0].id;
    const _nombre = recordset[0].nombre;
    const token = await generarJWT(_id, _nombre);

    return res.status(200).json({
      ok: true,
      msg: 'Usuario ingresado correctamente',
      usuario: recordset[0],
      token
    });

  } catch (error) {
    console.log(error.message);
    res.status(500).json({
      ok: false,
      msg: 'Error al procesar el ingreso del nuevo usuario.',
      msgSystem: error.originalError.info.message
    });
  }

}

const obtenerUsuario = async (req = request, res = response) => {

  try {

    let clave = req.params.clave;
    let valor = req.params.valor;
    let where = '';

    if (!valor) valor = '';
    if (!clave) clave = 'nombre';

    const cols = ['id', 'correo', 'contrasena', 'nombre', 'direccion', 'telefono', 'estado'];
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

   
    const myquery =`SELECT id ,correo ,nombre ,direccion ,telefono ,estado 
                    FROM Usuario ${where}`;
                    
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
      msg: `Usuario seleccionado`,
      usuario: recordset,
    });

  } catch (error) {
    console.log(error.message);
    res.status(500).json({
      ok: false,
      msg: 'Error al procesar la selección del usuario.',
      msgSystem: error.originalError.info.message
    });
  }
}

const actualizarUsuario = () => { }
const eliminarUsuario = () => { }

const existeElUsuario = async (correo) => {
  const myquery = `SELECT 1 FROM Usuario WHERE correo = '${correo}'`;
  await sql.close();
  const pool = await sql.connect(configBD);
  const result = await pool.request().query(myquery);
  const { recordset } = result;

  if (recordset.length === 1)
    return true;
  else
    return false;
}

module.exports = { nuevoUsuario, obtenerUsuario };