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
  List<NamazTimeModel> times = [];
  late NamazTimeModel? namazTimeModel;
  bool isLoading = true;
  String date = "";
  String titleString = "";
  int hour2 = DateTime.now().hour;
  int minute2 = DateTime.now().minute;
  int day = DateTime.now().day;
  int month = DateTime.now().month;

  _getTimes(String region, String month) async {
    setState(() {
      isLoading = true;
    });
    times = await apiRepository.getDailyTime(region: region, month: month);
    _getTime();
    setState(() {
      isLoading = false;
    });
  }

  _getTime() async {
    times.forEach((element) {
      if (element.day == day) {
        namazTimeModel = element;
      }
    });
    date += namazTimeModel!.day.toString();
    date += convertMonth(month.toString());
    date += "${DateTime.now().year}-yil";
    if (hour2 ==
        int.parse(namazTimeModel!.timesModel.tongSaharlik.substring(0, 2))) {
      if (minute2 <
          int.parse(namazTimeModel!.timesModel.tongSaharlik.substring(3))) {
        titleString = "Bomdod ${namazTimeModel!.timesModel.tongSaharlik}";
      } else {
        titleString = "Quyosh ${namazTimeModel!.timesModel.quyosh}";
      }
    } else if (hour2 <
        int.parse(namazTimeModel!.timesModel.tongSaharlik.substring(0, 2))) {
      titleString = "Bomdod ${namazTimeModel!.timesModel.tongSaharlik}";
    } else {
      if (hour2 ==
          int.parse(namazTimeModel!.timesModel.quyosh.substring(0, 2))) {
        if (minute2 <
            int.parse(namazTimeModel!.timesModel.quyosh.substring(3))) {
          titleString = "Quyosh ${namazTimeModel!.timesModel.quyosh}";
        } else {
          titleString = "Peshin ${namazTimeModel!.timesModel.peshin}";
        }
      } else if (hour2 <
          int.parse(namazTimeModel!.timesModel.quyosh.substring(0, 2))) {
        titleString = "Quyosh ${namazTimeModel!.timesModel.quyosh}";
      } else {
        if (hour2 ==
            int.parse(namazTimeModel!.timesModel.peshin.substring(0, 2))) {
          if (minute2 <
              int.parse(namazTimeModel!.timesModel.peshin.substring(3))) {
            titleString = "Peshin ${namazTimeModel!.timesModel.peshin}";
          } else {
            titleString = "Asr ${namazTimeModel!.timesModel.asr}";
          }
        } else if (hour2 <
            int.parse(namazTimeModel!.timesModel.peshin.substring(0, 2))) {
          titleString = "Peshin ${namazTimeModel!.timesModel.peshin}";
        } else {
          if (hour2 ==
              int.parse(namazTimeModel!.timesModel.asr.substring(0, 2))) {
            if (minute2 <
                int.parse(namazTimeModel!.timesModel.asr.substring(3))) {
              titleString = "Asr ${namazTimeModel!.timesModel.asr}";
            } else {
              titleString = "Shom ${namazTimeModel!.timesModel.shomIftor}";
            }
          } else if (hour2 <
              int.parse(namazTimeModel!.timesModel.asr.substring(0, 2))) {
            titleString = "Asr ${namazTimeModel!.timesModel.asr}";
          } else {
            if (hour2 ==
                int.parse(
                    namazTimeModel!.timesModel.shomIftor.substring(0, 2))) {
              if (minute2 <
                  int.parse(
                      namazTimeModel!.timesModel.shomIftor.substring(3))) {
                titleString = "Shom ${namazTimeModel!.timesModel.shomIftor}";
              } else {
                titleString = "Hufton ${namazTimeModel!.timesModel.hufton}";
              }
            } else if (hour2 <
                int.parse(
                    namazTimeModel!.timesModel.shomIftor.substring(0, 2))) {
              titleString = "Shom ${namazTimeModel!.timesModel.shomIftor}";
            } else {
              if (hour2 ==
                  int.parse(
                      namazTimeModel!.timesModel.hufton.substring(0, 2))) {
                if (minute2 <
                    int.parse(namazTimeModel!.timesModel.hufton.substring(3))) {
                  titleString = "Hufton ${namazTimeModel!.timesModel.hufton}";
                } else {
                  titleString =
                      "Bomdod ${namazTimeModel!.timesModel.tongSaharlik}";
                }
              } else if (hour2 <
                  int.parse(
                      namazTimeModel!.timesModel.hufton.substring(0, 2))) {
                titleString = "Hufton ${namazTimeModel!.timesModel.hufton}";
              }
            }
          }
        }
      }
    }
  }

  String convertMonth(String month) {
    if (month == "1") {
      return " Yanvar ";
    } else if (month == "2") {
      return " Fevral ";
    } else if (month == "3") {
      return " Mart ";
    } else if (month == "4") {
      return " Aprel ";
    } else if (month == "5") {
      return " May ";
    } else if (month == "6") {
      return " Iyun ";
    } else if (month == "7") {
      return " Iyul ";
    } else if (month == "8") {
      return " Avgust ";
    } else if (month == "9") {
      return " Sentyabr ";
    } else if (month == "10") {
      return " Oktabr ";
    } else if (month == "11") {
      return " Noyabr ";
    } else {
      return " Dekabr ";
    }
  }

  @override
  void initState() {
    apiRepository = ApiRepository(apiProvider: apiProvider);
    _getTimes("Toshkent", month.toString());
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
                                  onTap: () {
                                    date = "";
                                    day -= 1;
                                    if (day == 0) {
                                      month -= 1;
                                      _getTimes("Toshkent", month.toString());
                                      day = times.last.day-1;
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
                                      _getTimes("Toshkent", month.toString());
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
