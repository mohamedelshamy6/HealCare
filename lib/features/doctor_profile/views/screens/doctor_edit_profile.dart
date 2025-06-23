import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/image_picker_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_drop_down.dart';
import 'package:heal_care/features/auth/view/widgets/tff_with_label.dart';
import 'package:heal_care/features/auth/view/widgets/upload_photo_widget.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorEditProfile extends StatelessWidget {
  const DoctorEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyInjection.getIt<ProfileCubit>(),
      child: const _DoctorEditProfileContent(),
    );
  }
}

class _DoctorEditProfileContent extends StatefulWidget {
  const _DoctorEditProfileContent();

  @override
  _DoctorEditProfileState createState() => _DoctorEditProfileState();
}

class _DoctorEditProfileState extends State<_DoctorEditProfileContent> {
  File? image;
  final _nameController = TextEditingController();
  final _educationController = TextEditingController();
  final _instaPayController = TextEditingController();
  final _workingHoursController = TextEditingController();
  final _addressController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? specializationSelectedValue;
  String? genderSelectedValue;
  late ProfileCubit _profileCubit;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _profileCubit = context.read<ProfileCubit>();
    // Load initial data if needed
    _profileCubit.getProfileDataForDoctors();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _educationController.dispose();
    _instaPayController.dispose();
    _workingHoursController.dispose();
    _addressController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? uploadedImageUrl;

      if (image != null) {
        try {
          final bytes = await image!.readAsBytes();
          final fileExt = image!.path.split('.').last;
          final filePath =
              'doctors/profile_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

          await Supabase.instance.client.storage
              .from('doctors-media')
              .uploadBinary(
                filePath,
                bytes,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

          uploadedImageUrl = Supabase.instance.client.storage
              .from('doctors-media')
              .getPublicUrl(filePath);

              if (imageUrl != null) {
            final uri = Uri.parse(imageUrl!);
            final segments = uri.pathSegments;
            final index = segments.indexOf('patients-media');
            if (index != -1 && segments.length > index + 1) {
              final oldImagePath = segments.sublist(index + 1).join('/');
              await Supabase.instance.client.storage
                  .from('patients-media')
                  .remove([oldImagePath]);

              log('Old image full URL: $imageUrl');
              log('Path to delete from Supabase: $oldImagePath');
            }
          }
        } catch (e) {
          HelperMethods.showCustomSnackBarError(
              context, 'Failed to upload image: ${e.toString()}');
          return;
        }
      }

      final data = {
        'name': _nameController.text.trim(),
        'education': _educationController.text.trim(),
        'insta_pay_link': _instaPayController.text.trim(),
        'address': _addressController.text.trim(),
        'experience': _experienceController.text.trim(),
        'bio': _bioController.text.trim(),
        'specialization': specializationSelectedValue,
        'gender': genderSelectedValue,
        if (uploadedImageUrl != null) 'image': uploadedImageUrl,
      }..removeWhere((key, value) => value == null || value.isEmpty);

      _profileCubit.updateProfileForDoctors('doctors', data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoadingForDoctors) {
          HelperMethods.showLoadingAlertDialog(context);
        } else if (state is UpdateProfileSuccessForDoctors) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.bottomNavBar,
            (route) => false,
            arguments: 'doctor',
          );
          UserCacheHelper.cacheDoctorData(state.doctor!);

          HelperMethods.showCustomSnackBarSuccess(
              context, 'Profile updated successfully');
        } else if (state is UpdateProfileErrorForDoctors) {
          HelperMethods.showCustomSnackBarError(context, state.error);
        }
      },
      builder: (context, state) {
        final doctor = state is ProfileSuccessForDoctors ? state.doctor : null;

        if (doctor != null && _nameController.text.isEmpty) {
          _nameController.text = doctor.name ?? '';
          _educationController.text = doctor.education ?? '';
          _instaPayController.text = doctor.instapayLink ?? '';
          _addressController.text = doctor.address ?? '';
          _experienceController.text = doctor.experience ?? '';
          _bioController.text = doctor.bio ?? '';
          specializationSelectedValue = doctor.specialization;
          genderSelectedValue = doctor.gender;
        }

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppHeader(
                      canBack: true,
                      title: 'Edit Profile',
                      horizSpace:
                          MediaQuery.sizeOf(context).width < 400 ? 56 : 70,
                    ),
                    verticalSpace(16),
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
                    verticalSpace(24),
                    TFFWithLabel(
                      label: 'Full Name',
                      kbType: TextInputType.name,
                      controller: _nameController,
                    ),
                    verticalSpace(12),
                    TFFWithLabel(
                      label: 'Education',
                      kbType: TextInputType.text,
                      controller: _educationController,
                    ),
                    verticalSpace(12),
                    TFFWithLabel(
                      label: 'Insta Pay Link',
                      kbType: TextInputType.url,
                      controller: _instaPayController,
                    ),
                    verticalSpace(12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            isValueNull: specializationSelectedValue == null,
                            selectedValue: specializationSelectedValue,
                            onItemChanged: (value) {
                              setState(() {
                                specializationSelectedValue = value;
                              });
                            },
                            itemList: const [
                              'Eyes',
                              'Teeth',
                              'Skin',
                              'Heart',
                              'Lungs'
                            ],
                            hint: 'Specialization',
                            label: 'Specialization',
                          ),
                        ),
                        horizontalSpace(12),
                        Expanded(
                          child: CustomDropdown(
                            isValueNull: genderSelectedValue == null,
                            selectedValue: genderSelectedValue,
                            onItemChanged: (value) {
                              setState(() {
                                genderSelectedValue = value;
                              });
                            },
                            itemList: const [
                              'Male',
                              'Female',
                              'Rather Not Say'
                            ],
                            hint: 'Gender',
                            label: 'Gender',
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(12),
                    TFFWithLabel(
                      label: 'Address',
                      kbType: TextInputType.streetAddress,
                      maxLines: 3,
                      controller: _addressController,
                    ),
                    verticalSpace(12),
                    TFFWithLabel(
                      label: 'Experience',
                      kbType: TextInputType.multiline,
                      maxLines: 3,
                      controller: _experienceController,
                    ),
                    verticalSpace(12),
                    TFFWithLabel(
                      label: 'Bio',
                      kbType: TextInputType.multiline,
                      maxLines: 4,
                      controller: _bioController,
                    ),
                    verticalSpace(32),
                    CustomButton(
                      buttonText: 'Save',
                      buttonAction: _submitUpdate,
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
        );
      },
    );
  }
}
