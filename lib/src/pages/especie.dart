import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;


class Especie extends StatelessWidget {
  const Especie({super.key});

  @override
  Widget build(BuildContext context) {
  
  return Scaffold(
  appBar: AppBar(
    title: Text("Especies"),
  ),
  body: Stack(
    children: [
      GestureDetector(
        onTap: () {
          // Función para mostrar el primer encabezado en pantalla completa
        },
        child: Container(
          color: Colors.red,
          child: const Text("Familia"),
        ),
      ),
      GestureDetector(
        onTap: () {
          // Función para mostrar el segundo encabezado en pantalla completa
        },
        child: Container(
          color: Colors.green,
          child: const Text("Género"),
        ),
      ),
      GestureDetector(
        onTap: () {
          // Función para mostrar el tercer encabezado en pantalla completa
        },
        child: Container(
          color: Colors.blue,
          child: const Text("Especie"),
        ),
      ),
    ],
  ),
);
    
  }
}