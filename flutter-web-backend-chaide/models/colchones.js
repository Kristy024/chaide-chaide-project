const { Schema, model } = require('mongoose');

const ColchonesSchema = Schema({
    codigo: {
        type: String,
        required: [true, 'El codigo es obligatorio'],
        unique: true
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
    },
    fechaIngreso: {
        type: Date,
        default: Date.now
    },
    lote: {
        type: Schema.Types.ObjectId,
        ref: 'Lote',
        required: true
    },
    bordeTapaOndulado: {
        type: Boolean,
        default: false,
        required: true
    },
    esquinaColSobresalida: {
        type: Boolean,
        default: false,
        required: true
    },
    esquinaTapaMalformada: {
        type: Boolean,
        default: false,
        required: true
    },
    hiloSueltoReata: {
        type: Boolean,
        default: false,
        required: true
    },
    hiloSueltoRemate: {
        type: Boolean,
        default: false,
        required: true
    },
    hiloSueltoAlcochado: {
        type: Boolean,
        default: false,
        required: true
    },
    hiloSueltoInterior: {
        type: Boolean,
        default: false,
        required: true
    },
    puntaSaltadaReata: {
        type: Boolean,
        default: false,
        required: true
    },
    reataRasgadaEnganchada: {
        type: Boolean,
        default: false,
        required: true
    },
    tipoRemateInadecuado: {
        type: Boolean,
        default: false,
        required: true
    },
    telaEspumaSalidaReata: {
        type: Boolean,
        default: false,
        required: true
    },
    tapaDescuadrada: {
        type: Boolean,
        default: false,
        required: true
    },
    telaRasgada: {
        type: Boolean,
        default: false,
        required: true
    },
    ninguno: {
        type: Boolean,
        default: false,
        required: true
    },
    otros: {
        type: Boolean,
        default: false,
        required: true
    },
    texto_otro: {
        type: String,
        default: '',
    },
    intTotal: {
        type: Number,
        default: 0
    },
    medidas: {
        type: String,
        required: true
    },
    presenciaHiloSuelto: {
        type: Boolean,
        default: false
    },
    planAccion: {
        type: String,
        default: ''
    },
    observacion: {
        type: String,
        default: ''
    },
    img: {
        type: [String],
        default: []
    }



});


ColchonesSchema.methods.toJSON = function () {
    const { __v, ...data } = this.toObject();
    return data;
}

ColchonesSchema.pre('save', function (next) {
    // Obtener los campos booleanos que se deben contar
    const booleanFields = [
        this.bordeTapaOndulado,
        this.esquinaColSobresalida,
        this.esquinaTapaMalformada,
        this.hiloSueltoReata,
        this.hiloSueltoRemate,
        this.hiloSueltoAlcochado,
        this.hiloSueltoInterior,
        this.puntaSaltadaReata,
        this.reataRasgadaEnganchada,
        this.tipoRemateInadecuado,
        this.telaEspumaSalidaReata,
        this.tapaDescuadrada,
        this.telaRasgada,
        this.ninguno,
        this.otros,
        this.presenciaHiloSuelto
    ];

    // Calcular el total de booleanos verdaderos
    const booleanosVerdaderos = booleanFields.filter(Boolean);
    this.intTotal = booleanosVerdaderos.length;

    next();
});
module.exports = model('Colchones', ColchonesSchema);
