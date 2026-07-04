import 'package:equatable/equatable.dart';

class News extends Equatable{
  final int? id;
  final String title;
  final String content;
  final String image;
  final String published_at;
  News({required this.id,required this.title,required this.content,required this.image,required this.published_at});
  @override

  List<Object?> get props => [id,title,content,image,published_at];

}