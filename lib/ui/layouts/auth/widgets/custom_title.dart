import 'package:flutter/material.dart';


class CustomTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'twitter-white-logo.png',
            width: 50,
            height: 50,
          ),

          SizedBox( height: 20 ),

          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Happening Now',
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}