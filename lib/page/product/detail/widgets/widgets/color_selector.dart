import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/component/input/textfiled_input.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/option_product_detail.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/page/product/detail/product_detail_bloc.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

import 'dropdown/dropdown_option_products.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  // final List<Option> options;
  final String? selectedSize;

//  final Function(String) onSizeSelected;
  // final void Function(String?)? onChangedValueInput;
  final Function(Color) onColorSelected;
  //  final void Function(ValueOptionProduct? value) onChangeValueDropdown;
  // final void Function() onTapSelectItem;
  final ProductDetailBloc bloc;
//  final Color? selectedColor;
  const ColorSelector(
      {required this.colors,
      required this.onColorSelected,
      // required this.options,
      //    this.selectedColor,
      //   this.onChangedValueInput,
      required this.bloc,
      this.selectedSize,
      //   required this.onTapSelectItem,
      //    required this.onChangeValueDropdown,
      //     required this.onSizeSelected,
      Key? key})
      : super(key: key);

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color? selectedColor;
  String? selectedSize;
//  late ProductDetailBloc _productDetailBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          // Bạn có thể lấy bất kỳ thuộc tính nào từ state nếu cần thiết
          // Ví dụ: final isSelected = state.isSelected;

          return BlocSelector<ProductDetailBloc, ProductDetailState, bool>(
            selector: (selector) {
              return selector.isSelected;
            },
            builder: (context, selector) {
              return Column(
                key: ObjectKey(selector), // Cập nhật khi state thay đổi
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = state.options[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.title ?? '',
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (item.type == "field") ...[
                            TextFiledInputText(
                              keyboardType: TextInputType.name,
                              icon: const Icon(
                                Icons.input_sharp,
                                size: 26,
                              ),
                              hintext: 'Nhập giá trị',
                              onChanged: (name) {
                                //   widget.onChangedValueInput?.call(name);
                              },
                              isClear: true,
                            ),
                          ] else if (item.type == "dropdown") ...[
                            DropDownOptionProducts(
                              label: 'Chọn ${item.title ?? ''}',
                              isDense: true,
                              onChanged: (value) {
                                //    widget.onChangeValueDropdown(value);
                              },
                              reasonList: item.values!,
                            ),
                          ] else ...[
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    direction: Axis.horizontal,
                                    children: item.values!
                                        .map((itemSelected) => _item(
                                              selectedValue: itemSelected,
                                              onTap: () {
                                                widget.bloc
                                                    .onSelectAttributeValue(
                                                        option: item,
                                                        selectedValue:
                                                            itemSelected,
                                                        listOptions:
                                                            state.options);
                                              },
                                              context,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ],
                      );
                    },
                    itemCount: state.options.length,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _item(BuildContext context,
      {required ValueOptionProduct selectedValue, required void Function() onTap
      // required void Function({required bool valueChange}) onChangeValueDropdown,
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedValue.isSelected == true ? colorMain : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          selectedValue.title ?? '',
          style: TextStyle(
            color: selectedValue.isSelected == true ? colorMain : Colors.black,
          ),
        ),
      ),
    );
  }
}
