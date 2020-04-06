import 'dart:convert';

import 'package:dart_week_app/app/models/movimentacao_total_item_model.dart';

class MovimentacaoTotalModel {
  double total;
  double saldo;
  MovimentacaoTotalItemModel receitas;
  MovimentacaoTotalItemModel despesas;
  MovimentacaoTotalModel({
    this.total,
    this.saldo,
    this.receitas,
    this.despesas,
  });

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'saldo': saldo,
      'receitas': receitas.toMap(),
      'despesas': despesas.toMap(),
    };
  }

  static MovimentacaoTotalModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MovimentacaoTotalModel(
      total: map['total'],
      saldo: map['saldo'],
      receitas: MovimentacaoTotalItemModel.fromMap(map['receitas']),
      despesas: MovimentacaoTotalItemModel.fromMap(map['despesas']),
    );
  }

  String toJson() => json.encode(toMap());

  static MovimentacaoTotalModel fromJson(String source) => fromMap(json.decode(source));
}
