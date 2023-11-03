import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(int) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((ctx, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(index);
          },
          child: ExpenseItem(expense: expenses[index]),
        );
      }),
    );
  }
}
