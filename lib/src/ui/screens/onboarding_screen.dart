import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/map_page.dart';

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
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MapPage()));
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
            SizedBox(width: 40),
            SizedBox(
              height: 100,
              width: 60,
              child: ElevatedButton(
                  onPressed: () {
                    if (_pageIndex == onboarding_data.length - 1) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MapPage()));
                      });
                    } else {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Color(0xFF199A8E)),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
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
        color:
            isActive ? Color(0xFF199A8E) : Color(0xFF199A8E).withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
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
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 350,
          width: 450,
        ),
        const Spacer(),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          height: 150,
          width: 350,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              description,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 30),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
