import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/widgets/transaction_list.dart';

//import './widgets/user_transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
void main() => runApp(MaterialApp(
  home: MyApp(),
));


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
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense",

        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed: 
            () =>_startAddNewTransaction(context) // anynomouse function
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
           
            TransactionList(_transactions, _deleteTransaction),
          
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