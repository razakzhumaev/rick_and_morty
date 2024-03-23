import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty_app/features/locations/data/model/location_model.dart';
import 'package:rick_morty_app/internal/components/text_helper.dart';

class LocationDetailScreen extends StatefulWidget {
  final LocationModel locationModel;

  const LocationDetailScreen({
    Key? key,
    required this.locationModel,
  }) : super(key: key);

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    '${widget.locationModel.imageUrl}',
                    height: 298.h,
                    width: 375.w,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 251.h,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              height: 561.h,
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 34.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.locationModel.name ?? '-',
                      style: TextHelper.w700s24,
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.locationModel.type}',
                          style: TextHelper.w400s12grey,
                        ),
                        SizedBox(width: 5.w),
                        const Text('◦'),
                        SizedBox(width: 5.w),
                        Text(
                          '${widget.locationModel.dimension}',
                          style: TextHelper.w400s12grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    const Text(
                        'Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
