
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';

class FindDoctorsContainer extends StatefulWidget {
  const FindDoctorsContainer({super.key});

  @override
  State<FindDoctorsContainer> createState() => _FindDoctorsContainerState();
}

class _FindDoctorsContainerState extends State<FindDoctorsContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorsCubit>().getAllDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state is DoctorsSuccess ||
            state is PatientToogleFavouritesSuccess) {
          setState(() {});
        }
      },
      buildWhen: (previous, current) =>
          current is DoctorsSuccess ||
          current is PatientToogleFavouritesSuccess,
      builder: (context, state) {
        final cubit = context.read<DoctorsCubit>();
        final currentDoctors = cubit.doctorsModel;

        return ListView.separated(
          itemCount: currentDoctors.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final doctor = currentDoctors[index];
            return _buildDoctorCard(context, doctor);
          },
        );
      },
    );
  }

  Widget _buildDoctorCard(BuildContext context, DoctorsModel doctor) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(width: 2, color: AppColors.findDoctorsCardBorderColor),
        color: AppColors.findDoctorsCardColor,
      ),
      child: Column(
        children: [
          _buildDoctorHeader(context, doctor),
          _buildDoctorInfo(),
          verticalSpace(16),
          _buildBookButton(context, doctor),
        ],
      ),
    );
  }

  Widget _buildDoctorHeader(BuildContext context, DoctorsModel doctor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorAvatar(doctor),
        horizontalSpace(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name ?? 'Unknown',
                style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
              ),
              verticalSpace(4),
              Text(
                doctor.specialization ?? 'N/A',
                style: AppTextStyles.poppinsBlack(14, FontWeight.w400)
                    .copyWith(color: const Color(0xffAAB6C3)),
              ),
              verticalSpace(8),
            ],
          ),
        ),
        _buildFavoriteButton(context, doctor),
      ],
    );
  }

  Widget _buildDoctorAvatar(DoctorsModel doctor) {
    return CachedNetworkImage(
      imageUrl: doctor.image ?? '',
      width: 60.w,
      height: 60.h,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 30.r,
        backgroundImage: imageProvider,
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.person, size: 60.r),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, DoctorsModel doctor) {
    return IconButton(
      icon: Icon(
        doctor.isFavourite == true ? Icons.favorite : Icons.favorite_border,
        color: doctor.isFavourite == true ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        setState(() {
          doctor.isFavourite = !(doctor.isFavourite ?? false);
        });
        await context.read<DoctorsCubit>().toggleFavouriteDoctor(doctor);
        await context.read<DoctorsCubit>().getAllDoctors();
      },
    );
  }

  Widget _buildDoctorInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '4.8',
            style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
          ),
          horizontalSpace(4),
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: SvgPicture.asset(
              Assets.iconsStarIconYellow,
              height: 15.h,
              width: 15.w,
            ),
          ),
          horizontalSpace(24),
          Image.asset(
            Assets.iconsClockSquareIconGrey,
            height: 15.h,
            width: 15.w,
          ),
          horizontalSpace(8),
          Text(
            '10:30am - 5:30pm',
            style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton(BuildContext context, DoctorsModel doctor) {
    return CustomButton(
      buttonText: 'Book Appointment',
      buttonAction: () {
        Navigator.of(context).pushNamed(
          Routes.bookDoctorAppointment,
          arguments: doctor,
        );
            },
      textStyle: AppTextStyles.poppinsMainColor(14, FontWeight.w600),
      color: AppColors.findDoctorsCardButtonColor,
      borderRadius: 8,
    );
  }
}
