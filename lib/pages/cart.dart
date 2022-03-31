import 'package:flutter/material.dart';
import 'package:test_catalog/pages/cataloge.dart';
import 'package:provider/provider.dart';


class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  get items => _items;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void delete(Item item) {
    _items.remove(item);
    notifyListeners();
  }
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);
}

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text('cart',
        style: TextStyle(
          fontSize: 30.0,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
        ),
        backgroundColor: Colors.limeAccent,
      ),
      body: Container(
        color: Colors.amberAccent,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: CartList(),
              ),
            ),
            //const Divider(height: 4, color: Colors.black),
            Total()
          ],
        ),
      ),
    );
  }
}

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.label_important_outline),
        title: Text(
          cart.items[index].colorName,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class Total extends StatelessWidget {
  const Total({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
     children: [
        Text('Total price: ${cart.totalPrice.toString()}',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),),
     ],
    );
  }
}
