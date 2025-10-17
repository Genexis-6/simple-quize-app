import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/meme/models/meme_response_model.dart';
import 'package:mobile/features/meme/provider/meme_provider.dart';
import 'package:mobile/features/meme/view/widgets/default_button.dart';
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
      await getMemes();
    });
  }

  getMemes() async {
    var meme = context.read<MemeProvider>();
    await meme.fetchMemes();
    responseModel = meme.memeResponse!;
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
                return const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              }
              if (model.memeResponse == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric( vertical: 8.0),
                        child: Text(
                          "unable to fetch meme",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ),
                    ),
                    DefaultOperationButton(
                      title: "retry",
                      opration: () async => await getMemes(),
                    ),
                  ],
                );
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
