import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store/datas/product_data.dart';

class CartProduct {

  String cid;
  String category;
  String pid;
  int quantity;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    quantity = document.data["quantity"];
    pid = document.data["pid"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category" : category,
      "pid": pid,
      "quantity" : quantity,
      "size" : size,
      //"product" : productData.toResumedMap()
    };
  }
}