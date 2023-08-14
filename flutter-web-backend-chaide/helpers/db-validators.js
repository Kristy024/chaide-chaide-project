const Role = require('../models/role');
const { Usuario, Categoria, Producto, Lote,Colchones,Imagen } = require('../models');

const esRoleValido = async(rol = 'SUPERVISOR_ROLE') => {

    const existeRol = await Role.findOne({ rol });
    if ( !existeRol ) {
        throw new Error(`El rol ${ rol } no está registrado en la BD`);
    }
}

const emailExiste = async( correo = '' ) => {

    // Verificar si el correo existe
    const existeEmail = await Usuario.findOne({ correo });
    if ( existeEmail ) {
        throw new Error(`El correo: ${ correo }, ya está registrado`);
    }
}

const existeUsuarioPorId = async( id ) => {

    // Verificar si el correo existe
    const existeUsuario = await Usuario.findById(id);
    if ( !existeUsuario ) {
        throw new Error(`El id no existe ${ id }`);
    }
}

/**
 * Categorias
 */
const existeCategoriaPorId = async( id ) => {

    // Verificar si el correo existe
    const existeCategoria = await Categoria.findById(id);
    if ( !existeCategoria ) {
        throw new Error(`El id no existe ${ id }`);
    }
}
const existeLotePorId = async( id ) => {

    // Verificar si el correo existe
    const existeLote = await Lote.findById(id);
    if ( !existeLote ) {
        throw new Error(`El id no existe ${ id }`);
    }
}

/**
 * Productos
 */
const existeProductoPorId = async( id ) => {

    // Verificar si el correo existe
    const existeProducto = await Producto.findById(id);
    if ( !existeProducto ) {
        throw new Error(`El id no existe ${ id }`);
    }
}
const existeColchonPorId = async (id) => {
    // Verificar si el colchón existe
    const existeColchon = await Colchones.findById(id);
    if (!existeColchon) {
      throw new Error(`El colchón con ID ${id} no existe`);
    }
  };
  const existeImagenPorId = async (id) => {
    // Verificar si el colchón existe
    const existeImagen = await Imagen.findById(id);
    if (!existeImagen) {
      throw new Error(`La imagen con ID ${id} no existe`);
    }
  };
  
  
/**
 * Validar colecciones permitidas
 */
const coleccionesPermitidas = ( coleccion = '', colecciones = []) => {

    const incluida = colecciones.includes( coleccion );
    if ( !incluida ) {
        throw new Error(`La colección ${ coleccion } no es permitida, ${ colecciones }`);
    }
    return true;
}


module.exports = {
    esRoleValido,
    emailExiste,
    existeUsuarioPorId,
    existeCategoriaPorId,
    existeLotePorId,
    existeProductoPorId,
    coleccionesPermitidas,
    existeColchonPorId,
    existeImagenPorId
}

