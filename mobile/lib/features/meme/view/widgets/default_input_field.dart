import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultInputField extends StatelessWidget {
  const DefaultInputField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText = "",
    this.labelText = ""
  });

  final TextEditingController controller;
  final Function? validator;
  final String hintText, labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 60,
      child: TextFormField(
        controller: controller,
        validator: (value) => validator!.call(input: value!),
        style: GoogleFonts.roboto(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.green),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 216, 215, 215),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: GoogleFonts.roboto(color: Colors.black54),
          labelStyle: GoogleFonts.roboto(color: Colors.green),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
