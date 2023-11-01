import 'package:advanced_basics/questions_summary/summary_item.dart';
import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(
    this.summaryData, {
    super.key,
  });

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
            children: summaryData.map((data) {
          return SummaryItem(data);
        }).toList()),
      ),
    );
  }
}

bool isCorrect(Map<String, Object> data) {
  return data["correct_answer"] == data["user_answer"];
}
