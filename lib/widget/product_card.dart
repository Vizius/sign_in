import 'package:flutter/material.dart';
import 'package:sign_in/models/models.dart';

class ProductCard extends StatelessWidget {
  
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _CardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.imagen,),
            _ProductDetails(nombre: this.product.nombre, sub: this.product.id.toString()),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(price: product.precio,)
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _NotAviable(disp: product.disponible,)
            )
          ],
          
        ),
        
        
      ),
    );
  }

  BoxDecoration _CardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [BoxShadow(
      color: Colors.black12,
      offset: Offset(0,7),
      blurRadius: 10

    )]
  );
}

class _NotAviable extends StatelessWidget {

  final bool disp;

  const _NotAviable({super.key, required this.disp});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: 
            Text(disp == true ? "Disponible" : "No disponible",
            style: TextStyle(color: Colors.white,fontSize: 20),)
 
          
        ),
      ),
      width: 100,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("\$ $price", style: TextStyle(color: Colors.white,fontSize: 20),)
        ),
      ),

      width: 100,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String nombre;
  final String sub;

  const _ProductDetails({super.key, required this.nombre, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 60),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _BuildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nombre, 
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,),
            Text(sub, 
            style: TextStyle(fontSize: 15, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,)
          ],
        ),

      ),
    );
  }

  BoxDecoration _BuildBoxDecoration() => BoxDecoration(

    color: Colors.cyan,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))

  );
}

class _BackgroundImage extends StatelessWidget {
  final String? images;

  const _BackgroundImage(this.images);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 400,
        child: images == null
        ? 
        Image(
          image: AssetImage("assets/no-image.png"),
          fit: BoxFit.cover,
        )
        :FadeInImage(
          placeholder: AssetImage("assets/jar-loading.gif"),
          image: NetworkImage("$images"),
          fit: BoxFit.cover,
          ),
      ),
    );
  }

}