export 'movie_class.dart';

class Movie {
  int id;
  String codigo;
  String nombre;
  String genero;
  String director;

  Movie({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.genero,
    required this.director,
  });

  // Método para convertir un objeto Product a un mapa
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'genero': genero,
      'director': director,
    };
  }

  // Método para crear un objeto Product a partir de un mapa
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      codigo: map['codigo'],
      nombre: map['nombre'],
      genero: map['genero'],
      director: map['director'],
    );
  }
}
