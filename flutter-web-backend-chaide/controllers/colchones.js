const { response } = require('express');
const { Colchones } = require('../models');



const obtenerColchones = async (req, res = response) => {
  const query = { estado: true };

  const colchones = await Colchones.find(query)
    .populate('usuario', 'nombre')
    .populate('lote', 'codigo modelo');

  const total = colchones.length;

  res.json({
    total,
    colchones,
  });
};
const obtenerColchon = async (req, res = response) => {

  const { id } = req.params;
  const colchones = await Colchones.findById(id)
    .populate('usuario', 'nombre')
    .populate('lote', 'codigo modelo');

  res.json(colchones);

}

const crearColchon = async (req, res = response) => {
  const { estado, usuario, ...body } = req.body;

  const colchonDB = await Colchones.findOne({ codigo: body.codigo });

  if (colchonDB) {
    return res.status(400).json({
      msg: `El colchón ${colchonDB.codigo} ya existe`,
    });
  }

  // Calcular el total de booleanos verdaderos
  const booleanFields = Object.values(body);
  const booleanosVerdaderos = booleanFields.filter(Boolean);
  const intTotal = booleanosVerdaderos.length;

  // Generar la data a guardar
  const data = {
    ...body,
    codigo: body.codigo,
    usuario: req.usuario._id,
    intTotal: intTotal,
  };

  const colchon = new Colchones(data);

  // Guardar en la base de datos
  const nuevoColchon = await colchon.save();

  await nuevoColchon
    .populate('usuario', 'nombre')
    .populate('lote', 'codigo modelo')
    .execPopulate();

  res.status(201).json(nuevoColchon);
};

const actualizarColchon = async (req, res = response) => {
  const { id } = req.params;
  const { estado, usuario, ...data } = req.body;

  data.usuario = req.usuario._id;

  const colchon = await Colchones.findByIdAndUpdate(id, data, { new: true });

  // Obtener los campos booleanos que se deben contar
  const booleanFields = Object.values(data).filter(
    (value) => typeof value === 'boolean'
  );

  // Calcular el total de booleanos verdaderos
  const intTotal = booleanFields.filter(Boolean).length;

  // Asignar el valor de intTotal al colchon actualizado
  colchon.intTotal = intTotal;

  await colchon.populate('usuario', 'nombre').populate('lote', 'codigo modelo').execPopulate();

  res.json(colchon);
};


const borrarColchon = async (req, res = response) => {
  const { id } = req.params;
  const colchonBorrado = await Colchones.findByIdAndUpdate(
    id,
    { estado: false },
    { new: true }
  );

  res.json(colchonBorrado);
};





module.exports = {
  crearColchon,
  obtenerColchones,
  obtenerColchon,
  actualizarColchon,
  borrarColchon
}