
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({super.key, required this.child});
 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          
        _Purplebox(),

        _Icon(),

        this.child

      ]),
    );
  }
}

class _Icon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 40),
        child: Icon(Icons.person_pin, color: Colors.white,size: 100,),
      ),
    );
  }
}

class _Purplebox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _customBoxPurple(),
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: -50,left: 280,),
          Positioned(child: _Bubble(), top: 200,left: 300,),
          Positioned(child: _Bubble(), top: -50,left: 80,),
          Positioned(child: _Bubble(), top: 250,left: 10,),
          Positioned(child: _Bubble(), top: 90,left: 30,)
          
        ],
      ),
    );
  }

  BoxDecoration _customBoxPurple() => BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1),
    ])
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}