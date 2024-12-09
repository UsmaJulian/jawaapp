class AvatarReference {
  AvatarReference(this.downloadUrl);

  factory AvatarReference.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return AvatarReference('');
    }
    final downloadUrl = data['downloadUrl'].toString();
    return AvatarReference(downloadUrl);
  }
  final String downloadUrl;

  Map<String, dynamic> toMap() {
    return {
      'downloadUrl': downloadUrl,
    };
  }
}
