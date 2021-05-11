import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // String titleInput;
  // final String amountInput="";

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              // onChanged: (val){
              //   titleInput = val;
              // },
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: amountController,
              // onChanged: (val){
              //   amountInput = val;
              // },
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            TextButton(
              child: Text('Add Transaction'),
              onPressed: ()=>addTransaction(titleController.text, double.parse(amountController.text)),
            // onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
