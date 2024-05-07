import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 12),
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Thanh toán hoàn tất",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: colorBlack,
                                  fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: const Icon(Icons.close), onPressed: () {})
                    ],
                  ),
                  Text(
                    "Cảm ơn bạn vì đã mua hàng mã đơn #234234, đơn hàng của bạn sẽ được vận chuyển trong vòng 2-3 ngày.",
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: textTheme.bodyMedium?.copyWith(
                        color: colorGray03, fontWeight: FontWeight.w500),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}
