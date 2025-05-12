import '../../../../core/helpers/app_images.dart';

class DoctorssModel {
  final String name;
  final String image;
  final String job;

  DoctorssModel({
    required this.name,
    required this.image,
    required this.job,
  });
}

List<DoctorssModel> doctors = [
  DoctorssModel(
    name: 'Dr. Sherif Murad ',
    image: Assets.imagesDoctorsDoctorM7,
    job: 'Internal Medicine | Cardiology Doctor in Nasr City, Cairo',
  ),
  DoctorssModel(
    name: 'Dr. Atef Gaber',
    image: Assets.imagesDoctorsDoctorM6,
    job: 'Neurologist | ABC hospital',
  ),
  DoctorssModel(
    name: 'Dr. Tariq Ramadan',
    image: Assets.imagesDoctorsDoctorM5,
    job: 'Dentist | Cedar Dental care',
  ),
  DoctorssModel(
    name: 'Dr. Khaled Kamal Abu Nourj',
    image: Assets.imagesDoctorsDoctorM4,
    job: 'Internal Medicine, Cardiology Doctor in Nasr City, Cairo',
  ),
  DoctorssModel(
    name: 'Dr. Mayada Farag',
    image: Assets.imagesDoctorsDoctorF,
    job: 'Ear, Nose & Throat specialist - Mercy Hospital',
  ),
  DoctorssModel(
    name: 'Dr. Diaa El-Din Mohammed',
    image: Assets.imagesDoctorsDoctorM3,
    job: 'Cardiologist - Cumilla Medical Collage',
  ),
  DoctorssModel(
    name: 'Dr. Mena Wasef',
    image: Assets.imagesDoctorsDoctorM2,
    job: 'Cardiologist - ABC hospital',
  ),
  DoctorssModel(
    name: 'Dr. Essa Abdelall',
    image: Assets.imagesDoctorsDoctorM,
    job: 'Cardiologist - Cumilla Medical Collage',
  ),
];
