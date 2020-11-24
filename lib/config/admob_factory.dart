import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

abstract class AdMobFactory {
  static String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-6844643626556379~6787464159';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6844643626556379~1834520378';
    }
    return '';
  }

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-6844643626556379/9878847143';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6844643626556379/9052850630';
    }

    return '';
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-6844643626556379/1010192164';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6844643626556379/3444783818';
    }

    return '';
  }

  static String getRewardedAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-6844643626556379/3013221747';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6844643626556379/5147079429';
    }
    return '';
  }

  static InterstitialAd getInterstitialAd({@required VoidCallback onClosed}) {
    return InterstitialAd(
      adUnitId: AdMobFactory.getInterstitialAdUnitId(),
      targetingInfo: AdMobFactory.getTargetingInfo(),
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.closed) {
          onClosed();
        }
      },
    )..load();
  }

  static BannerAd getBannerAd() {
    return BannerAd(
      adUnitId: AdMobFactory.getBannerAdUnitId(),
      targetingInfo: AdMobFactory.getTargetingInfo(),
      size: AdSize.smartBanner,
    )..load();
  }

  static MobileAdTargetingInfo getTargetingInfo() {
    return MobileAdTargetingInfo(nonPersonalizedAds: Platform.isIOS);
  }
}
