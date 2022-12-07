import 'package:flutter/material.dart';
import 'package:sign_in/provider/login_form_provider.dart';
import 'package:sign_in/services/services.dart';
import 'package:sign_in/ui/input_decorations.dart';
import 'package:sign_in/widget/widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routerName ='register';

  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child:SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 250,),

              CardContainer(child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text('Crear Cuenta',style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 30,),
                  ChangeNotifierProvider(
                    create: (context) => LoginFormProvider() ,
                    child: _LoginForm(),
                  )
                  

                ],
              ),),

              SizedBox(height: 50,),
              TextButton(onPressed: () => Navigator.pushReplacementNamed(context, 'Login'), 
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.purple.withOpacity(0.2)),
                shape: MaterialStateProperty.all(StadiumBorder())
              ), 
              child: Text(
                "¿Ya tienes una Cuenta?" , style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
              ))
            ],
          ),
        ),)
    );
  }
}
class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginform = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginform.formkey,

        autovalidateMode: AutovalidateMode.onUserInteraction,
        child:Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: 'Ejemplo@ejemplo.com',labelText: 'Correo',icon: Icons.alternate_email,color: Colors.purple),
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '') ? null : 'Correo Invalido';

              },
              onChanged: (value) => loginform.email =value,
            ),
            SizedBox(height: 30,),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(hintText: '******',labelText: 'Contraseña',icon: Icons.lock_outline,color: Colors.purple),
              validator: (value) {
                return (value != null && value.length>= 6 ) ? null : 'Contraseña Incorrecta';

              },
              onChanged: (value) => loginform.password=value,
            ),
            SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80,vertical: 15),
                
                child: Text(loginform.isLoading ? 'Espere' : 'Crear', style: TextStyle(color: Colors.white),),
              ),
              
              onPressed:loginform.isLoading ? null : () async {

                FocusScope.of(context).unfocus();

                final authService = Provider.of<AuthService>(context, listen: false);

                if(!loginform.isValidForm())return;

                loginform.isLoading = true;
                
                final String? errorMessage = await authService.createUser(loginform.email, loginform.password);
                if(errorMessage == null)
                {
                    Navigator.pushReplacementNamed(context, "Home");
                }else
                {
                  mostrarAlerta(context, "El Usuario ya existe");
                  loginform.isLoading = false;
                }
                
            },)
            
          ],
        ) ,
      ));
  }
  void mostrarAlerta(BuildContext context, String mensaje ) {
 
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Text('Información Duplicada'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            
            onPressed: ()=> Navigator.of(context).pop(),
          )
        ],
      );
    }
  );}
}