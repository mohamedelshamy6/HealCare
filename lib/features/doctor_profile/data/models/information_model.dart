import 'package:heal_care/core/helpers/app_images.dart';

class InformationModel {
  final String icon;
  final String label;
  final String value;

  InformationModel({
    required this.icon,
    required this.label,
    required this.value,
  });
}

List<InformationModel> informationList = [
  InformationModel(
    icon: Assets.iconsAgeIconBlue,
    label: 'Specialization',
    value: 'Heart',
  ),
  InformationModel(
    icon: Assets.iconsEmailIconBlue,
    label: 'Email',
    value: 'O5YKJ@example.com',
  ),
  InformationModel(
    icon: Assets.iconsGenderIconBlue,
    label: 'Gender',
    value: 'Male',
  ),
  InformationModel(
    icon: Assets.iconsLocationIconBlue,
    label: 'Address',
    value: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  ),
];
