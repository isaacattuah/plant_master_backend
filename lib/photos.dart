class Photo{
  final String photo_url;

  Photo({
    required this.photo_url

  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        photo_url: json["images_results"][0]["original"],
    );
  }

}