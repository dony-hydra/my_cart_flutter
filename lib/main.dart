import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_cart/common/theme.dart';
import 'package:my_cart/models/catalog.dart';
import 'package:my_cart/models/cart.dart';
import 'package:my_cart/screens/catalog.dart';
import 'package:my_cart/screens/cart.dart';
import 'package:my_cart/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart) {
              if (cart == null) throw ArgumentError.notNull('cart');
              cart.catalog = catalog;
              return cart;
            })
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyLogin(),
          '/catalog': (context) => const MyCatalog(),
          '/cart': (context) => const MyCart()
        },
      ),
    );
  }
}
