import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/youtube/v3.dart';
import 'youtube_repository.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'YouTube Trending',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: asyncVideos.when(
        data: (videos) => SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < videos.length; i += 2)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildVideoCard(videos[i])),
                      if (i + 1 < videos.length)
                        Expanded(child: _buildVideoCard(videos[i + 1]))
                      else
                        const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $err', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(popularVideosProvider),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(Video video) {
    final snippet = video.snippet;
    final thumbnail =
        snippet?.thumbnails?.high ??
        snippet?.thumbnails?.medium ??
        snippet?.thumbnails?.default_;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO(tatsuyafujisaki): Open video
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (thumbnail?.url != null)
              AspectRatio(
                aspectRatio:
                    (thumbnail!.width != null &&
                        thumbnail.height != null &&
                        thumbnail.height! > 0)
                    ? thumbnail.width! / thumbnail.height!
                    : 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      thumbnail.url!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    if (video.contentDetails?.duration != null)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _formatDuration(video.contentDetails!.duration!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snippet?.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    snippet?.channelTitle ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(String duration) {
    // ISO 8601 duration format (PT#H#M#S)
    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(duration);
    if (match == null) {
      return '';
    }

    final hours = match.group(1);
    final minutes = match.group(2) ?? '0';
    final seconds = match.group(3) ?? '0';

    if (hours != null) {
      return '$hours:${minutes.padLeft(2, '0')}:${seconds.padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.padLeft(2, '0')}';
    }
  }
}
