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
    name: 'Dr. Jennifer Miller',
    image: Assets.imagesDoctorsDoctorF2,
    job: 'Pediatrician | Mercy Hospital',
  ),
  DoctorsModel(
    name: 'Dr. Robert Johnson',
    image: Assets.imagesDoctorsDoctorM2,
    job: 'Neurologist | ABC hospital',
  ),
  DoctorsModel(
    name: 'Dr. Laura White',
    image: Assets.imagesDoctorsDoctorF3,
    job: 'Dentist | Cedar Dental care',
  ),
  DoctorsModel(
    name: 'Dr. Brian Clark',
    image: Assets.imagesDoctorsDoctorM3,
    job: 'Psychiatrist | ABC hospital',
  ),
  DoctorsModel(
    name: 'Dr. Khaled Ahmed',
    image: Assets.imagesDoctorsDoctorM4,
    job: 'Cardiologist - Cumilla Medical Collage',
  ),
  DoctorsModel(
    name: 'Dr. Mahbuba Islam',
    image: Assets.imagesDoctorsDoctorF4,
    job: 'Cardiologist - ABC hospital',
  ),
  DoctorsModel(
    name: 'Dr. Maria Watson',
    image: Assets.imagesDoctorsDoctorF,
    job: 'Cardiologist - Cumilla Medical Collage',
  ),
  DoctorsModel(
    name: 'Dr. Stone Gaze',
    image: Assets.imagesDoctorsDoctorM,
    job: 'Ear, Nose & Throat specialist - Mercy Hospital',
  ),
];
