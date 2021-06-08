class FormModel {
  String? name;
  String? surname;

  FormModel({
    this.name,
    this.surname,
  });

  String getFullName() {
    return '$name $surname';
  }
}
