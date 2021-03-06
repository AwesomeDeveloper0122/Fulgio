import 'dart:async';
import 'dart:math';

import 'package:Fuligo/screens/video/info.dart';
import 'package:Fuligo/screens/route_screen.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_compass/flutter_compass.dart';

var themeNotifier = ValueNotifier<ThemeVariation>(
  const ThemeVariation(Colors.blue, Brightness.light),
);

class ThemeVariation {
  const ThemeVariation(this.color, this.brightness);
  final MaterialColor color;
  final Brightness brightness;
}

// ignore: must_be_immutable
class Audio extends StatefulWidget {
  String id;

  Audio({Key? key, required this.id}) : super(key: key);
  @override
  AudioState createState() => AudioState();
}

class AudioState extends State<Audio> {
  late AudioPlayer _player;

  late Stream<DurationState> _durationState;
  final _isShowingWidgetOutline = false;
  final _labelLocation = TimeLabelLocation.above;
  final _labelType = TimeLabelType.totalTime;
  final _labelPadding = 0.0;
  final _barHeight = 5.0;
  final _barCapShape = BarCapShape.round;

  List<Widget> images = [];
  List cachedimages = [];
  Map audioData = {};
  String audio_url = '';
  bool loading = true;

  Color? _thumbGlowColor;
  ValueNotifier<double> direction = ValueNotifier(0);
  final _thumbCanPaintOutsideBar = true;

  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  // ];

  @override
  void initState() {
    getAudioData(widget.id);
    FlutterCompass.events!.listen((event) {
      direction.value = event.heading!;
    });
    super.initState();

    _player = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(audio_url);
      _player.play();

      loading = false;
      setState(() {
        loading = loading;
      });
    } catch (e) {
      debugPrint('An error occured $e');
    }
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();
    return url;
  }

  // Future<List<CachedNetworkImageProvider>> _loadAllImages(List imgList) async {
  //   List<CachedNetworkImageProvider> cachedImages = [];
  //   for (int i = 0; i < imgList.length; i++) {
  //     var configuration = createLocalImageConfiguration(context);
  //     cachedImages.add(
  //         new CachedNetworkImageProvider(imgList[i])..resolve(configuration));
  //   }
  //   setState(() {
  //     cachedimages = cachedImages;
  //   });
  //   print("cachedImages");
  //   print(cachedImages);
  //   return cachedImages;
  // }

  Future<void> getAudioData(id) async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? "";
    var collection = FirebaseFirestore.instance.collection('pointOfInterest');
    var mediadata = await collection.doc(id).get();

    var data = mediadata.data();
    List imageUrl = data!["app_image"];

    String infoimage = "";
    infoimage = imageUrl[0];

    for (var i = 0; i < imageUrl.length; i++) {
      var item = imageUrl[i];
      // String img = await getUrlFromFirebase(item);
      // Uint8List uint8image = (await NetworkAssetBundle(Uri.parse(img)).load(""))
      //     .buffer
      //     .asUint8List();

      images.add(
        // MemoryImage(uint8image, scale: 2));
        // Image.network(
        //   item,
        //   fit: BoxFit.fill,
        //   gaplessPlayback: true,
        // ),
        Image(
          image: CachedNetworkImageProvider(item),
          fit: BoxFit.cover,
        ),
      );
    }

    List audioUrl = data["audio"];
    // ignore: non_constant_identifier_names
    String AudioNetUrl = await getUrlFromFirebase(audioUrl[0]);

    audioData = {
      "image": infoimage,
      "name": data["name"][lang],
      "description": data["description"][lang],
      "rating": data["rating"],
    };
    setState(() {
      audioData = audioData;
      audio_url = AudioNetUrl;
      images = images;
    });
    _init();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double rating = 0.0;
    print("images");
    print(images);
    if (audioData.isNotEmpty) {
      rating = audioData["rating"].toDouble();
      loading = false;
    }

    var mq = MediaQuery.of(context).size;

    return Scaffold(
        body: !loading
            ? Container(
                width: mq.width,
                height: mq.height,
                decoration: const BoxDecoration(
                  // color: bgColor.withAlpha(100),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
                      fit: BoxFit.cover),
                ),
                child: SafeArea(
                  child: Stack(children: [
                    CarouselSlider(
                      items: images,
                      options: CarouselOptions(
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        viewportFraction: 1,
                        // enlargeCenterPage: true,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pop(context),
                          // timer.cancel(),
                        },
                        child: Image.asset(
                          'assets/images/png/icon-cross.png',
                          scale: 0.8,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 65,
                      right: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            audioData["name"].toString(),
                            style: font_13_white,
                            textAlign: TextAlign.center,
                          ),
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.favorite,
                              color: whiteColor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/compass-rose.png",
                              scale: 3.5)
                        ],
                      ),
                    ),
                    Positioned(
                      top: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: direction,
                            builder: (context, x, z) {
                              return Transform.rotate(
                                angle: (direction.value * (pi / 180) * -1),
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 20),
                                    child: Image.asset(
                                        "assets/images/compass-needle.png",
                                        scale: 6)),
                              );
                            },
                          ),
                          // Image.asset("assets/images/compass-needle.png",
                          //     scale: 7)
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
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
                                            builder: (context) => Info(
                                              infodata: audioData,
                                            ),
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
                              child: _playButton(),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RouteScreen(
                                        infodata: audioData,
                                      ),
                                    ),
                                  ),
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: direction,
                                  builder: (context, x, z) {
                                    return Transform.rotate(
                                      angle:
                                          (direction.value * (pi / 180) * -1),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: Image.asset(
                                            "assets/images/icon-compass.png",
                                            scale: 6),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          decoration: _widgetBorder(),
                          child: _progressBar(),
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            : defaultloading(context));
  }

  BoxDecoration _widgetBorder() {
    return BoxDecoration(
      border: _isShowingWidgetOutline
          ? Border.all(color: Colors.red)
          : Border.all(color: Colors.transparent),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            _player.seek(duration);
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: _barHeight,
          baseBarColor: whiteColor.withOpacity(0.24),
          bufferedBarColor: whiteColor.withOpacity(0.24),
          progressBarColor: whiteColor,
          thumbColor: whiteColor,
          thumbGlowColor: _thumbGlowColor,
          barCapShape: _barCapShape,
          thumbRadius: 8,
          thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
          timeLabelTextStyle: TextStyle(color: whiteColor),
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_circle_outline),
            iconSize: 100.0,
            color: Colors.white,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause_circle_outline),
            iconSize: 100,
            color: Colors.white,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay_circle_filled_outlined),
            iconSize: 100,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
