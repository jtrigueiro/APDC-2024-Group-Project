import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/material.dart';

class ReserveScreen extends StatefulWidget {

  Restaurant restaurant;

  ReserveScreen({super.key, required this.restaurant});

  @override
  _ReserveScreenState createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  List<String> daysWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  Set<String> openDays = {};
  List<Set<TimeOfDay>> openHours = [{}, {}, {}, {}, {}, {}, {}];
  List<Dish> dishes = [];
  List<Dish> checkout = [];

  late String? _selectedDay;
  late TimeOfDay? _selectedTime;

  @override
  initState() {
    constructSchedule();
    getDishes();
    super.initState();
  }

  void constructSchedule() {
    for(int i = 0; i < 7; i++) {
      if(widget.restaurant.isOpen[i]) {
        openDays.add(daysWeek[i]);

        List<String> times = widget.restaurant.time[i].split('-');
        List<String> time = times[0].split(':');

        int currentHour = int.parse(time[0]);
        int currentMinute = int.parse(time[1]);
        while(currentHour < int.parse(times[1].split(':')[0])) {
          openHours[i].add(TimeOfDay(hour: currentHour, minute: currentMinute));
          currentHour++;
        }
      }
    }

    _selectedDay = openDays.first;
    _selectedTime = openHours[daysWeek.indexOf(_selectedDay!)].first;
  }

  void getDishes() {
    DatabaseService().getAllRestaurantDishes(widget.restaurant.id).then((value) {
      setState(() {
        dishes = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve a Table'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDropdownMenu(openDays),
                const SizedBox(width: 40.0),
                _buildTimeDropdownMenu(openHours[daysWeek.indexOf(_selectedDay!)]),
              ],
            ),
            const SizedBox(height: 50.0),
            _buildMenuItems(dishes),
            const SizedBox(height: 20.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    // TODO: Implement the functionality for the floating button
                  },
                  child: Text('Checkout (${checkout.length})'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu(Set<String> items) {
    return DropdownButton<String>(
      enableFeedback: true,
      menuMaxHeight: 100,
      value: _selectedDay,
      onChanged: (String? newValue) {
        setState(() {
          _selectedDay = newValue;
          _selectedTime = openHours[daysWeek.indexOf(_selectedDay!)].first;
        });
      },
      items: items
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  DropdownButton<TimeOfDay> _buildTimeDropdownMenu(Set<TimeOfDay> items) {
    return DropdownButton<TimeOfDay>(
      enableFeedback: true,
      menuMaxHeight: 400,
      value: _selectedTime,
      onChanged: (TimeOfDay? newValue) {
        setState(() {
          _selectedTime = newValue!;
        });
      },
      items: items
          .map<DropdownMenuItem<TimeOfDay>>((TimeOfDay value) {
        return DropdownMenuItem<TimeOfDay>(
          value: value,
          child: Text(value.format(context)),
        );
      }).toList(),
    );
  }

  Widget _buildMenuItems(List<Dish> menuItems) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      
      child: ListView.builder(
            itemCount: menuItems.length,
            physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            Dish menuItem = menuItems[index];
            return _buildDishTile(menuItem, index);
          },
        ),
    );
  }

  void _buildDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
            title: const Text('Add to Cart'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select quantity:'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            setState(() {
                            quantity--;
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$quantity'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if(quantity < 10) {
                                quantity++;
                            }
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  for(int i = 0; i < quantity; i++) {
                    checkout.add(dishes[index]);
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Add to Cart'),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildDishTile(Dish dish, int index) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        _buildDialog(index);
      },
      child: Card(
        elevation: 4,
        child: ListTile(
        title: Text(dish.name),
        subtitle: Text('${dish.price.toString()}€\n${dish.description}'),
        isThreeLine: true,
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/burger.png'),
        ),
        ),
      ),
    );
  }
}