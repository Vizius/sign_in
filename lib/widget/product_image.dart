import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductImage extends StatelessWidget {

  final String? url;

  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Container(
            decoration: _builDecoration(),
            width: double.infinity,
            height: 450,
            child: Opacity(
              opacity: 0.8,
              child: ClipRRect(
                
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                child: getImage(url)
              ),
            ),
          ),
        ),
    );
  }

  BoxDecoration _builDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0,5)

      )
    ]
  );

  Widget getImage(String? pic)
  {
    if (pic == null) 
    return
    Image(image: AssetImage("assets/no-image.png"),fit: BoxFit.cover,);
    
    if(pic.startsWith("http"))
    {
      return FadeInImage(
      placeholder: AssetImage("assets/jar-loading.gif"),
      image: NetworkImage("$url"),
      fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(pic),
      fit: BoxFit.cover,
    );
    
  }
}