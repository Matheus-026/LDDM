import 'package:flutter/material.dart';

void main() => runApp(MyApp(futuro: carregarHabitos()));

class Habito{
  final String nome, meta;
  final IconData icone;
  const Habito(this.nome, this.meta, this.icone);
}

Future<List<Habito>> carregarHabitos() async {
    // simula a demora de um banco de dados ou de um servidor
    await Future.delayed(const Duration(seconds: 4));
  return const [
  Habito('Tomar café da manhã', 'De manhã cedo', Icons.free_breakfast),
  Habito('Estudar', '2 matéria por dia', Icons.menu_book),
  Habito('Exercitar', '1 hora e meia por dia', Icons.fitness_center),
  Habito('Dormir', '8 horas por dia', Icons.bedtime),
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.futuro});

  final Future<List<Habito>> futuro;

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: Colors.grey,
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Meus Hábitos'),
            elevation: 0,
          ),
          body: FutureBuilder<List<Habito>>(
            future: futuro,
            builder: (context, snapshot){
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Não foi possível carregar'));
              }
              final habitos = snapshot.data!;
              if (habitos.isEmpty) {
                return const Center(child: Text('Nenhum hábito ainda'));
              }
              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  for(final h in habitos)
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: 
                            Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            h.icone,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          )
                        ),
                        title: Text(h.nome),
                        subtitle: Text('Meta: ${h.meta}'),
                      ),
                    )
                ],
              );
            }
          ),
        ),
      );
  }
