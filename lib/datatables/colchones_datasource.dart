import 'package:admin_dashboard/models/colchones.dart';
import 'package:admin_dashboard/providers/colchones_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lotes.dart';
import '../services/navigation_service.dart';

class ColchonesDTS extends DataTableSource {
  final BuildContext context;
  final List<Colchones> colchones;

  ColchonesDTS(this.context, this.colchones);

  @override
  DataRow getRow(int index) {
    final colchon = this.colchones[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Tooltip(
          message: colchon.codigo,
          child: Text(
            "${colchon.codigo.length > 20 ? colchon.codigo.substring(0, 20) + '...' : colchon.codigo}",
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        ),
      ),
      DataCell(
        Tooltip(
          message: colchon.lote.codigo,
          child: Text(
            "${colchon.lote.codigo.length > 20 ? colchon.lote.codigo.substring(0, 20) + '...' : colchon.lote.codigo}",
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        ),
      ),
      DataCell(Text(colchon.intTotal.toString())),
      DataCell(
        Tooltip(
          message: colchon.observacion,
          child: Text(
            "${colchon.observacion.length > 20 ? colchon.observacion.substring(0, 20) + '...' : colchon.observacion}",
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        ),
      ),
      DataCell(Text(colchon.usuario.nombre)),
      DataCell(Row(
        children: [
          IconButton(
              icon: Icon(Icons.remove_red_eye_rounded),
              onPressed: () {
                NavigationService.replaceTo(
                    '/dashboard/colchones/${colchon.id}');
              }),
          IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)),
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('¿Está seguro de borrarlo?'),
                  content: Text(
                      '¿Borrar definitivamente C. colchon ${colchon.codigo}?'),
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
                        await Provider.of<ColchonesProvider>(context,
                                listen: false)
                            .deleteColchon(colchon.id);

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );

                showDialog(context: context, builder: (_) => dialog);
              }),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => colchones.length;

  @override
  int get selectedRowCount => 0;
}
