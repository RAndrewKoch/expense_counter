import 'package:expense_counter/widgets/chart.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/newTransaction.dart';
import 'widgets/transactionList.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
              headline6: const TextStyle(fontFamily: 'Lemon Friday', fontSize: 20),
              button: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lemon Friday',
                  fontSize: 15),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(fontFamily: 'Lemon Friday', fontSize: 20),
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

  bool _showChart = true;

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

  void _deleteTransaction(Transaction transactionToDelete) {
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Expenses"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNewTransactionForm(context)),
      ],
    );

    final bottomAppBar = BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      child: Container(
        height: 40,
      ),
    );

    final _transactionListWidget = Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top -
          40) *
          .80,
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text('Show Chart'),
                      Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        },
                      ),
                    ],
                  ),
               if (!isLandscape) Container(
                 height: (MediaQuery.of(context).size.height -
                     appBar.preferredSize.height -
                     MediaQuery.of(context).padding.top -
                     40) *
                     .3,
                 child: Chart(
                   recentTransactions: _recentTransactions,
                 ),
               ),
               if (!isLandscape) _transactionListWidget,
               if (isLandscape) _showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top -
                                40) *
                            .8,
                        child: Chart(
                          recentTransactions: _recentTransactions,
                        ),
                      )
                    : _transactionListWidget
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewTransactionForm(context),
      ),
      bottomNavigationBar: bottomAppBar,
    );
  }
}
