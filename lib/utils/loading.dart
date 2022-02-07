import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// For Loading Widget
Widget kLoadingWidget(context) => Center(
      child: SpinKitFadingCube(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      ),
    );
Widget kLoadingWaveWidget(context, Color color) => Center(
      child: SpinKitWave(
        color: color,
        size: 50.0,
      ),
    );
Widget kLoadingFadeWidget(context) => Center(
      child: SpinKitDualRing(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      ),
    );

Widget kLoadingFadingWidget(context) => Center(
      child: SpinKitFadingCircle(
        color: Theme.of(context).primaryColor,
        size: 50.0,
      ),
    );
