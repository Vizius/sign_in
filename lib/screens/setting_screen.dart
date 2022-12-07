import 'package:flutter/material.dart';
import 'package:sign_in/provider/theme_provider.dart';
import 'package:sign_in/share_preference/preference.dart';
import 'package:sign_in/widget/widget.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {

  static const String routerName ='Setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  /*bool isdarkmode = false;
  int gender = 1;
  String name ='Sim';*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: SideMenu(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Ajustes', style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              Divider(),
              SwitchListTile.adaptive(
                value: Preferences.isDarkmode,
                title: Text('Darkmode')
                , onChanged: (value) {
                  Preferences.isDarkmode = value;
                  final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
                  value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
                  setState(() {
                  });
                },),
                Divider(),
                RadioListTile<int>(
                  value: 1, 
                  groupValue: Preferences.gender, 
                  title: Text('Masculino'),
                  onChanged: (value) {

                    Preferences.gender = value ?? 1;
                    setState(() {
                      
                    });
                  },
                ),

                RadioListTile<int>(
                  value: 2, 
                  groupValue: Preferences.gender, 
                  title: Text('Femenino'),
                  onChanged: (value) {
                    Preferences.gender = value ?? 2;
                    setState(() {
                      
                    });
                    
                  },
                ),
                Divider(),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    
                    onChanged: (value) {
                      
                      Preferences.name = value;
                      setState(() {
                        
                      });
                    },
                    initialValue: Preferences.name,
                    decoration: InputDecoration(labelText: 'Nombre', helperText: 'Nombre Usuario'),
                  ),
                )

            ],
          ),
        ),
      ),
    );
  }
}