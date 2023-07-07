const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');

const autenticar = async (req = request, res = response) => {

  try {

    const { correo, contrasena } = req.body;

    const myquery = `SELECT [id] ` +
      `,[u_correo] ` +
      `,[u_contrasena] ` +
      `,[u_nombre] ` +
      `,[u_estado] ` +
      `FROM [dbo].[Usuario] ` +
      `WHERE u_correo = '${correo}' AND u_contrasena = '${contrasena}'`;
    const pool = await sql.connect(configBD);
    const usuario = await pool.request().query(myquery);
    const { recordsets, recordset } = usuario;

    if (recordset.length != 1) {
      return res.status(401).json({
        ok: false,
        msg: "Unauthorized."
      });
    }

    const _id = recordset[0].id;
    const nombre = recordset[0].u_nombre;
    const token = await generarJWT(_id, nombre);
    const { u_contrasena, ...usuarioReturn } = recordset[0];

    res.status(200).json({
      ok: true,
      usuario: usuarioReturn,
      token
    });

  } catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error.message
    });
  }
}

const renovarToken = async (req = request, res = response) => {

  try {

    const {id, name} = req;
    const myquery = `select 1 from Usuario where id = ${id}`;
    const pool = await sql.connect(configBD);
    const usuario = await pool.request().query(myquery);
    const { recordsets, recordset } = usuario;

    if (recordset.length != 1) {
      return res.status(401).json({
        ok: false,
        msg: "Unauthorized.",        
      });
    }

    const token = await generarJWT(id, name);  

    res.status(200).json({
      ok: true,      
      token
    });

  } catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error.message
    });
  }
}

const obtenerEmpresasUsuario = async (req, res = response) => {

  try {

    const { id } = req;

    const myquery = `SELECT ` +
      ` E.[id] ` +
      `,E.[e_cedula] ` +
      `,E.[e_nombre] ` +
      `,E.[e_direccion] ` +
      `,E.[e_dbname] ` +
      `,E.[e_estado] ` +
      `FROM Empresa E ` +
      `JOIN [UsuarioEmpresa] EU on E.id = EU.e_id ` +
      `JOIN Usuario U on U.id = EU.u_id ` +
      `WHERE U.id = ${id} `;

    const pool = await sql.connect(configBD);
    const empresa = await pool.request().query(myquery);
    const { recordsets, recordset } = empresa;

    if (recordset.length < 1) {
      return res.status(204).json({
        ok: false,
        msg: "No Content."
      });
    }
    
    res.status(200).json({
      ok: true,
      empresas: recordset,
      // token
    });
  }

  catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error.message
    });
  }

};

module.exports = { autenticar, renovarToken, obtenerEmpresasUsuario };