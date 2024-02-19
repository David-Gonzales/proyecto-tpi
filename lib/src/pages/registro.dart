import 'package:app_tpi/src/model/request/registroRequest.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import '../model/response/loginResponse.dart';
import '../services/loginService.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;
class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? nombres = '';
  String? apellidos = '';
  String? email = '';
  String? clave = '';
  String? validarClave = '';
  TextEditingController fechaNacimientoController = TextEditingController();
  LoginResponse? loginResponse;
  bool cargando = false;

  void crearCuenta() async {
    FormState? formState = _formKey.currentState;

    if (formState!.validate()) {
      formState.save();
      setState(() {
        cargando = true;
      });
      RegistroRequest registroRequest = RegistroRequest(nombres: nombres, apellidos: apellidos, clave: clave, correoElectronico: email);
      loginResponse = await LoginService().registro(registroRequest);
      if(loginResponse == null){
        setState(() {
          cargando = false;
        });
        alertaError(titulo: 'Error', mensaje: 'No se pudo crear el usuario');
      } else {
        globals.datosUsuario = loginResponse;
        Navigator.of(context).pushReplacementNamed('/inicio');
      }
    }
  }

  Future alertaError({required String titulo, required String mensaje}) {
    return showDialog(
        context: context,
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

  @override
  void initState() {
    fechaNacimientoController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return cargando 
            ? const PaginaCargando() 
            : Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.1),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Nombres',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null) {
                            return 'El campo es obligatorio';
                          }
                          if (value.isEmpty) {
                            return 'El campo es obligatorio';
                          }
                          return null;
                        },
                        onSaved: (value) => nombres = value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.1),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Apellidos',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null) {
                            return 'El campo es obligatorio';
                          }
                          if (value.isEmpty) {
                            return 'El campo es obligatorio';
                          }
                          return null;
                        },
                        onSaved: (value) => apellidos = value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.1),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null) {
                            return 'El campo es obligatorio';
                          }
                          if (value.isEmpty) {
                            return 'El campo es obligatorio';
                          }
                          return null;
                        },
                        onSaved: (value) => email = value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.1),
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                        onChanged: (value) {
                          setState(() {
                            clave = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'El campo es obligatorio';
                          }
                          if (value.isEmpty) {
                            return 'El campo es obligatorio';
                          }
                          return null;
                        },
                        onSaved: (value) => clave = value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.1),
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Repetir contraseña',
                            labelStyle: TextStyle(fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                        onChanged: (value) {
                          setState(() {
                            validarClave = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'El campo es obligatorio';
                          }
                          if (value.isEmpty) {
                            return 'El campo es obligatorio';
                          }
                          log(clave!);
                          log(value);
                          if(clave != value){
                            return 'Las contraseñas tienen que ser iguales';
                          }
                          return null;
                        },
                        onSaved: (value) => validarClave = value,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: size.width - size.width * 0.2,
                      child: FilledButton(
                        onPressed: () => crearCuenta(),
                        child: const Text('Crear cuenta'),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class PaginaCargando extends StatelessWidget {
  const PaginaCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: const Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 40,),
            Text("Registrando usuario", style: TextStyle(color: Colors.white, fontSize: 18),),
          ],
        )

      ),
    );
  }
}