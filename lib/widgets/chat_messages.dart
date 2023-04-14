import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final String text;
  final String UID;
  final AnimationController animationController;

  const ChatMessages({
      super.key,
      required this.text,
      required this.UID,
      required this.animationController
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: Container(child: (UID == "123") ? _myMesagge() : _notMyMesagge()));
  }

  Widget _myMesagge() {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController,curve: Curves.easeOut),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 5, left: 50, right: 5),
          decoration: BoxDecoration(
              color: const Color(0xff4D9EF6),
              borderRadius: BorderRadius.circular(20)),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _notMyMesagge() {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController,curve: Curves.easeOut),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 50),
          decoration: BoxDecoration(
              color: const Color(0xffE4E5E8),
              borderRadius: BorderRadius.circular(20)),
          child: Text(text, style: const TextStyle(color: Colors.black87)),
        ),
      ),
    );
  }
}
