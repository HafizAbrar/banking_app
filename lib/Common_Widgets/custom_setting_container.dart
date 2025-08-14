import 'package:flutter/material.dart';

Widget customSettingContainer({
  required String title,
  VoidCallback? onPress,
  String? contactNumber,
  Icon? icon,
}) {
  return Container(
    height: 36,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            if (contactNumber != null && contactNumber.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  contactNumber,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            if (onPress != null)
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: icon ?? Icon(Icons.arrow_forward_ios),
                  onPressed: onPress,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
