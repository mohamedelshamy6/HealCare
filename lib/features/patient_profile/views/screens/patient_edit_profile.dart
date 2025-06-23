import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/image_picker_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_drop_down.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/view/widgets/tff_with_label.dart';
import 'package:heal_care/features/auth/view/widgets/upload_photo_widget.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

    // Fetch patient data when the screen loads
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    try {
      final patientData = await UserCacheHelper.getCachedPatientData();
      if (patientData != null) {
        setState(() {
          _ageController.text = patientData.age?.toString() ?? '';
          _weightController.text = patientData.weight?.toString() ?? '';
          _heightController.text = patientData.height?.toString() ?? '';
          bloodSelectedValue = patientData.bloodType;
          genderSelectedValue = patientData.gender;
          diseaseSelectedValue = patientData.disease;
          _addressController.text = patientData.address ?? '';
          _medicalHistoryController.text = patientData.medicalHistory ?? '';
          imageUrl = patientData.image;
        });
      }
    } catch (e) {
      log('Error loading patient data: $e');
    }
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
      String? uploadedImageUrl;

      if (image != null) {
        try {
          const bucketName = 'patients-media';
          final fileExt = image!.path.split('.').last;
          final newFilePath =
              'patient/profile_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

          await Supabase.instance.client.storage.from(bucketName).upload(
                newFilePath,
                image!,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

          uploadedImageUrl = Supabase.instance.client.storage
              .from(bucketName)
              .getPublicUrl(newFilePath);
        } catch (e) {
          log('Image upload failed: $e');
          HelperMethods.showCustomSnackBarError(context, 'Image upload failed');
          return;
        }
      }

      final data = {
        'age': int.tryParse(_ageController.text),
        'weight': int.tryParse(_weightController.text),
        'height': int.tryParse(_heightController.text),
        'blood_type': bloodSelectedValue,
        'gender': genderSelectedValue,
        'disease': diseaseSelectedValue,
        'address': _addressController.text,
        'medical_history': _medicalHistoryController.text,
        if (uploadedImageUrl != null) 'image': uploadedImageUrl,
      }..removeWhere((key, value) => value == null);

      context.read<ProfileCubit>().updateProfileForPatients(
            'patients',
            data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) async {
            if (state is UpdateProfileSuccessForPatients) {
              debugPrint('Profile update successful, navigating to home...');
              HelperMethods.showCustomSnackBarSuccess(
                context,
                'Profile updated successfully',
              );

              // Update cached data
              final cachedPatient =
                  await UserCacheHelper.getCachedPatientData();
              UserCacheHelper.cachePatientData(PatientsModel(
                name: cachedPatient?.name,
                age: int.tryParse(_ageController.text),
                weight: int.tryParse(_weightController.text),
                height: int.tryParse(_heightController.text),
                bloodType: bloodSelectedValue,
                gender: genderSelectedValue,
                disease: diseaseSelectedValue,
                address: _addressController.text,
                medicalHistory: _medicalHistoryController.text,
                image: imageUrl ??
                    (image != null
                        ? Supabase.instance.client.storage
                            .from('patients-media')
                            .getPublicUrl(
                                'patient/profile_${DateTime.now().millisecondsSinceEpoch}.${image!.path.split('.').last}')
                        : null),
              ));

              // Force a refresh of the profile data
              await BlocProvider.of<ProfileCubit>(context)
                  .getProfileDataForPatients();

              // Navigate to home
              if (mounted) {
                debugPrint('Navigating to: ${Routes.bottomNavBar}');
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.bottomNavBar,
                  (route) => false,
                  arguments: 'patient',
                );
              }
            } else if (state is UpdateProfileLoadingForPatients) {
              HelperMethods.showLoadingAlertDialog(context);
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
                          CustomAppHeader(
                            canBack: true,
                            title: 'Edit Profile',
                            horizSpace: MediaQuery.sizeOf(context).width < 400
                                ? 56
                                : 70,
                          ),
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
                            itemList: <String>[
                              'Hypertension',
                              'Abdominal pain',
                              'Diabetes Mellitus',
                              'Nausea or vomiting',
                              'Gastritis',
                              'Constipation',
                              'Peptic Ulcer Disease',
                              'Bloating or gas',
                              'Irritable Bowel Syndrome',
                              'Loss of appetite',
                              'Gastroesophageal Reflux Disease',
                              'Diarrhea',
                              'Inflammatory Bowel Disease',
                              'Acid reflux or Heartburn',
                              'Liver Cirrhosis',
                              'Chronic Kidney Disease',
                              'Heart Failure',
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
                                  label: 'Age',
                                  hintText: '22 Years',
                                  kbType: TextInputType.number,
                                  controller: _ageController,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your age';
                                    }
                                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                                      return 'Please enter a valid age';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              horizontalSpace(8),
                              Expanded(
                                child: CustomDropdown(
                                  itemList: const <String>[
                                    'Male',
                                    'Female',
                                    'Rather Not Say',
                                  ],
                                  hint: 'Select Gender',
                                  label: 'Gender',
                                  selectedValue: genderSelectedValue,
                                  isValueNull: isGenderSelected,
                                  onItemChanged: (String value) {
                                    setState(() {
                                      genderSelectedValue = value;
                                      isGenderSelected = true;
                                    });
                                  },
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
              ],
            );
          },
        ),
      ),
    );
  }
}
