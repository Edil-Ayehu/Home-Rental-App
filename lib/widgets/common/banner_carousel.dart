import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/banner_add.dart';
import '../../core/constants/color_constants.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.h,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: BannerAd.dummyBanners.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: NetworkImage(banner.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: BannerAd.dummyBanners.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 24.w : 8.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: _currentIndex == entry.key
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.2),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
