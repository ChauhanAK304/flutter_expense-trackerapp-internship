class UserExpense {
 // late final String id;
  late final String userid;
  late final String title;
  late final String category;
  late final double amount;
  late final String note;
  late final DateTime date;

  UserExpense({
   // required this.id,
     required this.userid,
    required this.title,
    required this.category,
    required this.amount,
    required this.note,
    required this.date,
  });


  /// object to map
UserExpense.fromMap(Map<String, dynamic>map, this.userid, this.title, this.category, this.amount, this.note, this.date){
 // id = map["id"];
  userid = map["userid"];
  title = map["title"];
  category = map["category"];
  amount = map["amount"];
  note = map["note"];
  date = map["date"];}


  /// map to object
  Map<String, dynamic> toMap() {
   return {
    // "id" : id,
     "userid" : userid,
     "title" : title,
     "category": category,
     "amount":  amount,
     "note": note,
     "date": date
   };
  }
}