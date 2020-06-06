import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleCotroller = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _onSubmitFomr() {
    final text = _titleCotroller.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (text.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onSubmit(text, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickerDate) {
      if (pickerDate == null) return;

      setState(() {
        _selectedDate = pickerDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleCotroller,
                onSubmitted: (_) => _onSubmitFomr(),
                decoration: InputDecoration(
                
                  labelText: 'Título',
                ),
                
              ),
              TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _onSubmitFomr(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma Data Selecionada'
                            : DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                                    'pt_br')
                                .format(_selectedDate),
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text(
                      'Nova Transação',
                    ),
                    onPressed: _onSubmitFomr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
