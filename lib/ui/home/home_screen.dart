import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/models/namaz_time_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';
import 'package:flutter_defualt_project/data/network/api_repository.dart';
import 'package:flutter_defualt_project/ui/home/widgets/row_items.dart';
import 'package:flutter_defualt_project/utils/colors.dart';
import 'package:flutter_defualt_project/utils/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiProvider apiProvider = ApiProvider();
  late ApiRepository apiRepository;
  late NamazTimeModel? namazTimeModel;
  bool isLoading = true;
  String date ="";
  String titleString="";


  _getTime(String region) async {
    setState(() {
      isLoading = true;
    });
    namazTimeModel = await apiRepository.getDailyTime(region: region);
    date+= namazTimeModel!.date.substring(8);
    date+= convertMonth(namazTimeModel!.date.substring(5,7));
    date+= "${namazTimeModel!.date.substring(0,4)}-yil";
    if(!(DateTime.now().hour>=int.parse(namazTimeModel!.timesModel.tongSaharlik.substring(0,2)))){
      if(!(DateTime.now().minute>=int.parse(namazTimeModel!.timesModel.tongSaharlik.substring(3)))){
        titleString="Bomdod ${namazTimeModel!.timesModel.tongSaharlik}";
      }
    }
    else if(!(DateTime.now().hour>=int.parse(namazTimeModel!.timesModel.peshin.substring(0,2)))){
      if(!(DateTime.now().minute>=int.parse(namazTimeModel!.timesModel.peshin.substring(3)))){
        titleString="Peshin ${namazTimeModel!.timesModel.peshin}";
      }
    }
    else if(!(DateTime.now().hour>=int.parse(namazTimeModel!.timesModel.asr.substring(0,2)))){
      if(!(DateTime.now().minute>=int.parse(namazTimeModel!.timesModel.asr.substring(3)))){
        titleString="Asr ${namazTimeModel!.timesModel.asr}";
      }
    }
    else if(!(DateTime.now().hour>=int.parse(namazTimeModel!.timesModel.shomIftor.substring(0,2)))){
      if(!(DateTime.now().minute>=int.parse(namazTimeModel!.timesModel.shomIftor.substring(3)))){
        titleString="Shom ${namazTimeModel!.timesModel.shomIftor}";
      }
    }
    else if(!(DateTime.now().hour>=int.parse(namazTimeModel!.timesModel.hufton.substring(0,2)))){
      if(!(DateTime.now().minute>=int.parse(namazTimeModel!.timesModel.hufton.substring(3)))){
        titleString="Hufton ${namazTimeModel!.timesModel.hufton}";
      }
    }
    setState(() {
      isLoading = false;
    });
  }
  String convertMonth(String month){
    if(month=="01") {
      return " Yanvar ";
    } else if(month=="02") {
      return " Fevral ";
    } else if(month=="03") {
      return " Mart ";
    } else if(month=="04") {
      return " Aprel ";
    } else if(month=="05") {
      return " May ";
    } else if(month=="06") {
      return " Iyun ";
    } else if(month=="07") {
      return " Iyul ";
    } else if(month=="08") {
      return " Avgust ";
    } else if(month=="09") {
      return " Sentyabr ";
    } else if(month=="10") {
      return " Oktabr ";
    } else if(month=="11") {
      return " Noyabr ";
    } else {
      return " Dekabr ";
    }
  }

  @override
  void initState() {
    apiRepository = ApiRepository(apiProvider: apiProvider);
    _getTime("Toshkent");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Stack(
                  children: [
                    Image.asset(
                      AppImages.background,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Namoz vaqtlari\n",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  children: [
                                    TextSpan(
                                      text: "\n${namazTimeModel?.region}\n",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      children: [
                                        TextSpan(
                                          text: "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ZoomTapAnimation(
                                child: Image.asset(
                                  AppImages.notification,
                                  width: 47.w,
                                ),
                                onTap: () {},
                              )
                            ],
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          Text(
                            titleString,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Mo'min bilan kofirning farqi namozni tark etishidir.",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontSize: 16.sp),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          Container(
                            width: 306.w,
                            height: 52.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36.r),
                                color: AppColors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ZoomTapAnimation(
                                  child: const Icon(Icons.arrow_back_ios),
                                  onTap: () {},
                                ),
                                Text(
                                  date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black),
                                ),
                                ZoomTapAnimation(
                                  child: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          RowItems(
                            title: "Bomdod",
                            time: "${namazTimeModel?.timesModel.tongSaharlik}",
                            img: AppImages.bomdod,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Quyosh",
                            time: "${namazTimeModel?.timesModel.quyosh}",
                            img: AppImages.asr,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Peshin",
                            time: "${namazTimeModel?.timesModel.peshin}",
                            img: AppImages.peshin,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Asr",
                            time: "${namazTimeModel?.timesModel.asr}",
                            img: AppImages.asr,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Shom",
                            time: "${namazTimeModel?.timesModel.shomIftor}",
                            img: AppImages.bomdod,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Xufton",
                            time: "${namazTimeModel?.timesModel.hufton}",
                            img: AppImages.peshin,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
