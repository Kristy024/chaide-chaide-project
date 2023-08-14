const { Schema, model } = require('mongoose');

const LoteSchema = Schema({
    nombre: {
        type: String,
        required: [true, 'El nombre es obligatorio'],
      
    }, 
    codigo: {
        type: String,
        required: [true, 'El codigo es obligatorio'],
        unique: true
    },
    fechaIngreso: {
        type: Date,
        default: () => {
            // Obtener la fecha actual
            const currentDate = new Date();
            // Restar 5 horas (300 minutos)
            currentDate.setMinutes(currentDate.getMinutes() - 300);
            return currentDate;
        }
    },
    modelo: {
        type: String,
        required: [true, 'El modelo es obligatorio'],
    
    },
    stock: {
        type: Number,
        required: [true, 'El stock es obligatorio'],
    },
    estadoRevision: {
        type: Boolean,
        default: false,
        required: true
    },
    estado: {
        type: Boolean,
        default: true,
        required: true
    },
    usuario: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    }
});


LoteSchema.methods.toJSON = function() {
    const { __v, ...data  } = this.toObject();
    return data;
}


module.exports = model( 'Lote', LoteSchema );
