import 'package:flutter/material.dart';
import 'package:quotesapp/quotesapp.dart';

void main() {
  runApp(const Myapp(),);
}
class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:quotesapp(),
    );
  }
}

