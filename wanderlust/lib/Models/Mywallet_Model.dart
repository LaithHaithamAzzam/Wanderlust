class MyWallet_Model {
  int? Money;

  MyWallet_Model({this.Money});

  MyWallet_Model.fromJson(Map<String, dynamic> json) {
    Money = json['Money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Money'] = this.Money;
    return data;
  }
}
