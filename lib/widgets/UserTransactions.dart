import 'package:expense_counter/models/transaction.dart';
import 'package:expense_counter/widgets/newTransaction.dart';
import 'package:expense_counter/widgets/transactionList.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}



class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now()),
  ];

  void _addNewTransaction (String title, double amount){
    final newTX = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now());
    setState(() {
      _transactions.add(newTX);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(addTransaction: _addNewTransaction),
        TransactionList(transactions: _transactions),
      ],
    );
  }
}
