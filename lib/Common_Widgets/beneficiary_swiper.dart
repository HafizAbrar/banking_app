import 'package:flutter/material.dart';

class BeneficiarySwiperItem extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final bool selected;
  final VoidCallback onTap;

  const BeneficiarySwiperItem({
    super.key,
    this.name,
    this.imageUrl,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue[900] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[300],
              backgroundImage: imageUrl != null ? AssetImage(imageUrl!) : null,
              child: imageUrl == null
                  ? const Icon(Icons.add, color: Colors.grey, size: 28)
                  : null,
            ),
            if (name != null) ...[
              const SizedBox(height: 8),
              Text(
                name!,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
