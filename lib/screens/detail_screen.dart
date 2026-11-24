import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({
    super.key,
    required this.post,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PostService postService = PostService();

  late Future<List<dynamic>> commentsFuture;

  @override
  void initState() {
    super.initState();
    commentsFuture = postService.getComments(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengumuman #${post.id}',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 28),
            const Divider(),
            const Text(
              'Komentar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            FutureBuilder<List<dynamic>>(
              future: commentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'Gagal memuat komentar. Periksa koneksi internet.',
                    style: TextStyle(color: Colors.red),
                  );
                }

                final comments = snapshot.data ?? [];

                return Column(
                  children: comments.map((comment) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          comment['name'] ?? 'Tanpa nama',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment['email'] ?? ''),
                            const SizedBox(height: 6),
                            Text(comment['body'] ?? ''),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
