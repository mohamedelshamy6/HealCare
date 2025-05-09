import '../../../../core/helpers/app_images.dart';

class DoctorsModel {
  final String name;
  final String image;
  final String job;

  DoctorsModel({
    required this.name,
    required this.image,
    required this.job,
  });
}

List<DoctorsModel> doctors = [
  DoctorsModel(
    name: 'Dr. Sherif Murad ',
    image: Assets.imagesDoctorsDoctorM7,
    job: 'Internal Medicine | Cardiology Doctor in Nasr City, Cairo',
  ),
  DoctorsModel(
    name: 'Dr. Atef Gaber',
    image: Assets.imagesDoctorsDoctorM6,
    job: 'Neurologist | ABC hospital',
  ),
  DoctorsModel(
    name: 'Dr. Tariq Ramadan',
    image: Assets.imagesDoctorsDoctorM5,
    job: 'Dentist | Cedar Dental care',
  ),
  DoctorsModel(
    name: 'Dr. Khaled Kamal Abu Nourj',
    image: Assets.imagesDoctorsDoctorM4,
    job: 'Internal Medicine, Cardiology Doctor in Nasr City, Cairo',
  ),
  DoctorsModel(
    name: 'Dr. Mayada Farag',
    image: Assets.imagesDoctorsDoctorF,
    job: 'Ear, Nose & Throat specialist - Mercy Hospital',
  ),
  DoctorsModel(
    name: 'Dr. Diaa El-Din Mohammed',
    image: Assets.imagesDoctorsDoctorM3,
    job: 'Cardiologist - Cumilla Medical Collage',
  ),
  DoctorsModel(
    name: 'Dr. Mena Wasef',
    image: Assets.imagesDoctorsDoctorM2,
    job: 'Cardiologist - ABC hospital',
  ),
  DoctorsModel(
    name: 'Dr. Essa Abdelall',
    image: Assets.imagesDoctorsDoctorM,
    job: 'Cardiologist - Cumilla Medical Collage',
  ),
];
