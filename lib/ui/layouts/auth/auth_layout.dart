import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/layouts/auth/widgets/background_twitter.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/links_bar.dart';


class AuthLayout extends StatelessWidget {

  final Widget child;

  const AuthLayout({
    Key? key, 
    required this.child
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        // isAlwaysShown: true,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [

            ( size.width > 1000 )
              ? _DesktopBody( child: child)
              : _MobileBody( child: child ),
            
            // LinksBar
            //LinksBar()
          ],
        ),
      )
    );
  }
}


class _MobileBody extends StatelessWidget {

  final Widget child;

  const _MobileBody({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 800,
      //color: Color(0xFFFFE3B3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox( height: 20 ),
          BackgroundLogin(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),

          /*Container(
            width: double.infinity,
            height: 400,
            child: BackgroundTwitter(),
          )*/
        ],
      ),
    );
  }
 
}


class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({
    Key? key, 
    required this.child
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: 800,
      //color: Color(0xFFFFE3B3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox( height: 20 ),
          BackgroundLogin(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),

          /*Container(
            width: double.infinity,
            height: 400,
            child: BackgroundTwitter(),
          )*/
        ],
      ),
    );
  }
}

class BackgroundLogin extends StatelessWidget {
  const BackgroundLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
	              height: 300,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('background.png'),
	                  fit: BoxFit.contain
	                )
	              ),
	              child: Stack(
	                children: <Widget>[
	                  Positioned(
	                    left: 30,
	                    width: 80,
	                    height: 200,
	                    child:Container(
             decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.2),
             borderRadius: BorderRadius.circular(25),
           ),
           child: Image.asset(
             'light-1.png',
             color: Colors.blue[300],
           ),
	                    ),
	                  ),
	                  Positioned(
	                    left: 140,
	                    width: 80,
	                    height: 150,
	                    child: Container(
             decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.2),
             borderRadius: BorderRadius.circular(25),
           ),
           child: Image.asset(
             'light-2.png',
             color: Colors.blue[200],
           ),
	                    )
	                  ),
	                  Positioned(
	                    right: 40,
	                    //top: 40,
	                    width: 80,
	                    height: 200,
	                    child: Container(
             decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.3),
             borderRadius: BorderRadius.circular(25),
           ),
           child: Image.asset(
             'light-1.png',
             color: Colors.blue[300],
           ),
	                    ),
	                  ),
        Positioned(
	                    right: 130,
	                    //top: 40,
	                    width: 80,
	                    height: 150,
	                    child: Container(
             decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.3),
             borderRadius: BorderRadius.circular(25),
           ),
           child: Image.asset(
             'light-2.png',
             color: Colors.blue[200],
           ),
	                    ),
	                  ),
	                 /* Positioned(
	                    child: FadeAnimation(1.6, Container(
	                      margin: EdgeInsets.only(top: 50),
	                      child: Center(
	                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	                      ),
	                    )),
	                  )*/
	                ],
	              ),
	            );
  }
}

