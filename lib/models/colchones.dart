// To parse this JSON data, do
//
//     final colchones = colchonesFromMap(jsonString);

import 'dart:convert';

class Colchones {
    bool estado;
    bool bordeTapaOndulado;
    bool esquinaColSobresalida;
    bool esquinaTapaMalformada;
    bool hiloSueltoReata;
    bool hiloSueltoRemate;
    bool hiloSueltoAlcochado;
    bool hiloSueltoInterior;
    bool puntaSaltadaReata;
    bool reataRasgadaEnganchada;
    bool tipoRemateInadecuado;
    bool telaEspumaSalidaReata;
    bool tapaDescuadrada;
    bool telaRasgada;
    bool ninguno;
    bool otros;
    int intTotal;
    bool presenciaHiloSuelto;
    String planAccion;
    String medidas;
    String observacion;
    String id;
    String codigo;
    String? texto_otro;
    Lote lote;
    Usuario usuario;
    List<String> img;
    DateTime fechaIngreso;

    Colchones({
        required this.estado,
        required this.medidas,
        required this.bordeTapaOndulado,
        required this.esquinaColSobresalida,
        required this.esquinaTapaMalformada,
        required this.hiloSueltoReata,
        required this.hiloSueltoRemate,
        required this.hiloSueltoAlcochado,
        required this.hiloSueltoInterior,
        required this.puntaSaltadaReata,
        required this.reataRasgadaEnganchada,
        required this.tipoRemateInadecuado,
        required this.telaEspumaSalidaReata,
        required this.tapaDescuadrada,
        required this.telaRasgada,
        required this.ninguno,
        required this.otros,
        required this.intTotal,
        required this.presenciaHiloSuelto,
        required this.planAccion,
        required this.observacion,
        required this.id,
        required this.codigo,
        required this.lote,
         this.texto_otro,
        required this.usuario,
        required this.img,
        required this.fechaIngreso,
    });

    factory Colchones.fromJson(String str) => Colchones.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Colchones.fromMap(Map<String, dynamic> json) => Colchones(
        estado: json["estado"],
        bordeTapaOndulado: json["bordeTapaOndulado"],
        medidas: json["medidas"],
        esquinaColSobresalida: json["esquinaColSobresalida"],
        esquinaTapaMalformada: json["esquinaTapaMalformada"],
        hiloSueltoReata: json["hiloSueltoReata"],
        hiloSueltoRemate: json["hiloSueltoRemate"],
        hiloSueltoAlcochado: json["hiloSueltoAlcochado"],
        hiloSueltoInterior: json["hiloSueltoInterior"],
        puntaSaltadaReata: json["puntaSaltadaReata"],
        reataRasgadaEnganchada: json["reataRasgadaEnganchada"],
        tipoRemateInadecuado: json["tipoRemateInadecuado"],
        telaEspumaSalidaReata: json["telaEspumaSalidaReata"],
        tapaDescuadrada: json["tapaDescuadrada"],
        telaRasgada: json["telaRasgada"],
        ninguno: json["ninguno"],
        otros: json["otros"],
        intTotal: json["intTotal"],
        presenciaHiloSuelto: json["presenciaHiloSuelto"],
        planAccion: json["planAccion"],
        texto_otro:json["texto_otro"],
        observacion: json["observacion"],
        id: json["_id"],
        codigo: json["codigo"],
        lote: Lote.fromMap(json["lote"]),
        usuario: Usuario.fromMap(json["usuario"]),
         img: List<String>.from(json["img"]),
         fechaIngreso: DateTime.parse(json["fechaIngreso"]),
    );

    Map<String, dynamic> toMap() => {
        "estado": estado,
        "bordeTapaOndulado": bordeTapaOndulado,
        "medidas":medidas,
        "esquinaColSobresalida": esquinaColSobresalida,
        "esquinaTapaMalformada": esquinaTapaMalformada,
        "hiloSueltoReata": hiloSueltoReata,
        "hiloSueltoRemate": hiloSueltoRemate,
        "hiloSueltoAlcochado": hiloSueltoAlcochado,
        "hiloSueltoInterior": hiloSueltoInterior,
        "puntaSaltadaReata": puntaSaltadaReata,
        "reataRasgadaEnganchada": reataRasgadaEnganchada,
        "tipoRemateInadecuado": tipoRemateInadecuado,
        "telaEspumaSalidaReata": telaEspumaSalidaReata,
        "tapaDescuadrada": tapaDescuadrada,
        "telaRasgada": telaRasgada,
        "ninguno": ninguno,
        "otros": otros,
        "intTotal": intTotal,
        "presenciaHiloSuelto": presenciaHiloSuelto,
        "planAccion": planAccion,
        "texto_otro":texto_otro,
        "observacion": observacion,
        "_id": id,
        "codigo": codigo,
        "lote": lote.toMap(),
        "usuario": usuario.toMap2(),
        "img": img,
        "fechaIngreso": fechaIngreso.toIso8601String(),
    };
}




class Lote {
    String id;
    String codigo;
    String modelo;

    Lote({
        required this.id,
        required this.codigo,
        required this.modelo,
    });

    factory Lote.fromJson(String str) => Lote.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Lote.fromMap(Map<String, dynamic> json) => Lote(
        id: json["_id"],
        codigo: json["codigo"],
        modelo: json["modelo"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "codigo": codigo,
        "modelo":modelo
    };
    
}
class Usuario {
    String id;
    String nombre;

    Usuario({
        required this.id,
        required this.nombre,
    });

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap2());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap2() => {
        "_id": id,
        "nombre": nombre,
    };
    
}
