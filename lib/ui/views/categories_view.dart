import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/datatables/categories_datasource.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';

import '../inputs/custom_inputs.dart';
import '../modals/lotes_modal.dart';


class LotesView extends StatefulWidget {

  @override
  _LotesViewState createState() => _LotesViewState();
}

class _LotesViewState extends State<LotesView> {
  String filtro="";
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

   
     Provider.of<CategoriesProvider>(context, listen: false).getLotes();

  }


  @override
  Widget build(BuildContext context) {

    
    final lotes = Provider.of<CategoriesProvider>(context).lotes;
    final provider= Provider.of<CategoriesProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
           TextFormField(
            initialValue: filtro,
            onChanged: (value) async {
              filtro=value;
             await provider.getLotesFiltro(filtro);
            },
            keyboardType: TextInputType.text,
    
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Buscar por código', 
              label: 'Buscar por código', 
              icon: Icons.numbers
            ),
            style: TextStyle(color: Colors.black),
            maxLength: 10, // Set maximum input length to 7 characters
          ),

          SizedBox(height: 10,),
          PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Modelo')),
                 DataColumn(label: Text('Codigo')),
                 DataColumn(label: Text('Stock')),
                 DataColumn(label: Text('Fecha I.')),
                DataColumn(label: Text('Ingresado por')),
                DataColumn(label: Text('Acciones')),
              ], 
              source: LotesDTS( context,lotes ),
              header: Text('Lotes Ingresados', maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold), ),
              onRowsPerPageChanged: ( value ) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true, // hacer que ocupe toda la pantalla
                      builder: (context) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: LoteModal( lotes: null )
                        );
                      }
                    );
                  },

                  text: 'Crear', 
                  icon: Icons.add_outlined,
                )
              ],
            )

        ],
      ),
    );
  }
}