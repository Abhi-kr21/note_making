
class Data{
   String? title;
   String? description;
   String? uid;
   Data({required this.title,required this.description, required this.uid});


   Map<String, dynamic> tojson() {
    return {
      'title': title,
      'description':description,
      'uid':uid
    };
  }

     factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        title: json['title'],
       description: json['description'],
       uid:json['uid']
       );
  }
}

