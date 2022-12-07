import 'dart:convert';

class Product {
    Product({
        this.imagen,
        required this.disponible,
        required this.nombre,
        required this.precio,
        this.id
    });

    bool disponible;
    String? imagen;
    String nombre;
    double precio;
    String? id;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        disponible: json["disponible"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
    };

    Product copy() => Product(
      disponible: this.disponible, 
      nombre: this.nombre, 
      precio: this.precio,
      imagen: this.imagen,
      id : this.id
    );
    
}
