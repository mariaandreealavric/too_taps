import 'package:flutter/material.dart';

class Griglia extends StatefulWidget {
  const Griglia({super.key});

  @override
  State<Griglia> createState() => _GrigliaState();
}

class _GrigliaState extends State<Griglia> {
  List<int> lista = List.generate(21, (index) => index); // Genera una lista da 0 a 20

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: GridView.count(
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: 3,
          children: [
            for (var i in lista)
              Card(
                color: Colors.blue.shade400,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('$i'), // Mostra il valore di 'i' nel Card
                ),
              ),
          ],
        ),
      ),
    );
  }
}
