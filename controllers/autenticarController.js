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

const nuevoUsuario = async (req = request, res = response) => {
  const { name, email, password } = req.body;

  try {



    const pool = await sql.connect(configBD);
    const resul = await pool.request()
      .input('u_name', sql.VarChar, name)
      .input('u_email', sql.VarChar, email)
      .input('u_password', sql.VarChar, password)
      .query('INSERT INTO [dbo].[users]( [u_name] ,[u_email], [u_password] ) VALUES ( @u_name, @u_email, @u_password )');


    res.status(200).json({
      ok: true,
      msg: 'user successfully entered'
    });

  } catch (error) {
    res.status(401).json({
      ok: false,
      msg: 'Error al procesar el ingreso del nuevo usuario.',
      msgSystem: error.originalError.info.message
    });
  }

}

const renovarToken = async (req, res = response) => {

  const { uid, name } = req;

  // //*Validar si el user uid ya existe en la base de datos??
  // const usuario = await Usuario.findOne({ _id:uid });

  // if (!usuario) {
  //   return res.status(400).json({
  //     ok: false,
  //     msg: "UID usuario no registrado"
  //   });
  // }

  // //* Generar el token JWT
  //const token = await generarJWT(usuario.id, usuario.name);
  const token = await generarJWT(uid, name);


  return res.status(200).json({
    ok: true,
    token
  });
};

const obtenerEmpresas = async (req, res = response) => {




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
    const usuario = await pool.request().query(myquery);
    const { recordsets, recordset } = usuario;



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

  // const _id = recordset[0].id;
  // const nombre = recordset[0].u_nombre;
  // const token = await generarJWT(_id, nombre);
  // const { u_contrasena, ...usuarioReturn } = recordset[0];



  catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error.message
    });
  }

  // try {

  //   const pool = await sql.connect(configBD);
  //   const empresas = await pool.request().query('select * from swe.SWTEMP_EMPRESA');
  //   const { recordsets } = empresas;

  //   res.status(200).json({
  //     ok: true,
  //     empresas: recordsets
  //   });

  //   /*
  //       sql.connect(configBD, (err) => {

  //         if (err) {
  //           console.log('ssss: ' + err);
  //         }
  //         const sqlreq = new sql.Request();
  //         sqlreq.query(


  //           'select * from swe.SWTEMP_EMPRESA'

  //           , (err, recordset) => {
  //             if (err) {
  //               console.log('saaasqqll: ' + err);
  //             }
  //             console.log(recordset);
  //             res.send(recordset);

  //           })

  //       });*/

  // } catch (error) {
  //   console.log('Error de ejecución:  ' + error);
  //   res.status(500).json({
  //     ok: false,
  //     msg: "View log system."
  //   });
  // }


};

module.exports = { autenticar, nuevoUsuario, renovarToken, obtenerEmpresas };