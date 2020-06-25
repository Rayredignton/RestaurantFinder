class User {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
 
  User({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["status"] = user.status;
    data["state"] = user.state;
    
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
   
  }
}