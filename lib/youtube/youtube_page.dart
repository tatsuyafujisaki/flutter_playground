import 'package:flutter/material.dart';
import 'package:flutter_playground/youtube/youtube_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googleapis/youtube/v3.dart';

final popularVideosProvider = FutureProvider<List<Video>>((ref) async {
  final repository = ref.watch(youtubeRepositoryProvider);
  return repository.fetchPopularVideos();
});

class YoutubePage extends ConsumerWidget {
  const YoutubePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncVideos = ref.watch(popularVideosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular Videos')),
      body: asyncVideos.when(
        data: (videos) => MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            final snippet = video.snippet;
            final thumbnail =
                snippet?.thumbnails?.high?.url ??
                snippet?.thumbnails?.medium?.url ??
                snippet?.thumbnails?.default_?.url;

            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (thumbnail != null)
                    Image.network(thumbnail, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snippet?.title ?? 'No Title',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: $err'),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
