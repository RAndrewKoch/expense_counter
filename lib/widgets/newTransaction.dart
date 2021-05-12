import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // String titleInput;
  // final String amountInput="";

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  submitData(BuildContext context) {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        double.parse(amountController.text) <= 0) {
      return showDialog(
        builder: (_) => AlertDialog(
            content: Text("Cannot enter transaction, please ensure you have a Title, and a non-negative numerical Amount"),
          actions: [
            TextButton(onPressed: ()=>Navigator.pop(context),
                child: Text("Understood")
            ),
          ]
        ),
        context: context,
      );
    }
    addTransaction(titleController.text, double.parse(amountController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              onSubmitted: (_) => submitData(context),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              onSubmitted: (_) => submitData(context),
            ),
            TextButton(
              child: Text('Add Transaction'),
              onPressed: () => submitData(context),
            )
          ],
        ),
      ),
    );
  }
}
