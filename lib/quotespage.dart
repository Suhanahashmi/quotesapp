import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
class quotespage extends StatefulWidget {
  final String categoryname;

  const quotespage({super.key, required this.categoryname});

  @override
  State<quotespage> createState() => _quotespageState();
}

class _quotespageState extends State<quotespage> {
  List quotes=[];
  List authors=[];
  bool isDataThere =false;
  @override
  void initState(){

    super.initState();
    setState(() {
      getquotes();
    });
  }
  getquotes() async {
    String url = "https://quotes.toscrape.com/tag/${widget.categoryname}/";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final quotesclass = document.getElementsByClassName("quote");
    quotes =
        quotesclass.map((element) =>
        element.getElementsByClassName('text')[0].innerHtml).toList();
    authors =
        quotesclass.map((element) =>
        element.getElementsByClassName('author')[0].innerHtml).toList();
    setState(() {
      isDataThere = true;
    });
  }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
        body:isDataThere==false?
        Center(child: CircularProgressIndicator(),):

        SingleChildScrollView(
        physics:ScrollPhysics(),
    child: Column(
    children: [
    Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 40),
    child: Text("${widget.categoryname}Quotes App",style: TextStyle(
    fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold

    ),),),
    ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: quotes.length,
    itemBuilder: (context,index){
    return Container(
    child: Card(
    color: Colors.white.withOpacity(0.8),
    elevation: 10,
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(quotes[index]),
    ),

    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(authors[index]),
    ),
    ],
    ),
    ),

    );
    }
    ),
    ],
    ),

    ),
    );
  }
}
