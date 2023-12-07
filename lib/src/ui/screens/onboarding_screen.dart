import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: PageView.builder(
              controller: _pageController,
              itemCount: onboarding_data.length,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
                if (index == onboarding_data.length - 1) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage()));
                  });
                }
              },
              itemBuilder: (context, index) => OnBoardContent(
                    image: onboarding_data[index].image,
                    description: onboarding_data[index].description,
                  )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                onboarding_data.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    )),
            const SizedBox(width: 30),
            SizedBox(
                height: 100,
                width: 70,
                child: TextButton(
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontStyle: FontStyle.italic
                    ,fontWeight: FontWeight.w500,color: pharmaGreenColor,fontSize:20),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage()));
                  },
                )
                ),
          ],
        )
      ],
    )));
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 12,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? pharmaGreenColor : pharmaGreenColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnBoard {
  final String image, description;

  OnBoard({
    required this.image,
    required this.description,
  });
}

final List<OnBoard> onboarding_data = [
  OnBoard(
    image: "assets/images/onboarding_image_1.png",
    description: "Find the nearest pharmacy to your location",
  ),
  OnBoard(
    image: "assets/images/onboarding_image_2.png",
    description: "Consult our chatbot",
  ),
  OnBoard(
    image: "assets/images/onboarding_image_3.png",
    description: "Look for an alternative drug ",
  ),
  OnBoard(
    image: "assets/images/onboarding_image_4.png",
    description: "Request for a stock up ",
  )
];

class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    Key? key,
    required this.image,
    required this.description,
    this.title,
  }) : super(key: key);

  final String image, description;
  String? title;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        return Column(
          children: [
            const Spacer(),
            // const SizedBox(height:1),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset(
                image,
                height: screenWidth * 1.1,
                width: screenWidth * 1.1,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            // const SizedBox(
            //   height: 50,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
                height: screenWidth * 0.4,
                width: screenWidth * 0.9,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    description,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: screenWidth * 0.09,
                        ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
