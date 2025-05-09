import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/patient_home/view/widgets/doctors_container.dart';
import 'package:heal_care/features/patient_home/view/widgets/filter_doctor_search_sheet.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key, required this.doctorsModel});
  final List<DoctorsModel> doctorsModel;

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<DoctorsModel> _filteredDoctors;

  @override
  void initState() {
    super.initState();
    _filteredDoctors = widget.doctorsModel;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDoctors = widget.doctorsModel.where((doctor) {
        final name = doctor.name?.toLowerCase() ?? '';
        final spec = doctor.specialization?.toLowerCase() ?? '';
        return name.contains(query) || spec.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppHeader(
                canBack: true,
                title: 'Doctors',
                horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 80,
              ),
              verticalSpace(32),
              CustomTFF(
                controller: _searchController,
                hintText: 'Search',
                kbType: TextInputType.text,
                hintTextStyle: AppTextStyles.poppinsGrey(15, FontWeight.w400),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(13.r),
                  child: SvgPicture.asset(Assets.iconsSearchIconGrey),
                ),
                enableFocusedBorder: false,
                suffixIcon: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const FilterDoctorSearchSheet(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5.r),
                    width: 38.w,
                    height: 38.h,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(Assets.iconsFilterIconWhite),
                    ),
                  ),
                ),
              ),
              verticalSpace(12),
              Text(
                'Specialist',
                style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
              ),
              verticalSpace(8),
              Expanded(
                child: _filteredDoctors.isEmpty
                    ? Center(
                        child: Text(
                          'No doctors found.',
                          style:
                              AppTextStyles.poppinsBlack(14, FontWeight.w500),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _filteredDoctors.length,
                        separatorBuilder: (context, index) => verticalSpace(12),
                        itemBuilder: (context, index) => DoctorsContainer(
                          doctorsModel: _filteredDoctors[index],
                        ),
                      ),
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
