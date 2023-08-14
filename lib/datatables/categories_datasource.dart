import 'package:admin_dashboard/ui/modals/lotes_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';



import '../models/lotes.dart';




class LotesDTS extends DataTableSource {

  final List<Lotes> lotes;
  final BuildContext context;
  

  LotesDTS( this.context, this.lotes);


  @override
  DataRow getRow(int index) {

    
    final lote = this.lotes[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Icon(lote.estadoRevision ? Icons.check : Icons.cancel), ),
        DataCell( Text( lote.modelo ) ),
          DataCell( Text( lote.codigo ) ),
            DataCell( Text( "${lote.stock}" ) ),
             DataCell( Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(lote.fechaIngreso.toString()))),),
        DataCell( Text( lote.usuario.nombre ) ),
        DataCell( 
          Row(
            children: [
              IconButton(
                icon: Icon( Icons.edit_outlined ),
                onPressed: () {
                  if(lote.estadoRevision==true){
                    
                  final dialog = AlertDialog(
                    title: Text('Lote revisado'),
                    content: Text('El lote ya ha sido revisado.'),
                    actions: [
                      TextButton(
                        child: Text('Aceptar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          
                        },
                      ),
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog 
                  );
                  return;
                  }
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true, // hacer que ocupe toda la pantalla
                      builder: (context) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: LoteModal( lotes: lote )
                        );
                      }
                    );
                }
              ),
              IconButton(
                icon: Icon( Icons.delete_outline, color: Colors.red.withOpacity(0.8)),
                onPressed: () {
                  final dialog = AlertDialog(
                    title: Text('¿Está seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente ${ lote.modelo }?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Si, borrar'),
                        onPressed: () async {
                          await Provider.of<CategoriesProvider>(context, listen: false)
                            .deleteLote(lote.id);

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog 
                  );


                }
              ),
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => lotes.length;

  @override

  int get selectedRowCount => 0;

}