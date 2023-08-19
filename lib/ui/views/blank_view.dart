import 'package:admin_dashboard/datatables/colchones_datasource.dart';
import 'package:admin_dashboard/providers/colchones_provider.dart';
import 'package:admin_dashboard/ui/modals/colchones_modal.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../buttons/custom_icon_button.dart';
import '../inputs/custom_inputs.dart';

class BlankView extends StatefulWidget {
  @override
  State<BlankView> createState() => _BlankViewState();
}

class _BlankViewState extends State<BlankView> {
  String filtro = "";
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  void initState() {
    super.initState();

    Provider.of<ColchonesProvider>(context, listen: false).getColchones();
  }

  @override
  Widget build(BuildContext context) {
    final colchones = Provider.of<ColchonesProvider>(context).colchones;
    final provider = Provider.of<ColchonesProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 10),
          TextFormField(
            initialValue: filtro,
            onChanged: (value) async {
              filtro = value;
              await provider.getColchonesFiltro(filtro);
            },
            keyboardType: TextInputType.text,

            decoration: CustomInputs.loginInputDecoration(
                hint: 'Buscar por código',
                label: 'Buscar por código',
                icon: Icons.numbers),
            style: TextStyle(color: Colors.black),
            maxLength: 10, // Set maximum input length to 7 characters
          ),
          PaginatedDataTable(
            columns: [
              DataColumn(label: Text('Código')),
              DataColumn(label: Text('C. lote')),
              DataColumn(label: Text('T. Falla')),
              DataColumn(label: Text('Observación')),
              DataColumn(label: Text('Ingresado por')),
              DataColumn(label: Text('Acciones')),
            ],
            source: ColchonesDTS(context, colchones),
            header: Text(
              'Colchones Ingresados',
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onRowsPerPageChanged: (value) {
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
                      isScrollControlled:
                          true, // hacer que ocupe toda la pantalla
                      builder: (context) {
                        return Align(
                            alignment: Alignment.bottomCenter,
                            child: ColchonModal(colchon: null));
                      });
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
