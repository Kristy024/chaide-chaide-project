import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final Color? backgroundColor; // Nuevo parámetro para el color de fondo

  const WhiteCard({
    Key? key,
    required this.child,
    this.title,
    this.width,
    this.backgroundColor, // Agregar el nuevo parámetro aquí
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return Container(
          width: width != null ? width : maxWidth < 400 ? maxWidth : null,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(10),
          decoration: buildBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                ...[
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider()
                ],
              child,
            ],
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: backgroundColor ?? Colors.white, // Usar el color proporcionado o blanco
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      );
}
