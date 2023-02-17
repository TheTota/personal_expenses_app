import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionCallback;

  NewTransaction(this.addTransactionCallback, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColor),
              onPressed: submitData,
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    widget.addTransactionCallback(enteredTitle, enteredAmount);
    
    Navigator.of(context).pop();
  }
}
