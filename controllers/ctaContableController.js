const { configBD } = require('../database/config');
const { generarJWT } = require('../helpers/jwt');
const { response, request } = require("express");
const bcryptjs = require('bcryptjs');
const sql = require('mssql');
const fs = require('fs');


const onGetCtaContable =(req, res = response)=>{
    return res.status(200).json({
        ok:true,
        msg:'onGetCtaContable'
    });
}
const onNewCtaContable =(req, res = response)=>{
    return res.status(200).json({
        ok:true,
        msg:'onNewCtaContable'
    });
}
const onUpdateCtaContable =(req, res = response)=>{
    return res.status(200).json({
        ok:true,
        msg:'onUpdateCtaContable'
    });
}
const onDeleteCtaContable =(req, res = response)=>{
    return res.status(200).json({
        ok:true,
        msg:'onDeleteCtaContable'
    });
}


module.exports = { onGetCtaContable, onNewCtaContable, onUpdateCtaContable, onDeleteCtaContable,};