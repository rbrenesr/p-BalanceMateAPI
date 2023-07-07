const express = require('express');
const usuarioRouter = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const { validateInputDataNuevoUsuario } = require('../middlewares/validateInputData');
const { nuevoUsuario } = require("../controllers/usuarioController");


usuarioRouter.use(validarJWT);
// usuarioRouter.post('/nuevoUsuario', validateInputDataNewUser, nuevoUsuario);
 usuarioRouter.post('/nuevoUsuario', validateInputDataNuevoUsuario , nuevoUsuario);

module.exports = { usuarioRouter };