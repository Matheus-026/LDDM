import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dados/habitos_repositorio.dart';
import 'dados/preferencias.dart';
import 'dominio/habitos_store.dart';
import 'ui/tela_detalhada.dart';
import 'ui/tela_novo_habito.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => HabitosStore(HabitosRepositorio())..carregar(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _preferencias = Preferencias();
  bool _temaEscuro = false;

  @override
  void initState() {
    super.initState();
    _preferencias.lerTema().then((valor) {
      if (mounted) setState(() => _temaEscuro = valor);
    });
  }

  void _alternarTema() {
    final novoValor = !_temaEscuro;
    setState(() => _temaEscuro = novoValor);
    _preferencias.salvarTema(novoValor);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1B5377),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xFF1B5377),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        themeMode: _temaEscuro ? ThemeMode.dark : ThemeMode.light,
        home: TelaHabitos(
          temaEscuro: _temaEscuro,
          aoAlternarTema: _alternarTema,
        ),
      );
}

class TelaHabitos extends StatefulWidget {
  const TelaHabitos({
    super.key,
    required this.temaEscuro,
    required this.aoAlternarTema,
  });

  final bool temaEscuro;
  final VoidCallback aoAlternarTema;

  @override
  State<TelaHabitos> createState() => _TelaHabitosState();
}

class _TelaHabitosState extends State<TelaHabitos> {
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    context.read<HabitosStore>().carregar().then((_) {
      if (mounted) setState(() => _carregando = false);
    });
  }

  void _abrirNovoHabito() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TelaNovoHabito()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habitos = context.watch<HabitosStore>().habitos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: widget.temaEscuro ? 'Tema claro' : 'Tema escuro',
            icon: Icon(
              widget.temaEscuro ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.aoAlternarTema,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirNovoHabito,
        child: const Icon(Icons.add),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
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
                      ? const Center(child: Text('Nenhum hábito ainda'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: habitos.length,
                          itemBuilder: (context, i) {
                            final h = habitos[i];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
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
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  child: Icon(
                                    h.icone,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
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