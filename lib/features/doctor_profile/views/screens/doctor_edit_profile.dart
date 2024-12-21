import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/patient_profile/views/widgets/profile_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../auth/view/widgets/tff_with_label.dart';

class DoctorEditProfile extends StatelessWidget {
  const DoctorEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                CustomAppHeader(
                  canBack: true,
                  title: 'Edit Profile',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 70,
                ),
                verticalSpace(16),
                ProfileHeader(),
                verticalSpace(32),
                TFFWithLabel(
                  label: 'Doctor\'s name',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Education',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Instapay Link',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Working hours availability',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        itemList: <String>[
                          'Eyes',
                          'Teeth',
                          'Skin',
                          'Heart',
                          'Lungs',
                        ],
                        hint: 'Eyes',
                        label: 'Specialization',
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: CustomDropdown(
                        itemList: <String>[
                          'Male',
                          'Female',
                          'Rather Not Say',
                        ],
                        hint: 'Male',
                        label: 'Gender',
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Address',
                  kbType: TextInputType.multiline,
                  maxLines: 3,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Experience',
                  kbType: TextInputType.multiline,
                  maxLines: 3,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Biography',
                  kbType: TextInputType.multiline,
                  maxLines: 7,
                ),
                verticalSpace(36),
                CustomButton(
                  buttonText: 'Save',
                  buttonAction: () {
                    Navigator.pop(context);
                  },
                  textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                  height: 52.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
