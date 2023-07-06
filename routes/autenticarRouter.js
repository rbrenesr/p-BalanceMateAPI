const express = require('express');
const autenticarRouter = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const { validateInputDataLogin, validateInputDataNewUser } = require('../middlewares/validateInputData');
const { autenticar, nuevoUsuario, renovarToken, obtenerEmpresas } = require("../controllers/autenticarController");


autenticarRouter.use(validarJWT);

autenticarRouter.post('/',validateInputDataLogin, autenticar);
autenticarRouter.post('/nuevoUsuario', validateInputDataNewUser, nuevoUsuario);
autenticarRouter.get('/renvarToken', validarJWT, renovarToken);
autenticarRouter.get('/obtenerEmpresas', obtenerEmpresas);

module.exports = { autenticarRouter };