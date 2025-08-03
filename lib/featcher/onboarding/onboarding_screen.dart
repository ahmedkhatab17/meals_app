import 'package:carousel_slider/carousel_slider.dart';
import 'package:day2_task/featcher/home/home_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> titles = [
    'Save Your \nMeals \nIngredient',
    'Use Our App \nThe Best \nChoice',
    'Our App Your \nUltimate Choice',
  ];

  final List<String> descriptions = [
    'Add Your Meals and its \n Ingredients and we will \n save it for you',
    'The best choice for \n your kitchen, \ndo not  hesitate',
    'All the best restaurants\n and their top menus\n are ready for you',
  ];

  final CarouselSliderController controller = CarouselSliderController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pngs/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Bottom Container
          Positioned(
            bottom: 30,
            left: 32,
            right: 32,
            child: Container(
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: Colors.orange.withOpacity(0.9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Carousel Slider with controller
                  CarouselSlider.builder(
                    itemCount: titles.length,
                    carouselController: controller,
                    itemBuilder: (context, index, realIndex) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            titles[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            descriptions[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 280,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Dots Indicator
                  DotsIndicator(
                    dotsCount: titles.length,
                    position: currentIndex.toDouble(),
                    decorator: const DotsDecorator(
                      activeColor: Colors.white,
                      color: Colors.white54,
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Spacer(),

                  // Conditional Buttons
                  currentIndex == titles.length - 1
                      ? InkWell(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isFirstTime', false);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.orange,
                          ),
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              // Optional: Jump to last
                              controller.animateToPage(titles.length - 1);
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (currentIndex < titles.length - 1) {
                                controller.nextPage();
                              }
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
