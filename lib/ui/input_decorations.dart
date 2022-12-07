import 'package:flutter/material.dart';

class InputDecorations
{
  static InputDecoration authInputDecoration(
    {
      required String hintText,
      required String labelText,
      IconData? icon,
      required Color color
    }
  )
  {
    return InputDecoration(
                 enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: color
                  ),
                  
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 2
                  )
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: icon !=null ? Icon(icon,color: color,): null
              );
  }
 
}