import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/ui/home/home_screen.dart';
import 'package:flutter_defualt_project/utils/constants.dart';

import '../../data/local/db/storage_repo.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StorageRepository.putBool('isBoarding', false);
    return Scaffold(    
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
              regions.length,
              (index) => Center(
                  child: GestureDetector(
                      onTap: () {
                        region = regions[index];
                        StorageRepository.putString('region', region);
                        StorageRepository.putBool('isBoarding', true);
                        if (context.mounted) {
                          Navigator.pushNamed(
                              context, RouteNames.home);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                          child: Text(regionsEng[index])))))
        ],
      ),
    );
  }
}
