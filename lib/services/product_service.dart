import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sign_in/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier
{
  final String _baseUrl ='flutter-var-dd4ee-default-rtdb.firebaseio.com';
  final List<Product> products =[];
  
  final storage = new FlutterSecureStorage();

  File? newPicturefile;

  bool isloading = true;
  bool isSavin = false;

  late Product selectedProduct;

  ProductService()
  {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async
  {
    this.isloading = true;
    notifyListeners();


    final url = Uri.https(_baseUrl,'Productos.json',
    {
      'auth': await storage.read(key: 'idtoken') ?? ''
    });
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);


    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);

    });

    this.isloading = false;
    notifyListeners();

    return this.products;

  }

  Future saveOrCreateProduct (Product product)async
  {
    isSavin = true;
    notifyListeners();

    if(product.id == null)
    {
      this.createProduct(product);

    }else{
      this.updateProduct(product);
    }

    isSavin = false;
    notifyListeners();
  }

  Future <String> updateProduct(Product product) async
  {
    final url = Uri.https(_baseUrl,'Productos/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());

    final decodedata = resp.body;

    final index = this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;
    print(decodedata);
    notifyListeners();

    return product.id!;
  }

   Future <String> createProduct(Product product) async
  {
    final url = Uri.https(_baseUrl,'Productos.json');
    final resp = await http.post(url, body: product.toJson());

    final decodeData = json.decode( resp.body);
    product.id = decodeData['name'];
    this.products.add(product);
    notifyListeners();


    return product.id!;
  }

  void updateSelectedProductImgae(String path)
  {
    this.selectedProduct.imagen = path;
    this.newPicturefile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future <String?> updateImage() async
  {
    
    if(this.newPicturefile == null) return null;

    this.isSavin = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/did1hbefq/image/upload?upload_preset=qo2ox2kv');

    final imegeUpdateRequest = http.MultipartRequest('POST',url);

    final file = await http.MultipartFile.fromPath('file', newPicturefile!.path);

    imegeUpdateRequest.files.add(file);
    final streamResponse = await imegeUpdateRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201)
    {
      print("algo salio mal");
      print(resp.body);
      return null;
    }
    this.newPicturefile = null;

    final decodeData = json.decode(resp.body);

    return decodeData['secure_url'];

   
  }

}