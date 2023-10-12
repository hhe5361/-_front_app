class AifileModel {
  final String filePath;

  AifileModel({required this.filePath});

  factory AifileModel.fromJson(Map<String, dynamic> json) {
    return AifileModel(
      filePath: json['filePath'],
    );
  }
}
