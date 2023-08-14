import 'package:flutter/material.dart';


class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 0 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
         
          Text(
            'Inventario',
            style:TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w200,
              color: Colors.blue
            ),
          )
        ],
      ),
    );
  }
}