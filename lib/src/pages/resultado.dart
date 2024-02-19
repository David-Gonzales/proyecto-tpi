import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_tpi/src/Dto/resultadoResponse.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;
import '../model/response/evaluacionResponse.dart';

class Resultado extends StatelessWidget {
  const Resultado({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ResultadoResponse resultado = ModalRoute.of(context)!.settings.arguments as ResultadoResponse;
    EvaluacionResponse? resultadoEvaluacion = globals.resultadoEvaluacion;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identificación - Resultados'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 300),
                  placeholder: const AssetImage('assets/carga.gif'), 
                  image: FileImage(File(resultado.foto)), width: 250, height: 250, fit: BoxFit.cover
                ),
                const SizedBox(height: 10,),
                for (var item in resultadoEvaluacion!.resultadoEvaluacion)
                  if(item.animal != "Negativo") 
                    Column(
                      children: [Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Material(
                            color: colors.primary,
                            child: SizedBox(
                              width: size.width,
                              child: Column(
                                children: [
                                  ListTile(
                                  title: Text(item.animal, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                  subtitle: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black12,
                                      ),
                                      child: Center(child: Text("${item.probabilidad}%", style: const TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.right, ))),
                                  ),
                                ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ]
                    ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
