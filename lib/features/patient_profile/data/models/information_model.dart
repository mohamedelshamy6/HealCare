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
    icon: Assets.iconsAgeIconBlue,
    label: 'Age',
    value: '22',
  ),
  InformationModel(
    icon: Assets.iconsBloodtypeIconBlue,
    label: 'Blood Type',
    value: 'B+',
  ),
  InformationModel(
    icon: Assets.iconsWeightIconBlue,
    label: 'Weight',
    value: '85kg',
  ),
  InformationModel(
    icon: Assets.iconsHeightIconBlue,
    label: 'Height',
    value: '185cm',
  ),
  InformationModel(
    icon: Assets.iconsLocationIconBlue,
    label: 'Address',
    value: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  ),
];
