import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTx;

  TransactionList(this.transactions, this._deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 15),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 460
                      ? TextButton.icon(
                          onPressed: () => _deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.error),
                        )
                      : IconButton(
                          onPressed: () => _deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete)),
                  iconColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
