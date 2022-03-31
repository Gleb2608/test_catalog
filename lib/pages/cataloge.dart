import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_catalog/pages/cart.dart';


class CatalogModel{

  List <Map> itemColorNames = [
    {'colorName' : 'lightGreen',
      'color'  : Colors.lightGreen},
    {'colorName' : 'black',
      'color'  : Colors.black},
    {'colorName' : 'cyanAccent',
      'color'  : Colors.cyanAccent},
    {'colorName' : 'lightBlueAccent',
      'color'  : Colors.lightBlueAccent},
    {'colorName' : 'pink',
      'color'  : Colors.pink},
    {'colorName' : 'deepPurple',
      'color'  : Colors.deepPurple},
    {'colorName' : 'brown',
      'color'  : Colors.brown},
    {'colorName' : 'purple',
      'color'  : Colors.purple},
    {'colorName' : 'deepOrangeAccent',
      'color'  : Colors.deepOrangeAccent},
    {'colorName' : 'yellow',
      'color'  : Colors.yellow},
    {'colorName' : 'teal',
      'color'  : Colors.teal},
    {'colorName' : 'limeAccent',
      'color'  : Colors.limeAccent},
    {'colorName' : 'amber',
      'color'  : Colors.blueGrey},

  ];

  Item getItem(id){
    Map itemMap = itemColorNames[id % itemColorNames.length];
    return Item(id, itemMap['colorName'],  itemMap['color'], 42);
  }


}

class Item {
  final int colorId;
  final String colorName;
  final Color color;
  final int price;

  Item(this.colorId, this.colorName, this.color, this.price);

}

class CatalogList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('catalog',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(
              onPressed: (){
              Navigator.pushNamed(context, '/cart', );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.black,),
          ),
        ],
      ),
      body:
      ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return CatalogeItem(index);
        }
      ),
      );

  }
}


class CatalogeItem extends StatelessWidget {
  final int index;
  const CatalogeItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var colorItem = context.select<CatalogModel, Item>(
    (catalog) => catalog.getItem(index),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: colorItem.color,
          width: 25.0,
          height: 25.0,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        ),
        Text('${colorItem.colorName}',
          style: TextStyle(
            fontSize: 20.0,
          ),),
        Spacer(),
        AddToCartButton(colorItem: colorItem,)
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget  {
  final Item colorItem;
  AddToCartButton({Key? key, required this.colorItem}) ;


  @override
  Widget build(BuildContext context) {

    var isAdded = context.select<CartModel, bool>(
          (cart) => cart.items.contains(colorItem),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            child: Row(
              children: [
              (!isAdded
                  ? const Text('ADD', style: TextStyle(color: Colors.black),)
                  : const Icon(Icons.done, color: Colors.blueGrey,)),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),

             onPressed: isAdded
              ? () {
               var cart = context.read<CartModel>();
               cart.delete(colorItem);
             }
              : () {
               var cart = context.read<CartModel>();
              cart.add(colorItem);
              },
          style: ElevatedButton.styleFrom(
              primary : Colors.white,
              shadowColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
