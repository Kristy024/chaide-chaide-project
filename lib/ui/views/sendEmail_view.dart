import 'package:admin_dashboard/models/colchones.dart';
import 'package:admin_dashboard/models/lotes.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/models/usuario.dart';
import '../../providers/auth_provider.dart';
import '../../providers/categories_provider.dart';
import '../../providers/colchones_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;

import 'package:universal_html/html.dart' as html;

import '../buttons/custom_outlined_button.dart';
import '../inputs/custom_inputs.dart';

// Define the ChartData class
Future<void> generateAndDownloadPdf(
  String nameUser,
  String rol,
  String comentario,
  String tipoFiltro,
  List<Colchones> colchones,
  int totalGeneral,
  int contadorBordeTapaOndulado,
  int contadorEsquinaColSobreSalida,
  int contadorEsquinaTapaMalformada,
  int contadorHiloSueltoReata,
  int contadorHiloSueltoRemate,
  int contadorHiloSueltoAlcochado,
  int contadorHiloSueltoInterior,
  int contadorPuntaSaltadaReata,
  int contadorReataRasgadaEnganchada,
  int contadorTipoRemateInadecuado,
  int contadorTelaEspumaSalidaReata,
  int contadorTapaDescuadrada,
  int contadorTelaRasgada,
  int contadorNinguno,
  int contadorOtros,
  int contadorPresenciaHiloSuelto,
) async {
  final pdf = pw.Document();
  // Obtener los datos para el gráfico
  int contadorBordeTapaOndulado = 0;
  int contadorEsquinaColSobreSalida = 0;
  int contadorEsquinaTapaMalformada = 0;
  int contadorHiloSueltoReata = 0;
  int contadorHiloSueltoRemate = 0;
  int contadorHiloSueltoAlcochado = 0;
  int contadorHiloSueltoInterior = 0;
  int contadorPuntaSaltadaReata = 0;
  int contadorReataRasgadaEnganchada = 0;
  int contadorTipoRemateInadecuado = 0;
  int contadorTelaEspumaSalidaReata = 0;
  int contadorTapaDescuadrada = 0;
  int contadorTelaRasgada = 0;
  int contadorNinguno = 0;
  int contadorOtros = 0;
  int contadorPresenciaHiloSuelto = 0;

  for (var colchon in colchones) {
    if (colchon.bordeTapaOndulado) contadorBordeTapaOndulado++;
    if (colchon.esquinaColSobresalida) contadorEsquinaColSobreSalida++;
    if (colchon.esquinaTapaMalformada) contadorEsquinaTapaMalformada++;
    if (colchon.hiloSueltoReata) contadorHiloSueltoReata++;
    if (colchon.hiloSueltoRemate) contadorHiloSueltoRemate++;
    if (colchon.hiloSueltoAlcochado) contadorHiloSueltoAlcochado++;
    if (colchon.hiloSueltoInterior) contadorHiloSueltoInterior++;
    if (colchon.puntaSaltadaReata) contadorPuntaSaltadaReata++;
    if (colchon.reataRasgadaEnganchada) contadorReataRasgadaEnganchada++;
    if (colchon.tipoRemateInadecuado) contadorTipoRemateInadecuado++;
    if (colchon.telaEspumaSalidaReata) contadorTelaEspumaSalidaReata++;
    if (colchon.tapaDescuadrada) contadorTapaDescuadrada++;
    if (colchon.telaRasgada) contadorTelaRasgada++;
    if (colchon.ninguno) contadorNinguno++;
    if (colchon.otros) contadorOtros++;
    if (colchon.presenciaHiloSuelto) contadorPresenciaHiloSuelto++;
  }
  String role = rol;
  if (rol == "ADMIN_ROLE") {
    role = "Administrador";
  } else if (rol == "SUPERVISOR_ROLE") {
    role = "Supervisor";
  } else if (rol == "OPERADOR_ROLE") {
    role = "Operador";
  }
  // Calcular el total general
  int totalGeneral = contadorBordeTapaOndulado +
      contadorEsquinaColSobreSalida +
      contadorEsquinaTapaMalformada +
      contadorHiloSueltoReata +
      contadorHiloSueltoRemate +
      contadorHiloSueltoAlcochado +
      contadorHiloSueltoInterior +
      contadorPuntaSaltadaReata +
      contadorReataRasgadaEnganchada +
      contadorTipoRemateInadecuado +
      contadorTelaEspumaSalidaReata +
      contadorTapaDescuadrada +
      contadorTelaRasgada +
      contadorNinguno +
      contadorOtros +
      contadorPresenciaHiloSuelto;

  List<TipoColchonData> data = [
    TipoColchonData('Borde Tapa Ondulado', contadorBordeTapaOndulado),
    TipoColchonData('Esquina Col Sobresalida', contadorEsquinaColSobreSalida),
    TipoColchonData('Esquina Tapa Malformada', contadorEsquinaTapaMalformada),
    TipoColchonData('Hilo Suelto Reata', contadorHiloSueltoReata),
    TipoColchonData('Hilo Suelto Remate', contadorHiloSueltoRemate),
    TipoColchonData('Hilo Suelto Alcochado', contadorHiloSueltoAlcochado),
    TipoColchonData('Hilo Suelto Interior', contadorHiloSueltoInterior),
    TipoColchonData('Punta Saltada Reata', contadorPuntaSaltadaReata),
    TipoColchonData('Reata Rasgada Enganchada', contadorReataRasgadaEnganchada),
    TipoColchonData('Tipo Remate Inadecuado', contadorTipoRemateInadecuado),
    TipoColchonData('Tela Espuma Salida Reata', contadorTelaEspumaSalidaReata),
    TipoColchonData('Tapa Descuadrada', contadorTapaDescuadrada),
    TipoColchonData('Tela Rasgada', contadorTelaRasgada),
    TipoColchonData('Ninguno', contadorNinguno),
    TipoColchonData('Otros', contadorOtros),
    TipoColchonData('Presencia Hilo Suelto', contadorPresenciaHiloSuelto),
  ];
  final series = [
    charts.Series<TipoColchonData, String>(
      id: 'Cantidad',
      domainFn: (TipoColchonData data, _) => data.tipo,
      measureFn: (TipoColchonData data, _) => data.cantidad,
      data: data,
    ),
  ];
  final barChart = charts.BarChart(
    series,
    animate: true,
    vertical: true,
    defaultRenderer: charts.BarRendererConfig(
      barRendererDecorator: charts.BarLabelDecorator<String>(
        labelPosition: charts.BarLabelPosition.inside,
      ),
    ),
    domainAxis: charts.OrdinalAxisSpec(
      renderSpec: charts.NoneRenderSpec(),
    ),
  );

  //final ByteData imageLeftData = await rootBundle.load('assets/logo_pdfFruty.jpeg');
  final ByteData imageCenterData = await rootBundle.load('/background.png');
  //final ByteData imageRightData = await rootBundle.load('/logo_pdfImagen.jpeg');

  //final Uint8List imageLeftBytes = imageLeftData.buffer.asUint8List();
  final Uint8List imageCenterBytes = imageCenterData.buffer.asUint8List();
  //final Uint8List imageRightBytes = imageRightData.buffer.asUint8List();

  // Crear las imágenes
  //final pdfImageLeft = pw.MemoryImage(imageLeftBytes);
  final pdfImageCenter = pw.MemoryImage(imageCenterBytes);
  final ahora = DateTime.now();
  final formatoFecha = DateFormat(
      'dd/MM/yyyy HH:mm'); // Cambia el formato de fecha según tus preferencias

  // ... Resto del código

  // final pdfImageRight = pw.MemoryImage(imageRightBytes);
  // Crear la tabla de permisos
  final colchonesTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Text('Lote Código',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) =>
              pw.Text(colchon.codigo, style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Borde Tapa Ondulado',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.bordeTapaOndulado ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Esquina Col Sobresalida',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.esquinaColSobresalida ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Esquina Tapa Malformada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.esquinaTapaMalformada ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Reata',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.hiloSueltoReata ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Remate',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.hiloSueltoRemate ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Alcochado',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.hiloSueltoAlcochado ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Interior',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.hiloSueltoInterior ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Punta Saltada Reata',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.puntaSaltadaReata ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Reata Rasgada Enganchada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.reataRasgadaEnganchada ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tipo Remate Inadecuado',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.tipoRemateInadecuado ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tela Espuma Salida Reata',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.telaEspumaSalidaReata ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tapa Descuadrada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.tapaDescuadrada ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tela Rasgada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.telaRasgada ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Ninguno',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(colchon.ninguno ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Otros',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(colchon.otros ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Presencia Hilo Suelto',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          ...colchones.map((colchon) => pw.Text(
              colchon.presenciaHiloSuelto ? 'Sí' : 'No',
              style: pw.TextStyle(fontSize: 8))),
        ],
      ),
    ],
  );
  final modelosTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(children: [
        pw.Text('Modelo',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
        pw.Text('Código de lote',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
        pw.Text('Código de colchon',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
        pw.Text('Total de Fallos',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
        pw.Text('Medidas',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
        pw.Text('Observación',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
      ]),
      ...colchones.map((e) => pw.TableRow(children: [
            pw.Text('${e.lote.modelo}',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('${e.lote.codigo}',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('${e.codigo}',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('${e.intTotal}',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('${e.medidas}',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('${e.observacion}',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
          ])),
    ],
  );
  final inicialTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Reporte General de Fallos',
                style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight
                        .bold)), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Image(pdfImageCenter,
                width: 250,
                height:
                    150), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
        ],
      ),
    ],
  );
  final datosReporteTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Nombre:',
                style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight
                        .bold)), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('$nameUser',
                style: pw.TextStyle(
                  fontSize: 12,
                )), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Rol:',
                style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight
                        .bold)), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('$role',
                style: pw.TextStyle(
                  fontSize: 12,
                )), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Fecha:',
                style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight
                        .bold)), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(formatoFecha.format(ahora),
                style: pw.TextStyle(fontSize: 12)),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Tipo de filtro:',
                style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight
                        .bold)), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('$tipoFiltro',
                style: pw.TextStyle(
                  fontSize: 12,
                )), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Comentario:',
                style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight
                        .bold)), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('$comentario',
                style: pw.TextStyle(
                  fontSize: 12,
                )), // Reemplaza 'yourLogoImageProvider' con la fuente de la imagen de tu logo
          ),
        ],
      ),
    ],
  );
  final contadoresTable = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Text('Borde Tapa Ondulado',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorBordeTapaOndulado.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Esquina Col Sobresalida',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorEsquinaColSobreSalida.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Esquina Tapa Malformada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorEsquinaTapaMalformada.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Reata',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorHiloSueltoReata.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Remate',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorHiloSueltoRemate.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Alcochado',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorHiloSueltoAlcochado.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Hilo Suelto Interior',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorHiloSueltoInterior.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Punta Saltada Reata',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorPuntaSaltadaReata.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Reata Rasgada Enganchada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorReataRasgadaEnganchada.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tipo Remate Inadecuado',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorTipoRemateInadecuado.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tela Espuma Salida Reata',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorTelaEspumaSalidaReata.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tapa Descuadrada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorTapaDescuadrada.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Tela Rasgada',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorTelaRasgada.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Ninguno',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorNinguno.toString(), style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Otros',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorOtros.toString(), style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Presencia Hilo Suelto',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(contadorPresenciaHiloSuelto.toString(),
              style: pw.TextStyle(fontSize: 8)),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Text('Total General',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.Text(totalGeneral.toString(), style: pw.TextStyle(fontSize: 8)),
        ],
      ),
    ],
  );

  // Convertir el gráfico a una imagen

  // Agregar las tablas al documento PDF
  pdf.addPage(
    pw.MultiPage(
      header: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            //pw.Image(pdfImageLeft, width: 100, height: 100),
            //pw.Container(width: 150),
            //pw.Image(pdfImageCenter, width: 250, height: 150),
            //pw.Container(width: 200),
            //  pw.Image(pdfImageRight, width: 100, height: 100),
          ],
        );
      },
      footer: (pw.Context context) {
        return pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
              'Página ${context.pageNumber} de ${context.pagesCount}',
              style: pw.TextStyle(fontSize: 12)),
        );
      },
      build: (pw.Context context) {
        return [
          inicialTable,
          datosReporteTable,
          pw.SizedBox(height: 10),
          pw.DecoratedBox(
            child: pw.Column(children: [
              pw.SizedBox(height: 20),
              pw.Text('Tabla de Colchones',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              modelosTable,
              pw.SizedBox(height: 20),
              pw.Text('Tabla de Fallos',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              colchonesTable,
              pw.SizedBox(height: 20),
              pw.Text('Total Registrado de Fallos en Colchones',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              contadoresTable,
              pw.SizedBox(height: 10),
            ]),
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              //color: pw.Colors.blue.opacity(),

              // Puedes ajustar el ajuste según lo necesites
            ),
          ),
        ];
      },
    ),
  );

  final Uint8List bytes = await pdf.save();

  // Descargar el archivo PDF
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'InformeGeneral.pdf';

  html.document.body?.children.add(anchor);
  anchor.click();

  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

class ChartData {
  final String loteCodigo;
  final double porcentajeFallas;

  ChartData(this.loteCodigo, this.porcentajeFallas);
}

class TipoColchonData {
  final String tipo;
  final int cantidad;

  TipoColchonData(this.tipo, this.cantidad);
}

class SendEmailView extends StatefulWidget {
  @override
  State<SendEmailView> createState() => _SendEmailViewState();
}

class _SendEmailViewState extends State<SendEmailView> {
  String filtro = "";
  String selectedFiltro = '';
  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getLotes();
    Provider.of<ColchonesProvider>(context, listen: false).getColchones();
    Provider.of<ColchonesProvider>(context, listen: false).getModeloColchones();
  }

  TextEditingController _fechaController = TextEditingController();
  TextEditingController _fechaController2 = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _fechaController.text = picked.toLocal().toString().split(' ')[0];

      setState(() {});
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _fechaController2.text = picked.toLocal().toString().split(' ')[0];

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final lotes1 = Provider.of<CategoriesProvider>(context).lotes;
    final colchones1 = Provider.of<ColchonesProvider>(context).colchones;

    final provider = Provider.of<ColchonesProvider>(context, listen: false);
    final List<Colchones> colchones = [];
    final List<Lotes> lotes = [];

    String fechaInicioText = _fechaController.text;
    String fechaFinText = _fechaController2.text;

    DateTime? fechaInicio;
    DateTime? fechaFin;

    // Verificar si el texto del controlador de fecha de inicio es válido
    if (fechaInicioText.isNotEmpty) {
      fechaInicio = DateTime.tryParse(fechaInicioText)!;
    }

    // Verificar si el texto del controlador de fecha de fin es válido
    if (fechaFinText.isNotEmpty) {
      fechaFin = DateTime.tryParse(fechaFinText)!;
    }

    // Verificar si ambas fechas son válidas antes de aplicar el filtro
    if (fechaInicio != null && fechaFin != null) {
      // Filtrar los colchones que están dentro del rango de fechas seleccionadas
      colchones.clear();
      colchones.addAll(colchones1.where((colchon) {
        DateTime fechaColchon = colchon.fechaIngreso;
        return fechaColchon.isAfter(fechaInicio!) &&
            fechaColchon.isBefore(fechaFin!);
      }).toList());

      // Filtrar los lotes que están dentro del rango de fechas seleccionadas
      lotes.clear();
      lotes.addAll(lotes1.where((lote) {
        DateTime fechaLote = lote.fechaIngreso;
        return fechaLote.isAfter(fechaInicio!) && fechaLote.isBefore(fechaFin!);
      }).toList());

      // Hacer algo con las listas colchones y lotes filtradas
      // ...
    } else {
      // No aplicar el filtro y utilizar las listas originales sin cambios
      colchones.clear();
      colchones.addAll(colchones1);

      lotes.clear();
      lotes.addAll(lotes1);

      // Hacer algo con las listas colchones y lotes originales
      // ...
    }

    int cantidadLotes = lotes.length;
    int cantidadRevisados = 0;
    int cantidadNoR = 0;
    // Obtén el total de colchones por lote y el porcentaje de fallas
    Map<String, int> totalColchonesPorLote = {};
    Map<String, double> porcentajeFallasPorLote = {};

    int contadorBordeTapaOndulado = 0;
    int contadorEsquinaColSobreSalida = 0;
    int contadorEsquinaTapaMalformada = 0;
    int contadorHiloSueltoReata = 0;
    int contadorHiloSueltoRemate = 0;
    int contadorHiloSueltoAlcochado = 0;
    int contadorHiloSueltoInterior = 0;
    int contadorPuntaSaltadaReata = 0;
    int contadorReataRasgadaEnganchada = 0;
    int contadorTipoRemateInadecuado = 0;
    int contadorTelaEspumaSalidaReata = 0;
    int contadorTapaDescuadrada = 0;
    int contadorTelaRasgada = 0;
    int contadorNinguno = 0;
    int contadorOtros = 0;
    int contadorPresenciaHiloSuelto = 0;

    for (var colchon in colchones) {
      if (colchon.bordeTapaOndulado) contadorBordeTapaOndulado++;
      if (colchon.esquinaColSobresalida) contadorEsquinaColSobreSalida++;
      if (colchon.esquinaTapaMalformada) contadorEsquinaTapaMalformada++;
      if (colchon.hiloSueltoReata) contadorHiloSueltoReata++;
      if (colchon.hiloSueltoRemate) contadorHiloSueltoRemate++;
      if (colchon.hiloSueltoAlcochado) contadorHiloSueltoAlcochado++;
      if (colchon.hiloSueltoInterior) contadorHiloSueltoInterior++;
      if (colchon.puntaSaltadaReata) contadorPuntaSaltadaReata++;
      if (colchon.reataRasgadaEnganchada) contadorReataRasgadaEnganchada++;
      if (colchon.tipoRemateInadecuado) contadorTipoRemateInadecuado++;
      if (colchon.telaEspumaSalidaReata) contadorTelaEspumaSalidaReata++;
      if (colchon.tapaDescuadrada) contadorTapaDescuadrada++;
      if (colchon.telaRasgada) contadorTelaRasgada++;
      if (colchon.ninguno) contadorNinguno++;
      if (colchon.otros) contadorOtros++;
      if (colchon.presenciaHiloSuelto) contadorPresenciaHiloSuelto++;
    }

    // Calcular el total general
    int totalGeneral = contadorBordeTapaOndulado +
        contadorEsquinaColSobreSalida +
        contadorEsquinaTapaMalformada +
        contadorHiloSueltoReata +
        contadorHiloSueltoRemate +
        contadorHiloSueltoAlcochado +
        contadorHiloSueltoInterior +
        contadorPuntaSaltadaReata +
        contadorReataRasgadaEnganchada +
        contadorTipoRemateInadecuado +
        contadorTelaEspumaSalidaReata +
        contadorTapaDescuadrada +
        contadorTelaRasgada +
        contadorNinguno +
        contadorOtros +
        contadorPresenciaHiloSuelto;

    List<TipoColchonData> data = [
      TipoColchonData('Borde Tapa Ondulado', contadorBordeTapaOndulado),
      TipoColchonData('Esquina Col Sobresalida', contadorEsquinaColSobreSalida),
      TipoColchonData('Esquina Tapa Malformada', contadorEsquinaTapaMalformada),
      TipoColchonData('Hilo Suelto Reata', contadorHiloSueltoReata),
      TipoColchonData('Hilo Suelto Remate', contadorHiloSueltoRemate),
      TipoColchonData('Hilo Suelto Alcochado', contadorHiloSueltoAlcochado),
      TipoColchonData('Hilo Suelto Interior', contadorHiloSueltoInterior),
      TipoColchonData('Punta Saltada Reata', contadorPuntaSaltadaReata),
      TipoColchonData(
          'Reata Rasgada Enganchada', contadorReataRasgadaEnganchada),
      TipoColchonData('Tipo Remate Inadecuado', contadorTipoRemateInadecuado),
      TipoColchonData(
          'Tela Espuma Salida Reata', contadorTelaEspumaSalidaReata),
      TipoColchonData('Tapa Descuadrada', contadorTapaDescuadrada),
      TipoColchonData('Tela Rasgada', contadorTelaRasgada),
      TipoColchonData('Ninguno', contadorNinguno),
      TipoColchonData('Otros', contadorOtros),
      TipoColchonData('Presencia Hilo Suelto', contadorPresenciaHiloSuelto),
    ];

    final series = [
      charts.Series<TipoColchonData, String>(
        id: 'Cantidad',
        domainFn: (TipoColchonData data, _) => data.tipo,
        measureFn: (TipoColchonData data, _) => data.cantidad,
        data: data,
      ),
    ];

    final barChart = charts.BarChart(
      series,
      animate: true,
      vertical: true,
      defaultRenderer: charts.BarRendererConfig(
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.inside,
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );

    for (var colchon in colchones) {
      String codigoLote = colchon.lote.codigo;

      if (totalColchonesPorLote.containsKey(codigoLote)) {
        totalColchonesPorLote[codigoLote] =
            totalColchonesPorLote[codigoLote]! + 1;
      } else {
        totalColchonesPorLote[codigoLote] = 1;
      }

      if (porcentajeFallasPorLote.containsKey(codigoLote)) {
        porcentajeFallasPorLote[codigoLote] =
            (porcentajeFallasPorLote[codigoLote]! + colchon.intTotal) /
                totalColchonesPorLote[codigoLote]!;
      } else {
        porcentajeFallasPorLote[codigoLote] = colchon.intTotal.toDouble();
      }
    }

    List<String> tipoFiltro = [
      "Modelo",
      "Fecha",
      "Código",
    ];

    final modelosName = Provider.of<ColchonesProvider>(context).modelos;

    // Genera la lista de datos para el gráfico
    List<charts.Series<ChartData, String>> seriesList = [];

    for (var entry in porcentajeFallasPorLote.entries) {
      String codigoLote = entry.key;
      double porcentajeFallas = entry.value;

      seriesList.add(
        charts.Series<ChartData, String>(
          id: codigoLote,
          domainFn: (ChartData data, _) =>
              "${data.loteCodigo}\n${data.porcentajeFallas.toStringAsFixed(2)}%",
          measureFn: (ChartData data, _) => data.porcentajeFallas,
          data: [ChartData(codigoLote, porcentajeFallas)],
          labelAccessorFn: (ChartData data, _) => '',
        ),
      );
    }
    for (var lote in lotes) {
      if (lote.estadoRevision == true) {
        cantidadRevisados++;
      } else
        cantidadNoR++;
    }
    Map<String, int> registrosPorDia = {};

    for (var lote in lotes) {
      String dia = DateFormat('yyyy-MM-dd').format(lote.fechaIngreso);

      if (registrosPorDia.containsKey(dia)) {
        registrosPorDia[dia] = registrosPorDia[dia]! + 1;
      } else {
        registrosPorDia[dia] = 1;
      }
    }

    final user = Provider.of<AuthProvider>(context).user!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          //CABECERA Y FILTROS
          DropdownButtonFormField<String>(
            value: null,
            dropdownColor: Colors.white,
            items: tipoFiltro.map((medida) {
              return DropdownMenuItem<String>(
                value: medida,
                child: Text(
                  medida,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                //selectedFiltro = value;
                selectedFiltro = value.toString();
              });
            },
            decoration: InputDecoration(
              labelText: "Tipo de filtro",
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),

          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController _controller =
                      TextEditingController(); // Controlador para manejar el valor del campo de texto

                  return AlertDialog(
                    title: Text('Ingresar Comentario'),
                    content: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Comentario',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Cerrar el cuadro de diálogo sin comentario
                        },
                      ),
                      TextButton(
                        child: Text('Aceptar'),
                        onPressed: () {
                          String comentario = _controller
                              .text; // Obtener el valor del campo de texto
                          if (comentario.isNotEmpty) {
                            generateAndDownloadPdf(
                                user.nombre,
                                user.rol,
                                comentario,
                                selectedFiltro,
                                colchones,
                                totalGeneral,
                                contadorBordeTapaOndulado,
                                contadorEsquinaColSobreSalida,
                                contadorEsquinaTapaMalformada,
                                contadorHiloSueltoReata,
                                contadorHiloSueltoRemate,
                                contadorHiloSueltoAlcochado,
                                contadorHiloSueltoInterior,
                                contadorPuntaSaltadaReata,
                                contadorReataRasgadaEnganchada,
                                contadorTipoRemateInadecuado,
                                contadorTelaEspumaSalidaReata,
                                contadorTapaDescuadrada,
                                contadorTelaRasgada,
                                contadorNinguno,
                                contadorOtros,
                                contadorPresenciaHiloSuelto);
                          }
                          Navigator.of(context)
                              .pop(); // Cerrar el cuadro de diálogo
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.picture_as_pdf, color: Colors.red),
          ),

          if (selectedFiltro == "Modelo")
            DropdownButtonFormField<String>(
              value: null,
              dropdownColor: Colors.white,
              items: modelosName.map((modeloN) {
                return DropdownMenuItem<String>(
                  value: modeloN,
                  child: Text(
                    modeloN,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) async {
                filtro = value!;
                print(filtro);
                await provider.getColchonesFiltroModelo(filtro);
              },
              decoration: InputDecoration(
                labelText: "Filtro de modelos",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          if (selectedFiltro == "Fecha")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Desde: ",
                  style: TextStyle(color: Colors.black),
                ),
                CustomOutlinedButton(
                  text: _fechaController.text == ""
                      ? "Seleccione"
                      : _fechaController.text,
                  onPressed: () => _selectDate(context),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Hasta: ",
                  style: TextStyle(color: Colors.black),
                ),
                CustomOutlinedButton(
                  text: _fechaController2.text == ""
                      ? "Seleccione"
                      : _fechaController2.text,
                  onPressed: () => _selectDate2(context),
                ),
              ],
            ),

          if (selectedFiltro == "Código")
            TextFormField(
              initialValue: filtro,
              onChanged: (value) async {
                filtro = value;
                await provider.getColchonesFiltroCodigo(filtro);
              },
              keyboardType: TextInputType.text,

              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Buscar por código de lote',
                  label: 'Buscar por código de lote',
                  icon: Icons.numbers),
              style: TextStyle(color: Colors.white),
              maxLength: 10, // Set maximum input length to 7 characters
            ),

          if (selectedFiltro != "Modelo")
            WhiteCard(
              backgroundColor: Colors.white,
              title: 'Porcentaje de Fallas por Lote',
              child: Container(
                height: 300,
                child: charts.BarChart(
                  seriesList,
                  animate: true,
                  vertical: true,
                  defaultInteractions: true,
                  barRendererDecorator: charts.BarLabelDecorator<String>(
                    labelPosition: charts.BarLabelPosition.outside,
                    labelAnchor: charts.BarLabelAnchor.end,
                    insideLabelStyleSpec: charts.TextStyleSpec(
                      color: charts.Color.black,
                    ),
                  ),
                ),
              ),
            ),
          Card(
            child: Container(
              color: Colors.white,
              height: 400, // Ajusta la altura según tus necesidades
              padding: EdgeInsets.all(20),
              child: barChart,
            ),
          ),

          Wrap(
            children: [
              WhiteCard(
                backgroundColor: Colors.white,
                // width: 800,
                title: "Cantidad de Lotes \nRegistrados: $cantidadLotes ",
                child: Row(
                  children: [
                    WhiteCard(
                        title:
                            "Cantidad\nRevisados: $cantidadRevisados \nNo Revisados: $cantidadNoR",
                        child: WhiteCard(
                          width: 200,
                          title: 'Registros por Día',
                          child: Column(
                            children: registrosPorDia.entries.map((entry) {
                              String dia = entry.key;
                              int cantidadRegistros = entry.value;

                              return Text(
                                'Día $dia: $cantidadRegistros registros',
                                style: TextStyle(fontSize: 16),
                              );
                            }).toList(),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: WhiteCard(
                        width: 300,
                        title: 'Colchones',
                        child: DataTable(
                          columnSpacing: 100,
                          columns: [
                            DataColumn(label: Text('Etiqueta de fila')),
                            DataColumn(label: Text('Cuenta')),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text('Borde Tapa Ondulado')),
                                DataCell(
                                    Text(contadorBordeTapaOndulado.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Esquina Col Sobresalida')),
                                DataCell(Text(
                                    contadorEsquinaColSobreSalida.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Esquina Tapa Malformada')),
                                DataCell(Text(
                                    contadorEsquinaTapaMalformada.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hilo Suelto Reata')),
                                DataCell(
                                    Text(contadorHiloSueltoReata.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hilo Suelto Remate')),
                                DataCell(
                                    Text(contadorHiloSueltoRemate.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hilo Suelto Alcochado')),
                                DataCell(Text(
                                    contadorHiloSueltoAlcochado.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hilo Suelto Interior')),
                                DataCell(Text(
                                    contadorHiloSueltoInterior.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Punta Saltada Reata')),
                                DataCell(
                                    Text(contadorPuntaSaltadaReata.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Reata Rasgada Enganchada')),
                                DataCell(Text(
                                    contadorReataRasgadaEnganchada.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Tipo Remate Inadecuado')),
                                DataCell(Text(
                                    contadorTipoRemateInadecuado.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Tela Espuma Salida Reata')),
                                DataCell(Text(
                                    contadorTelaEspumaSalidaReata.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Tapa Descuadrada')),
                                DataCell(
                                    Text(contadorTapaDescuadrada.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Tela Rasgada')),
                                DataCell(Text(contadorTelaRasgada.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Ninguno')),
                                DataCell(Text(contadorNinguno.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Otros')),
                                DataCell(Text(contadorOtros.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Presencia Hilo Suelto')),
                                DataCell(Text(
                                    contadorPresenciaHiloSuelto.toString())),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Total General')),
                                DataCell(Text(totalGeneral.toString())),
                              ],
                            ),
                            // Agregar las demás etiquetas de fila aquí...
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //termina lote
        ],
      ),
    );
  }
}
