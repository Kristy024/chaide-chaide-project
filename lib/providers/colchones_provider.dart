import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:flutter/material.dart';

import '../models/colchones.dart';
import '../models/http/colchones_response.dart';

class ColchonesProvider extends ChangeNotifier {
  List<Colchones> colchones = [];
  List<String> modelos=[];
  getColchones() async {
    final resp = await CafeApi.httpGet('/colchones');
    final colchonesResp = ColchonesResponse.fromMap(resp);

    this.colchones = [...colchonesResp.colchones];



    notifyListeners();
  }
 
     Future<void> getColchonesFiltro(String filtro) async {
    final resp = await CafeApi.httpGet('/colchones');
    final colchonesResp = ColchonesResponse.fromMap(resp);

    if (filtro.isEmpty) {
      // Si el filtro es una cadena vacía, guardar todos los lotes
          this.colchones = [...colchonesResp.colchones];
    } else {
      // Si hay un filtro, guardar solo los lotes que coinciden con el criterio
      this.colchones = colchonesResp.colchones.where((colchon) {
        // Aquí debes implementar tu lógica de filtrado basado en el filtro y las propiedades del lote
        // Por ejemplo, si el lote contiene el filtro en el nombre o en alguna otra propiedad.
        // Por simplicidad, aquí solo verifico si el nombre del lote contiene el filtro (ignorando mayúsculas y minúsculas).
        return colchon.codigo.toLowerCase().contains(filtro.toLowerCase());
      }).toList();
    }


    notifyListeners();
  }
       Future<void> getColchonesFiltroModelo(String filtro) async {
    final resp = await CafeApi.httpGet('/colchones');
    final colchonesResp = ColchonesResponse.fromMap(resp);

    if (filtro.isEmpty) {
      // Si el filtro es una cadena vacía, guardar todos los lotes
          this.colchones = [...colchonesResp.colchones];
    } else {
      // Si hay un filtro, guardar solo los lotes que coinciden con el criterio
      this.colchones = colchonesResp.colchones.where((colchon) {
        // Aquí debes implementar tu lógica de filtrado basado en el filtro y las propiedades del lote
        // Por ejemplo, si el lote contiene el filtro en el nombre o en alguna otra propiedad.
        // Por simplicidad, aquí solo verifico si el nombre del lote contiene el filtro (ignorando mayúsculas y minúsculas).
        return colchon.lote.modelo.toLowerCase().contains(filtro.toLowerCase());
      }).toList();
    }


    notifyListeners();
  }
        Future<void> getColchonesFiltroCodigo(String filtro) async {
    final resp = await CafeApi.httpGet('/colchones');
    final colchonesResp = ColchonesResponse.fromMap(resp);

    if (filtro.isEmpty) {
      // Si el filtro es una cadena vacía, guardar todos los lotes
          this.colchones = [...colchonesResp.colchones];
    } else {
      // Si hay un filtro, guardar solo los lotes que coinciden con el criterio
      this.colchones = colchonesResp.colchones.where((colchon) {
        // Aquí debes implementar tu lógica de filtrado basado en el filtro y las propiedades del lote
        // Por ejemplo, si el lote contiene el filtro en el nombre o en alguna otra propiedad.
        // Por simplicidad, aquí solo verifico si el nombre del lote contiene el filtro (ignorando mayúsculas y minúsculas).
        return colchon.lote.codigo.toLowerCase().contains(filtro.toLowerCase());
      }).toList();
    }


    notifyListeners();
  }
     Future<void> getModeloColchones() async {
  Set<String> modelosUnicos = {}; // Utiliza un conjunto en lugar de una lista

  final resp = await CafeApi.httpGet('/colchones');
  final colchonesResp = ColchonesResponse.fromMap(resp);

  colchonesResp.colchones.forEach((element) {
    modelosUnicos.add(element.lote.modelo); // Agrega el modelo al conjunto
  });

  modelos.clear();
  modelos.addAll(modelosUnicos.toList()); // Convierte el conjunto en una lista y agrega los elementos a 'modelos'

  notifyListeners();
}


  Future newColchon(Colchones colchone,String? otrosTexto) async {
      print(colchone.medidas);
      if(otrosTexto==null){
        otrosTexto="";
      }
        final data = {
      "codigo": colchone.codigo,
      "bordeTapaOndulado": colchone.bordeTapaOndulado,
      "esquinaColSobresalida": colchone.esquinaColSobresalida,
      "esquinaTapaMalformada": colchone.esquinaTapaMalformada,
      "hiloSueltoReata": colchone.hiloSueltoReata,
      "hiloSueltoRemate": colchone.hiloSueltoRemate,
      "hiloSueltoAlcochado": colchone.hiloSueltoAlcochado,
      "hiloSueltoInterior": colchone.hiloSueltoInterior,
      "puntaSaltadaReata": colchone.puntaSaltadaReata,
      "reataRasgadaEnganchada": colchone.reataRasgadaEnganchada,
      "tipoRemateInadecuado": colchone.tipoRemateInadecuado,
      "telaEspumaSalidaReata": colchone.telaEspumaSalidaReata,
      "tapaDescuadrada": colchone.tapaDescuadrada,
      "telaRasgada": colchone.telaRasgada,
      "ninguno": colchone.ninguno,
      "observacion":colchone.observacion,
      "planAccion": colchone.planAccion,
      "presenciaHiloSuelto":colchone.presenciaHiloSuelto,
      "otros": colchone.otros,
      "lote":colchone.lote.id,
      "medidas":colchone.medidas,
      "img":colchone.img,
      "texto_otro":otrosTexto
    };

    try {
      final json = await CafeApi.post('/colchones', data);
      print(json);
      final newColchon = Colchones.fromMap(json);

      colchones.add(newColchon);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear colchón';
    }
  }

  Future updateColchon(Colchones colchone) async {
  try {
      final json = colchone.toMap();
      await CafeApi.put('/colchones/${colchone.id}', json);

      final index =
          colchones.indexWhere((c) => c.id == colchone.id);
      if (index >= 0) {
        colchones[index] = colchone;
      }

      notifyListeners();
    } catch (e) {
      throw 'Error updating colchon: $e';
    }
  }

    Future<Colchones?> getColchonById( String uid ) async {
    
    try {
      final resp = await CafeApi.httpGet('/colchones/$uid');
      final colchon = Colchones.fromMap(resp);
      return colchon;
      
    } catch (e) {
      return null;
    }
  }

  Future deleteColchon(String id) async {
    print("el id es '$id'");

    try {
      await CafeApi.delete('/colchones/$id', {});

      colchones.removeWhere((colchon) => colchon.id == id);

      notifyListeners();
    } catch (e) {
      print('Error al eliminar colchón');
    }
  }
}
