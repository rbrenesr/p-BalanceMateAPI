const express = require('express');
const cors = require('cors');
require('dotenv').config(); //*Variables de entorno

const { auth } = require('./routes/auth');
const { settings } = require('./routes/settings');


const app = express();
app.use(cors());
app.use(express.static('public'));
app.use(express.json());

app.use('/api/auth', auth);
app.use('/api/settings', settings);
// app.use('/api/company', company);
// app.use('/api/accounts', accounts);
// app.use('/api/journalEntriesTypes', journalEntriesTypes);
// app.use('/api/documentsTypes', documentsTypes);
// app.use('/api/journalEntries', journalEntries);
// app.use('/api/suppliers', suppliers);
// app.use('/api/customers', customers);
// app.use('/api/periodClosing', periodClosing);

app.listen(process.env.PORT, () => {
    console.log(`Server running in port ${process.env.PORT}`);
});