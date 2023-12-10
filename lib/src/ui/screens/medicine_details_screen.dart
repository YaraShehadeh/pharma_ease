import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/screens/MedicineSearch/search_medicine_screen.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

import '../../model/medicine_model.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final DrugModel medicine;

  const MedicineDetailsScreen({Key? key, required this.medicine})
      : super(key: key);

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  int currentIndex = 0;
  bool isExpanded = false;
  late String fullText;

  late String summaryText;

  @override
  void initState() {
    super.initState();
    fullText = widget.medicine.drugDescription;
    updateSummaryText();
  }

  void updateSummaryText() {
    // Display all words if less than 30
    final words = fullText.split(' ');
    final displayWords = isExpanded ? words : words.take(10).toList();
    summaryText = displayWords.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: pharmaGreenColor),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MedicineListScreen()));
          },
        ),
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: pharmaGreenColor),
            onPressed: () { Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MapPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              if (widget.medicine.drugImages.length == 1)
                Image.asset(
                  widget.medicine.drugImages[0],
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                SizedBox(
                  height: 350,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        itemCount: widget.medicine.drugImages.length,
                        controller: PageController(initialPage: currentIndex),
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            widget.medicine.drugImages[index],
                            height: MediaQuery.of(context).size.height * 2,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 8,
                        child: Row(
                          children: List.generate(
                            widget.medicine.drugImages.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.medicine.drugName,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.medicine.drugPerscription,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                    updateSummaryText();
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: summaryText,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            if (!isExpanded)
                              const TextSpan(
                                text: ' Read more',
                                style: TextStyle(color: Colors.blue),
                              ),
                            if (isExpanded)
                              const TextSpan(
                                text: ' Read less',
                                style: TextStyle(color: Colors.blue),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Rounded Container under the Description section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 17),
                    decoration: BoxDecoration(
                      color: pharmaGreenColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Is carried in",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Available in  ${widget.medicine.holdingPharmacies} pharmacies near you",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Medical Interactions",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Flexible(
                    child: Text(
                      "Using this medicine with any of the following medicines is usually not recommended, but may be required in some cases. If both medicines are prescribed together, your doctor may change the dose or how often you use one or both of the medicines.",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF199A8E),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 17),
                    decoration: BoxDecoration(
                      color: const Color(0xFF199A8E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.alt_route_outlined,
                          size: 26,
                          color: Colors.white,
                        ),
                        SizedBox(width: 9),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              Text(
                                "View Drug alternatives",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
