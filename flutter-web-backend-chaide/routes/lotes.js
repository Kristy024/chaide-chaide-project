const { Router } = require('express');
const { check } = require('express-validator');

const { validarJWT, validarCampos } = require('../middlewares');

const { crearLote,obtenerLotes, obtenerLote,actualizarLote,borrarLote} = require('../controllers/lotes');

const {existeLotePorId } = require('../helpers/db-validators');

const router = Router();

/**
 * {{url}}/api/categorias
 */

//  Obtener todas las categorias - publico
router.get('/', obtenerLotes );

// Obtener una categoria por id - publico
router.get('/:id',[
    check('id', 'No es un id de Mongo válido').isMongoId(),
    check('id').custom( existeLotePorId ),
    validarCampos,
], obtenerLote );

// Crear categoria - privado - cualquier persona con un token válido
router.post('/', [ 
    validarJWT,
    check('nombre','El nombre es obligatorio').not().isEmpty(),
    check('codigo','El codigo es obligatorio').not().isEmpty(),
    check('modelo','El modelo es obligatorio').not().isEmpty(),
    check('stock','El stock es obligatorio').not().isEmpty(),
    validarCampos
], crearLote );

// Actualizar - privado - cualquiera con token válido
router.put('/:id',[
    validarJWT,
    check('nombre','El nombre es obligatorio').not().isEmpty(),
    check('codigo','El codigo es obligatorio').not().isEmpty(),
    check('modelo','El modelo es obligatorio').not().isEmpty(),
    check('stock','El stock es obligatorio').not().isEmpty(),
    check('id').custom( existeLotePorId ),
    validarCampos
],actualizarLote );

// Borrar una categoria - Admin
router.delete('/:id',[
    validarJWT,
    check('id', 'No es un id de Mongo válido').isMongoId(),
    check('id').custom( existeLotePorId ),
    validarCampos,
],borrarLote);



module.exports = router;