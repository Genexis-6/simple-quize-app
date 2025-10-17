import 'package:flutter/material.dart';
import 'package:mobile/features/meme/provider/audio_play_provider.dart';
import 'package:mobile/features/meme/provider/meme_provider.dart';
import 'package:mobile/features/meme/provider/track_question_provider.dart';
import 'package:mobile/features/meme/view/pages/home_meme_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MemeApp());
}

class MemeApp extends StatelessWidget {
  const MemeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (context) => MemeProvider()),
        ChangeNotifierProvider(create: (context) => TrackQuestionProvider()),
        ChangeNotifierProvider(create: (context)=> AudioPlayProvider())
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'Meme App',
        home: const HomeMemeScreen(),
      ),
    );
  }
}
