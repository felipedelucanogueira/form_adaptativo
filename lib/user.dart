class User{
  int? rowid;
  String name;
  String surname;

  User(this.name,this.surname, this.rowid);

  User.fromMap(Map <String , dynamic> map):

  name = map['name'],
  surname = map['surname'],
  rowid = map['rowid'];

  Map<String,dynamic> toMap() {
    return { 'name':name,'surname': surname,'rowid': rowid};

  }
}