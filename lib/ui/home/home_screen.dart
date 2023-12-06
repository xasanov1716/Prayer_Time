import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/data/local/db/storage_repo.dart';
import 'package:flutter_defualt_project/data/models/namaz_time_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';
import 'package:flutter_defualt_project/data/network/api_repository.dart';
import 'package:flutter_defualt_project/ui/home/widgets/row_items.dart';
import 'package:flutter_defualt_project/utils/colors.dart';
import 'package:flutter_defualt_project/utils/constants.dart';
import 'package:flutter_defualt_project/utils/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../utils/icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiProvider apiProvider = ApiProvider();
  late ApiRepository apiRepository;
  List<NamazTimeModel> times = [];
  NamazTimeModel? prayerTimeModel;
  bool isLoading = true;
  String date = "";
  String titleString = "";
  int hour2 = DateTime.now().hour;
  int minute2 = DateTime.now().minute;
  int day = DateTime.now().day;

  _getTimes() async {
    setState(() {
      isLoading = true;
    });
    times = await apiRepository.getDailyTime(
        region: region, month: month.toString());
    _getTime();
    setState(() {
      isLoading = false;
    });
  }

  _getTime() async {
    times.forEach((element) {
      if (element.day == day) {
        prayerTimeModel = element;
      }
    });
    date += prayerTimeModel!.day.toString();
    date += convertMonth(month.toString());
    date += "${DateTime.now().year}-year";
    if (hour2 ==
        int.parse(prayerTimeModel!.timesModel.tongSaharlik.substring(0, 2))) {
      if (minute2 <
          int.parse(prayerTimeModel!.timesModel.tongSaharlik.substring(3))) {
        titleString = "Fajr ${prayerTimeModel!.timesModel.tongSaharlik}";
      } else {
        titleString = "Shuruk ${prayerTimeModel!.timesModel.quyosh}";
      }
    } else if (hour2 <
        int.parse(prayerTimeModel!.timesModel.tongSaharlik.substring(0, 2))) {
      titleString = "Fajr ${prayerTimeModel!.timesModel.tongSaharlik}";
    } else {
      if (hour2 ==
          int.parse(prayerTimeModel!.timesModel.quyosh.substring(0, 2))) {
        if (minute2 <
            int.parse(prayerTimeModel!.timesModel.quyosh.substring(3))) {
          titleString = "Shuruk ${prayerTimeModel!.timesModel.quyosh}";
        } else {
          titleString = "Zuhr ${prayerTimeModel!.timesModel.peshin}";
        }
      } else if (hour2 <
          int.parse(prayerTimeModel!.timesModel.quyosh.substring(0, 2))) {
        titleString = "Shuruk ${prayerTimeModel!.timesModel.quyosh}";
      } else {
        if (hour2 ==
            int.parse(prayerTimeModel!.timesModel.peshin.substring(0, 2))) {
          if (minute2 <
              int.parse(prayerTimeModel!.timesModel.peshin.substring(3))) {
            titleString = "Zuhr ${prayerTimeModel!.timesModel.peshin}";
          } else {
            titleString = "Asr ${prayerTimeModel!.timesModel.asr}";
          }
        } else if (hour2 <
            int.parse(prayerTimeModel!.timesModel.peshin.substring(0, 2))) {
          titleString = "Zuhr ${prayerTimeModel!.timesModel.peshin}";
        } else {
          if (hour2 ==
              int.parse(prayerTimeModel!.timesModel.asr.substring(0, 2))) {
            if (minute2 <
                int.parse(prayerTimeModel!.timesModel.asr.substring(3))) {
              titleString = "Asr ${prayerTimeModel!.timesModel.asr}";
            } else {
              titleString = "Maghreb ${prayerTimeModel!.timesModel.shomIftor}";
            }
          } else if (hour2 <
              int.parse(prayerTimeModel!.timesModel.asr.substring(0, 2))) {
            titleString = "Asr ${prayerTimeModel!.timesModel.asr}";
          } else {
            if (hour2 ==
                int.parse(
                    prayerTimeModel!.timesModel.shomIftor.substring(0, 2))) {
              if (minute2 <
                  int.parse(
                      prayerTimeModel!.timesModel.shomIftor.substring(3))) {
                titleString = "Maghreb ${prayerTimeModel!.timesModel.shomIftor}";
              } else {
                titleString = "Isha ${prayerTimeModel!.timesModel.hufton}";
              }
            } else if (hour2 <
                int.parse(
                    prayerTimeModel!.timesModel.shomIftor.substring(0, 2))) {
              titleString = "Maghreb ${prayerTimeModel!.timesModel.shomIftor}";
            } else {
              if (hour2 ==
                  int.parse(
                      prayerTimeModel!.timesModel.hufton.substring(0, 2))) {
                if (minute2 <
                    int.parse(
                        prayerTimeModel!.timesModel.hufton.substring(3))) {
                  titleString = "Isha ${prayerTimeModel!.timesModel.hufton}";
                } else {
                  titleString =
                      "Bomdod ${prayerTimeModel!.timesModel.tongSaharlik}";
                }
              } else if (hour2 <
                  int.parse(
                      prayerTimeModel!.timesModel.hufton.substring(0, 2))) {
                titleString = "Isha ${prayerTimeModel!.timesModel.hufton}";
              }
            }
          }
        }
      }
    }
  }

  String convertMonth(String month) {
    if (month == "1") {
      return " January ";
    } else if (month == "2") {
      return " February ";
    } else if (month == "3") {
      return " March ";
    } else if (month == "4") {
      return " April ";
    } else if (month == "5") {
      return " May ";
    } else if (month == "6") {
      return " June ";
    } else if (month == "7") {
      return " July ";
    } else if (month == "8") {
      return " August ";
    } else if (month == "9") {
      return " September ";
    } else if (month == "10") {
      return " October ";
    } else if (month == "11") {
      return " November ";
    } else {
      return " December ";
    }
  }

  @override
  void initState() {
    apiRepository = ApiRepository(apiProvider: apiProvider);
    _getTimes();
    _getTime();
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
                                  text: "Prayer Times\n",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  children: [
                                    TextSpan(
                                      text: "\n${switchRegion(prayerTimeModel?.region)}\n",
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
                              PopupMenuButton<String>(
                                  child: SvgPicture.asset(AppIcons.more,height: 50* MediaQuery.of(context).size.height / 812,width: 50 * MediaQuery.of(context).size.width / 375,),
                                  onSelected: (String result) {
                                    date = '';
                                    print('Selected: $result');
                                    StorageRepository.putString('region', result);
                                    region = StorageRepository.getString('region');
                                    _getTimes();
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return List.generate(
                                        regions.length,
                                        (index) => PopupMenuItem(
                                          value: regions[index],
                                            child: Text(regionsEng[index])));
                                  }),
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
                            "The difference between a believer and an unbeliever is that he abandons prayer.",
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
                                  onTap: () {
                                    date = "";
                                    day -= 1;
                                    if (day == 0) {
                                      month -= 1;
                                      _getTimes();
                                      day = times.last.day - 1;
                                      _getTime();
                                      setState(() {
                                        date = "";
                                      });
                                    } else {
                                      _getTime();
                                      setState(() {});
                                    }
                                  },
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
                                  onTap: () {
                                    date = "";
                                    day += 1;
                                    if (day == times.last.day + 1) {
                                      month += 1;
                                      _getTimes();
                                      day = 1;
                                      _getTime();
                                      setState(() {
                                        date = "";
                                      });
                                    } else {
                                      _getTime();
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          RowItems(
                            title: "Fajr",
                            time: "${prayerTimeModel?.timesModel.tongSaharlik}",
                            img: AppImages.bomdod,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Shuruk",
                            time: "${prayerTimeModel?.timesModel.quyosh}",
                            img: AppImages.asr,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Zuhr",
                            time: "${prayerTimeModel?.timesModel.peshin}",
                            img: AppImages.peshin,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Asr",
                            time: "${prayerTimeModel?.timesModel.asr}",
                            img: AppImages.asr,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Maghreb",
                            time: "${prayerTimeModel?.timesModel.shomIftor}",
                            img: AppImages.bomdod,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RowItems(
                            title: "Isha",
                            time: "${prayerTimeModel?.timesModel.hufton}",
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
