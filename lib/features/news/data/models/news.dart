import '../../domain/entities/news.dart';

class NewsModel extends News {
 NewsModel({
  required super.id,
  required super.title,
  required super.content,
  required super.image,
  required super.published_at,
 });


 factory NewsModel.fromDetailsJson(Map<String, dynamic> json) {
  final data = json['news'];

  return NewsModel(
   id: data['id'],
   title: data['title'],
   content: data['content'],
   image: data['image_url'] ?? '',
   published_at: data['published_at'],
  );
 }


 factory NewsModel.fromJson(Map<String, dynamic> json) {
  return NewsModel(
   id: json['id'],
   title: json['title'],
   content: json['content'],
   image: json['image_url'] ?? '',
   published_at: json['published_at'],
  );
 }
}