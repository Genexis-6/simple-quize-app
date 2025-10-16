import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultOperationButton extends StatelessWidget {
  const DefaultOperationButton({super.key, this.opration, required this.title});
  final Function? opration;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(200, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: () => opration!.call(),
      child: Text(
        title,
        style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
