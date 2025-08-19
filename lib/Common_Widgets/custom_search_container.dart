import 'package:flutter/material.dart';

Widget customSearchContainer({
  required String title,
  required String subTitle,
  required String icon,
  required VoidCallback onPress,
}) {
  return Container(
    height: 110,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Row(
        children: [
          /// <-- FIXED PART
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12),
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          /// Image on right side
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              icon,
              width: 105,
              height: 81,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
  );
}
