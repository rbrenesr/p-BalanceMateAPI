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

    /**
     * Forma I de trabajar los valores de entrada
     * 
     
        var cols = ['correo', 'contrasena', 'nombre', 'direccion', 'telefono', 'estado'];
        var vals = [correo, contrasena, nombre, direccion, telefono, estado];
    
        const pool = await sql.connect(configBD);
        const request = pool.request();
    
        for (let i = 0; i < vals.length; i++)
          request.input(`param_${i}`, vals[i]);  //if you skip the parametertype, mssql will guess it from the value
    
         const sqlquery = `insert into Usuario(${cols}) values (  ${  vals.map(  (_,i) => `@param_${i}`)  }    )`;
         const result = await request.query(sqlquery);
     */

    /**
     * Forma II de trabajar los valores de entrada
     * 
     
        const pool = await sql.connect(configBD);
        const resul = await pool.request()
          .input('u_correo', sql.VarChar, correo)
          .input('u_contrasena', sql.VarChar, contrasena)
          .input('u_nombre', sql.VarChar, nombre)
          .input('u_direccion', sql.VarChar, direccion)
          .input('u_telefono', sql.Char, telefono)
          .input('u_estado', sql.TinyInt, estado)
          .query('INSERT INTO Usuario ( u_correo, u_contrasena, u_nombre, u_direccion, u_telefono, u_estado ) ' +
            'VALUES ( @u_correo, @u_contrasena, @u_nombre, @u_direccion, @u_telefono, @u_estado )');
    */

    /**
     * Forma III de trabajar los valores de entrada
     * 
     */
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



    const myquery =
      `SELECT id ` +
      `,correo ` +
      `,nombre ` +
      `,direccion ` +
      `,telefono ` +
      `,estado ` +
      `FROM Usuario ` +
      `WHERE id = ${newId}`;


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

// const obtenerUsuarioPorId = async (req = request, res = response) => {

//   try {

//     const id = req.params.id;
//     const uid = req.id;

//     //TODO
//     //* Validar que el usuario que realiza la solicitud tenga acceso al recurso

//     const myquery =
//       `SELECT id ` +
//       `,correo ` +
//       `,nombre` +
//       `,direccion ` +
//       `,telefono ` +
//       `,estado ` +
//       `FROM Usuario ` +
//       `WHERE id = ${id}`;

//     const pool = await sql.connect(configBD);
//     const result = await pool.request().query(myquery);
//     const recordset = result.recordset;


//     if (recordset.length < 1) {
//       return res.status(200).json({
//         ok: false,
//         msg: `No existe usuarios con el id = ${id}`,
//         usuario: recordset[0],
//       });
//     }


//     return res.status(200).json({
//       ok: true,
//       msg: `Usuario seleccionado= ${id}`,
//       usuario: recordset[0],
//     });

//   } catch (error) {
//     console.log(error.message);
//     res.status(500).json({
//       ok: false,
//       msg: 'Error al procesar la selección del usuario.',
//       msgSystem: error.originalError.info.message
//     });
//   }


// }

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

    /**
        if (!clave) { clave = 'u_nombre'; }
        else {
    
          const claveMapping = {
            'nombre': 'u_nombre',
            'correo': 'u_correo',
            'telefono': 'u_telefono',
            'direccion': 'u_direccion',
          };
    
          if (claveMapping.hasOwnProperty(clave)) {
            clave = claveMapping[clave];
          }
    
        }
     *
     */

    const uid = req.id;
    //TODO
    //* Validar que el usuario que realiza la solicitud tenga acceso al recurso

    const myquery =
      `SELECT id ` +
      `,correo ` +
      `,nombre ` +
      `,direccion ` +
      `,telefono ` +
      `,estado ` +
      `FROM Usuario ` +
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
      msg: 'Error al procesar la selección del usuario.',
      msgSystem: error.originalError.info.message
    });
  }
}

const actualizarUsuario = () => { }
const eliminarUsuario = () => { }

const existeElUsuario = async (correo) => {
  const myquery = `SELECT 1 FROM Usuario WHERE correo = '${correo}'`;
  const pool = await sql.connect(configBD);
  const result = await pool.request().query(myquery);
  const { recordset } = result;

  if (recordset.length === 1)
    return true;
  else
    return false;
}

module.exports = { nuevoUsuario, obtenerUsuario, actualizarUsuario, eliminarUsuario };