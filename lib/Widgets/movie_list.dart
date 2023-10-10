import 'package:flutter/material.dart';
import 'package:parcial2/DB/db_sql.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final List<Map<String, dynamic>> movies = [];

  @override
  void initState() {
    super.initState();
    _cargarMovieos();
  }

  Future<void> _cargarMovieos() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    final listaDeMovieos = await dbHelper.getAllMovies();
    setState(() {
      movies.addAll(listaDeMovieos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        final id = movie['id'];
        final codigo = movie['codigo'];
        final nombre = movie['nombre'];
        final genero = movie['genero'];
        final director = movie['director'];

        return Column(
          children: [
            ListTile(
              title: Text('ID: $id'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Codigo: $codigo'),
                  Text('Nombre: $nombre'),
                  Text('Genero: $genero'),
                  Text('Director: $director'),
                ],
              ),
              // Personaliza la apariencia de cada elemento de la lista aquí
            ),
            const Divider(
              color: Colors.grey, // Color gris para la separación
              thickness: 1.0, // Grosor de la línea divisora
              height: 1.0, // Altura de la línea divisora
            ),
          ],
        );
      },
    );
  }
}

