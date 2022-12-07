import 'package:flutter/material.dart';
import 'package:sign_in/provider/theme_provider.dart';
import 'package:sign_in/screens/product_screen.dart';
import 'package:sign_in/screens/screens.dart';
import 'package:sign_in/services/services.dart';
import 'package:sign_in/share_preference/preference.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/src/views/fullscreenmap.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  

  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (context) => ThemeProvider(isDarkmode: Preferences.isDarkmode),
      ),
      ChangeNotifierProvider(create: (context) => ProductService(),),
      ChangeNotifierProvider(create: (context) => AuthService(),)
    ],
    child: MyApp(),
  )
  );
} 


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: CheckScreen.routerName,
      routes: {
        HomeScreen.routerName          :(context) => HomeScreen(),
        SettingScreen.routerName       :(context) => SettingScreen(),
        LoginScreen.routerName         :(context) => LoginScreen(),
        ProductScreen.routerName       :(context) => ProductScreen(),
        DetailProductScreen.routerName :(context) => DetailProductScreen(),
        RegisterScreen.routerName      :(context) => RegisterScreen(),
        CheckScreen.routerName         :(context) => CheckScreen(),
        FullScreenMap.routerName       :(context) => FullScreenMap()
        
      },

      theme: Provider.of<ThemeProvider>(context).currenTheme,
      
    );
  }
}