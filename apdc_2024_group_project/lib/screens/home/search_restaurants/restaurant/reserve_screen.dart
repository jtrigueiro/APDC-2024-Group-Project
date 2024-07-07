import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';

class ReserveScreen extends StatefulWidget {

  Restaurant restaurant;
  DateTime day;

  ReserveScreen({super.key, required this.restaurant, required this.day});

  @override
  ReserveScreenState createState() => ReserveScreenState();
}

class ReserveScreenState extends State<ReserveScreen> {
  List<String> daysWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  List<String> openDays = [];
  List<Set<TimeOfDay>> openHours = [{}, {}, {}, {}, {}, {}, {}];
  List<Dish> dishes = [];
  List<Dish> checkout = [];
  late String? _selectedDay;
  late TimeOfDay? _selectedTime;
  late DateTime selectedDate;
  int _selectedIndex = 0;
  bool loading = true;

  
  @override
  initState() {
    super.initState();
    selectedDate = widget.day;
    constructSchedule(widget.restaurant.isOpen);
    getDishes();
  }

  void constructSchedule(List<bool> isOpen) {
    for(int i = 0; i < 7; i++) {
      if(isOpen[i]) {
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

    _selectedDay = daysWeek[widget.day.weekday - 1];
    _selectedTime = openHours[widget.day.weekday - 1].first;

    setState(() {
      loading = false;
    });
  }

  void getDishes() {
    DatabaseService().getAllRestaurantDishes(widget.restaurant.id).then((value) {
      setState(() {
        dishes = value;
      });
    });
  }

  Column dateSelection() {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text('Selected Date and Time')),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 14)),
                  selectableDayPredicate: (day) {
                    return widget.restaurant.isOpen[day.weekday - 1];
                  },
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                      _selectedDay = daysWeek[selectedDate.weekday - 1];
                    });
                  }
                });
              },
              child: Text('$_selectedDay: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),),
            const SizedBox(width: 20.0),
            Center( child: _buildTimeDropdownMenu(openHours[selectedDate.weekday - 1]),)
          ],),
        ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve a Table'),
      ),
      body: loading ? const LoadingScreen() : (_selectedIndex == 0) ? Stack(
          children: [
            dateSelection(),
            Align(
              alignment: const Alignment(0, 0.95),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: const Text('N E X T'),
              ),
            ),
          ]
        ) : 
        Stack(
          children: [
            _buildMenuItems(dishes),
            const SizedBox(height: 20.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton (
                  onPressed: () {
                    if(checkout.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: const Text('Add items to cart first!'),
                        animation: CurvedAnimation(parent: const AlwaysStoppedAnimation(1), curve: Curves.easeInOut),
                        duration: const Duration(seconds: 2),
                      ));
                      return;
                    }
                    else { showModalBottomSheet(context: context, builder: (context) {
                      return Stack(
                          children: [
                            
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: checkout.length,
                                itemBuilder: (context, index) {
                                Dish dish = checkout[index];
                                return ListTile(
                                  title: Text(dish.name),
                                  subtitle: Text('${dish.price.toString()}€'),
                                  leading: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/burger.png'),
                                  ),
                                  trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                    checkout.removeAt(index);
                                    });
                              
                                    Navigator.of(context).pop();
                              
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content: Text('${dish.name} removed from cart'),
                                    animation: CurvedAnimation(parent: const AlwaysStoppedAnimation(1), curve: Curves.easeInOut),
                                    duration: const Duration(seconds: 2),
                                    ));
                              
                              
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                  ),
                                );
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Align(
                                alignment: const Alignment(0, 0.95),

                              child: ElevatedButton(
                                onPressed: () {
                                  
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Reservation Confirmation'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Please confirm the following details:'),
                                          const SizedBox(height: 10),
                                          Text('Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                                          Text('Time: ${_selectedTime!.format(context)}'),
                                          const SizedBox(height: 10),
                                          const Text('Items in cart:'),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 200,
                                            child: _buildMenuItems(checkout),
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
                                          onPressed: () async {
                                            Map<String, int> dishes = {};
                                            double cost = 0;

                                            for(Dish item in checkout) {
                                              if(!dishes.containsKey(item.id)) {
                                                dishes[item.id] = 1;
                                              } else {
                                                dishes[item.id] = dishes[item.id]! + 1;
                                              }
                                              cost += item.price;
                                            }

                                            DateTime time = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, _selectedTime!.hour, _selectedTime!.minute);

                                            await DatabaseService().addOrUpdateRestaurantReservationsData(widget.restaurant.id, widget.restaurant.name, dishes, cost, time);

                                            Navigator.popUntil(context, (route) => route.isFirst);
                                            
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Reservation Confirmed'),
                                                  content: const Text('Your reservation has been confirmed!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  });
                                },
                                child: const Text('M A K E  R E S E R V A T I O N'),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        );
                    });}
                  },
                  child: const Text('C H E C K O U T',
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
        ),
        ],
        ),
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

                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: Text('$quantity ${dishes[index].name} added to cart'),
                    animation: CurvedAnimation(parent: const AlwaysStoppedAnimation(1), curve: Curves.easeInOut),
                    duration: const Duration(seconds: 2),
                  ));
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