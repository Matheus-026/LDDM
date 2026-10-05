import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dados/habitos_repositorio.dart';
import 'dominio/habitos_store.dart';
import 'ui/tela_detalhada.dart';
import 'ui/tela_novo_habito.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => HabitosStore(HabitosRepositorio()),
        child: const MyApp(),
      ),
    );

class Habito {
  final String nome, meta, descricao;
  final IconData icone;

  const Habito(this.nome, this.meta, this.icone, {this.descricao = ''});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1B5377),
          useMaterial3: true,
        ),
        home: const TelaHabitos(),
      );
}

class TelaHabitos extends StatefulWidget {
  const TelaHabitos({super.key});

  @override
  State<TelaHabitos> createState() => _TelaHabitosState();
}

class _TelaHabitosState extends State<TelaHabitos> {
  bool _carregando = true;

  @override
  void initState() {
    super.initState();

    context.read<HabitosStore>().carregar().then((_) {
      if (mounted) {
        setState(() => _carregando = false);
      }
    });
  }

  void _abrirNovoHabito() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TelaNovoHabito(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habitos = context.watch<HabitosStore>().habitos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirNovoHabito,
        child: const Icon(Icons.add),
      ),
      body: _carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${habitos.length} hábitos',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: habitos.isEmpty
                      ? const Center(
                          child: Text('Nenhum hábito ainda'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: habitos.length,
                          itemBuilder: (context, i) {
                            final h = habitos[i];

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          TelaDetalhesHabito(habito: h),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  child: Icon(
                                    h.icone,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                title: Text(h.nome),
                                subtitle: Text('Meta: ${h.meta}'),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}