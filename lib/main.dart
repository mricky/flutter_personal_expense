import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
//import './widgets/user_transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
void main() { 
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp
  // ]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 18
          ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'OpenSans', 
            fontSize: 20,
            fontWeight: FontWeight.bold),
            ), 
        ) 
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   bool _showChart = false;
    List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1', title: 'New Shoes',amount: 69.99,date:DateTime.now()
    //   ),
    // Transaction(
    //   id: 't2', title: 'Weekly Groceries',amount: 16,date:DateTime.now()
    //   ),
  ];

  void _addNewTransaction(String txTitle, double txtAmount, DateTime chosenDate){
    final newTx = Transaction(
      title: txTitle, 
      amount: txtAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    // masukan ke list
    setState(() {
      _transactions.add(newTx);
    });
  }
  void _deleteTransaction(String id){
      setState(() {
        _transactions.removeWhere((tx) => tx.id == id);
      });
  }
  List<Transaction> get _recentTransactions {
      
      return _transactions.where((tx){
        return tx.date.isAfter(
          DateTime.now().subtract(
             Duration(
               days: 7),
          ),
        );
      }).toList();
  }
  void _startAddNewTransaction(BuildContext ctx){
    // method bawaan flutter
    showModalBottomSheet(
      context: ctx,
       builder: (_){
         return GestureDetector(
          onTap: (){},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
         );
        },
    );
  }

  @override
  
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
        title: Text("Personal Expense",

        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed: 
            () =>_startAddNewTransaction(context) // anynomouse function
          ),
        ],
      );
      final txtListWidget = Container(
              height: (mediaQuery.size.height -
                  appBar.preferredSize.height - 
                  MediaQuery.of(context).padding.top) * 
                  0.7, 
              child: TransactionList(_transactions, _deleteTransaction)
            );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch(value: _showChart, onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                }),
              
            ],
            ),
            if(!isLandscape)
            Container(
              // 0.4 = 40% dari total size scrreen
              height: (mediaQuery.size.height - 
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransactions)
            ),
            if(!isLandscape) txtListWidget,
            if(isLandscape) _showChart 
            ? Container(
              // 0.4 = 40% dari total size scrreen
              height: (mediaQuery.size.height - 
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions)
            ) :
              txtListWidget
          ],
         ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add),
        onPressed: ()=> _startAddNewTransaction(context)
        ),
    );
  }
}