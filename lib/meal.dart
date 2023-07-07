import 'package:flutter/material.dart';

void main() {
  runApp(MealSuggestions());
}

class MealSuggestions extends StatelessWidget {
  final Map<String, String> mealData = {
    'Monday': 'Channay, Biryani',
    'Tuesday': 'Alu Anda, Daal',
    'Wednesday': 'Omelette, Sabzi',
    'Thursday': 'Channay, Chicken',
    'Friday': 'Alo Anda, Palao',
    'Saturday': 'Channay, Kari Pakora',
    'Sunday': 'Alo Anda, Sabzi',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height-450,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: mealData.length,
            itemBuilder: (context, index) {
              String day = mealData.keys.elementAt(index);
              String meals = mealData[day]!;
              return ListTile(
                title: Text(day),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Breakfast: ${meals.split(", ")[0]}'),
                    Text('Dinner: ${meals.split(", ")[1]}'),
                  ],
                ),
              );
            },
          ),
      ),
    );
  }
}
