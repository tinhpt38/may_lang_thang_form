class Show {
  final String singer;
  final String buildDate;
  final String vipRent;
  final String midRent;
  final String normalRent;

  Show(
      {this.singer,
      this.buildDate,
      this.vipRent,
      this.midRent,
      this.normalRent});

  Show.fromJson(Map<String, dynamic> json)
      : this.singer = json['singer'],
        this.buildDate = json['buildDate'],
        this.midRent = json['midRent'],
        this.normalRent = json['normalRent'],
        this.vipRent = json['vipRent'];

  Map<String, dynamic> toJson() => {
        'singer': this.singer,
        'buildDate': this.buildDate,
        'midRent': this.midRent,
        'normalRent': this.normalRent,
        'vipRent': this.vipRent
      };
}
