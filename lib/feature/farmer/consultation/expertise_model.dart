class ExpertiseModel {
  final String name;
  final String number;
  final String email;
  ExpertiseModel({
    required this.name,
    required this.number,
    required this.email,
  });
}

class ExpertiseData {
  ExpertiseData._();

  static List<ExpertiseModel> data = [
    ExpertiseModel(
      name: "Frederick",
      number: "1234567890",
      email: "LQqFP@example.com",
    ),
    ExpertiseModel(
      name: "Mawuli",
      number: "1234567890",
      email: "LQqFP@example.com",
    ),
    ExpertiseModel(
      name: "Albert",
      number: "1234567890",
      email: "LQqFP@example.com",
    )
  ];
}
