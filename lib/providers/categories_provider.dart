import 'package:admin_dashboard/models/http/lotes_response.dart';
import 'package:admin_dashboard/models/lotes.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/CafeApi.dart';

import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';

class CategoriesProvider extends ChangeNotifier {

  List<Categoria> categorias = [];
  List<Lotes> lotes = [];

  getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);

    this.categorias = [...categoriesResp.categorias];

    print( this.categorias );

    notifyListeners();
  }
  getLotes() async {
    final resp2 = await CafeApi.httpGet('/lotes');
    final lotesResp = LotesResponse.fromMap(resp2);

    this.lotes = [...lotesResp.lotes];
    
    print( this.lotes );

    notifyListeners();
  }

    Future<void> getLotesFiltro(String filtro) async {
    final resp2 = await CafeApi.httpGet('/lotes');
    final lotesResp = LotesResponse.fromMap(resp2);

    if (filtro.isEmpty) {
      // Si el filtro es una cadena vacía, guardar todos los lotes
      this.lotes = [...lotesResp.lotes];
    } else {
      // Si hay un filtro, guardar solo los lotes que coinciden con el criterio
      this.lotes = lotesResp.lotes.where((lote) {
        // Aquí debes implementar tu lógica de filtrado basado en el filtro y las propiedades del lote
        // Por ejemplo, si el lote contiene el filtro en el nombre o en alguna otra propiedad.
        // Por simplicidad, aquí solo verifico si el nombre del lote contiene el filtro (ignorando mayúsculas y minúsculas).
        return lote.codigo.toLowerCase().contains(filtro.toLowerCase());
      }).toList();
    }


    notifyListeners();
  }


    Future newLote( String name,String codigo,String modelo,bool estado,int stock ) async {

    final data = {
      'nombre': name,
      "codigo": codigo,
      "modelo": modelo,
      "stock":stock,
    };

    try {

      final json = await CafeApi.post('/lotes', data );
      print(json);
      final newLote = Lotes.fromMap(json);

      print(newLote);
      lotes.add( newLote );
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear lotes';
    }

  }
Future updateLotes( String id,  String name,String codigo,String modelo,bool estado,int stock ) async {

     final data = {
      'nombre': name,
      "codigo": codigo,
      "modelo": modelo,
      "stock":stock,
      "estadoRevision":estado,
    };

    try {

      await CafeApi.put('/lotes/$id', data );
    
      this.lotes = this.lotes.map(
        (lotes) {
          if ( lotes.id != id ) return lotes;
          lotes.nombre = name;
          lotes.codigo = codigo;
          lotes.modelo = modelo;
          lotes.stock = stock;
          lotes.estadoRevision = estado;
          return lotes;
        }
      ).toList();
      
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear lote';
    }

  }




    Future deleteLote( String id ) async {

    try {

      await CafeApi.delete('/lotes/$id', {} );
    
      lotes.removeWhere((lotes) => lotes.id == id );
     
      notifyListeners();
      
      
    } catch (e) {
      print(e);
      print('Error al eliminar lote');
    }

  }

}