const { Router } = require('express');
const { check } = require('express-validator');

const { validarJWT, validarCampos, esAdminRole } = require('../middlewares');

const { crearImagen,
        obtenerImagenes,
       
        actualizarImagen, 
        borrarImagen } = require('../controllers/imagen');
const { existeImagenPorId,existeColchonPorId } = require('../helpers/db-validators');

const router = Router();

/**
 * {{url}}/api/categorias
 */

//  Obtener todas las categorias - publico
router.get('/', obtenerImagenes );

// Obtener una categoria por id - publico

// Crear categoria - privado - cualquier persona con un token válido
router.post('/', [
    validarJWT,
    check('url', 'La URL es obligatoria').not().isEmpty(),
    check('colchonId', 'El ID del colchón es obligatorio').not().isEmpty(),
    check('colchonId').custom(existeColchonPorId),
    validarCampos
  ], crearImagen);
  
  router.put('/:id', [
    validarJWT,
    check('url', 'La URL es obligatoria').not().isEmpty(),
    check('colchonId', 'El ID del colchón es obligatorio').not().isEmpty(),
    check('colchonId').custom(existeColchonPorId),
    check('id').custom(existeImagenPorId),
    validarCampos
], actualizarImagen);

router.delete('/:id', [
    validarJWT,
    check('id', 'No es un ID de Mongo válido').isMongoId(),
    check('id').custom(existeImagenPorId),
    validarCampos
], borrarImagen);


module.exports = router;