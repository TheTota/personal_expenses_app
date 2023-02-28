import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './adaptive_text_button.dart';
import './adaptive_elevated_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionCallback;

  const NewTransaction(this.addTransactionCallback, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: mediaQuery.viewInsets.bottom + 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen'
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    AdaptiveTextButton('Choose date', _presentDatePicker),
                  ],
                ),
              ),
              AdaptiveElevatedButton(
                text: 'Add Transaction',
                callback: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      return;
    }

    widget.addTransactionCallback(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }

        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }
}
