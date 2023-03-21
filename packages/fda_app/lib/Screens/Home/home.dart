import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_project/Screens/History/history.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.black87,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          'images/profile.png',
          height: 120,
          width: 120,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Chu Duc Anh',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        const SizedBox(
          height: 1,
        ),
        const Text(
          'chuducanh@gmail.com',
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 30,
              ),
              FaIcon(
                FontAwesomeIcons.userClock,
                color: Colors.red,
                size: 45,
              ),
              SizedBox(
                width: 48,
              ),
              FaIcon(
                FontAwesomeIcons.check,
                color: Colors.green,
                size: 45,
              ),
              SizedBox(
                width: 43,
              ),
              FaIcon(
                FontAwesomeIcons.bed,
                color: Colors.orange,
                size: 45,
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                width: 40,
              ),
              Text(
                '0',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                width: 75,
              ),
              Text(
                '9',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                width: 70,
              ),
              Text(
                '1',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Thứ bảy, 18/03/2023  Hôm nay',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Đã điểm danh vào lúc 9h02',
          style: TextStyle(color: Colors.orange, fontSize: 18),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const History()),
            );
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 230, 218, 229),
                      Color.fromARGB(255, 58, 53, 50),
                      Color.fromARGB(255, 63, 60, 60),
                    ])),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Lịch sử điểm danh',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    )));
  }
}
