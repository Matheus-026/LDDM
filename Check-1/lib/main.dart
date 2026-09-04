import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Filme {
  final String titulo, diretor;
  final int minutos;
  final IconData icone;
  const Filme(this.titulo, this.diretor, this.minutos, {this.icone = Icons.movie});
}

const List<Filme> listaDeFilmes = [
  Filme('Cidade de Deus', 'Fernando Meirelles', 130),
  Filme('A Chegada', 'Denis Villeneuve', 116),
  Filme('Bacurau', 'Kleber Mendonça Filho', 131),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1B5377),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Filmes'),
            elevation: 0,
            backgroundColor: const Color(0xFF1B5377),
            foregroundColor: Colors.white,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.search),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                color: const Color.fromARGB(255, 213, 213, 213),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  '${listaDeFilmes.length} Filmes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: const Color(0xFF1B5377),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    for (final f in listaDeFilmes)
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          onTap: null,
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(
                              f.icone,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          title: Text(f.titulo),
                          subtitle: Text('${f.diretor} · ${f.minutos} minutos'),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}