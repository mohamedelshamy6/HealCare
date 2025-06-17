import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/image_picker_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_drop_down.dart';
import 'package:heal_care/features/auth/view/widgets/tff_with_label.dart';
import 'package:heal_care/features/auth/view/widgets/upload_photo_widget.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';

class PatientEditProfile extends StatefulWidget {
  const PatientEditProfile({super.key});

  @override
  State<PatientEditProfile> createState() => _PatientEditProfileState();
}

class _PatientEditProfileState extends State<PatientEditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _addressController;
  late TextEditingController _medicalHistoryController;

  String? diseaseSelectedValue;
  String? genderSelectedValue;
  String? bloodSelectedValue;
  File? image;
  String? imageUrl;
  bool? isGenderSelected;
  bool? isBloodSelected;
  bool? isDiseaseSelected;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _addressController = TextEditingController();
    _medicalHistoryController = TextEditingController();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _addressController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'age': int.tryParse(_ageController.text),
        'weight': int.tryParse(_weightController.text),
        'height': int.tryParse(_heightController.text),
        'blood_type': bloodSelectedValue,
        'gender': genderSelectedValue,
        'disease': diseaseSelectedValue,
        'address': _addressController.text,
        'medical_history': _medicalHistoryController.text,
        if (image != null) 'image': imageUrl,
      }..removeWhere((key, value) => value == null);

      // Call the cubit to update profile
      context.read<ProfileCubit>().updateProfileForPatients(
            '${AppConstants.baseRestUrl}patients',
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccessForPatients) {
              HelperMethods.showCustomSnackBarSuccess(
                context,
                'Profile updated successfully',
              );
              Navigator.pop(context, true);
            } else if (state is UpdateProfileErrorForPatients) {
              HelperMethods.showCustomSnackBarError(
                context,
                state.error,
              );
            }
          },
          builder: (context, state) {
            final patient =
                state is ProfileSuccessForPatients ? state.patient : null;

            // Initialize form fields with patient data
            if (patient != null && _ageController.text.isEmpty) {
              _ageController.text = patient.age?.toString() ?? '';
              _weightController.text = patient.weight?.toString() ?? '';
              _heightController.text = patient.height?.toString() ?? '';
              bloodSelectedValue = patient.bloodType;
              genderSelectedValue = patient.gender;
              diseaseSelectedValue = patient.disease;
              _addressController.text = patient.address ?? '';
              _medicalHistoryController.text = patient.medicalHistory ?? '';
              imageUrl = patient.image;
            }

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(16),
                          const CustomAppHeader(canBack: true),
                          verticalSpace(12),
                          Center(
                            child: UploadPhotoWidget(
                              onTap: () async {
                                final pickedImage =
                                    await ImagePickerHelper.getImage(
                                        imageSource: ImageSource.gallery);
                                setState(() {
                                  if (pickedImage != null) {
                                    image = File(pickedImage.path);
                                    // Here you would typically upload the image to your storage
                                    // and get the URL to save with the profile
                                  }
                                });
                              },
                              imagePath: image,
                            ),
                          ),
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
                            itemList: const <String>[
                              'Blood Pressure',
                              'Fever',
                              'Headache',
                              'Diabetes',
                            ],
                            hint: 'Select Disease',
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
                            itemList: const <String>[
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'AB+',
                              'AB-',
                              'O+',
                              'O-',
                            ],
                            hint: 'Select Blood Type',
                            label: 'Blood Type',
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              Expanded(
                                child: TFFWithLabel(
                                  controller: _ageController,
                                  label: 'Age',
                                  hintText: '22',
                                  kbType: TextInputType.number,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your age';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              horizontalSpace(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gender',
                                      style: AppTextStyles.poppinsGrey(
                                        12,
                                        FontWeight.w400,
                                      ),
                                    ),
                                    verticalSpace(4),
                                    CustomDropdown(
                                      isValueNull: isGenderSelected,
                                      selectedValue: genderSelectedValue,
                                      onItemChanged: (value) {
                                        setState(() {
                                          isGenderSelected = true;
                                          genderSelectedValue = value;
                                        });
                                      },
                                      itemList: const <String>[
                                        'Male',
                                        'Female',
                                        'Other',
                                      ],
                                      hint: 'Select Gender',
                                      label: '',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(12),
                          Row(
                            children: [
                              Expanded(
                                child: TFFWithLabel(
                            label: 'Weight',
                            maxInputLength: 3,
                            hintText: '50 Kg',
                            kbType: TextInputType.number,
                            controller: _weightController,
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
                            controller: _heightController,
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
                      controller: _addressController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                          verticalSpace(12),
                          TFFWithLabel(
                            controller: _medicalHistoryController,
                            label: 'Medical History',
                            hintText: 'Enter your medical history',
                            kbType: TextInputType.multiline,
                            maxLines: 4,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide your medical history';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(24),
                          CustomButton(
                            buttonText: 'Save Changes',
                            buttonAction: _updateProfile,
                            textStyle:
                                AppTextStyles.poppinsWhite(15, FontWeight.w500),
                            height: 52.h,
                          ),
                          verticalSpace(24),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is UpdateProfileLoadingForPatients)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
