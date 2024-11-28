import 'dart:core';

class Resource {
  String resourceId;
  String title;
  String type;
  String link;

  Resource(this.resourceId, this.title, this.type, this.link);

  void accessResource() {
    // In a real app, this might launch a web view or download a file
    print('Accessing resource: $title');
    print('Opening link: $link');
  }

  Map<String, dynamic> getResourceDetails() {
    return {
      'id': resourceId,
      'title': title,
      'type': type,
      'link': link,
    };
  }
}
