
import 'package:expense_counter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  '\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
          icon: Icon(Icons.delete,
            color: Theme.of(context).errorColor,),
          label: Text(
            "Delete",
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          onPressed: () =>
              deleteTransaction(transaction),
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () =>
              deleteTransaction(transaction),
        ),
        title: Text(transaction.title,
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          DateFormat.yMMMd().format(
            transaction.date,
          ),
        ),
      ),
    );
  }
}
