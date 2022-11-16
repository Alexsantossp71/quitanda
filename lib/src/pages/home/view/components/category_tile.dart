import 'package:flutter/material.dart';
import 'package:greengrocery/src/config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
              color: isSelected
                  ? CustomColors.customSwacthColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : CustomColors.customContrastColor,
                fontSize: isSelected ? 16 : 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
