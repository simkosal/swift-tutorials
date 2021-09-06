class ResponePinModel {
  final PinData? data;
  final String? message;

  ResponePinModel({this.data, this.message});

  factory ResponePinModel.fromJson(Map<String, dynamic> json) {
    return ResponePinModel(
      data: json['data'] != null ? new PinData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class PinData {
  final String? pID;
  final bool? isStatic;

  PinData({this.pID, this.isStatic});

  factory PinData.fromJson(Map<String, dynamic> json) {
    return PinData(pID: json['PID'], isStatic: json["static"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PID'] = this.pID;
    return data;
  }
}
