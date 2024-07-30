import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onColorSelected;

  const ColorSelector(
      {required this.colors, required this.onColorSelected, Key? key})
      : super(key: key);

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Màu sắc',
              style: textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: widget.colors.map((color) {
            bool isSelected = color == selectedColor;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
                widget.onColorSelected(color);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: isSelected ? colorMain : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  if (isSelected)
                    const Positioned(
                      right: 4,
                      top: 4,
                      child: Icon(
                        Icons.check,
                        color: colorMain,
                        size: 16,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
