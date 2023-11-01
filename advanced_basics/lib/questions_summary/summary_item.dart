import 'package:advanced_basics/questions_summary/question_identifier.dart';
import 'package:advanced_basics/questions_summary/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer = isCorrect(itemData);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
              questionIndex: itemData["question_index"] as int,
              isCorrectAnswer: isCorrectAnswer),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData["question"].toString(),
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                itemData["user_answer"] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 202, 171, 252),
                ),
              ),
              Text(
                itemData["correct_answer"] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 181, 254, 246),
                ),
              )
            ],
          ))
        ],
      ),
    );

    throw UnimplementedError();
  }
}
