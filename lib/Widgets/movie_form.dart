import 'package:flutter/material.dart';
import 'package:parcial2/movie_class.dart';
import 'package:parcial2/util/text_num_input.dart';
import 'package:parcial2/util/success_dialog.dart';
import 'package:parcial2/DB/db_sql.dart';

class MovieForm extends StatefulWidget {

  const MovieForm({ Key? key}) : super(key: key);

  @override
  State<MovieForm> createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();

  final List<String> generos = [
  'Accion',
  'Drama',
  'Misterio',
  'Terror',
  ];

  @override
  Widget build(BuildContext context) {
    String genero = generos.isNotEmpty ? generos[0] : '';
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 90.0),
                  child: const Text(
                    'Agregar Movie',
                    style: TextStyle(
                      fontSize:
                          37, 
                      fontWeight: FontWeight
                          .bold, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                inputAbstracto(
                    controller: _codigoController,
                    labelText: 'CÓDIGO DE PELICULA'),
                const SizedBox(height: 10),
                inputAbstracto(
                    controller: _nombreController,
                    labelText: 'NOMBRE DE PELICULA'),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: genero, // Guarda el género seleccionado
                  onChanged: (newValue) {
                    setState(() {
                      genero = newValue.toString();
                    });
                  },
                  items: generos.map((genero) {
                    return DropdownMenuItem<String>(
                      value: genero,
                      child: Text(genero),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'GENERO DE PELICULA',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecciona un género de película';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                inputAbstracto(
                    controller: _directorController,
                    labelText: 'NOMBRE DE DIRECTOR'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      final movie = Movie(
                        id: 0,
                        codigo: _codigoController.text,
                        nombre: _nombreController.text,
                        genero: genero,
                        director: _directorController.text,
                      );

                      
                      DatabaseHelper dbHelper = DatabaseHelper();

                      await dbHelper.insertMovie(movie);

                      success(context, 'Successful save');
                      // Limpiar los campos del formulario
                      _codigoController.clear();
                      _nombreController.clear();
                      _directorController.clear();
                    }
                  },
                  child: const Text('Save Movie'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

