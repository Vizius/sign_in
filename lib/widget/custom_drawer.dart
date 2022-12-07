import 'package:flutter/material.dart';
import 'package:sign_in/screens/screens.dart';
import 'package:sign_in/services/services.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          _DrawerHeader(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'Home',arguments: HomeScreen(),);
            },
          ),
          ListTile(
            leading: Icon(Icons.people_outline),
            title: Text('Productos'),
            onTap: () {
              Navigator.pushNamed(context, 'Product');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuracion'),
            onTap: () {

              Navigator.pushReplacementNamed(context, 'Setting',arguments: SettingScreen(),);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('Cerrar Sesion'),
            onTap: () {

              authService.logout();
              Navigator.pushReplacementNamed(context, "Login");

            },
          )

      ]),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/menu-img.jpg'),
        fit: BoxFit.cover
      ),
    ),);
  }
}