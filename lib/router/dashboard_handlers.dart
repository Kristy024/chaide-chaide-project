import 'package:admin_dashboard/ui/views/colchon_view.dart';
import 'package:admin_dashboard/ui/views/no_page_found_view.dart';
import 'package:admin_dashboard/ui/views/sendEmail_view.dart';
import 'package:admin_dashboard/ui/views/user_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';


import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';

import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';


class DashboardHandlers {

  static Handler dashboard = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.dashboardRoute );

      // if ( authProvider.authStatus == AuthStatus.authenticated )
      //   return DashboardView();
      // else 
      //   return LoginView();




      if ( authProvider.authStatus == AuthStatus.notAuthenticated ) {
        return LoginView();
      }
      
      if ( authProvider.user?.rol == 'SUPERVISOR_ROLE' ) {
        return BlankView();
      }

      if ( authProvider.user?.rol == 'ADMIN_ROLE' ) {
        return UsersView();
      }

      if ( authProvider.user?.rol == 'OPERADOR_ROLE' ) {
        return LotesView();
      }
      
      return NoPageFoundView();

        
    }
  );


  static Handler icons = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.iconsRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return IconsView();
      else 
        return LoginView();
    }
  );
    static Handler generarpdf = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.generarPDFRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return SendEmailView();
      else 
        return LoginView();
    }
  );


  static Handler blank = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.blankRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return BlankView();
      else 
        return LoginView();
    }
  );


  static Handler categories = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.categoriesRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return LotesView();
      else 
        return LoginView();
    }
  );

  // users
  static Handler users = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.usersRoute );

      if ( authProvider.authStatus != AuthStatus.authenticated && authProvider.user?.rol == 'ADMIN_ROLE' ) {
        return LoginView();
      }

      if ( authProvider.user?.rol == 'ADMIN_ROLE' ) {
        return UsersView();
      }

      return NoPageFoundView();
        
        
    }
  );

  // user
  static Handler user = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.userRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ){
        print( params );
        if ( params['uid']?.first != null ) {
            return UserView(uid: params['uid']!.first );
        } else {
          return UsersView();
        }


      } else {
        return LoginView();
      }
    }
  );
    static Handler colchon = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( Flurorouter.colchonRoute );

      if ( authProvider.authStatus == AuthStatus.authenticated ){
        print( params );
        if ( params['uid']?.first != null ) {
            return ColchonView(uid: params['uid']!.first );
        } else {
          return BlankView();
        }


      } else {
        return LoginView();
      }
    }
  );

}

