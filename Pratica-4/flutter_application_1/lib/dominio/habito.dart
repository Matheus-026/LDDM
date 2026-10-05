import 'package:flutter/material.dart';

class Habito {
  final int? id;
  final String nome, meta, descricao;
  final IconData icone;

  const Habito(
    this.nome,
    this.meta,
    this.icone, {
    this.descricao = '',
    this.id,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'nome': nome,
        'meta': meta,
        'descricao': descricao,
        'icone': icone.codePoint,
      };

  factory Habito.fromMap(Map<String, Object?> m) => Habito(
        m['nome'] as String,
        m['meta'] as String,
        IconData(m['icone'] as int, fontFamily: 'MaterialIcons'),
        descricao: m['descricao'] as String? ?? '',
        id: m['id'] as int?,
      );
}