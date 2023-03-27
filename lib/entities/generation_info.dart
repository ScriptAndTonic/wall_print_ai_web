class GenerationInfo {
  final String predictionId;
  final List<String> imageUrls;

  const GenerationInfo({
    required this.predictionId,
    required this.imageUrls,
  });

  factory GenerationInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> imageUrlsAsDynamicList = json['imageUrls'];
    return GenerationInfo(
      predictionId: json['predictionId'] as String,
      imageUrls: imageUrlsAsDynamicList.map((e) => e as String).toList(),
    );
  }
}
