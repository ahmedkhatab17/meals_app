import 'package:day2_task/featcher/add_meal/add_meal_screen.dart';
import 'package:day2_task/featcher/home/database/db_helper.dart';
import 'package:day2_task/featcher/meal_details/meal_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> meals = const [
    {'image': 'assets/pngs/meal.png', 'title': 'Cheese Burger'},
    {'image': 'assets/pngs/meal2.jpg', 'title': 'Pasta'},
    {'image': 'assets/pngs/meal3.jpg', 'title': 'Breakfast'},
    {'image': 'assets/pngs/meal4.jpg', 'title': 'Fries'},
  ];

  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMealScreen()),
          );
        },
      ),
      body: SizedBox(
        width: size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/pngs/home_banner.png', fit: BoxFit.cover),
                Positioned(
                  bottom: 20,
                  left: 30,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        'Welcome\nAdd A New\nRecipe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Your Food',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder(
                  future: databaseHelper.getMeals(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final mealModel = snapshot.data!;
                      if (snapshot.data!.isEmpty) {
                        return Center(child: Text('no meals found'));
                      }
                      return GridView.builder(
                        itemCount: mealModel.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          final meal = mealModel[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          MealDetailsScreen(mealModel: meal),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  meal.imageUrl.startsWith('http')
                                      ? Image.network(
                                        meal.imageUrl,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        meal.imageUrl,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                  SizedBox(height: 8),
                                  Text(meal.name),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/pngs/star.svg'),
                                      SizedBox(width: 5),
                                      Text(meal.rate.toString()),
                                      Spacer(),
                                      SvgPicture.asset('assets/pngs/clock.svg'),
                                      SizedBox(width: 5),
                                      Text(meal.time),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
