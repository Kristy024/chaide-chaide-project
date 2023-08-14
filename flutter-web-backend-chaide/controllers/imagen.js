const { response } = require('express');
const { Imagen } = require('../models');




const obtenerImagenes = async (req, res = response) => {
    const query = { estado: true };
  
    const [total, imagenes] = await Promise.all([
      Imagen.countDocuments(query),
      Imagen.find(query)
        .populate('colchon', 'codigo')
    ]);
  
    res.json({
      total,
      imagenes
    });
  };

const crearImagen = async (req, res = response) => {
    const { url, descripcion, colchonId } = req.body;
  
    const imagen = new Imagen({
      url,
      descripcion,
      colchon: colchonId
    });
  
    // Guardar en la base de datos
    await imagen.save();
    await imagen.populate('colchon', 'codigo').execPopulate();
    res.status(201).json(imagen);
  };
  
  const actualizarImagen = async (req, res = response) => {
    const { id } = req.params;
    const { url, descripcion, colchonId, ...data } = req.body;

    data.colchon = colchonId;

    const imagen = await Imagen.findByIdAndUpdate(id, { url, descripcion, ...data }, { new: true });
    await imagen.populate('colchon', 'codigo').execPopulate();

    res.json(imagen);
};


const borrarImagen = async (req, res = response) => {
  const { id } = req.params;
  const imagenBorrada = await Imagen.findByIdAndUpdate(id, { estado: false }, { new: true });

  res.json(imagenBorrada);
};




module.exports = {
    crearImagen,
    obtenerImagenes,
    actualizarImagen,
    borrarImagen
}