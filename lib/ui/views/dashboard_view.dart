import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';

import '../../providers/categories_provider.dart';
import '../../providers/colchones_provider.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// Define the ChartData class
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

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getLotes();
    Provider.of<ColchonesProvider>(context, listen: false).getColchones();
  }

  @override
  Widget build(BuildContext context) {
    final lotes = Provider.of<CategoriesProvider>(context).lotes;
    final colchones = Provider.of<ColchonesProvider>(context).colchones;
    int cantidadLotes = lotes.length;
    int cantidadRevisados = 0;
    int cantidadNoR = 0;
    // Obtén el total de colchones por lote y el porcentaje de fallas
    Map<String, int> totalColchonesPorLote = {};
    Map<String, double> porcentajeFallasPorLote = {};
    // Genera la lista de datos para el gráfico
    // List<charts.Series<ChartData, String>> seriesList = [];
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

    /* for (var entry in porcentajeFallasPorLote.entries) {
      String codigoLote = entry.key;
      double porcentajeFallas = entry.value;

      // seriesList.add(
      //   charts.Series<ChartData, String>(
      //     id: codigoLote,
      //     domainFn: (ChartData data, _) => data.loteCodigo,
      //     measureFn: (ChartData data, _) => data.porcentajeFallas,
      //     data: [ChartData(codigoLote, porcentajeFallas)],
      //     labelAccessorFn: (ChartData data, _) =>
      //         '${data.loteCodigo}: ${data.porcentajeFallas.toStringAsFixed(2)}%',
      //   ),
      // );
    } */
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Card(),
          Wrap(
            children: [
              WhiteCard(
                width: 500,
                title: "Cantidad de Lotes \nRegistrados: $cantidadLotes ",
                child: Column(
                  children: [
                    WhiteCard(
                        title:
                            "Cantidad \nRevisados: $cantidadRevisados \nNo Revisados: $cantidadNoR",
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
                  ],
                ),
              ),
            ],
          ),
          WhiteCard(
            title: 'Porcentaje de Fallas por Lote',
            child: Container(
              height: 300,
              // child: charts.BarChart(
              //   seriesList,
              //   animate: true,
              //   vertical: true,
              //   barRendererDecorator: charts.BarLabelDecorator<String>(),
              // ),
            ),
          ),

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
                      DataCell(Text(contadorBordeTapaOndulado.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Esquina Col Sobresalida')),
                      DataCell(Text(contadorEsquinaColSobreSalida.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Esquina Tapa Malformada')),
                      DataCell(Text(contadorEsquinaTapaMalformada.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Hilo Suelto Reata')),
                      DataCell(Text(contadorHiloSueltoReata.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Hilo Suelto Remate')),
                      DataCell(Text(contadorHiloSueltoRemate.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Hilo Suelto Alcochado')),
                      DataCell(Text(contadorHiloSueltoAlcochado.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Hilo Suelto Interior')),
                      DataCell(Text(contadorHiloSueltoInterior.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Punta Saltada Reata')),
                      DataCell(Text(contadorPuntaSaltadaReata.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Reata Rasgada Enganchada')),
                      DataCell(Text(contadorReataRasgadaEnganchada.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Tipo Remate Inadecuado')),
                      DataCell(Text(contadorTipoRemateInadecuado.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Tela Espuma Salida Reata')),
                      DataCell(Text(contadorTelaEspumaSalidaReata.toString())),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Tapa Descuadrada')),
                      DataCell(Text(contadorTapaDescuadrada.toString())),
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
                      DataCell(Text(contadorPresenciaHiloSuelto.toString())),
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

          Card(
            child: Container(
              height: 400, // Ajusta la altura según tus necesidades
              // padding: EdgeInsets.all(20),
              // child: barChart,
            ),
          ),
          //termina lote
        ],
      ),
    );
  }
}
