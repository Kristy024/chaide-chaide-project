import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/no_page_found_view.dart';
import 'package:admin_dashboard/ui/views/users_view.dart';
import 'package:fluro/fluro.dart';

import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/register_view.dart';
import 'package:provider/provider.dart';

import '../ui/views/resset_view.dart';
import '../ui/views/ressetemail_view.dart';

class AdminHandlers {

  static Handler login = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);

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

  static Handler register = Handler(
    handlerFunc: ( context, params ) {
      
      final authProvider = Provider.of<AuthProvider>(context!);
      
      if ( authProvider.authStatus == AuthStatus.notAuthenticated )
        return RegisterView();
      else 
        return DashboardView();
    }
  );
  static Handler ressetPasswordEmailView = Handler(
    handlerFunc: ( context, params ) {
      
      final authProvider = Provider.of<AuthProvider>(context!);
      
      if ( authProvider.authStatus == AuthStatus.notAuthenticated )
        return RessetEmailView();
      else 
        return DashboardView();
    }
  );
  
  static Handler resset = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
     


      if ( authProvider.authStatus == AuthStatus.notAuthenticated ){
        print( params );
        if ( params['token']?.first != null ) {
            return RessetView(token: params['token']!.first);
        } else {
            return DashboardView();
        }


      } else {
        return LoginView();
      }
    }
  );


}

