class IssueDetails {
  String image;
  List<Map<String, String>> characterCredits;
  List<Map<String, String>> teamCredits;
  List<Map<String, String>> locationCredits;

  IssueDetails({
    required this.image,
    required this.characterCredits,
    required this.teamCredits,
    required this.locationCredits,
  });

  factory IssueDetails.fromJson(Map<String, dynamic> json) {
    return IssueDetails(
      image: json['image']['original_url'],
      characterCredits: json['characterCredits'],
      teamCredits: json['teamCredits'],
      locationCredits: json['locationCredits'],
    );
  }
}
