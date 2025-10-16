import 'package:flutter/material.dart';
import 'package:mobile/features/meme/provider/meme_provider.dart';
import 'package:provider/provider.dart';

class ShowProgress extends StatelessWidget {
  const ShowProgress({super.key});

  @override
  Widget build(BuildContext context) {
    var scores = context.read<MemeProvider>();
    return Wrap(
      runSpacing: 2,
      spacing: 2,
      children: [
        if(scores.getCachedMemeAns.isEmpty)Text(".... 👀", style: TextStyle(
          fontSize: 20
        ),),

                ...scores.getCachedMemeAns.map(
          (ans) => ans.isCorrect == true
              ? Icon(Icons.check, color: Colors.green)
              : Icon(Icons.close, color: Colors.red),
        ),
      ],
    );
  }
}