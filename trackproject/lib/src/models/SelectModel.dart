class DataSelect {
  DataSelect({required this.datatype}); //id가 미리 정해짐 ? ㄴ

  late int id;
  final String datatype;

  Map<String, dynamic> tojson() {
    //json 데이터로 포맷
    return {datatype + "id": id};
  }
}
