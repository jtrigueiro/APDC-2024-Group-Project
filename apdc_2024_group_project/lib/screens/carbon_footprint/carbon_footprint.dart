import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CarbonFootprintScreen extends StatefulWidget {
  CarbonFootprintScreen({super.key});

  @override
  CarbonFootprintScreenState createState() => CarbonFootprintScreenState();
}

class CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  Map<String, double> carbonMap = {
    'Food': 10,
    'Transport': 30,
  };

  List<Color> colorList = [
    const Color.fromARGB(255, 122, 143, 122),
    const Color.fromARGB(255, 8, 76, 8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('My Carbon Footprint',
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      const Icon(Icons.eco,
                        color: Color.fromARGB(255, 122, 143, 122),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: PieChart(
                    dataMap: carbonMap,
                    colorList: colorList,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 70,
                    chartRadius: MediaQuery.of(context).size.width * 0.6,
                    centerText: 'CO2',
                    centerTextStyle: Theme.of(context).textTheme.bodySmall,
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.bottom,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      chartValueStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white54),
                      showChartValueBackground: false,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,

                    ),
                    animationDuration: const Duration(seconds: 1),
                    emptyColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 10, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.food_bank_outlined,
                            color: colorList[0],
                          ),
                          const SizedBox(width: 5),
                          Text('Food ',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 60),
                          Text(carbonMap.values.first.toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.emoji_transportation,
                            color: colorList[0],
                          ),
                          const SizedBox(width: 5),
                          Text('Transport ',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 12),
                          Text(carbonMap.values.last.toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
