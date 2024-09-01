import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSizeSelected;
  final String? selectedSize;

  const SizeSelector({
    required this.sizes,
    required this.onSizeSelected,
    this.selectedSize,
    Key? key,
  }) : super(key: key);

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? selectedSize;
  @override
  void initState() {
    selectedSize = widget.selectedSize;
    super.initState();
  }

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
              'Size',
              style: textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: widget.sizes.map((size) {
            bool isSelected = size == selectedSize;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
                widget.onSizeSelected(size);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? colorMain : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? colorMain : Colors.black,
                      ),
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
