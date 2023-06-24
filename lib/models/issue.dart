class Issue {
  String name;
  String dateAdded;
  String image;
  String detailUrl;

  Issue({
    required this.name,
    required this.dateAdded,
    required this.image,
    required this.detailUrl,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    String? tempName = json['name'] ?? 'Unnamed';

    return Issue(
      name: '$tempName #${json["issue_number"]}',
      dateAdded: json['date_added'],
      image: json['image']['original_url'],
      detailUrl: json['api_detail_url'],
    );
  }

  static List<Issue> fromArray(List list) {
    List<Issue> result = [];
    for (var json in list) {
      result.add(Issue.fromJson(json));
    }
    return result;
  }
}
