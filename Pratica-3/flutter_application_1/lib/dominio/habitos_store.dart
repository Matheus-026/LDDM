import 'package:flutter/foundation.dart';
import '../dados/habitos_repositorio.dart';
import '../main.dart';

class HabitosStore extends ChangeNotifier {
  HabitosStore(this._repo);
  final HabitosRepositorio _repo;

  List<Habito> _habitos = [];
  List<Habito> get habitos => List.unmodifiable(_habitos);

  Future<void> carregar() async {
    _habitos = await _repo.carregar();
    notifyListeners();
  }

  void adicionar(Habito h) {
    _habitos.add(h);
    _repo.salvar(h);
    notifyListeners();
  }

  void remover(Habito h) {
    _habitos.remove(h);
    _repo.excluir(h);
    notifyListeners();
  }
}