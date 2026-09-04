import 'package:flutter/material.dart';
import 'main.dart';

class TelaDetalhesHabito extends StatelessWidget {
  final Habito habito;

  const TelaDetalhesHabito({super.key, required this.habito});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cores.surface,
      appBar: AppBar(
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
        title: Text(
          habito.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cores.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 26,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: cores.onPrimary,
                    child: Text(
                      habito.nome == 'Beber água' ? 'H2O' : '',
                      style: TextStyle(
                        color: cores.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 88,
                  top: 28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habito.nome,
                        style: TextStyle(
                          color: cores.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.local_drink,
                            color: cores.onPrimary,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Meta: ${habito.meta}',
                            style: TextStyle(
                              color: cores.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildEstatisticaCard('12', 'dias seguidos', cores)),
                const SizedBox(width: 12),
                Expanded(child: _buildEstatisticaCard('5 / 8', 'hoje', cores)),
                const SizedBox(width: 12),
                Expanded(child: _buildEstatisticaCard('62%', 'no mês', cores)),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sobre este hábito',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: cores.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      habito.descricao.isNotEmpty ? habito.descricao : 'Nenhuma descrição disponível.',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstatisticaCard(String valor, String rotulo, ColorScheme cores) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: cores.onPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            valor,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cores.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            rotulo,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}