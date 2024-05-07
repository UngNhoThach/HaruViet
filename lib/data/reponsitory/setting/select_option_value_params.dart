import 'package:eco_app/data/reponsitory/setting/item_base_response.dart';
import 'package:eco_app/data/reponsitory/setting/option_value_base_list_request.dart';

class SelectOptionValueParams {
  SelectOptionValueParams({
    required this.option,
    required this.onChanged,
    required this.title,
    this.isHD = false,
  });
  final OptionValueBaseListRequest option;
  final void Function(ItemBaseResponse?) onChanged;
  final String title;
  final bool isHD;
}
