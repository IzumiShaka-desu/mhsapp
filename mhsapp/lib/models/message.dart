class MessageResponse {
  bool result;
  String message;
  String fnameData;
  MessageResponse({this.message, this.result,this.fnameData=''});
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(message: json['message'], result:(json['result'])==1,fnameData: json['fnameData']??'');
}
