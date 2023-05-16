import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:quotesapp/quotespage.dart';

class quotesapp extends StatefulWidget {

 const quotesapp({Key? key}) : super(key: key);

  @override
  State<quotesapp> createState() => _quotesappState();
}
class _quotesappState extends State<quotesapp> {
  List<String>Categories =["love","inspirational","life","humor"];

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
    String url = "https://quotes.toscrape.com/";
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
    backgroundColor: Colors.grey,
        body:SingleChildScrollView(
    physics:ScrollPhysics(),
    child: Column(
    children: [
      Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 40),
    child: Text("Quotes",style: TextStyle(
    fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold
    ),),
    ),
    SizedBox(height: 10,),
    GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics:NeverScrollableScrollPhysics(),
    mainAxisSpacing: 20,
    crossAxisSpacing: 20,
    children: Categories.map((Category){
  return InkWell(
  onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>quotespage( categoryname:Category)));
  },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Text(
          Category.toUpperCase(),
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
    }).toList(),
    ),
      SizedBox(height: 40,),
      //isDataThere==false?Center(child: CircularProgressIndicator(),);
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
                    child: Text(quotes[index],
                    style: TextStyle(color: Colors.black),),
                  ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(authors[index],
            style:TextStyle(color: Colors.black) ),
          )

                ],
              ),
            ),
          );
      }
      )
    ]
    ),
    ),
    );
       }
}
