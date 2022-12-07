import 'package:flutter/material.dart';
import 'package:sign_in/models/models.dart';
import 'package:sign_in/screens/screens.dart';
import 'package:sign_in/services/services.dart';
import 'package:sign_in/widget/widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static const String routerName ='Product';

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductService>(context);

    if(productsService.isloading) return LoadingScreen();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(onPressed:() => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: Text("Productos"),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ((context, index) => GestureDetector(
          onTap: () 
          {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, "DetailProduct");
          },
          child:ProductCard(product: productsService.products[index],)
        )
        
      )),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = new Product(
            disponible: true, 
            nombre: "", 
            precio: 0);
          Navigator.pushNamed(context, 'DetailProduct');
        },
      ),
    );
  }
}