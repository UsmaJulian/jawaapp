class AvatarReference {
  AvatarReference(this.downloadUrl);
  final String downloadUrl;

  factory AvatarReference.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return AvatarReference('');
    }
    final String? downloadUrl = data['downloadUrl'];
    if (downloadUrl == null) {
      return AvatarReference('');
    }
    return AvatarReference(downloadUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'downloadUrl': downloadUrl,
    };
  }
}
