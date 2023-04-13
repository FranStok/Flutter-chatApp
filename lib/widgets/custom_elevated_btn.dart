import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomElevatedBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: const StadiumBorder(),
        elevation: 2,
      ),
      onPressed: () => onPressed(),
      child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: Text(text,
              style: const TextStyle(fontSize: 18),
          )
        )
      )
    );
  }
}
