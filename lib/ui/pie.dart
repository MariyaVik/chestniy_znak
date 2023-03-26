import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/my_data.dart';

class PieChartSample1 extends StatefulWidget {
  final String title;
  final List<List<MyData>> data;
  final List<String> categories;
  const PieChartSample1(
      {this.title = '',
      required this.data,
      required this.categories,
      super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State<PieChartSample1> {
  int touchedIndex = -1;

  List<Color> colors = [
    const Color(0xFFA85CCC),
    const Color(0xFF40BE2C),
    const Color(0xFFDD5EA1),
    const Color(0xFFE0E535),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Выручка по группам товаров',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 300,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 28,
                width: 28,
              ),

              // const SizedBox(
              //   height: 18,
              //   width: 18,
              // ),
              ...widget.data.map(
                (e) => SizedBox(
                  height: MediaQuery.of(context).size.width /
                      (widget.categories.length + 1),
                  width: MediaQuery.of(context).size.width /
                      (widget.categories.length + 1),
                  // flex: 2,
                  child: Column(
                    children: [
                      Text(
                        widget.categories[widget.data.indexOf(e)],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            startDegreeOffset: 180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 1,
                            centerSpaceRadius: 0,
                            sections: showingSections(e),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                // flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.data[0]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Indicator(
                              color: colors[
                                  widget.data[0].indexOf(e) % colors.length],
                              text: e.category,
                              isSquare: false,
                              size: touchedIndex == widget.data[0].indexOf(e)
                                  ? 18
                                  : 16,
                              textColor:
                                  touchedIndex == widget.data[0].indexOf(e)
                                      ? Colors.black
                                      : Colors.grey,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(List<MyData> data) {
    return List.generate(
      data.length,
      (i) {
        final isTouched = i == touchedIndex;

        return PieChartSectionData(
          color: colors[i % colors.length],
          value: data[i].percent.toDouble(),
          title: '${data[i].percent.round()}%',
          titleStyle: const TextStyle(fontSize: 20),
          titlePositionPercentageOffset: 0.7,
          radius: isTouched
              ? 120
              : MediaQuery.of(context).size.width /
                  (widget.categories.length + 1) /
                  2.5,
          // borderSide: isTouched
          //     ? const BorderSide(color: AppColors.contentColorWhite, width: 6)
          //     : BorderSide(color: AppColors.contentColorWhite.withOpacity(0)),
        );
      },
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        )
      ],
    );
  }
}
