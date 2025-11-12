import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 231),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Image.asset(
              'assets/images/headphones.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Explore \nthe Best \nProducts',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 45),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                elevation: 10,
                shadowColor: Colors.brown,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(fontSize: 32),
              ),
            ),
          )
        ],
      ),
    );
  }
}
