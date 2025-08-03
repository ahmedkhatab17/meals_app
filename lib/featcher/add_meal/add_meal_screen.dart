import 'package:day2_task/featcher/add_meal/widgets/custom_text_form_faild.dart';
import 'package:day2_task/featcher/home/database/db_helper.dart';
import 'package:day2_task/featcher/home/home_screen.dart';
import 'package:day2_task/featcher/home/models/meal_model.dart';
import 'package:flutter/material.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController mealController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Add Meal'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text('Meal Name'),
                      SizedBox(height: 5),
                      CustomTextField(
                        width: size.width,
                        controller: mealController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty && value.length < 3) {
                            return 'Please Enter Meal Name or at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text('Image Url'),
                      SizedBox(height: 5),
                      CustomTextField(
                        width: size.width,
                        controller: imageUrlController,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Image Url';
                          } else if (!value.contains('http')) {
                            return '@';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text('Rate'),
                      SizedBox(height: 5),
                      CustomTextField(
                        width: size.width,
                        controller: rateController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Rate';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text('Time'),
                      SizedBox(height: 5),
                      CustomTextField(
                        width: size.width,
                        controller: timeController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Time';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text('Description'),
                      SizedBox(height: 5),
                      CustomTextField(
                        width: size.width,
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SizedBox(
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  MealModel mealModel = MealModel(
                    imageUrl: imageUrlController.text,
                    name: mealController.text,
                    description: descriptionController.text,
                    rate: double.parse(rateController.text),
                    time: timeController.text,
                  );

                  DatabaseHelper.instance.insertMeal(mealModel).then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  });
                }
              },
              child: Text('add meal', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
