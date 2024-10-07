import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight, // Fissa il contenuto in basso a destra
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Aggiunge un po' di padding se necessario
        child: RichText(
          textAlign: TextAlign.right, // Allinea il testo a destra
          text: TextSpan(
            children: [
              TextSpan(
                text: title, // Testo passato come parametro
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontFamily: 'KeplerStd', // Nome della famiglia del font come specificato in pubspec.yaml
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}