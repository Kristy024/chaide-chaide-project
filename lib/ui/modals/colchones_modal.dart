import 'package:admin_dashboard/providers/colchones_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';

import '../../models/colchones.dart';
import '../../providers/categories_provider.dart';
import '../inputs/custom_inputs.dart';

class ColchonModal extends StatefulWidget {
  final Colchones? colchon;

  const ColchonModal({Key? key, this.colchon}) : super(key: key);

  @override
  _ColchonModalState createState() => _ColchonModalState();
}

class _ColchonModalState extends State<ColchonModal> {
  String filtro = "";
  bool bordeTapaOndulado = false;
  bool esquinaColSobresalida = false;
  bool esquinaTapaMalformada = false;
  bool hiloSueltoReata = false;
  bool hiloSueltoRemate = false;
  bool hiloSueltoAlcochado = false;
  bool hiloSueltoInterior = false;
  bool puntaSaltadaReata = false;
  bool reataRasgadaEnganchada = false;
  bool tipoRemateInadecuado = false;
  bool telaEspumaSalidaReata = false;
  bool tapaDescuadrada = false;
  bool telaRasgada = false;
  bool ninguno = false;
  bool otros = false;
  int intTotal = 0;
  bool presenciaHiloSuelto = false;
  String planAccion = '';
  String observacion = "";
  String? otroTexto;
  String? id;
  String codigo = '';
  String? selectedLoteId = '';
  String loteId = '';
  String? selectedmedidas = '80x190';
  String medida = '80x190';
  List<String> imageUrls = [];
  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getLotes();

    id = widget.colchon?.id;
    codigo = widget.colchon?.codigo ?? '';
    //lote = widget.colchon?.lote;

    // Resto de las propiedades del colchón...

    // Verificar si hay valores definidos en el widget inicial
    if (widget.colchon != null) {
      final colchon = widget.colchon!;
      bordeTapaOndulado = colchon.bordeTapaOndulado ?? true;
      esquinaColSobresalida = colchon.esquinaColSobresalida ?? true;
      esquinaTapaMalformada = colchon.esquinaTapaMalformada ?? true;
      hiloSueltoReata = colchon.hiloSueltoReata ?? true;
      hiloSueltoRemate = colchon.hiloSueltoRemate ?? true;
      hiloSueltoAlcochado = colchon.hiloSueltoAlcochado ?? true;
      hiloSueltoInterior = colchon.hiloSueltoInterior ?? true;
      puntaSaltadaReata = colchon.puntaSaltadaReata ?? true;
      reataRasgadaEnganchada = colchon.reataRasgadaEnganchada ?? true;
      tipoRemateInadecuado = colchon.tipoRemateInadecuado ?? true;
      telaEspumaSalidaReata = colchon.telaEspumaSalidaReata ?? true;
      tapaDescuadrada = colchon.tapaDescuadrada ?? true;
      telaRasgada = colchon.telaRasgada ?? true;
      ninguno = colchon.ninguno ?? true;
      otros = colchon.otros ?? true;
      medida = colchon.medidas ?? "80x190";
      selectedmedidas = colchon.medidas ?? "80x190";
      intTotal = colchon.intTotal ?? 0;
      presenciaHiloSuelto = colchon.presenciaHiloSuelto ?? true;
      planAccion = colchon.planAccion ?? "";
      observacion = colchon.observacion ?? "";
    }
  }

  Future<void> _uploadImages() async {
    final imageFiles = await pickImagesFromLibrary();

    if (imageFiles.isNotEmpty) {
      for (final imageFile in imageFiles) {
        try {
          final newImageUrl = await uploadToCloudinary(imageFile);
          setState(() {
            imageUrls.add(newImageUrl);
          });
          print('URL de la foto: $newImageUrl');
        } catch (error) {
          print('Error al subir la foto: $error');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colchonesProvider =
        Provider.of<ColchonesProvider>(context, listen: false);
    final provider = Provider.of<CategoriesProvider>(context, listen: false);
    final lotes = Provider.of<CategoriesProvider>(context).lotes;
    if (lotes.isNotEmpty) selectedLoteId = lotes[0].id;
    List<String> medidas = [
      "80x190",
      "90x190",
      "105x190",
      "135x190",
      "160x200",
      "200x200"
    ];
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      height: size.height,
      width: size.width * 0.5,
      decoration: buildBoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.colchon?.codigo ?? 'Nuevo Colchón',
                  style: CustomLabels.h1.copyWith(color: Colors.black),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Fallos',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Borde Tapa Ondulado',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: bordeTapaOndulado,
                                onChanged: (bool? value) {
                                  setState(() {
                                    bordeTapaOndulado = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Esquina Tapa Malformada',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: esquinaTapaMalformada,
                                onChanged: (bool? value) {
                                  setState(() {
                                    esquinaTapaMalformada = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Hilo Suelto Reata',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: hiloSueltoReata,
                                onChanged: (bool? value) {
                                  setState(() {
                                    hiloSueltoReata = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Hilo Suelto Remate',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: hiloSueltoRemate,
                                onChanged: (bool? value) {
                                  setState(() {
                                    hiloSueltoRemate = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Hilo Suelto Alcochado',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: hiloSueltoAlcochado,
                                onChanged: (bool? value) {
                                  setState(() {
                                    hiloSueltoAlcochado = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Hilo Suelto Interior',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: hiloSueltoInterior,
                                onChanged: (bool? value) {
                                  setState(() {
                                    hiloSueltoInterior = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Reata Rasgada Enganchada',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: reataRasgadaEnganchada,
                                onChanged: (bool? value) {
                                  setState(() {
                                    reataRasgadaEnganchada = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Tipo Remate Inadecuado',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: tipoRemateInadecuado,
                                onChanged: (bool? value) {
                                  setState(() {
                                    tipoRemateInadecuado = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Tela Espuma Salida Reata',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: telaEspumaSalidaReata,
                                onChanged: (bool? value) {
                                  setState(() {
                                    telaEspumaSalidaReata = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Tapa Descuadrada',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: tapaDescuadrada,
                                onChanged: (bool? value) {
                                  setState(() {
                                    tapaDescuadrada = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Tela Rasgada',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: telaRasgada,
                                onChanged: (bool? value) {
                                  setState(() {
                                    telaRasgada = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Punta salteada reata',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: puntaSaltadaReata,
                                onChanged: (bool? value) {
                                  setState(() {
                                    puntaSaltadaReata = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Presencia Hilo Suelto',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: presenciaHiloSuelto,
                                onChanged: (bool? value) {
                                  setState(() {
                                    presenciaHiloSuelto = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Ninguno',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: ninguno,
                                onChanged: (bool? value) {
                                  setState(() {
                                    ninguno = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  'Otros',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: otros,
                                onChanged: (bool? value) {
                                  setState(() {
                                    otros = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      // Resto de los campos del formulario para el colchón...
                    ],
                  ),
                ],
              ),
            ),

            if (otros != false) SizedBox(height: 30),

            if (otros != false)
              TextFormField(
                initialValue: otroTexto,
                onChanged: (value) => otroTexto = value,
                decoration: CustomInputs.loginInputDecoration(
                  hint: 'Describa el fallo',
                  label: 'Otro fallo',
                  icon: Icons.comment,
                ),
                style: TextStyle(color: Colors.black),
              ),

            SizedBox(height: 30),

            TextFormField(
              initialValue: codigo,
              onChanged: (value) => codigo = value,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d+')),
              ],
              decoration: CustomInputs.loginInputDecoration(
                hint: 'Código',
                label: 'Código',
                icon: Icons.assignment,
              ),
              style: TextStyle(color: Colors.black),
              maxLength: 10,
            ),

            SizedBox(height: 10),

            TextFormField(
              initialValue: planAccion,
              onChanged: (value) => planAccion = value,
              decoration: CustomInputs.loginInputDecoration(
                hint: 'Plan de Acción',
                label: 'Plan de Acción',
                icon: Icons.assignment,
              ),
              style: TextStyle(color: Colors.black),
            ),

            SizedBox(height: 30),

            TextFormField(
              initialValue: observacion,
              onChanged: (value) => observacion = value,
              decoration: CustomInputs.loginInputDecoration(
                hint: 'Observación',
                label: 'Observación',
                icon: Icons.comment,
              ),
              style: TextStyle(color: Colors.black),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 15, right: 5),
                    child: TextFormField(
                      //textAlign: TextAlign.end,
                      initialValue: filtro,
                      onChanged: (value) async {
                        filtro = value;
                        await provider.getLotesFiltro(filtro);
                      },
                      keyboardType: TextInputType.text,
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Buscar lote',
                        label: 'Buscar lote',
                        icon: Icons.search,
                      ),
                      style: TextStyle(color: Colors.black),
                      maxLength: 10, // Set maximum input length to 7 characters
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedLoteId,
                    dropdownColor: Colors.white,
                    items: lotes.map((lote) {
                      return DropdownMenuItem<String>(
                        value: lote.id,
                        child: Text(
                          lote.codigo,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLoteId = value;
                        loteId = value.toString();
                        print(loteId);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Lote',
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
                ),
              ],
            ),
            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedmedidas,
              dropdownColor: Colors.white,
              items: medidas.map((medida) {
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
                  selectedmedidas = value;
                  medida = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'medidas',
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

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: _uploadImages,
              child: Text('Cargar imágenes'),
            ),

            SizedBox(height: 10),

            //IMAGEN
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: imageUrls
                  .map((imageUrl) => Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Resto de los campos del formulario para el colchón...
            Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: lotes.isNotEmpty
                    ? CustomOutlinedButton(
                        onPressed: () async {
                          try {
                            if (loteId == "") {
                              NotificationsService.showSnackbarError(
                                  'Seleccione el lote');
                              return;
                            }
                            print(imageUrls);

                            if (id == null) {
                              // Crear
                              await colchonesProvider.newColchon(
                                  Colchones(
                                      estado: true,
                                      bordeTapaOndulado: bordeTapaOndulado,
                                      esquinaColSobresalida:
                                          esquinaColSobresalida,
                                      esquinaTapaMalformada:
                                          esquinaTapaMalformada,
                                      hiloSueltoReata: hiloSueltoReata,
                                      hiloSueltoRemate: hiloSueltoRemate,
                                      hiloSueltoAlcochado: hiloSueltoAlcochado,
                                      hiloSueltoInterior: hiloSueltoInterior,
                                      puntaSaltadaReata: puntaSaltadaReata,
                                      reataRasgadaEnganchada:
                                          reataRasgadaEnganchada,
                                      tipoRemateInadecuado:
                                          tipoRemateInadecuado,
                                      telaEspumaSalidaReata:
                                          telaEspumaSalidaReata,
                                      tapaDescuadrada: tapaDescuadrada,
                                      telaRasgada: telaRasgada,
                                      ninguno: ninguno,
                                      otros: otros,
                                      intTotal: intTotal,
                                      presenciaHiloSuelto: presenciaHiloSuelto,
                                      planAccion: planAccion,
                                      observacion: observacion,
                                      id: "0",
                                      codigo: codigo,
                                      lote: Lote(
                                          id: loteId,
                                          codigo: codigo,
                                          modelo: "modelo"),
                                      usuario: Usuario(id: "0", nombre: "0"),
                                      img: imageUrls,
                                      fechaIngreso: DateTime.now(),
                                      medidas: medida),
                                  otroTexto);
                              NotificationsService.showSnackbar('Creado!');
                            } else {
                              // Actualizar
                              NotificationsService.showSnackbar('Actualizado!');
                            }

                            Navigator.of(context).pop();
                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError(
                                'No se pudo guardar el colchón');
                          }
                        },
                        text: 'Guardar',
                        color: Colors.white,
                      )
                    : Text(
                        "Lotes vacio",
                        style: TextStyle(color: Colors.white),
                      )),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black26)]);
  Future<List<html.File>> pickImagesFromLibrary() async {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.multiple = true;
    input.click();

    await input.onChange.first;

    if (input.files!.isNotEmpty) {
      return input.files!;
    }

    return [];
  }
}

const cloudName = 'darqvpjtk';
const apiKey = '434675434518466';
const apiSecret = 'OgXh4l0qh_7mriMCxu2b0FP0vQU';
const uploadPreset =
    'lwa56ryv'; // Replace 'tu_upload_preset' with your own Cloudinary upload preset

Future<String> uploadToCloudinary(html.File imageFile) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(imageFile);
  await reader.onLoad.first; // Wait for the reader to load the file

  final buffer = reader.result as Uint8List;

  final uri =
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
  final request = http.MultipartRequest('POST', uri);

  final multipartFile = http.MultipartFile.fromBytes(
    'file',
    buffer,
    filename: imageFile.name,
  );

  request.fields['upload_preset'] = uploadPreset;
  request.files.add(multipartFile);

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();
  print(responseBody);

  if (response.statusCode == 200) {
    // Parse the JSON response
    final jsonData = jsonDecode(responseBody);
    final imageUrl = jsonData['secure_url'];

    return imageUrl;
  } else {
    throw Exception('Error uploading photo to Cloudinary');
  }
}
