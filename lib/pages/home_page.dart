import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/filme.dart';
import 'package:flutter_application_1/services/omdb_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {

  final TextEditingController controller =
    TextEditingController();

  final OmbdService service = OmbdService();

  List<Filme> filmes =[];

  bool carregando = false;

  Future<void> pesquisar() async {

    setState(() {
      carregando = true;
    });

    filmes =
      await service.buscarFilmes(controller.text,);
    
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget Build(BuildContext context) {
    return const Placeholder();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Digite o filme',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                 icon: Icon(Icons.search),
                 onPressed: pesquisar,
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (carregando) const CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: filmes.length,
                itemBuilder: (context, index) {
                  final filme = filmes[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            filme.poster != 'N/A'
                                ? filme.poster
                                : 'https://via.placeholder.com/100',

                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 150,
                                color: Colors.grey[300],

                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filme.titulo,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text('Ano: ${filme.ano}'),
                                const SizedBox(height: 10),
                                Text(
                                  filme.descricao,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}