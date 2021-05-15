import 'package:expense_counter/widgets/chart.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/newTransaction.dart';
import 'widgets/transactionList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontFamily: 'Lemon Friday', fontSize: 20),
              button: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lemon Friday',
                  fontSize: 15),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'Lemon Friday', fontSize: 20),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage render
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now()),
    Transaction(
      id: 't3',
      title: 'Private',
      amount: 79.95,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'School',
      amount: 400,
      date: DateTime.now().subtract(Duration(days: 2)),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date == null ? DateTime.now() : date);
    setState(() {
      _transactions.add(newTX);
    });
  }

  void _deleteTransaction(Transaction transactionToDelete){
    setState(() {
      _transactions.remove(transactionToDelete);
    });
  }

  void _showNewTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return NewTransaction(addTransaction: _addNewTransaction);
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showNewTransactionForm(context)),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Chart(
                  recentTransactions: _recentTransactions,
                ),
                TransactionList(
                  transactions: _transactions,
                  deleteTransaction: _deleteTransaction,
                ),
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewTransactionForm(context),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 40,
        ),
      ),
    );
  }
}
