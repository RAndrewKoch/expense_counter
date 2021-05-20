
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({@required this.addTransaction}){
    print ('constructor NewTransaction()');
  }

  @override
  _NewTransactionState createState()  {print ('create state NewTransaction Widget');  return _NewTransactionState();}
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;


  _NewTransactionState(){
    print("constructor _NewTransactionState");
  }


  @override
  void initState()  {
    print('initState()');
    super.initState();


  }

  @override
  void didUpdateWidget(NewTransaction oldWidget){
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose(){
    print('dispose()');
    super.dispose();
  }

  _submitData(BuildContext context) {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        double.parse(amountController.text) <= 0) {
      return;
    }
    widget.addTransaction(
        titleController.text, double.parse(amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Padding(padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        ),
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
                  onSubmitted: (_) => _submitData(context),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                  ),
                  onSubmitted: (_) => _submitData(context),
                ),
                Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                            _selectedDate == null
                                ? "Date Not Chosen"
                                : 'Picked Date: ${DateFormat.yMEd().format(_selectedDate)}',
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex:2,
                        child: TextButton(
                          style: (ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                Theme.of(context).textTheme.headline6),
                          )),
                          onPressed: _presentDatePicker,
                          child: Text("Choose Date"),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('Add Transaction'),
                    onPressed: () => _submitData(context),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
