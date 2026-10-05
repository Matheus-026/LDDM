import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dominio/habitos_store.dart';
import '../main.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({super.key});

  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  final _chaveForm = GlobalKey<FormState>();
  final _controleNome = TextEditingController();
  final _controleMeta = TextEditingController();

  @override
  void dispose() {
    _controleNome.dispose();
    _controleMeta.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_chaveForm.currentState!.validate()) {
      final habito = Habito(
        _controleNome.text.trim(),
        _controleMeta.text.trim(),
        Icons.star,
      );
      context.read<HabitosStore>().adicionar(habito);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo hábito'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _chaveForm,
          child: Column(
            children: [
              TextFormField(
                controller: _controleNome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Informe o nome';
                  }
                  if (v.trim().length < 3) {
                    return 'Use ao menos 3 letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _controleMeta,
                decoration: const InputDecoration(
                  labelText: 'Meta diária',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Informe a meta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _salvar,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}