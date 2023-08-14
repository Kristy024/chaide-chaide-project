import 'package:admin_dashboard/models/colchones.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

import 'package:intl/intl.dart';

import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';

import '../../providers/colchones_provider.dart';

class ColchonView extends StatefulWidget {
  final String uid;

  const ColchonView({Key? key, required this.uid}) : super(key: key);

  @override
  _ColchonViewState createState() => _ColchonViewState();
}

class _ColchonViewState extends State<ColchonView> {
  Colchones? colchon;

  @override
  void initState() {
    super.initState();

    final colchonProvider =
        Provider.of<ColchonesProvider>(context, listen: false);

    colchonProvider.getColchonById(widget.uid).then((userDB) {
      if (userDB != null) {
        setState(() {
          this.colchon = userDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/colchones');
      }
    });
  }

  @override
  void dispose() {
    //Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colchones = Provider.of<ColchonesProvider>(context).colchones;
    final Colchones colchon2 = colchon ??
        Colchones(
            estado: true,
            bordeTapaOndulado: false,
            esquinaColSobresalida: false,
            esquinaTapaMalformada: false,
            hiloSueltoReata: false,
            hiloSueltoRemate: false,
            hiloSueltoAlcochado: false,
            hiloSueltoInterior: false,
            puntaSaltadaReata: false,
            reataRasgadaEnganchada: false,
            tipoRemateInadecuado: false,
            telaEspumaSalidaReata: false,
            tapaDescuadrada: false,
            telaRasgada: false,
            ninguno: false,
            otros: false,
            intTotal: 0,
            presenciaHiloSuelto: false,
            planAccion: "",
            observacion: "",
            id: "",
            codigo: "",
            lote: Lote(id: "0", codigo: "", modelo: ''),
            usuario: Usuario(id: "", nombre: ""),
            img: [],
            fechaIngreso: DateTime.now(),
            medidas: ''); // Valor de respaldo si colchon es null

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Colchon', style: CustomLabels.h1),
          SizedBox(height: 10),
          _ColchonViewBody(
            colchon: colchon2,
          )
        ],
      ),
    );
  }
}

class _ColchonViewBody extends StatelessWidget {
  final Colchones colchon;

  _ColchonViewBody({required this.colchon});

  Widget _buildBoolIcon(bool value) {
    return value
        ? Icon(Icons.check, color: Colors.red)
        : Icon(Icons.circle, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(300),
        },
        children: [
          TableRow(children: [
            // Información general
            WhiteCard(
              title: 'General',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Código: ${colchon.codigo}'),
                  Text('Medidas: ${colchon.medidas}'),
                  Text('Observación: ${colchon.observacion}'),
                  Text('Plan de acción: ${colchon.planAccion}'),
                  Text(
                      'Fecha ingresado el control de fallo: ${DateFormat('yyyy, MMM d, HH:mm').format(colchon.fechaIngreso)}'),
                  SizedBox(height: 10),
                  Text('Lote al que pertenece: ${colchon.lote.codigo}'),
                  SizedBox(height: 20),
                  Text('Usuario que registro: ${colchon.usuario.nombre}'),
                ],
              ),
            ),
          ]),
          TableRow(children: [
            // Lista de atributos
            WhiteCard(
              title: 'Fállas',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (colchon.bordeTapaOndulado)
                    Row(
                      children: [
                        Text('Borde Tapa Ondulado:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.bordeTapaOndulado),
                      ],
                    ),
                  if (colchon.esquinaColSobresalida)
                    Row(
                      children: [
                        Text('Esquina Col Sobresalida:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.esquinaColSobresalida),
                      ],
                    ),
                  if (colchon.esquinaTapaMalformada)
                    Row(
                      children: [
                        Text('Esquina Tapa Malformada:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.esquinaTapaMalformada),
                      ],
                    ),
                  if (colchon.hiloSueltoReata)
                    Row(
                      children: [
                        Text('Hilo Suelto Reata:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.hiloSueltoReata),
                      ],
                    ),
                  if (colchon.hiloSueltoRemate)
                    Row(
                      children: [
                        Text('Hilo Suelto Remate:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.hiloSueltoRemate),
                      ],
                    ),
                  if (colchon.hiloSueltoAlcochado)
                    Row(
                      children: [
                        Text('Hilo Suelto Alcochado:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.hiloSueltoAlcochado),
                      ],
                    ),
                  if (colchon.hiloSueltoInterior)
                    Row(
                      children: [
                        Text('Hilo Suelto Interior:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.hiloSueltoInterior),
                      ],
                    ),
                  if (colchon.puntaSaltadaReata)
                    Row(
                      children: [
                        Text('Punta Saltada Reata:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.puntaSaltadaReata),
                      ],
                    ),
                  if (colchon.reataRasgadaEnganchada)
                    Row(
                      children: [
                        Text('Reata Rasgada Enganchada:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.reataRasgadaEnganchada),
                      ],
                    ),
                  if (colchon.tipoRemateInadecuado)
                    Row(
                      children: [
                        Text('Tipo Remate Inadecuado:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.tipoRemateInadecuado),
                      ],
                    ),
                  if (colchon.telaEspumaSalidaReata)
                    Row(
                      children: [
                        Text('Tela Espuma Salida Reata:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.telaEspumaSalidaReata),
                      ],
                    ),
                  if (colchon.tapaDescuadrada)
                    Row(
                      children: [
                        Text('Tapa Descuadrada:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.tapaDescuadrada),
                      ],
                    ),
                  if (colchon.telaRasgada)
                    Row(
                      children: [
                        Text('Tela Rasgada:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.telaRasgada),
                      ],
                    ),
                  if (colchon.ninguno)
                    Row(
                      children: [
                        Text('Ninguno:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.ninguno),
                      ],
                    ),
                  if (colchon.otros && colchon.texto_otro != null)
                    Row(
                      children: [
                        Text('Otros:'),
                        Text(colchon.texto_otro!),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.otros),
                      ],
                    ),
                  if (colchon.presenciaHiloSuelto)
                    Row(
                      children: [
                        Text('Presencia Hilo Suelto:'),
                        SizedBox(width: 10),
                        _buildBoolIcon(colchon.presenciaHiloSuelto),
                      ],
                    ),
                ],
              ),
            ),
          ]),
          TableRow(children: [
            // Imágenes
            WhiteCard(
              title: 'Imágenes',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < colchon.img.length; index += 2)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: PhotoView(
                                      imageProvider:
                                          NetworkImage(colchon.img[index]),
                                      loadingBuilder: (context, event) =>
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 200, // Ancho deseado
                                height: 200, // Alto deseado
                                child: Image.network(colchon.img[index]),
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // Separación entre las imágenes
                          if (index + 1 < colchon.img.length)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: PhotoView(
                                        imageProvider: NetworkImage(
                                            colchon.img[index + 1]),
                                        loadingBuilder: (context, event) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator()),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 200, // Ancho deseado
                                  height: 200, // Alto deseado
                                  child: Image.network(colchon.img[index + 1]),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
