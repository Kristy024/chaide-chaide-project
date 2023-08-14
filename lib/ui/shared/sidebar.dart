import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/sidemenu_provider.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';

import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';


class Sidebar extends StatelessWidget {
 

  void navigateTo( String routeName ) {
    NavigationService.replaceTo( routeName );
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {

    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
      final user = Provider.of<AuthProvider>(context).user!;
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [

        

          SizedBox( height: 50 ),
            if(user.rol=="ADMIN_ROLE")
          TextSeparator( text: 'Seguridad' ),
            if(user.rol=="ADMIN_ROLE")
           MenuItem( 
            text: 'Usuarios', 
            icon: Icons.people_alt_outlined, 
            onPressed: () => navigateTo( Flurorouter.usersRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
          ),
        
                if(user.rol=="SUPERVISOR_ROLE"|| user.rol == "OPERADOR_ROLE")
           TextSeparator( text: 'Bodega' ),
               if(user.rol == "OPERADOR_ROLE")
             MenuItem(
            text: 'Ingreso de lotes', 
            icon: Icons.content_paste_go_sharp, 
            onPressed: () => navigateTo( Flurorouter.categoriesRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
          ),
            if(user.rol=="SUPERVISOR_ROLE"|| user.rol == "OPERADOR_ROLE")
           MenuItem(
            text: 'Fallos de lotes',
            icon: Icons.bed,
            onPressed: () => navigateTo( Flurorouter.blankRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          ),
               if (user.rol == "ADMIN_ROLE" || user.rol == "SUPERVISOR_ROLE" || user.rol == "OPERADOR_ROLE")
           TextSeparator( text: 'Control de fallos' ),

         if (user.rol == "ADMIN_ROLE" || user.rol == "SUPERVISOR_ROLE" || user.rol == "OPERADOR_ROLE")
          MenuItem(
            text: 'Reportes',
            icon: Icons.format_align_left_sharp,
             onPressed: () => navigateTo( Flurorouter.generarPDFRoute ),
            isActive: sideMenuProvider.currentPage == Flurorouter.generarPDFRoute,
          ),

 
          
        


       

      

          SizedBox( height: 20 ),
  
          MenuItem( 
            text: 'Logout', 
            icon: Icons.exit_to_app_outlined, 
            onPressed: (){
              Provider.of<AuthProvider>(context, listen: false)
                .logout();
            }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.blue,
        Colors.blue.shade700,
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.blue,
        blurRadius: 10
      )
    ]
  );
}