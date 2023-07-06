require('dotenv').config();

const configBD = {
    user: 'sa',
    password: 'Sfd2220175',
    server: 'ANDROMEDA\\SQL01',         
    database: '00B_CONTROL' ,
    options: {
        encrypt: true, // for azure
        trustServerCertificate: true // change to true for local dev / self-signed certs
      }
};

module.exports={ configBD }