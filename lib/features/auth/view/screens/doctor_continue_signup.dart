import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/errors/messages/error_messages.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/helpers/image_picker_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../widgets/tff_with_label.dart';
import '../../../../core/helpers/app_constants.dart';
import '../widgets/upload_photo_widget.dart';

class DoctorContinueSignupScreen extends StatefulWidget {
  final String email, password, name;
  const DoctorContinueSignupScreen({
    super.key,
    required this.email,
    required this.password,
    required this.name,
  });

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
  File? image;
  String? imageUrl;
  bool? isGenderSelected;
  bool? isSpecializationSelected;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is SignUpLoading) {
          HelperMethods.showLoadingAlertDialog(context);
        }
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          CacheHelper().saveSecuredData(
              key: 'accessToken', value: state.signUpModel!.accessToken!);
          CacheHelper().saveSecuredData(
              key: 'refreshToken', value: state.signUpModel!.refreshToken!);
          CacheHelper()
              .saveData(key: 'doctor_Id', value: state.signUpModel!.user?.id);
        

          image == null
              ? null
              : await DependencyInjection.getIt<supabase.SupabaseClient>()
                  .storage
                  .from('doctors-media')
                  .upload(
                    'doctor/${widget.name}/profile.png',
                    image!,
                    fileOptions: const supabase.FileOptions(upsert: true),
                  )
                  .then((value) {
                  imageUrl =
                      DependencyInjection.getIt<supabase.SupabaseClient>()
                          .storage
                          .from('doctors-media')
                          .getPublicUrl(value);
                });
          context.read<DoctorsCubit>().addDoctor(
            '${AppConstants.baseRestUrl}doctors',
            {
              'id': state.signUpModel?.user?.id,
              'email': widget.email,
              'name': widget.name,
              'education': educationController.text,
              'insta_pay_link': instapayController.text,
              'specialization': specializationSelectedValue,
              'gender': genderSelectedValue,
              'address': addressController.text,
              'experience': experienceController.text,
              'bio': biographyController.text,
              'image': imageUrl,
            },
          ).then((value) {
            
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.bottomNavBar, (route) => false,
                arguments: 'doctor');
            CacheHelper().saveData(key: 'role', value: 'doctor');
          }).onError((_, error) {
            HelperMethods.showCustomSnackBarError(
                context, ErrorMessages.errorMessage(error.toString()));
            return null;
          });
        }
        if (state is SignUpFailure) {
          Navigator.pop(context);
          HelperMethods.showCustomSnackBarError(
              context, ErrorMessages.errorMessage(state.error));
        }
      },
      child: Scaffold(
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
                    UploadPhotoWidget(
                      onTap: () async {
                        final pickedImage = await ImagePickerHelper.getImage(
                            imageSource: ImageSource.gallery);
                        setState(() {
                          if (pickedImage != null) {
                            image = File(pickedImage.path);
                          }
                        });
                      },
                      imagePath: image,
                    ),
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
                        if (formKey.currentState!.validate()) {
                          specializationSelectedValue == null ||
                                  genderSelectedValue == null
                              ? null
                              : context.read<AuthCubit>().signUp(
                                  '${AppConstants.baseAuthUrl}signup',
                                  {
                                    'email': widget.email,
                                    'password': widget.password,
                                    'data': {
                                      'name': widget.name,
                                      'education': educationController.text,
                                      'insta_pay_link': instapayController.text,
                                      'specialization':
                                          specializationSelectedValue,
                                      'gender': genderSelectedValue,
                                      'address': addressController.text,
                                      'experience': experienceController.text,
                                      'bio': biographyController.text,
                                      'image': imageUrl,
                                      'type': 'doctor',
                                    }
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
