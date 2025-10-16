import 'package:flutter/material.dart';
import 'package:mobile/features/meme/models/meme_response_model.dart';
import 'package:mobile/features/meme/provider/meme_provider.dart';
import 'package:mobile/features/meme/view/widgets/home_body_section.dart';
import 'package:provider/provider.dart';

class HomeMemeScreen extends StatefulWidget {
  const HomeMemeScreen({super.key});

  @override
  State<HomeMemeScreen> createState() => _HomeMemeScreenState();
}

class _HomeMemeScreenState extends State<HomeMemeScreen> {
  final TextEditingController _editingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late MemeResponseModel responseModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var meme = context.read<MemeProvider>();
      await meme.fetchMemes();
      responseModel = meme.memeResponse!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        title: Text("Meme App"),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Consumer<MemeProvider>(
            builder: (context, model, _) {
              if (model.isLoading == true) {
                return const Center(child: CircularProgressIndicator());
              }
              if (model.memeResponse == null) {
                return const Center(child: Text("No memes loaded yet"));
              }
              return BodySection(
                memeResponseModel: model.memeResponse!,
                formKey: _formKey,
                editingController: _editingController,
              );
            },
          ),
        ),
      ),
    );
  }
}


