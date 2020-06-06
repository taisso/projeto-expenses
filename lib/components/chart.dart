import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenteTransation;

  Chart(this.recenteTransation);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recenteTransation.length; i++) {
        bool sameDay = recenteTransation[i].date.day == weekDay.day;
        bool sameMoth = recenteTransation[i].date.month == weekDay.month;
        bool sameYear = recenteTransation[i].date.year == weekDay.year;

        if (sameDay && sameMoth && sameYear) {
          totalSum += recenteTransation[i].value;
        }
      }

      return {
        'day': DateFormat(DateFormat.ABBR_WEEKDAY, 'pt_br').format(weekDay),
        'value': totalSum
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (acc, tr) {
      return acc + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _weekTotalValue == 0
                    ? 0.0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
