import '../../../../core/helpers/app_images.dart';

class PatientModel {
  final String name;
  final String image;

  PatientModel({required this.name, required this.image});
}

List<PatientModel> patients = [
  PatientModel(
    name: 'Eman Abo Samra',
    image: Assets.imagesPatientsPatientF,
  ),
  PatientModel(
    name: 'Eman Salah',
    image: Assets.imagesPatientsPatientF3,
  ),
  PatientModel(
    name: 'Abdelrahman Mohamed',
    image: Assets.imagesPatientsPatientM2,
  ),
  PatientModel(
    name: 'Naira Abdallah',
    image: Assets.imagesPatientsPatientF2,
  ),
  PatientModel(
    name: 'Omar Zeki',
    image: Assets.imagesPatientsPatientM,
  ),
  PatientModel(
    name: 'Mohamed Samy',
    image: Assets.imagesPatientsPatientM3,
  ),
  PatientModel(
    name: 'Mohamed Waleed',
    image: Assets.imagesPatientsPatientM4,
  ),
];
