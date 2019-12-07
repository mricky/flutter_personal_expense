import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyHomePage(),
));


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home:  Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHART'),
              elevation: 5,
            ),
          ),
          Card(
            color: Colors.red ,
            child: Text("List OF TX"),
          )
        ],
       ),
      ),
    );
  }
}