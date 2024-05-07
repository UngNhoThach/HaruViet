import 'dart:ui';

import 'package:flutter/material.dart';

class StatusWithBoderLeft extends StatelessWidget {
  final int? status;
  final List<StatusConfig> statusConfigs;

  const StatusWithBoderLeft({
    Key? key,
    this.status,
    required this.statusConfigs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusConfig? selectedConfig = statusConfigs.firstWhere(
      (config) => config.status == status,
      orElse: () => StatusConfig(Colors.black, "Có lỗi diễn ra"),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          stops: const [0.04, 0.02],
          colors: [selectedConfig.color, selectedConfig.color.withOpacity(0.2)],
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Text(
        selectedConfig.statusText,
        style: TextStyle(
          color: selectedConfig.color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class StatusConfig {
  final Color color;
  final String statusText;
  final int? status;

  StatusConfig(this.color, this.statusText, {this.status});
}

class StatusWithBoder extends StatelessWidget {
  final int? status;
  final List<StatusConfig> statusConfigs;

  const StatusWithBoder({
    Key? key,
    this.status,
    required this.statusConfigs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusConfig? selectedConfig = statusConfigs.firstWhere(
      (config) => config.status == status,
      orElse: () => StatusConfig(Colors.black, "Có lỗi diễn ra"),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: selectedConfig.color,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: Text(
        selectedConfig.statusText,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
