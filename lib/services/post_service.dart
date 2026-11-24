import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Mengambil semua pengumuman
  Future<List<Post>> getPosts() async {
    final url = Uri.parse('$baseUrl/posts');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil pengumuman');
    }
  }

  // Mengambil komentar berdasarkan ID pengumuman
  Future<List<dynamic>> getComments(int postId) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil komentar');
    }
  }

  // Mengirim pengumuman baru
  Future<Post> createPost(String title, String body) async {
    final url = Uri.parse('$baseUrl/posts');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Post.fromJson(data);
    } else {
      throw Exception('Gagal membuat pengumuman');
    }
  }
}
