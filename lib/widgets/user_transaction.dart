import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/widgets/transaction_list.dart';

import '../widgets/new_transaction.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
    List<Transaction> _transactions = [
    Transaction(
      id: 't1', title: 'New Shoes',amount: 69.99,date:DateTime.now()
      ),
    Transaction(
      id: 't2', title: 'Weekly Groceries',amount: 16,date:DateTime.now()
      ),
  ];

  void _addNewTransaction(String txTitle, double txtAmount){
    final newTx = Transaction(
      title: txTitle, 
      amount: txtAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    // masukan ke list
    setState(() {
      _transactions.add(newTx);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          NewTransaction(_addNewTransaction),
          TransactionList(_transactions),
      ],
    );
  }
}