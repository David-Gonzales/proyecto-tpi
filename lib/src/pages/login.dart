import 'package:app_tpi/src/model/request/loginRequest.dart';
import 'package:app_tpi/src/model/response/loginResponse.dart';
import 'package:app_tpi/src/services/evaluacionService.dart';
import 'package:app_tpi/src/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:app_tpi/src/model/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  LoginResponse? loginResponse;
  String? email = '';
  String? clave = '';
  bool cargando = false;

  void iniciarSesion() async {
    FormState? formState = _formKey.currentState;
    globals.datosUsuario = null;
    if (formState!.validate()) {
      formState.save();
      setState(() {
        cargando = true;
      });
      LoginRequest loginRequest = LoginRequest(correoElectronico: email, clave: clave);
      loginResponse = await LoginService().login(loginRequest);
      if(loginResponse == null){
        setState(() {
          cargando = false;
        });
        alertaError(titulo: 'Error', mensaje: 'El email o contraseña es incorrecto.');
      } else {
        globals.datosUsuario = loginResponse;
        globals.listaEvaluaciones = await EvaluacionService().obtenerEvaluaciones(globals.datosUsuario!.id);
        Navigator.of(context).pushReplacementNamed('/inicio');
      }
    }
  }

  void registrarse() {
    Navigator.of(context).pushNamed('/registro');
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return cargando 
            ? const PaginaCargando() 
            : Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1),
            Image.asset(
              "images/logo.png",
              height: 170,
              width: 170,
            ),
            const ListTile(
                title: Text('ECO AMIGOS',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 40),
                    textAlign: TextAlign.center)),
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: [
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
                        onChanged: (value) {
                          setState(() {
                            email = value;
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.1, right: size.width * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('¿No tienes una cuenta?'),
                          TextButton(
                              onPressed: () => registrarse(),
                              child: const Text(
                                'Regístrate',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width - size.width * 0.2,
                      child: FilledButton(
                        onPressed: () => iniciarSesion(),
                        child: const Text('Iniciar sesión'),
                      ),
                    )
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
            Text("Validando datos", style: TextStyle(color: Colors.white, fontSize: 18),),
          ],
        )

      ),
    );
  }
}