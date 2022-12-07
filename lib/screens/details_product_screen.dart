import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in/provider/product_form_provider.dart';
import 'package:sign_in/services/services.dart';
import 'package:sign_in/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../ui/input_decorations.dart';

class DetailProductScreen extends StatelessWidget {

  static const String routerName ='DetailProduct';

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(create: (context) => ProductFormProvider(productService.selectedProduct),
    child: _DetailScreenBody(productService: productService) ,
    );

  }
}

class _DetailScreenBody extends StatelessWidget {
  const _DetailScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
         //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
         child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.imagen),
                Positioned(
                  top: 70,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new,size: 40,color: Colors.white,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                )),
                Positioned(
                  top: 70,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.white,),
                    onPressed: () async{

                    final picker = new ImagePicker();

                    final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.camera, 
                      imageQuality: 100
                    );
                    
                    if (pickedFile == null)
                    {
                      print("no selecciono nada");
                      return;
                    }

                    print("tenemos imagen ${pickedFile.path}");
                    
                    productService.updateSelectedProductImgae(pickedFile.path);
                  },
                ))
              ],
            ),
            _ProductForm(),

            SizedBox(height: 100,)
          
          ],
         ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child:productService.isSavin
        ? CircularProgressIndicator(color: Colors.white,)
        :Icon(Icons.save),
        onPressed: productService.isSavin
        ? null
        : () async{

         if( !productForm.isValidForm()) return;

         final String? imageUrl = await productService.updateImage();

         if(imageUrl != null) productForm.product.imagen = imageUrl;



         await productService.saveOrCreateProduct(productForm.product);

        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    final  productForm =  Provider.of<ProductFormProvider>(context);
    final  product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10,),

              TextFormField(
              autocorrect: false,
              initialValue: product.nombre,
              onChanged: (value) => product.nombre = value,
              validator: (value) {
                if (value == null || value.length < 1 )
                return "El nombre es obligatorio";
              },
              decoration: InputDecorations.authInputDecoration(
                hintText: "nombre producto",
                labelText: 'Nombre:',icon: Icons.shopping_bag_outlined,
                color: Colors.cyan
                )
              ),

              SizedBox(height:30),

              TextFormField(
              autocorrect: false,
              initialValue: '${product.precio}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              onChanged: (value) 
              {
                if(double.tryParse(value)==null)
                {
                  product.precio = 0;
                }else
                {
                  product.precio = double.parse(value);
                }
                
              },
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '\$1000',
                labelText: 'Precio:',icon: Icons.paid_outlined,
                color: Colors.cyan)
              ),

              SizedBox(height:30),
              SwitchListTile.adaptive(
                value: product.disponible,
                title: Text("Disponible"),
                activeColor: Colors.cyan,
                onChanged: (value) => productForm.upDateDispo(value)
               
              ),
              SizedBox(height:30),

            ],
          )
        ),
        
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20)
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5
        )
      ]
    );
  }
}

