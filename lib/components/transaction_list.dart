import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              final tr = _transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(child: Text('R\$${tr.value}')),
                    ),
                  ),
                  title: Text(
                    '${tr.title}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, 'pt_br')
                        .format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? FlatButton.icon(
                          onPressed: () => _deleteTransaction(tr.id),
                          icon: Icon(Icons.delete),
                          label: Text('Excluir'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTransaction(tr.id);
                          },
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
          );
  }
}
