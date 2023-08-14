const { Schema, model } = require('mongoose');

const medidaSchema = Schema({
    medida: {
        type: String,
        required: [true, 'la medida es obligatorio']
    }
});


module.exports = model( 'Medida', medidaSchema );
