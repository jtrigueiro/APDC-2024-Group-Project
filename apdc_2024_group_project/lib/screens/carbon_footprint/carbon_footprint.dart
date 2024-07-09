import 'package:adc_group_project/services/firestore_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CarbonFootprintScreen extends StatefulWidget {

  CarbonFootprintScreen({super.key});

  @override
  CarbonFootprintScreenState createState() => CarbonFootprintScreenState();
}

class CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  late ScrollController scrollController;
  List<String> emissions = [];

  @override
  void initState() {
    getUserEmissions();
    scrollController = ScrollController();
    super.initState();
  }

  void getUserEmissions() async {
    emissions = await DatabaseService().getUserEmissions();

    setState(() {
      carbonMap = {
        'Food': double.parse(emissions[0]),
        'Transport': 2.0,
      };
    });
  }

  Map<String, double> carbonMap = {
    'Food': 50,
    'Transport': 50,
  };

  List<Color> colorList = [
    const Color.fromARGB(255, 61, 130, 20),
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
                          Text('${carbonMap.values.first.toString()} g CO2e',
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
                          Text('${carbonMap.values.last.toString()} g CO2e',
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
