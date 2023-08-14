const { Schema, model } = require('mongoose');
const ImagenSchema = new Schema({
  url: {
    type: String,
    required: true
  },
  estado: {
    type: Boolean,
    default: true,
    required: true
},
  descripcion: {
    type: String,
    default: ''
  },
  colchon: {
    type: Schema.Types.ObjectId,
    ref: 'Colchones'
  }
  
});
ImagenSchema.methods.toJSON = function() {
    const { __v, ...data  } = this.toObject();
    return data;
}
module.exports = model( 'Imagen', ImagenSchema );