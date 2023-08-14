import 'package:admin_dashboard/providers/colchones_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/api/CafeApi.dart';

import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';

import 'package:admin_dashboard/router/router.dart';


import 'package:admin_dashboard/providers/providers.dart';


import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
 
void main() async {

  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  
  Flurorouter.configureRoutes();
  runApp(AppState());
}
 
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: ( _ ) => AuthProvider() ),
        ChangeNotifierProvider(lazy: false, create: ( _ ) => SideMenuProvider() ),
        ChangeNotifierProvider(create: ( _ ) => CategoriesProvider() ),
        ChangeNotifierProvider(create: ( _ ) => UsersProvider() ),
        ChangeNotifierProvider(create: ( _ ) => UserFormProvider() ),
        ChangeNotifierProvider(create: ( _ ) => ColchonesProvider() ),

      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chaide Chaide',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: ( _ , child ){
        
        final authProvider = Provider.of<AuthProvider>(context);

        if ( authProvider.authStatus == AuthStatus.checking )
          return SplashLayout();

        if( authProvider.authStatus == AuthStatus.authenticated ) {
          return DashboardLayout( child: child! );
        } else {
          return AuthLayout( child: child! );
        }
              

      },
          theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
        ),
        cardTheme: CardTheme(
          
          // Aquí puedes personalizar el CardTheme según tus preferencias
          surfaceTintColor: Colors.black,
          clipBehavior: Clip.antiAlias,
        
          color: Colors.white, // Cambiar el color de fondo del Card
          elevation: 10,
           // Cambiar la elevación del Card
        ),
        dialogTheme: DialogTheme(
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Bordes redondeados para el AlertDialog
          ),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Estilo del texto del título
          contentTextStyle: TextStyle(fontSize: 16, color: Colors.black), // Estilo del texto del contenido
          backgroundColor: Colors.grey.shade100, // Color de fondo del AlertDialog
          elevation: 40, // Elevación del AlertDialog
          // Más configuraciones según tus preferencias...
        ),
  

        dataTableTheme: DataTableThemeData(
          decoration: BoxDecoration(
      // Color de fondo amarillo para toda la tabla
      border:  Border(
      top: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
      left: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
      right: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
      bottom: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    ),
            //headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade400), // Color amarillo para el encabezado
    //dataRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow), // Color amarillo para las celdas de datos
    headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Estilo de texto en el encabezado
    dataTextStyle: TextStyle(color: Colors.black), // Estilo de texto en las celdas de datos
    horizontalMargin: 16, // Margen horizontal de 16
    columnSpacing: 8, // Espacio entre columnas de 8
            dividerThickness: 6,
           // headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade400), // 
        )
      ),
      
    );
  }
}