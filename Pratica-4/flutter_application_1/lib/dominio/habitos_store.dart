import 'package:flutter/foundation.dart';
import '../dados/habitos_repositorio.dart';
import 'habito.dart';

class HabitosStore extends ChangeNotifier {
  HabitosStore(this._repo);
  final HabitosRepositorio _repo;

  List<Habito> _habitos = [];
  List<Habito> get habitos => List.unmodifiable(_habitos);

  Future<void> carregar() async {
    _habitos = await _repo.carregar();
    notifyListeners();
  }

  Future<void> adicionar(Habito h) async {
    final id = await _repo.salvar(h);
    _habitos.add(
      Habito(h.nome, h.meta, h.icone, descricao: h.descricao, id: id),
    );
    notifyListeners();
  }

  void remover(Habito h) {
    _habitos.remove(h);
    _repo.excluir(h.id!);
    notifyListeners();
  }
}