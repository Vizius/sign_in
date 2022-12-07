
import 'package:flutter/material.dart';
import 'package:sign_in/screens/screens.dart';
import 'package:sign_in/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckScreen extends StatelessWidget {
  static const String routerName ='check';

  

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (context, AsyncSnapshot<String> snapshot) {

            if (!snapshot.hasData)
             return CircularProgressIndicator(color: Colors.cyan,);

            if (snapshot.data=='')
            {
              Future.microtask(() async{
                
                   Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___)=> LoginScreen(),
                  transitionDuration: Duration (seconds: 0)
                ));
                

              },);

            }else
            {
              Future.microtask(() async{
                
                  Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___)=> HomeScreen(),
                  transitionDuration: Duration (seconds: 0)
                ));
                
                
              },);
            }


            return Container();
            
          },
        ),
      ),
    );
  }
}