import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_catalog/pages/cataloge.dart';
import 'package:test_catalog/pages/cart.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => CatalogList(),
          '/cart': (contex) => Cart(),
        },
      ),
    );
  }
}