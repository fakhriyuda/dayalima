import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widget_zoom/widget_zoom.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostItem extends StatelessWidget {
  const PostItem(
      {super.key,
      this.image,
      this.likes,
      this.message,
      this.id = 0,
      this.videoUrl});
  final String? image;
  final String? message;
  final int? likes;
  final int? id;
  final String? videoUrl;

  @override
  Widget build(BuildContext context) {
    String? videoId;
    check() {
      videoId = YoutubePlayer.convertUrlToId(videoUrl ?? "") ?? "";
      return videoId!;
    }

    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: check(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    var imageNull = image ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(),
            ),
            Text("Username", style: Theme.of(context).textTheme.bodyLarge),
          ]),
          Visibility(
              visible: imageNull != "",
              replacement: videoId != ""
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(message!,
                          style: Theme.of(context).textTheme.headlineSmall),
                      alignment: Alignment.center,
                      color: Colors.blueGrey[50],
                    ),
              child: WidgetZoom(
                heroAnimationTag: 'tag$id',
                zoomWidget: CachedNetworkImage(
                  imageUrl: image ?? "",
                  placeholder: (context, url) {
                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            height: 200,
                                            width: double.infinity,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                // FadeInImage.assetNetwork(

                //     placeholder: 'assets/images/noimage.jpg',
                //     image: image ?? ""),
              )),
          Visibility(
            visible: videoId != "",
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$likes Likes"),
                RichText(
                  text: TextSpan(
                    text: 'Username ',
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: <TextSpan>[
                      TextSpan(
                        text: message ?? "",
                        style: DefaultTextStyle.of(context).style,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
