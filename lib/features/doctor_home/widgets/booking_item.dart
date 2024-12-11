import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_button.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({
    super.key,
    required this.selectedIndex, required this.imageUrl,
  });

  final int selectedIndex;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 15.w, vertical: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainWhite,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  height: 70.h,
                  width: 70.w,
                  child: Image.asset(
                      imageUrl??'assets/images/patients/patient_m.png')),
              horizontalSpace(15),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    'John Deo',
                    style:
                        AppTextStyles.poppinsBlack(
                            18, FontWeight.w600),
                  ),
                  Text(
                    'M.Sc. - Food and Nutrition',
                    style:
                        AppTextStyles.poppinsGrey(
                            12, FontWeight.w400),
                  ),
                  Text(
                    'Nutritionist',
                    style:
                        AppTextStyles.poppinsGrey(
                            14, FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color:
                                AppColors.mainGrey,
                          ),
                          horizontalSpace(2),
                          Text(
                            '02 February 2023',
                            style: AppTextStyles
                                .poppinsBlack(
                                    10,
                                    FontWeight
                                        .w400),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons
                                .calendar_view_day_rounded,
                            color:
                                AppColors.mainGrey,
                          ),
                          horizontalSpace(2),
                          Text(
                            '1:00 PM - 2:00 PM',
                            style: AppTextStyles
                                .poppinsBlack(
                                    10,
                                    FontWeight
                                        .w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(14),
          selectedIndex == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 17.w),
                  child: CustomButton(
                      color: AppColors.lightOrange,
                      buttonText: 'Canceled',
                      buttonAction: () {},
                      textStyle: AppTextStyles
                          .setPoppinsTextStyle(
                              color: AppColors
                                  .tFFErrorColor,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w500)),
                )
              : selectedIndex == 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 17.w),
                      child: CustomButton(
                          buttonText:
                              'Attend Session',
                          buttonAction: () {},
                          textStyle: AppTextStyles
                              .poppinsWhite(14,
                                  FontWeight.w500)),
                    )
                  : selectedIndex == 2
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: 60.w),
                          child: Container(
                            padding: EdgeInsets
                                .symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h),
                            decoration: BoxDecoration(
                                color: const Color
                                    .fromARGB(255,
                                    142, 223, 145)),
                            child: Text(
                              'Completed',
                              style: AppTextStyles
                                  .setPoppinsTextStyle(
                                      color: Colors
                                          .green,
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight
                                              .w500),
                            ),
                          ))
                      : Padding(
                          padding: EdgeInsets.only(
                              right: 60.w),
                          child: Container(
                            padding: EdgeInsets
                                .symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h),
                            decoration:
                                BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                              color: AppColors
                                  .lightOrange,
                            ),
                            child: Text(
                              'Canceled',
                              style: AppTextStyles
                                  .setPoppinsTextStyle(
                                      color:  AppColors
                                  .tFFErrorColor,
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight
                                              .w500),
                            ),
                          )),
        ],
      ),
    );
  }
}
