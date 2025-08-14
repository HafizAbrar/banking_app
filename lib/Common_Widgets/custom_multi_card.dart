import 'package:flutter/material.dart';

Widget CustomCard({
  required String ownerName,
  required String cardName,
  required String cardNumber,
  required String balance,
  required String cardImage,
}) {
  return SizedBox(
    height: 261,
    width: 327,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        // Bottom card
        Positioned(
          top: 82,
          child: Container(
            height: 164,
            width: 261,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Middle card
        Positioned(
          top: 60,
          child: Container(
            height: 178,
            width: 287,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Topmost card
        Positioned(
          top: 0,
          child: Container(
            height: 264,
            width: 387,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(cardImage),
                fit: BoxFit.cover,
              ),
            ),
            // Optionally, overlay text / details here:
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ownerName,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    cardName,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    cardNumber,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    balance,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
