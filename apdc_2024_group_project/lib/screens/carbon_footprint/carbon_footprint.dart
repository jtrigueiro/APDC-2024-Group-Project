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
    const Color.fromARGB(255, 117, 85, 18),
    const Color.fromARGB(255, 182, 141, 64),
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
                      Text('My Carbon Footprint',
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(width: 10),
                      Icon(
                        Icons.eco,
                        color: Color.fromARGB(255, 182, 141, 64),
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
                          Theme.of(context).textTheme.bodyMedium ?? TextStyle(),
                      showChartValueBackground: false,
                      showChartValuesOutside: true,
                    ),
                    animationDuration: Duration(seconds: 1),
                    emptyColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.food_bank_outlined,
                            color: Color.fromARGB(255, 182, 141, 64),
                          ),
                          SizedBox(width: 5),
                          Text('Food ',
                              style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(width: 60),
                          Text(carbonMap.values.first.toString(),
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.emoji_transportation,
                            color: Color.fromARGB(255, 182, 141, 64),
                          ),
                          SizedBox(width: 5),
                          Text('Transport ',
                              style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(width: 12),
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
