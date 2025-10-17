import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/meme/models/cache_answer.dart';
import 'package:mobile/features/meme/models/meme_data.dart';
import 'package:mobile/features/meme/models/meme_response_model.dart';
import 'package:mobile/features/meme/provider/meme_provider.dart';
import 'package:mobile/features/meme/provider/track_question_provider.dart';
import 'package:mobile/features/meme/view/widgets/audio_player_widget.dart';
// import 'package:mobile/features/meme/view/pages/home_meme_screen.dart';
import 'package:mobile/features/meme/view/widgets/default_button.dart';
import 'package:mobile/features/meme/view/widgets/default_input_field.dart';
import 'package:mobile/features/meme/view/widgets/show_progress.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/text.dart';
import 'package:mobile/utils/notifications.dart';
import 'package:mobile/utils/validators.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BodySection extends StatefulWidget {
  const BodySection({
    super.key,
    required this.memeResponseModel,
    required GlobalKey<FormState> formKey,
    required TextEditingController editingController,
  }) : _formKey = formKey,
       _editingController = editingController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _editingController;
  final MemeResponseModel memeResponseModel;

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> with DisplayNotification {
  late List<MemeData> memeDatalist;

  @override
  void initState() {
    super.initState();
    memeDatalist = widget.memeResponseModel.data;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackQuestionProvider>().setTotal(memeDatalist.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    var meme = context.read<MemeProvider>();
    var total = context.read<TrackQuestionProvider>();
    var currentMeme = memeDatalist[total.getCurrent];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            KText.greeting,
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
                        Row(
                          children: [
                            Text(
                              KText.memeText,
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 280,
                                  maxHeight: 300,
                                ),
                                child: Text(
                                  currentMeme.memeText,
                                  maxLines: 4,

                                  style: GoogleFonts.roboto(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              KText.memeAudioText,
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                            AudioPlayerWidget(audioUrl: currentMeme.audioFile),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(width: 200, child: Divider()),
                        const SizedBox(height: 10),

                        Form(
                          key: widget._formKey,
                          child: Column(
                            children: [
                              DefaultInputField(
                                hintText: KText.inputHintText,
                                labelText: KText.inputLable,
                                controller: widget._editingController,
                                validator: KValidators.validateInput,
                              ),
                              const SizedBox(height: 20),
                              DefaultOperationButton(
                                title: "Check",
                                opration: () async {
                                  if (widget._formKey.currentState!
                                      .validate()) {
                                    String userInput = widget
                                        ._editingController
                                        .text
                                        .trim();

                                    // store anwser in an array
                                    meme.addAnswer(
                                      data: CachedAns(
                                        id: currentMeme.id,
                                        person: userInput,
                                        isCorrect:
                                            userInput.toLowerCase() ==
                                            currentMeme.person.toLowerCase(),
                                      ),
                                    );

                                    // push to next question
                                    total.next();

                                    // clear input field
                                    widget._editingController.clear();

                                    if (total.getQuizStatus == true) {
                                      showNotification(
                                        context,
                                        () {
                                          meme.clearCache();
                                          total.reset();
                                        },
                                        title: "Quiz finished",
                                        message:
                                            'you scored ${meme.totalCorrectAnswer}/${total.getTotal}',
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          KText.progressText,
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),

                        const SizedBox(height: 10),

                        ShowProgress(),
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
                      image: AssetImage(KImgaeStrings.chillGuyPath),
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
    );
  }
}
