import'package:flutter/material.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
          ),
          child:  Row(
            children: [
              const Expanded(
                child:  TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),

                ),

              ),
              IconButton(
                icon: const Icon(Icons.camera_alt , color:pharmaGreenColor ,),
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}