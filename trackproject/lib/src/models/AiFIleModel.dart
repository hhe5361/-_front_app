//완성된 영상 작업물 연결하는 거임.
class AifileModel {
  final String filePath;

  AifileModel({required this.filePath});

  factory AifileModel.fromJson(Map<String, dynamic> json) {
    return AifileModel(
      filePath: json['filePath'],
    );
  }
}
