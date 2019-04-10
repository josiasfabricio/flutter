import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Placed"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            Text(
              "Successful order",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(
              "Order code: $orderId",
              style: TextStyle(fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
