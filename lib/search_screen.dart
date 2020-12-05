import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[900], Colors.pink[300]]),
        ),
        child: Center(
          child: Column(children: [
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('Flipkart Product Review',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 60)),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      icon: Icon(Icons.search),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white))),
            ),
            SizedBox(height: 100),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 75),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.pink[300]),
              child: Center(
                child: FlatButton(
                  child: Text("Search For Product",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
