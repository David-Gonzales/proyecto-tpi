import 'dart:convert';
import 'dart:io';
import 'package:app_tpi/src/Dto/resultadoResponse.dart';
import 'package:app_tpi/src/model/request/evaluacionRequest.dart';
import 'package:app_tpi/src/model/response/evaluacionResponse.dart';
import 'package:app_tpi/src/services/evaluacionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class Evaluacion extends StatefulWidget {
  const Evaluacion({super.key});

  @override
  State<Evaluacion> createState() => _EvaluacionState();
}

class _EvaluacionState extends State<Evaluacion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imagen;
  String? _nombreEvaluacion = 'Evaluacion';
  bool aceptado = false;
  bool cargando = false;

  EvaluacionResponse? evaluacionResponse;
  ResultadoResponse? resultado;

  Future getImagen(ImageSource source) async {
    try {
      final imagen = await ImagePicker().pickImage(source: source);
      if (imagen == null) return;

      final imagenPermanente = await guardarImagenPermanentemente(imagen.path);
      setState(() {
        _imagen = imagenPermanente;
      });
    } on PlatformException catch (e) {
      alertaMostrarMensajeError(
          titulo: 'Error', mensaje: 'Error en la captura de imagen.');
    }
    evaluacion();
  }

  Future<File> guardarImagenPermanentemente(String imagenPath) async {
    final directorio = await getApplicationDocumentsDirectory();
    final nombre = basename(imagenPath);
    final imagen = File('${directorio.path}/$nombre');

    return File(imagenPath).copy(imagen.path);
  }

  void evaluacion() async {
    setState(() {
      mostrarLoader();
    });

    File imagenReducida = await compressFile(_imagen!);
     Uint8List imagebytes = await imagenReducida.readAsBytes();
    String base64string = base64.encode(imagebytes);
    EvaluacionRequest evaluacionRequest = EvaluacionRequest(nombreEvaluacion: _nombreEvaluacion, idUsuario: globals.datosUsuario?.id, imagen: base64string);
    evaluacionResponse = await EvaluacionService().evaluacion(evaluacionRequest);
    
    // ResultadoEvaluacion a = ResultadoEvaluacion(animal: "Gato", probabilidad: 12);
    // ResultadoEvaluacion b = ResultadoEvaluacion(animal: "Canidae - Canis - Lupues (PERRO)", probabilidad: 100);
    // final List<ResultadoEvaluacion> listaResultadoEvaluacion = [a, b,a, b,a, b,a, b,a, b,];

    // evaluacionResponse = EvaluacionResponse(nombre: "Nombre", fecha: "12/12/12", resultadoEvaluacion: listaResultadoEvaluacion);
    if (evaluacionResponse == null) {
      setState(() {
        Navigator.of(this.context).pop();
      });
      alertaMostrarMensajeError(
          titulo: 'Error',
          mensaje:
              'Imagen no aceptada. Por favor vuelva a ingresar otra imagen.');
      return;
    }

    resultado = ResultadoResponse(imagenReducida.path);
    globals.resultadoEvaluacion = evaluacionResponse;
    globals.listaEvaluaciones = await EvaluacionService().obtenerEvaluaciones(globals.datosUsuario!.id); 
    Navigator.of(this.context).pushReplacementNamed('/resultado', arguments: resultado);
  }

  Future alertaMostrarMensajeError(
      {required String titulo, required String mensaje}) {
    return showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Future mostrarLoader() {
    return showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 40,),
            Text("Realizando evaluación", style: TextStyle(color: Colors.white, fontSize: 18),),
          ],
        );
        });
  }

  Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 50,
    );
    return File(result!.path);
  }

  Future alertaError({required String titulo, required String mensaje}) async {
    return showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () => {
                  setState(() {
                    aceptado = true;
                  }),
                  Navigator.of(context).pop()
                },
              ),
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return  
    Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/fondo.png'), fit: BoxFit.fill),
            ),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                        width: size.width - size.width * 0.1,
                        child: Column(children: [
                          const Text(
                            "Toca para identificar",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Material(
                              color: colors.primary,
                              child: InkWell(
                                onTap: () => getImagen(ImageSource.camera),
                                child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 150,
                                    )),
                              ),
                            ),
                          ),
                        ])),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: FilledButton.icon(
                        onPressed: () => getImagen(ImageSource.gallery),
                        label: const Text('Galería'),
                        icon: const Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
