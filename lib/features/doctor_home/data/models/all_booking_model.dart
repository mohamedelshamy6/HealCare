class AllBookingModel {
  final String name;
  final String? specialty;
  final String? imageUrl;
  final String? jobAddress;
  final String? startDate;
  final String? endDate;

  AllBookingModel(
      {required this.name,
      required this.specialty,
      required this.imageUrl,
      required this.jobAddress,
      required this.startDate,
      required this.endDate});
}
