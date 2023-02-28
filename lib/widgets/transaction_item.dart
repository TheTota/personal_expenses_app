import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.mediaQuery,
    required Function deleteTx,
  }) : _deleteTx = deleteTx;

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function _deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: mediaQuery.size.width > 460
            ? TextButton.icon(
                onPressed: () => _deleteTx(transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error),
              )
            : IconButton(
                onPressed: () => _deleteTx(transaction.id),
                icon: const Icon(Icons.delete),
              ),
        iconColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
