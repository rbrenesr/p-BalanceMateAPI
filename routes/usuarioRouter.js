const express = require('express');
const usuarioRouter = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const {
    validateInputDataNuevoUsuario,
    validateInputDataObtenerUsuarioPorId
} = require('../middlewares/validateInputData');
const { nuevoUsuario, obtenerUsuarioPorId, obtenerUsuarioPorClave } = require("../controllers/usuarioController");


usuarioRouter.use(validarJWT);

usuarioRouter.post('/nuevoUsuario', validateInputDataNuevoUsuario, nuevoUsuario);
usuarioRouter.get('/obtenerUsuarioPorId/:id', validateInputDataObtenerUsuarioPorId, obtenerUsuarioPorId);
usuarioRouter.get('/obtenerUsuarioPorClave/:clave?/:valor?', obtenerUsuarioPorClave);

module.exports = { usuarioRouter };