import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RowItems extends StatelessWidget {
  const RowItems({super.key, required this.title, required this.time, required this.img});
  final String title;
  final String time;
  final String img;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(img),
          Text(title,style: Theme.of(context).textTheme.bodyMedium,),
          Text(time,style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

