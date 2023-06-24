class IssueDetails {
  String image;
  List<Map<String, dynamic>>? characterCredits;
  List<Map<String, dynamic>>? teamCredits;
  List<Map<String, dynamic>>? locationCredits;
  List<Map<String, dynamic>>? conceptCredits;

  IssueDetails({
    required this.image,
    this.characterCredits,
    this.teamCredits,
    this.locationCredits,
    this.conceptCredits,
  });

  factory IssueDetails.fromJson(Map<String, dynamic> json) {
    return IssueDetails(
      image: json['image'],
      characterCredits: json['character_credits'],
      teamCredits: json['team_credits'],
      locationCredits: json['location_credits'],
      conceptCredits: json['concept_credits'],
    );
  }
}
