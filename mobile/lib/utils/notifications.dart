import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import "package:flutter/material.dart";

mixin DisplayNotification {
  void showNotification(
    BuildContext context,
    Function resetState, {
    required String message,
    required String title,
  }) {
    Alert(
      context: context,
      title: title,
      desc: message,
      style: AlertStyle(
        titleStyle: GoogleFonts.roboto(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        descStyle: GoogleFonts.roboto(
          color: Colors.green,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      closeFunction: () {
        resetState();
        Navigator.pop(context);
      },
      buttons: [
        DialogButton(
          color: Colors.red,
          onPressed: () {
            resetState();
            Navigator.pop(context);
          },
          child: Text(
            "restart",
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
