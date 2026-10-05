import 'package:flutter/material.dart';
import '../main.dart';

class HabitosRepositorio {
  final List<Habito> _memoria = [
    const Habito(
      'Beber água',
      '8 copos por dia',
      Icons.water_drop,
      descricao:
          'Manter-se hidratado é essencial para a saúde. Beber água regularmente ajuda a regular a temperatura do corpo, lubrificar as articulações e eliminar toxinas.',
    ),
    const Habito('Estudar', '2 matéria por dia', Icons.menu_book),
    const Habito('Exercitar', '1 hora e meia por dia', Icons.fitness_center),
    const Habito('Dormir', '8 horas por dia', Icons.bedtime),
  ];

  Future<List<Habito>> carregar() async {
    await Future.delayed(const Duration(seconds: 4));
    return List.of(_memoria);
  }

  Future<void> salvar(Habito h) async {
    _memoria.add(h);
  }

  Future<void> excluir(Habito h) async {
    _memoria.remove(h);
  }
}