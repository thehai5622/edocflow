import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DocumentSingleChart extends StatelessWidget {
  final Map<String, int> statusData;

  DocumentSingleChart({
    super.key,
    required this.statusData,
  });

  final List<String> statuses = [
    "canceled",
    "unprocessed",
    "pending_approval",
    "pending_release",
    "active",
    "overdue"
  ];

  final Map<String, String> statusLabels = {
    "canceled": "Đã hủy",
    "unprocessed": "Chưa xử lý",
    "pending_approval": "Chờ duyệt",
    "pending_release": "Chờ phát hành",
    "active": "Đang hoạt động",
    "overdue": "Quá hạn",
  };

  final List<Color> statusColors = [
    AppColor.grey, // canceled
    AppColor.dstatus1, // unprocessed
    AppColor.dstatus2, // pending_approval
    AppColor.dstatus3, // pending_release
    AppColor.dstatus4, // active
    AppColor.dstatus5, // overdue
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 4,
                        child: Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: DeviceHelper.getFontSize(16),
                            color: AppColor.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= statuses.length) {
                        return Container();
                      }
                      final statusKey = statuses[index];
                      final label = statusLabels[statusKey] ?? statusKey;

                      return SideTitleWidget(
                        meta: meta,
                        space: 8,
                        child: Transform.rotate(
                          // angle: -0.75, // Xoay khoảng -43 độ
                          angle: -0.50,
                          child: Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: DeviceHelper.getFontSize(12),
                              color: AppColor.text1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(statuses.length, (index) {
                final key = statuses[index];
                final value = statusData[key] ?? 0;
                final color = statusColors[index];
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value.toDouble(),
                      color: color,
                      width: 16,
                    ),
                  ],
                );
              }),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: true),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
