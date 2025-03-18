import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../widgets/tff_with_label.dart';
import '../widgets/upload_photo_widget.dart';

class DoctorContinueSignupScreen extends StatefulWidget {
  const DoctorContinueSignupScreen({super.key});

  @override
  State<DoctorContinueSignupScreen> createState() =>
      _DoctorContinueSignupScreenState();
}

class _DoctorContinueSignupScreenState
    extends State<DoctorContinueSignupScreen> {
  TextEditingController educationController = TextEditingController();
  TextEditingController instapayController = TextEditingController();
  TextEditingController workingHoursController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController experienceController = TextEditingController();
  TextEditingController biographyController = TextEditingController();
  @override
  void dispose() {
    educationController.dispose();
    instapayController.dispose();
    workingHoursController.dispose();
    addressController.dispose();
    experienceController.dispose();
    biographyController.dispose();
    super.dispose();
    formKey.currentState?.dispose();
  }

  String? specializationSelectedValue;
  String? genderSelectedValue;
  bool? isGenderSelected;
  bool? isSpecializationSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(16),
                  CustomAppHeader(canBack: true),
                  verticalSpace(12),
                  UploadPhotoWidget(),
                  verticalSpace(16),
                  TFFWithLabel(
                    label: 'Education',
                    kbType: TextInputType.text,
                    controller: educationController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your education';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(12),
                  TFFWithLabel(
                    label: 'Instapay Link',
                    kbType: TextInputType.text,
                    controller: instapayController,
                    validate: (value) =>
                        ValidationErrorTexts.urlValidation(value),
                  ),
                  verticalSpace(12),
                  TFFWithLabel(
                    label: 'Working hours availability',
                    kbType: TextInputType.number,
                    controller: workingHoursController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your working hours availability';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Please enter a valid height';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown(
                          isValueNull: isSpecializationSelected,
                          selectedValue: specializationSelectedValue,
                          onItemChanged: (value) {
                            setState(() {
                              isSpecializationSelected = true;
                              specializationSelectedValue = value;
                            });
                          },
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
                          isValueNull: isGenderSelected,
                          selectedValue: genderSelectedValue,
                          onItemChanged: (value) {
                            setState(() {
                              isGenderSelected = true;
                              genderSelectedValue = value;
                            });
                          },
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
                    controller: addressController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(12),
                  TFFWithLabel(
                    label: 'Experience',
                    kbType: TextInputType.multiline,
                    maxLines: 3,
                    controller: experienceController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your experience';
                      }
                      return null;
                    },
                  ),
                  verticalSpace(12),
                  TFFWithLabel(
                    label: 'Biography',
                    controller: biographyController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your biography';
                      }
                      return null;
                    },
                    kbType: TextInputType.multiline,
                    maxLines: 7,
                  ),
                  verticalSpace(36),
                  CustomButton(
                    buttonAction: () {
                      validateDoctorDropDownButtons(context);
                      if (formKey.currentState!.validate()) {}
                    },
                    buttonText: 'Sign Up',
                    height: 50.h,
                    textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                  ),
                  verticalSpace(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateDoctorDropDownButtons(BuildContext context) {
    specializationSelectedValue == null && genderSelectedValue == null
        ? {
            HelperMethods.showCustomSnackBarError(
                context, 'Please select your specialization and gender'),
            setState(() {
              isSpecializationSelected = false;
              isGenderSelected = false;
            })
          }
        : {
            specializationSelectedValue == null
                ? {
                    HelperMethods.showCustomSnackBarError(
                        context, 'Please select your specialization'),
                    setState(() {
                      isSpecializationSelected = false;
                    })
                  }
                : null,
            genderSelectedValue == null
                ? {
                    HelperMethods.showCustomSnackBarError(
                        context, 'Please select your gender'),
                    setState(() {
                      isGenderSelected = false;
                    })
                  }
                : null
          };
  }
}
