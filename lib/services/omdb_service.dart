import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/filme.dart';

class OmbdService {

  final String apikey = 'e539c6c2';

  Future<List<Filme>> buscarFilmes(String nomeFilme) async {

    List<Filme> listarFilmes = [];

    final urlBusca =
      'https://www.omdbapi.com/?s=$nomeFilme&apihey=$apikey';

    final responseBusca =
      await http.get(Uri.parse(urlBusca));
    
    final dadoBusca =
      json.decode(responseBusca.body);

    if (dadoBusca['Search'] != null){
      for (var item in dadoBusca['Search']){

        final imdbID = item['imdbID'];

        final urlDetalhes =
        'https://www.omdbapi.com/?s=$imdbID&plot=short&apikey=$apikey';

        final responseDetalhes =
          await http.get(Uri.parse(urlDetalhes));

        final dadosDetalhes =
          json.decode(responseDetalhes);

        listarFilmes.add(
          Filme.fromJson(dadosDetalhes),
        );
      }
    }
  }
}