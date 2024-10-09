import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haruviet/component/input/textfiled_input.dart';
import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/value_product_detail.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/page/product/detail/product_detail_bloc.dart';
import 'package:haruviet/page/product/detail/product_detail_state.dart';
import 'package:haruviet/page/product/detail/widgets/widgets/selector/selector_option_products.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';

import 'dropdown/dropdown_option_products.dart';

class WidgetValueSelect extends StatefulWidget {
  final String? selectedSize;
  final ProductDetailBloc bloc;

  const WidgetValueSelect({required this.bloc, this.selectedSize, Key? key})
      : super(key: key);

  @override
  State<WidgetValueSelect> createState() => _WidgetValueSelectState();
}

class _WidgetValueSelectState extends State<WidgetValueSelect> {
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
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                        item?.title ?? '',
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (item?.type == "field") ...[
                    TextFiledInputText(
                      onClearText: () {
                        item?.values?[0].note = '';
                      },
                      icon: null,
                      hintext: 'Nhập giá trị',
                      initialText: item?.values?[0].note,
                      onChanged: (value) {
                        widget.bloc.onFieldAttributeValue(
                            idOption: item?.id ?? '',
                            index: index,
                            value: value);
                      },
                    ),
                    spaceH12,
                  ] else if (item?.type == "dropdown") ...[
                    DropDownOptionProducts(
                      label: 'Chọn ${item?.title ?? ''}',
                      isDense: true,
                      onChanged: (value) {
                        widget.bloc.onChangeValueDropdownAttribute(
                            index: index,
                            selectedValue: value!,
                            idOption: item.id ?? '');
                      },
                      item: item!,
                    ),
                    spaceH12,
                  ] else ...[
                    AttributeValueSelector(
                      item: item!,
                      onSelect: (selectedValue) {
                        widget.bloc.onSelectAttributeValue(
                            index: index,
                            selectedValue: selectedValue,
                            idOption: item.id ?? '');
                      },
                    ),
                    spaceH12,
                  ]
                ],
              );
            },
            itemCount: state.options.length,
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
          color: selectedValue.isSelected ? colorGray02 : null,
          border: Border.all(
            color: colorGray02,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          selectedValue.title ?? '',
          style: TextStyle(
            color: selectedValue.isSelected
                ? Theme.of(context).primaryColor
                : colorBlack,
          ),
        ),
      ),
    );
  }
}
