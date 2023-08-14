const { Router } = require('express');
const { check } = require('express-validator');

const { validarJWT, validarCampos, esAdminRole } = require('../middlewares');

const { crearColchon,
        obtenerColchones,
        obtenerColchon,
        actualizarColchon, 
        borrarColchon } = require('../controllers/colchones');

const {  existeLotePorId,existeColchonPorId } = require('../helpers/db-validators');

const router = Router();

/**
 * {{url}}/api/categorias
 */

//  Obtener todas las categorias - publico
router.get('/', obtenerColchones );

// Obtener una categoria por id - publico
router.get('/:id',[
    check('id', 'No es un id de Mongo válido').isMongoId(),
    check('id').custom( existeColchonPorId ),
    validarCampos,
], obtenerColchon );


// Crear categoria - privado - cualquier persona con un token válido
router.post('/', [ 
    validarJWT,
    check('codigo','El codigo es obligatorio').not().isEmpty(),
    check('lote','No es un id de Mongo').isMongoId(),
    check('lote').custom( existeLotePorId ),
    validarCampos
], crearColchon );

// Actualizar - privado - cualquiera con token válido
router.put('/:id', [
    validarJWT,
    // check('categoria','No es un id de Mongo').isMongoId(),
    check('id').custom(existeColchonPorId),
    validarCampos
], actualizarColchon);

// Borrar una categoria - Admin
router.delete('/:id', [
    validarJWT,

    check('id', 'No es un ID de Mongo válido').isMongoId(),
    check('id').custom(existeColchonPorId),
    validarCampos
  ], borrarColchon);
  

module.exports = router;