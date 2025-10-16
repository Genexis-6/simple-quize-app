import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/meme/view/widgets/default_button.dart';
import 'package:mobile/features/meme/view/widgets/default_input_field.dart';
import 'package:mobile/utils/validators.dart';

class HomeMemeScreen extends StatefulWidget {
  const HomeMemeScreen({super.key});

  @override
  State<HomeMemeScreen> createState() => _HomeMemeScreenState();
}

class _HomeMemeScreenState extends State<HomeMemeScreen> {
  final TextEditingController _editingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        // title: Text("Meme App"),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Heading here",
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 1,
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color.fromARGB(150, 216, 215, 215),
                        child: Container(
                          padding: EdgeInsets.only(left: 16, top: 20),
                          width: double.infinity,

                          height: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 280,
                                    maxHeight: 300,
                                  ),
                                  child: Text(
                                    "Nieria meme here",
                                    maxLines: 4,

                                    style: GoogleFonts.roboto(
                                      fontSize: 17,

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("audio side"),

                              const SizedBox(height: 20),
                              SizedBox(width: 200, child: Divider()),
                              const SizedBox(height: 10),

                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    DefaultInputField(
                                      hintText: "Who said it??",
                                      labelText: "Guess...",
                                      controller: _editingController,
                                      validator: KValidators.validateInput,
                                    ),
                                    const SizedBox(height: 20),
                                    DefaultOperationButton(
                                      title: "Check",
                                      opration: () {
                                        if (_formKey.currentState!.validate()) {
                                          print(_editingController.text);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Total meme -> 5",
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),

                              const SizedBox(height: 10),
                              Wrap(
                                runSpacing: 2,
                                spacing: 2,
                                children: [
                                  Icon(Icons.check, color: Colors.green),
                                  Icon(Icons.close, color: Colors.red),
                                  Icon(Icons.check, color: Colors.green),
                                  Icon(Icons.close, color: Colors.red),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: -1,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/bg.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),

                      children: [
                        TextSpan(text: "Created by -> "),
                        TextSpan(
                          text: " Victory",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

