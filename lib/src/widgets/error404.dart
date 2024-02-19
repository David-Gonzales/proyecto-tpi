import 'package:flutter/material.dart';

class Error404 extends StatefulWidget {
  const Error404({super.key});

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ListTile(
          title:  Text('Error 404', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.center,),
          subtitle: Text('Página no encontrada', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
        ) 
      ),
    );
  }
}