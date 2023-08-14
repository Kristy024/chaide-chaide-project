// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromMap(jsonString);
import 'dart:convert';

import 'package:admin_dashboard/models/colchones.dart';



class ColchonesResponse {
    ColchonesResponse({
        required this.total,
        required this.colchones,
    });

    int total;
    List<Colchones> colchones;

    factory ColchonesResponse.fromJson(String str) => ColchonesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ColchonesResponse.fromMap(Map<String, dynamic> json) => ColchonesResponse(
        total: json["total"],
        colchones: List<Colchones>.from(json["colchones"].map((x) => Colchones.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "colchones": List<dynamic>.from(colchones.map((x) => x.toMap())),
    };
}


