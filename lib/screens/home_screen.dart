
import 'package:flutter/material.dart';
import 'package:sign_in/share_preference/preference.dart';
import 'package:sign_in/widget/widget.dart';

class HomeScreen extends StatelessWidget {

  static const String routerName ='Home';


  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: SideMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Darkmode: ${Preferences.isDarkmode}'),
          Divider(),
          Text('Genero: ${Preferences.gender}'),
          Divider(),
          Text('Nombre de Usuario: ${Preferences.name}'),
          Divider(),
          TextButton(onPressed: () => Navigator.pushNamed(context, "Product"), 
          child: Text("Ir a productos")),
          Divider(),
          TextButton(onPressed: () => Navigator.pushNamed(context, "full"), 
          child: Text("Ir a Mapa"))
        ],
      ),
    );
  }
}