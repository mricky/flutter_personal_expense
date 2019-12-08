import 'package:flutter/material.dart';

import './widgets/user_transaction.dart';

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
      body: Container(
        height: 600,
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.start,
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
            UserTransaction(),
          ],
         ),
      ),
      ),
    );
  }
}