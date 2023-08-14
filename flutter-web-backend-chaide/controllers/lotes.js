const { response } = require('express');
const { Lote } = require('../models');


const obtenerLotes = async(req, res = response ) => {

     //const { limite = 5, desde = 0 } = req.query;
    const query = { estado: true };

    const [ total, lotes ] = await Promise.all([
        Lote.countDocuments(query),
        Lote.find(query)
            .populate('usuario', 'nombre')
             //.skip( Number( desde ) )
             //.limit(Number( limite ))
    ]);

    res.json({
        total,
        lotes
    });
}

const obtenerLote = async(req, res = response ) => {

    const { id } = req.params;
    const lote = await Lote.findById( id )
                            .populate('usuario', 'nombre');

    res.json( lote );

}
const obtenerLotesPorNombre = async (req, res = response) => {
    const { nombre } = req.params;
  
    try {
      const lotes = await Lote.find({ nombre: nombre }).populate('usuario', 'nombre');
      res.json(lotes);
    } catch (error) {
      console.log(error);
      res.status(500).json({
        msg: 'Ocurrió un error al buscar los lotes por nombre'
      });
    }
  }

const crearLote = async(req, res = response ) => {

    const { nombre,codigo,modelo,stock } = req.body;

    const lotesDB = await Lote.findOne({ codigo });

    if ( lotesDB ) {
        return res.status(400).json({
            msg: `el lote con codigo ${ lotesDB.codigo }, ya existe`
        });
    }

    // Generar la data a guardar
    const data = {
        nombre,
        codigo,
        modelo,
        stock,
        usuario: req.usuario._id
    }

    const lote = new Lote( data );

    // Guardar DB
    await lote.save();

    await lote
    .populate('usuario', 'nombre')
    .execPopulate();

    res.status(201).json(lote);

}

const actualizarLote = async( req, res = response ) => {

    const { id } = req.params;
    const { estado, usuario, ...data } = req.body;

    data.usuario = req.usuario._id;

    const lote = await Lote.findByIdAndUpdate(id, data, { new: true });

    res.json( lote );

}

const borrarLote = async(req, res =response ) => {

    const { id } = req.params;
    const lotesBorrada = await Lote.findByIdAndUpdate( id, { estado: false }, {new: true });

    res.json( lotesBorrada );
}




module.exports = {
    crearLote,
    obtenerLotes,
    obtenerLote,
    actualizarLote,
    borrarLote,
    obtenerLotesPorNombre
}