const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');

const autenticar = async (req = request, res = response) => {

  try {

    const { correo, contrasena } = req.body;

    const myquery = `SELECT id ,correo ,contrasena ,nombre ,estado 
                      FROM [dbo].[Usuario] 
                      WHERE correo = '${correo}' AND contrasena = '${contrasena}'`;

    await sql.close();
    const pool = await sql.connect(configBD);
    const usuario = await pool.request().query(myquery);
    const { recordset } = usuario;

    if (recordset.length != 1) {
      return res.status(401).json({
        ok: false,
        msg: "Unauthorized."
      });
    }

    const _id = recordset[0].id;
    const _nombre = recordset[0].u_nombre;
    const token = await generarJWT(_id, _nombre, configBD.database);
    const { contrasena: contrasenaUsuario, ...usuarioReturn } = recordset[0];

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

    const { id, name } = req;
    const db = req.params.id;

    const myquery = `SELECT 1 FROM Usuario WHERE id = ${id}`;

    await sql.close();
    const pool = await sql.connect(configBD);
    const usuario = await pool.request().query(myquery);
    const { recordset } = usuario;

    if (recordset.length != 1) {
      return res.status(401).json({
        ok: false,
        msg: "Unauthorized.",
      });
    }

    const token = await generarJWT(id, name, db);

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

    const myquery = `SELECT E.id ,E.cedula ,E.nombre ,E.direccion ,E.baseDatos ,E.estado 
                      FROM Empresa E 
                      JOIN UsuarioEmpresa EU on E.id = EU.empresaId 
                      JOIN Usuario U on U.id = EU.usuarioId 
                      WHERE U.id = ${id} `;
      
    await sql.close();
    const pool = await sql.connect(configBD);
    const empresa = await pool.request().query(myquery);
    const { recordset } = empresa;

    if (recordset.length < 1) {
      return res.status(204).json({
        ok: false,
        msg: "No Content."
      });
    }

    res.status(200).json({
      ok: true,
      empresas: recordset,
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