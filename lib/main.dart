import 'package:day2_task/featcher/home/database/db_helper.dart';
import 'package:day2_task/featcher/home/models/meal_model.dart';
import 'package:day2_task/featcher/splash/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper databaseHelper = DatabaseHelper();

  MealModel burgerAssetModel = MealModel(
    imageUrl: 'assets/pngs/meal.png',
    name: "Cheese Burger",
    description:
        "Sink your teeth into our Cheese Burger – a juicy grilled beef patty topped with melted cheese, fresh lettuce, tomatoes, and house sauce in a toasted bun. Perfect with a side of fries.",
    rate: 4.5,
    time: '5 - 10',
  );

  MealModel pastaModel = MealModel(
    imageUrl: 'assets/pngs/meal2.jpg',
    name: "Pasta",
    description:
        "Delight in our creamy Alfredo or spicy Arrabbiata Pasta – cooked to perfection with flavorful sauces and topped with fresh herbs and parmesan. A comforting classic!",
    rate: 4.7,
    time: '10 - 15',
  );

  MealModel breakfastModel = MealModel(
    imageUrl: 'assets/pngs/meal3.jpg',
    name: "Breakfast",
    description:
        "Start your day right with our hearty Breakfast – eggs, toast, sausage, and hash browns served with juice or coffee. Fuel up for whatever comes next!",
    rate: 4.2,
    time: '3 - 7',
  );

  MealModel friesModel = MealModel(
    imageUrl: 'assets/pngs/meal4.jpg',
    name: "Fries",
    description:
        "Crispy golden fries fried to perfection, seasoned with sea salt, and served hot. Ideal as a side or snack on the go!",
    rate: 4.6,
    time: '2 - 5',
  );
  MealModel pizzaModel = MealModel(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIibPbOeDQQscm9g-fDNdCvROokQJukg8nYQ&s',
    name: "pizza",
    description:
        "Indulge in our Ultimate Pizza Feast – a perfect blend of crispy crust, rich tomato sauce, and gooey melted cheese, loaded with your favorite toppings! Choose from classic Margherita, spicy Pepperoni, savory BBQ Chicken, or a loaded Veggie Delight. Each slice is packed with flavor, baked to golden perfection, and best enjoyed hot & fresh!",
    rate: 5.0,
    time: '10 - 15',
  );

  await databaseHelper.clearMeals();

  await databaseHelper.insertMeal(friesModel);
  await databaseHelper.insertMeal(breakfastModel);
  await databaseHelper.insertMeal(pastaModel);
  await databaseHelper.insertMeal(burgerAssetModel);
  await databaseHelper.insertMeal(pizzaModel);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
