import 'package:expense_counter/models/transaction.dart';
import 'package:expense_counter/widgets/transactionItem.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text("No transactions added yet!",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 50),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset("assets/images/waiting.png",
                      fit: BoxFit.cover),
                ),
              ],
            );
          })
        : ListView(children:
            transactions
                .map(
                  (transaction) => TransactionItem(
                    key: ValueKey(transaction.id),
                    transaction: transaction,
                    deleteTransaction: deleteTransaction,
                  ),
                )
                .toList(),
          );
  }
}
