import 'package:admin_dashboard/models/lotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';


class LoteModal extends StatefulWidget {

  final Lotes? lotes;

  const LoteModal({
    Key? key, 
    this.lotes
  }) : super(key: key);

  @override
  _LoteModalState createState() => _LoteModalState();
}

class _LoteModalState extends State<LoteModal> {

  String nombre = '';
  String? id;
  bool estadoR=false;
  String codigo= '';
  String modelo = '';
  int stock = 1;
  bool _isChecked = false;
  @override
  void initState() {
    super.initState();

    id     = widget.lotes?.id;
    nombre = widget.lotes?.nombre ?? '';
    estadoR = widget.lotes?.estadoRevision??false;
    codigo = widget.lotes?.codigo??'';
    modelo = widget.lotes?.modelo??'';
    stock = widget.lotes?.stock??1;
    _isChecked = widget.lotes?.estado ?? false;

  }


  @override
  Widget build(BuildContext context) {

    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
    
    return Container(
      padding: EdgeInsets.all(20),
      height: 700,
      width: 400, // expanded
      decoration: buildBoxDecoration(),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( widget.lotes?.nombre ?? 'Nuevo Lote', style: CustomLabels.h1.copyWith( color: Color.fromRGBO(0, 83, 157, 1) )),
              IconButton(
                icon: Icon( Icons.close, color: Color.fromRGBO(0, 83, 157, 1), ), 
                onPressed: () => Navigator.of(context).pop()
              )
            ],
          ),

          Divider( color: Colors.white.withOpacity(0.3 )),

          SizedBox(height: 20 ),

          TextFormField(
            initialValue: widget.lotes?.nombre ?? '',
            onChanged: ( value ) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre', 
              // label: 'Nombre', 
              icon: Icons.new_releases_outlined
            ),
            style: TextStyle( color: Colors.black ),
          ),

          SizedBox(height: 20 ),
          
          TextFormField(
            initialValue: widget.lotes?.codigo ?? '',
            onChanged: ( value ) => codigo = value,
             inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'\d+')),
            ],
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Código', 
              label: 'Código', 
              icon: Icons.copy_rounded
            ),
             maxLength: 10,
            style: TextStyle( color: Colors.black ),
          ),
          
          SizedBox(height: 20 ),
          
           TextFormField(
            initialValue: widget.lotes?.modelo ?? '',
            onChanged: ( value ) => modelo = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Modelo', 
              label: 'Modelo', 
              icon: Icons.bed
            ),
            style: TextStyle( color: Colors.black ),
          ),

          SizedBox(height: 20 ),

          TextFormField(
            initialValue: widget.lotes?.stock.toString() ?? '',
            onChanged: (value) => stock = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'\d+')),
            ],
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Stock', 
              label: 'Stock', 
              icon: Icons.numbers
            ),
            style: TextStyle(color: Colors.black),
            maxLength: 7, // Set maximum input length to 7 characters
          ),


          if (widget.lotes != null)
            CheckboxListTile(
              title: Text('Revisado'),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
          
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async{
                
                try {
                  if( id == null ) {
                    // Crear
                    await categoryProvider.newLote(nombre,codigo,modelo,_isChecked,stock);
                    NotificationsService.showSnackbar('creado!');

                  } else {
                    // Actualizar
                    await categoryProvider.updateLotes( id!, nombre,codigo,modelo,_isChecked,stock );
                    NotificationsService.showSnackbar('Actualizado!');

                    if(_isChecked==true)
                    NotificationsService.showSnackbar('Se ha marcado como revisado el lote');
                  }

                  Navigator.of(context).pop();

                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError('No se pudo guardar el lote');
                }
                
          
                

              },
              text: 'Guardar',
              color: Colors.black,
            ),
          )

        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.only( topLeft:  Radius.circular(20), topRight: Radius.circular(20) ),
    // color: Color(0xff0F2041),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}



