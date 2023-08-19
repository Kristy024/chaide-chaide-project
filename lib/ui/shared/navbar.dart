import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width <= 700)
            IconButton(
                icon: Icon(Icons.menu_outlined),
                onPressed: () => SideMenuProvider.openMenu()),

          SizedBox(width: 5),

          // Search input
          if (size.width > 390)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: Image.asset(
                'background.png',
                width: 220, // Tamaño de la imagen
                height: 220,
                // Color de la imagen
              ),
            ),

          Spacer(),

          SizedBox(width: 10),
          Logo(),
          SizedBox(width: 10)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 5
        //   )
        // ]
      );
}
