import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/local/db/storage_repo.dart';
import 'package:flutter_defualt_project/ui/app_routes.dart';
import 'package:flutter_defualt_project/utils/constants.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    _init();
    super.initState();
  }


  _init()async{
    await Future.delayed(const Duration(seconds: 3));
    if(context.mounted){
      StorageRepository.getBool('isBoarding')? Navigator.pushReplacementNamed(context, RouteNames.home): Navigator.pushReplacementNamed(context, RouteNames.onBoarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('assets/lottie/splash_lottie.json'),)
    );
  }
}
