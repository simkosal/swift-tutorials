import 'dart:io';

class MessagingNotificationModel {
  final String title;
  final String description;
  final String customData;

  MessagingNotificationModel(this.title, this.description, this.customData);

  factory MessagingNotificationModel.fromJson(Map<String, dynamic> message) {
    String title;
    String description;
    String customData;

    if (!Platform.isIOS) {
      title = message['notification']['title'];
      description = message['notification']['body'];
      customData = message['data']['customData'];
    } else {
      title = message['aps']['alert']['title'];
      description = message['aps']['alert']['body'];
      customData = message['customData'];
    }

    return MessagingNotificationModel(title, description, customData);
  }
}
