import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_flat_button.dart';
class NewTransaction extends StatefulWidget {
  
final Function addTx;

NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
final titleController = TextEditingController();
final amountController = TextEditingController();
DateTime _selectedDate;
void _submitData(){
  if(amountController.text.isEmpty){
    return;
  }
  final enteredTitle = titleController.text;
  final enteredAmount = double.parse(amountController.text);
  if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
     return;
  }
  
  widget.addTx(
    enteredTitle,  
    enteredAmount,
    _selectedDate,
  );
  Navigator.of(context).pop();
 
}
void _presentDatePicker(){
    showDatePicker(
      context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2019),
       lastDate: DateTime.now(),
      ).then((pickedDate){
        if(pickedDate == null){
          return;
        }
        setState(() {
            _selectedDate = pickedDate;
        });
       
      });
      print('..');
  }
@override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_)=> _submitData,
                      ),
                    Container(
                      height: 70,
                      child: Row(children: <Widget>[
                        Expanded(
                             child: Text(
                            _selectedDate == null 
                            ? 'No Date Chosen!'
                            : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}',
                          ),
                        ),
                        // using custom adaptive flat button
                        AdaptiveFlatButton('Choose Date', _presentDatePicker),
                      ],
                      ),
                    ),
                    RaisedButton(
                        child: Text('Add Transaction'),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).buttonColor,
                        onPressed: (){
                          _submitData();
                        },
          
                    ),
                  ],
                ),
              ),
            ),
    );
  }
} 