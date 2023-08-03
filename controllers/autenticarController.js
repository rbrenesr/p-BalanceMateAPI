const { response, request } = require("express");
const { configBD } = require('../database/config');
const DatabaseManager = require('../database/DatabaseManager');
const { generarJWT } = require('../helpers/jwt');

const autenticar = async (req = request, res = response) => {

  const dbManager = new DatabaseManager(configBD);
  await dbManager.connect();

  try {

    const { correo, contrasena } = req.body;

    const usuario = await dbManager.executeQuery(
      `SELECT id ,correo ,contrasena ,nombre ,estado 
      FROM [dbo].[Usuario] 
      WHERE correo = '${correo}' AND contrasena = '${contrasena}'`
    );

    if (usuario.length != 1) {
      return res.status(401).json({
        ok: false,
        msg: "Unauthorized."
      });
    }

    const _id = usuario[0].id;
    const _correo = usuario[0].correo;
    const _nombre = usuario[0].nombre;
    const _db = configBD.database;
    
    
    const token = await generarJWT(_id, _db);
    

    res.status(200).json({
      ok: true,
      usuario: {id:_id, correo:_correo, nombre:_nombre, db:_db },
      token
    });

  } catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error
    });
  } finally {
    await dbManager.disconnect();
  }
}

const renovarToken = async (req = request, res = response) => {

  const dbManager = new DatabaseManager(configBD);
  await dbManager.connect();

  try {

    const { id, name, db } = req;    
    const dbNew = req.params.id;
    let dbToSend = (dbNew) ? dbNew : db;

    const usuario = await dbManager.executeQuery(`SELECT 1 FROM Usuario WHERE id = ${id}`);
    
    if (usuario.length != 1) {
      return res.status(401).json({
        ok: false,
        msg: "Unauthorized.",
      });
    }

    const token = await generarJWT(id, name, dbToSend);

    res.status(200).json({
      ok: true,
      usuario:{ id, name, db},
      token
    });

  } catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error
    });
  }finally{
    await dbManager.disconnect();
  }
}

const obtenerEmpresasUsuario = async (req, res = response) => {

  const { id } = req; 
  const dbManager = new DatabaseManager(configBD);
  await dbManager.connect();

  try {

    const empresa = await dbManager.executeQuery(
      `SELECT E.id ,E.cedula ,E.nombre ,E.direccion ,E.baseDatos ,E.estado 
      FROM Empresa E 
      JOIN UsuarioEmpresa EU on E.id = EU.empresaId 
      JOIN Usuario U on U.id = EU.usuarioId 
      WHERE U.id = ${id} `      
    );
    
    if (empresa.length < 1) {
      return res.status(204).json({
        ok: false,
        msg: "No Content."
      });
    }

    res.status(200).json({
      ok: true,
      empresas: empresa,
    });
  }

  catch (error) {
    console.log('500 Internal Server Error:  ' + error);
    res.status(500).json({
      ok: false,
      msg: "Internal Server Error.",
      description: error
    });
  }
  finally{
    await dbManager.disconnect();
  }

};

module.exports = { autenticar, renovarToken, obtenerEmpresasUsuario };