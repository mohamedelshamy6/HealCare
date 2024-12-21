
import 'package:heal_care/core/helpers/app_images.dart';

class AllBookingModel {
  final String? name;
  final String? specialty;
  final String? imageUrl;
  final String? jobAddress;
  final String? startDate;
  final String? endDate;
  AllBookingModel(
      { this.name,
       this.specialty,
       this.imageUrl,
       this.jobAddress,
       this.startDate,
       this.endDate});
}
List<AllBookingModel> bookingList = [
      AllBookingModel(
        name: 'John Deo',
        specialty: 'M.Sc. - Food and Nutrition',
        imageUrl: Assets.imagesPatientsPatientM,
        jobAddress: 'Nutritionist',
        startDate: '02 February 2023',
        endDate: '1:00 PM - 2:00 PM',
      ),
      AllBookingModel(
          name: 'Lama',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: Assets.imagesPatientsPatientF,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2024',
          endDate: '2:00 PM - 3:00 PM'),
      AllBookingModel(
          name: 'Mala',
          specialty: 'M.Sc. - lunch and Nutrition',
          imageUrl: Assets.imagesPatientsPatientF2,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2025',
          endDate: '3:00 PM - 4:00 PM'),
      AllBookingModel(
          name: 'Linda',
          specialty: 'M.Sc. - Food only',
          imageUrl: Assets.imagesPatientsPatientF3,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Sam',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: Assets.imagesPatientsPatientM2,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Dan',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: Assets.imagesPatientsPatientM3,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Mad',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: Assets.imagesPatientsPatientM4,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Leo',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: Assets.imagesPatientsPatientM5,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Ramy',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: Assets.imagesPatientsPatientM6,
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
    ];