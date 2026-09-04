import 'package:flutter/material.dart';
import 'tela_detalhada.dart';

void main() => runApp(MyApp(futuro: carregarHabitos()));

class Habito{
  final String nome, meta, descricao;
  final IconData icone;
  const Habito(this.nome, this.meta, this.icone, {this.descricao = ''});
}

Future<List<Habito>> carregarHabitos() async {
    // simula a demora de um banco de dados ou de um servidor
    await Future.delayed(const Duration(seconds: 4));
  return const [
  Habito('Beber água', '8 copos por dia', Icons.water_drop, descricao: 'Manter-se hidratado é essencial para a saúde. Beber água regularmente ajuda a regular a temperatura do corpo, lubrificar as articulações e eliminar toxinas.'),
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
          colorSchemeSeed: const Color(0xFF1B5377),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaDetalhesHabito(habito: h),
                            ),
                          );
                        },
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
