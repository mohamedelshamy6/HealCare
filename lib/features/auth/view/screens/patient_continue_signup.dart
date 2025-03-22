import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/auth/logic/cubit/auth_cubit.dart';
import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../widgets/tff_with_label.dart';
import '../widgets/upload_photo_widget.dart';

class PatientContinueSignupScreen extends StatefulWidget {
  final String email, password;
  const PatientContinueSignupScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<PatientContinueSignupScreen> createState() =>
      _PatientContinueSignupScreenState();
}

class _PatientContinueSignupScreenState
    extends State<PatientContinueSignupScreen> {
  String? diseaseSelectedValue;
  String? genderSelectedValue;
  String? bloodSelectedValue;
  TextEditingController ageConotroller = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightCoontroller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController medicalController = TextEditingController();
  bool? isGenderSelected;
  bool? isBloodSelected;
  bool? isDiseaseSelected;
  @override
  void dispose() {
    ageConotroller.dispose();
    weightController.dispose();
    heightCoontroller.dispose();
    addressController.dispose();
    medicalController.dispose();
    super.dispose();
    formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              HelperMethods.showLoadingAlertDialog(context);
            }
            if (state is SignUpSuccess) {
              Navigator.pop(context);
              CacheHelper().saveSecuredData(
                  key: 'accessToken', value: state.signUpModel!.accessToken!);
              CacheHelper().saveSecuredData(
                  key: 'refreshToken', value: state.signUpModel!.refreshToken!);
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.bottomNavBar, (route) => false,
                  arguments: 'patient');
              CacheHelper().saveData(key: 'role', value: 'patient');
            }
            if (state is SignUpFailure) {
              Navigator.pop(context);
              HelperMethods.showCustomSnackBarError(
                  context, ErrorMessages.errorMessage(state.error));
            }
          },
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
                    CustomDropdown(
                      isValueNull: isDiseaseSelected,
                      selectedValue: diseaseSelectedValue,
                      onItemChanged: (value) {
                        setState(() {
                          isDiseaseSelected = true;
                          diseaseSelectedValue = value;
                        });
                      },
                      itemList: <String>[
                        'Blood Pressure',
                        'Fever',
                        'Headache',
                        'Diabetes',
                      ],
                      hint: 'Cold',
                      label: 'Disease Type',
                    ),
                    verticalSpace(12),
                    CustomDropdown(
                      isValueNull: isBloodSelected,
                      selectedValue: bloodSelectedValue,
                      onItemChanged: (value) {
                        setState(() {
                          isBloodSelected = true;
                          bloodSelectedValue = value;
                        });
                      },
                      itemList: <String>[
                        'A+',
                        'A-',
                        'AB',
                        'B+',
                        'B-',
                        'O+',
                        'O-',
                      ],
                      hint: 'A+',
                      label: 'Blood Type',
                    ),
                    verticalSpace(12),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                          child: TFFWithLabel(
                            label: 'Age',
                            hintText: '22 Years',
                            maxInputLength: 3,
                            kbType: TextInputType.number,
                            controller: ageConotroller,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Please enter a valid height';
                              }
                              return null;
                            },
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
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Expanded(
                          child: TFFWithLabel(
                            label: 'Weight',
                            maxInputLength: 3,
                            hintText: '50 Kg',
                            kbType: TextInputType.number,
                            controller: weightController,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your weight';
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Please enter a valid height';
                              }
                              return null;
                            },
                          ),
                        ),
                        horizontalSpace(8),
                        Expanded(
                          child: TFFWithLabel(
                            label: 'Height',
                            hintText: '185 cm',
                            controller: heightCoontroller,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your height';
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Please enter a valid height';
                              }
                              return null;
                            },
                            maxInputLength: 3,
                            kbType: TextInputType.number,
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
                      label: 'Medical History',
                      controller: medicalController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your medical history';
                        }
                        return null;
                      },
                      kbType: TextInputType.multiline,
                      maxLines: 6,
                    ),
                    verticalSpace(12),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: AppColors.mainWhite,
                          border: Border.all(color: AppColors.mainGrey),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: AppColors.mainColor,
                            ),
                            horizontalSpace(8),
                            Text(
                              'Upload File',
                              style: AppTextStyles.poppinsMainColor(
                                  14, FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(36),
                    CustomButton(
                      buttonAction: () {
                        validateDropDownButtons(context);
                        if (formKey.currentState!.validate()) {
                          genderSelectedValue == null ||
                                  diseaseSelectedValue == null ||
                                  num.parse(ageConotroller.text) < 18 ||
                                  num.parse(ageConotroller.text) > 80 ||
                                  num.parse(weightController.text) < 30 ||
                                  num.parse(weightController.text) > 200 ||
                                  num.parse(heightCoontroller.text) < 100 ||
                                  num.parse(heightCoontroller.text) > 250 ||
                                  bloodSelectedValue == null
                              ? null
                              : context.read<AuthCubit>().signUp(
                                  '${AppConstants.baseAuthUrl}signup',
                                  {
                                    'email': widget.email,
                                    'password': widget.password,
                                  },
                                );
                        }
                      },
                      buttonText: 'Sign Up',
                      height: 50.h,
                      textStyle:
                          AppTextStyles.poppinsWhite(15, FontWeight.w500),
                    ),
                    verticalSpace(24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateDropDownButtons(BuildContext context) {
    bloodSelectedValue == null &&
            genderSelectedValue == null &&
            diseaseSelectedValue == null
        ? {
            HelperMethods.showCustomSnackBarError(
                context, 'Please select your disease, blood type and gender'),
            setState(() {
              isBloodSelected = false;
              isDiseaseSelected = false;
              isGenderSelected = false;
            })
          }
        : bloodSelectedValue == null && genderSelectedValue == null
            ? {
                HelperMethods.showCustomSnackBarError(
                    context, 'Please select your blood type and gender'),
                setState(() {
                  isBloodSelected = false;
                  isGenderSelected = false;
                })
              }
            : bloodSelectedValue == null && diseaseSelectedValue == null
                ? {
                    HelperMethods.showCustomSnackBarError(
                        context, 'Please select your blood type and disease'),
                    setState(() {
                      isBloodSelected = false;
                      isDiseaseSelected = false;
                    })
                  }
                : genderSelectedValue == null && diseaseSelectedValue == null
                    ? {
                        HelperMethods.showCustomSnackBarError(
                            context, 'Please select your gender and disease'),
                        setState(() {
                          isGenderSelected = false;
                          isDiseaseSelected = false;
                        })
                      }
                    : {
                        diseaseSelectedValue == null
                            ? {
                                HelperMethods.showCustomSnackBarError(
                                    context, 'Please select your disease'),
                                setState(() {
                                  isDiseaseSelected = false;
                                })
                              }
                            : null,
                        bloodSelectedValue == null
                            ? {
                                HelperMethods.showCustomSnackBarError(
                                    context, 'Please select your blood type'),
                                setState(() {
                                  isBloodSelected = false;
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
    ageConotroller.text.isNotEmpty
        ? num.parse(ageConotroller.text) < 18 ||
                num.parse(ageConotroller.text) > 80
            ? HelperMethods.showCustomSnackBarError(
                context, 'Age must be between 18 and 80')
            : null
        : null;
    weightController.text.isNotEmpty
        ? num.parse(weightController.text) < 30 ||
                num.parse(weightController.text) > 200
            ? HelperMethods.showCustomSnackBarError(
                context, 'Weight must be between 30 and 200')
            : null
        : null;
    heightCoontroller.text.isNotEmpty
        ? num.parse(heightCoontroller.text) < 100 ||
                num.parse(heightCoontroller.text) > 250
            ? HelperMethods.showCustomSnackBarError(
                context, 'Height must be between 100 and 250')
            : null
        : null;
  }
}
