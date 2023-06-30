
const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');

const login = async (req = request, res = response) => {

  try {

    const { email, password } = req.body;


    console.log({ email, password });
    const token = await generarJWT('123456789', 'rafael brenes');
    res.status(200).json({
      ok: true,
      email,
      name: "",
      token
    });

/*
    //todo
    //*Verificar que el usuario exista en la base de datos
    const usuario = 'null';

    if (!usuario) {
      return res.status(400).json({
        ok: false,
        msg: "Error de autenticación.!"
      });
    }

    //todo
    //*verificar contraseña asociada al mail
    const isValid = 'null';
    if (!isValid) {
      return res.status(400).json({
        ok: false,
        msg: "Error de autenticación.!"
      });
    }

    //todo
    //* Generar el token JWT
    //const token = await generarJWT(usuario.id, usuario.name);
    const token = await generarJWT('123456789', 'rafael brenes');

    res.status(200).json({
      ok: true,
      email,
      name: "",
      token
    });

*/




  } catch (error) {
    console.log('Error de ejecución:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "View log system."
    });
  }
}

const newUser = async (req = request, res = response) => {
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

const renewToken = async (req, res = response) => {

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


const getEmpresas = async (req, res = response) => {


  try {

    const pool = await sql.connect(configBD);
    const empresas = await pool.request().query('select * from swe.SWTEMP_EMPRESA');
    const { recordsets } = empresas;

    res.status(200).json({
      ok: true,
      empresas: recordsets
    });

    /*
        sql.connect(configBD, (err) => {
    
          if (err) {
            console.log('ssss: ' + err);
          }
          const sqlreq = new sql.Request();
          sqlreq.query(
    
    
            'select * from swe.SWTEMP_EMPRESA'
    
            , (err, recordset) => {
              if (err) {
                console.log('saaasqqll: ' + err);
              }
              console.log(recordset);
              res.send(recordset);
    
            })
    
        });*/

  } catch (error) {
    console.log('Error de ejecución:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "View log system."
    });
  }


};

module.exports = { login, newUser, renewToken, getEmpresas };