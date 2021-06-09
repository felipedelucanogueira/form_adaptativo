class FormModel {
  String? name;
  String? surname;
  int? rowid;

  FormModel({
    this.name,
    this.surname,
  });

  String getFullName() {
    return '$name $surname';
  }
}
