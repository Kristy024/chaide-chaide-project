import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/router/admin_handlers.dart';

class Flurorouter {

  static final FluroRouter router = new FluroRouter();

  static String rootRoute     = '/';

  // Auth Router
  static String loginRoute    = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute  = '/dashboard';
  static String iconsRoute      = '/dashboard/icons';
  static String blankRoute      = '/dashboard/colchones';
  static String generarPDFRoute      = '/dashboard/emision';
    static String colchonRoute      = '/dashboard/colchones/:uid';
  static String categoriesRoute = '/dashboard/lotes';
  
  static String usersRoute = '/dashboard/users';
  static String userRoute  = '/dashboard/users/:uid';

  static String ressetView  = '/auth/ressetPasswordP/:token';
    static String ressetPasswordEmailView = '/auth/ressetPassword';
  static void configureRoutes() {
    // Auth Routes
    router.define( rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define( loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define( registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none );
        router.define( ressetPasswordEmailView, handler: AdminHandlers.ressetPasswordEmailView, transitionType: TransitionType.none );
     router.define( ressetView, handler: AdminHandlers.resset, transitionType: TransitionType.none );
    // Dashboard
    router.define( dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn );
    
    router.define( categoriesRoute, handler: DashboardHandlers.categories, transitionType: TransitionType.fadeIn );
    router.define( iconsRoute, handler: DashboardHandlers.icons, transitionType: TransitionType.fadeIn );
        router.define( generarPDFRoute, handler: DashboardHandlers.generarpdf, transitionType: TransitionType.fadeIn );

    // users
    router.define( usersRoute, handler: DashboardHandlers.users, transitionType: TransitionType.fadeIn );
    router.define( userRoute, handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn );

  //colchones
  router.define( blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.fadeIn );
  router.define( colchonRoute, handler: DashboardHandlers.colchon, transitionType: TransitionType.fadeIn );
    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;

  }
  


}

