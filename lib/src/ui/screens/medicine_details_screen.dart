import 'package:flutter/material.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final List<String> images;

  const MedicineDetailsScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  int currentIndex = 0;
  bool isExpanded = false;
  String fullText =
      "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.";

  late String summaryText;

  @override
  void initState() {
    super.initState();
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:const Icon(Icons.arrow_back, color: Color(0xFF199A8E)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(''),
        actions: [
          IconButton(
            icon:const Icon(Icons.home, color: Color(0xFF199A8E)),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              if (widget.images.length == 1)
                Image.asset(
                  widget.images[0],
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
                        itemCount: widget.images.length,
                        controller: PageController(initialPage: currentIndex),
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            widget.images[index],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 8,
                        child: Row(
                          children: List.generate(
                            widget.images.length,
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Prednisolone",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "75ml",
                    style: TextStyle(color: Colors.grey),
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
                    width: 350,
                    padding:const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                    decoration: BoxDecoration(
                      color:const Color(0xFF199A8E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Is carried in",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Available in # pharmacies near you",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
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
                    style: TextStyle(color: Colors.grey,fontSize: 12),),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF199A8E),
                  ),
                ],
              ),
              const SizedBox(height:30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                    decoration: BoxDecoration(
                      color: const Color(0xFF199A8E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.alt_route_outlined,size: 26,color: Colors.white,),
                        SizedBox(width:9),
                        Padding(
                          padding:  EdgeInsets.only(top:5.0),
                          child: Row(
                            children: [
                              Text(
                                "View Drug alternatives",
                                style: TextStyle(
                                    fontSize:16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 90,),
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
              const SizedBox(height:30),
            ],
          ),
        ),
      ),
    );
  }
}
