class Employee {
  final int id;
  final String name;
  final DateTime joiningDate;
  final bool isActive;

  Employee({
    required this.id,
    required this.name,
    required this.joiningDate,
    required this.isActive,
  });

  factory Employee.jsonToEmployee(e) {
    return Employee(
      id: e['id'] ?? 0,
      name: e['name'] ?? '',
      joiningDate: DateTime.parse(e['joiningDate']).toLocal(),
      isActive: e['isActive'] ?? false,
    );
  }
}
