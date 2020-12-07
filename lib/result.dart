import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';

class MainMenu extends StatefulWidget {
  final String uid;
  MainMenu({Key key, @required this.uid}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState(uid);
}

class _MainMenuState extends State<MainMenu> {
  final String uid;
  _MainMenuState(this.uid);
  var name;
  var avg;
  var product;
  String url = "http://103.212.88.139:9000/";
  void getname() async {
    var send = await http.post(url, body: json.encode({'name': uid}));
    final decode = json.decode(send.body);
    final decode2 = json.decode(decode);
    setState(() {
      name = decode2["prod_name"];
      avg = decode2["average"];
      product = decode2['product'];
      print(product[0]["name"]);
    });
  }

  @override
  void initState() {
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[900], Colors.pink[300]]),
              ),
              child: Column(children: [
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText('$name',maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 30)),
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 15.0,
                  percent: double.parse(avg) / 5,
                  center: new Text("$avg",
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  progressColor: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Average Rating',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                ),
                Container(
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: ListView.builder(
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return Card(
                            point: product[index]["point"],
                            name: product[index]["name"],
                            review: product[index]["reviews"],
                            title: product[index]["title"]);
                      },
                    ))
              ])));
    }
  }
}

class Card extends StatelessWidget {
  final String point;
  final String name;
  final String review;
  final String title;
  Card(
      {Key key,
      @required this.point,
      @required this.name,
      @required this.review,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[900], Colors.pink[300]]),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(title,
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 25)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            color: Colors.white,
                          )),
                      SizedBox(width: 50),
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 5.0,
                        percent: double.parse(point) / 5,
                        center: new Text("$point",style:TextStyle(color:Colors.white)),
                        progressColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  AutoSizeText(review, textAlign:TextAlign.left,maxLines:2,style:TextStyle(fontFamily: 'Source Sans Pro',
                                  color: Colors.white,)),
                ),
                SizedBox(height: 35),
              ],
            )));
  }
}
