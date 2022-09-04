class Building {
  final int id;
  final String? address;
  final String name;
  final String shortName;

  Building(
      {required this.id,
      required this.name,
      this.address,
      required this.shortName});
}
