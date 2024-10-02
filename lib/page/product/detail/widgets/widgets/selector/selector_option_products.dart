import 'package:flutter/material.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/helper/colors.dart';

class AttributeValueSelector extends StatelessWidget {
  const AttributeValueSelector({
    Key? key,
    required this.item,
    required this.onSelect,
  }) : super(key: key);

  final Option item;
  final void Function(ValueOptionProduct selectedValue) onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            direction: Axis.horizontal,
            children: item.values!
                .map((itemSelected) => _buildItem(
                      selectedValue: itemSelected,
                      onTap: () {
                        onSelect(
                            itemSelected); // Gọi hàm onSelect khi chọn item
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildItem({
    required ValueOptionProduct selectedValue,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedValue.isSelected ? colorGray02 : null,
          border: Border.all(
            color: colorGray02,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          selectedValue.title ?? '',
          style: TextStyle(
            color: selectedValue.isSelected ? colorMain : colorBlack,
          ),
        ),
      ),
    );
  }
}
