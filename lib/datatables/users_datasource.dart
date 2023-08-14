import 'package:flutter/material.dart';

import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/models/usuario.dart';
import 'package:provider/provider.dart';

import '../providers/users_provider.dart';

class UsersDataSource extends DataTableSource {

  final List<Usuario> users;
  final BuildContext context;
  UsersDataSource(this.users, this.context);


  @override
  DataRow getRow(int index) {
    
    final Usuario user = users[index];

    final image = ( user.img == null )  
      ? Image(image: AssetImage('no-image.jpg'), width: 35, height: 35, )
      : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!, width: 35, height: 35, );

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( user.rol ) ),
        DataCell( Text( user.nombre ) ),
        DataCell( Text( user.correo ) ),
        DataCell( Text( user.uid ) ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon( Icons.edit_outlined ), 
                onPressed: () {
                  NavigationService.replaceTo('/dashboard/users/${ user.uid }');
                }
              ),
              IconButton(
            icon: Icon( Icons.delete ), 
            onPressed: ()async {
              await Provider.of<UsersProvider>(context,listen: false).deleteUser(user.uid);
              
            }
          )
            ],
          )
        ),
      ]
    );
  }

  @override
  
  bool get isRowCountApproximate => false;

  @override
  
  int get rowCount => this.users.length;

  @override
  
  int get selectedRowCount => 0;


}