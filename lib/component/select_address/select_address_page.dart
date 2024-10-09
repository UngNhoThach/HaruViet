import 'package:haruviet/component/input/search_bar.dart';
import 'package:haruviet/component/loading/loading.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'models/select_address_params.dart';
import 'models/select_address_step.dart';
import 'select_address_bloc.dart';
import 'select_address_state.dart';
import 'widgets/popup_input_address.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key, required this.params});

  final SelectAddressParams params;

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  late SelectAddressBloc bloc;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    bloc = SelectAddressBloc()..getData(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SelectAddressBloc, SelectAddressState>(
            listenWhen: (previous, current) =>
                previous.isSelect != current.isSelect &&
                current.isSelect == true,
            listener: (context, state) async {
              if (state.step == SelectAddressStep.address) {
                if (widget.params.isNotAddress) {
                  context.justBack();
                  widget.params.onChange(state.dataAddress);
                } else {
                  PopupInputAddress.show(
                    context,
                    isRequired: widget.params.isRequiredAddress,
                    onChange: (value) {
                      bloc.onSubmit(value);
                    },
                  );
                }
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectAddressPage(
                      params: SelectAddressParams(
                        step: state.step,
                        dataAddress: state.dataAddress,
                        onChange: widget.params.onChange,
                        isRequiredAddress: widget.params.isRequiredAddress,
                        isNotAddress: widget.params.isNotAddress,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<SelectAddressBloc, SelectAddressState>(
            listenWhen: (previous, current) =>
                previous.isSubmitSuccess != current.isSubmitSuccess &&
                current.isSubmitSuccess == true,
            listener: (context, state) {
              context.justBack();
              widget.params.onChange(state.dataAddress);
            },
          ),
        ],
        child: BlocBuilder<SelectAddressBloc, SelectAddressState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: colorWhite,
              appBar: AppBar(
                title: _isSearching
                    ? _buildSearchField()
                    : Text(
                        'Chọn ${widget.params.step?.value ?? SelectAddressStep.city.value}',
                        style: textTheme.titleMedium?.copyWith(
                            color: colorWhite, fontWeight: FontWeight.bold),
                      ),
                actions: [
                  IconButton(
                    icon: Icon(_isSearching ? Icons.close : Icons.search),
                    onPressed: () {
                      if (_isSearching) {
                        bloc.onSearch('');
                      }
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                  ),
                ],
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: state.isLoading
                  ? const LoadingLogo()
                  : ListView.separated(
                      padding: EdgeInsets.only(
                        top: 16.h,
                        right: 16.w,
                        bottom: 72.h,
                        left: 16.w,
                      ),
                      itemBuilder: (context, index) {
                        final item = state.dataSearchList[index];
                        return InkWell(
                          onTap: () {
                            bloc.onSelect(item);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Text(
                                    item.name ?? '',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: context.appColorScheme
                                          .colorExtendedTextBodyMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.dataSearchList.length,
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return AppSearchBar(
      hintText: 'Tìm kiếm',
      onChanged: (keyword) {
        bloc.onSearch(keyword);
      },
    );
  }
}
