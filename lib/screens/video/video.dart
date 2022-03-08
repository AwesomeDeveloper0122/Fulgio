// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/video/info.dart';
import 'package:Fuligo/screens/route_screen.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Video extends StatefulWidget {
  String id;

  Video({Key? key, required this.id}) : super(key: key);

  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Video> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  bool startedPlaying = false;
  String totalTimeString = "";
  String currentTimeString = "";
  Map videoData = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getVideoData(widget.id);

    // _controller.play();
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();

    return url;
  }

  Future<void> getVideoData(id) async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? "";
    var collection = FirebaseFirestore.instance.collection('pointOfInterest');
    var mediadata = await collection.doc(id).get();
    var data = mediadata.data();
    List imageUrl = data!["image"];
    String infoimage = "";
    infoimage = await getUrlFromFirebase(imageUrl[0]);
    List imageNetList = [];
    if (imageUrl.isNotEmpty) {
      for (var item in imageUrl) {
        imageNetList.add(await getUrlFromFirebase(item));
      }
    }
    List videoUrl = mediadata.get("video");
    String videoNetUrl = await getUrlFromFirebase(videoUrl[0]);
    if (videoNetUrl.isNotEmpty) {
      _controller = VideoPlayerController.network((videoNetUrl));
      _initializeVideoPlayerFuture = _controller.initialize();

      _controller.addListener(() {
        loading = false;
        setState(() {});
      });
      _controller.setLooping(true);
      _controller.initialize().then((_) => setState(() {}));
      _controller.play(); //auto play
    }

    videoData = {
      "image": infoimage,
      "name": data["name"][lang],
      "description": data["description"][lang],
      "rating": data["rating"],
    };
    setState(() {
      videoData = videoData;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !loading
            ? FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                VideoPlayer(_controller),
                                Container(
                                    child: _ControlsOverlay(
                                        controller: _controller,
                                        infodata: videoData)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 30),
                                  child: VideoProgressIndicator(
                                    _controller,
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                        backgroundColor: Colors.grey,
                                        // bufferedColor: Colors.yellow,
                                        playedColor: Colors.white),
                                  ),
                                ),
                                SecondaryButton(context),
                                Positioned(
                                  top: 65,
                                  right: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        videoData["name"] ?? "",
                                        style: font_13_white,
                                        textAlign: TextAlign.center,
                                      ),
                                      RatingBar.builder(
                                        initialRating: videoData["rating"]!,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.favorite,
                                          color: whiteColor,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return defaultloading(context);
                  }
                },
              )
            : defaultloading(context));
  }
}

// ignore: must_be_immutable
class _ControlsOverlay extends StatelessWidget {
  Map infodata;
  _ControlsOverlay({Key? key, required this.controller, required this.infodata})
      : super(key: key);

  final VideoPlayerController controller;

  Duration get totalVideoLength {
    return controller.value.duration;
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String get totalVideoLengthString {
    return _printDuration(totalVideoLength);
  }

  Duration get timeRemaining {
    Duration current = controller.value.position;
    int millis = totalVideoLength.inMilliseconds - current.inMilliseconds;
    return Duration(milliseconds: millis);
  }

  String get timeRemainingString {
    return _printDuration(timeRemaining);
  }

  Duration get timecurrent {
    Duration current = controller.value.position;
    int millis = current.inMilliseconds;
    return Duration(milliseconds: millis);
  }

  String get timeCurrentString {
    return _printDuration(timecurrent);
  }

  @override
  Widget build(BuildContext context) {
    Map infodata = this.infodata;

    return Stack(
      children: <Widget>[
        Positioned(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 60),
                width: MediaQuery.of(context).size.width,
                color: !controller.value.isPlaying
                    ? Colors.black54
                    : Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Info(infodata: infodata),
                                  ),
                                ),
                              },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 66.0,
                              semanticLabel: 'Route',
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: !controller.value.isPlaying
                          ? GestureDetector(
                              onTap: () {
                                controller.play();
                              },
                              child: Icon(
                                Icons.play_circle_outline_outlined,
                                color: Colors.white,
                                size: 100.0,
                                semanticLabel: 'Play',
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.pause();
                              },
                              child: Icon(
                                Icons.pause_circle_outline,
                                color: Colors.white,
                                size: 100.0,
                                semanticLabel: 'Pause',
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RouteScreen(infodata: infodata),
                                  ),
                                ),
                              },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.power_settings_new_sharp,
                              color: Colors.white,
                              size: 66.0,
                              semanticLabel: 'Route',
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            child: Text(
              timeCurrentString,
              style: TextStyle(color: whiteColor, fontSize: 15),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            child: Text(
              totalVideoLengthString,
              style: TextStyle(color: whiteColor, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
