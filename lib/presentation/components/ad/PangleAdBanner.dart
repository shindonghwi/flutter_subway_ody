// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
//
// import 'AdvertiseHelper.dart';
//
// class PangleAdBanner extends HookWidget {
//   const PangleAdBanner({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isShowing = useState(true);
//
//     useEffect(() {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Future.delayed(const Duration(seconds: 3), () {
//           AdvertiseHelper.initPangleBannerAd(
//             onAdLoaded: () => isShowing.value = true,
//             onAdError: () => isShowing.value = true,
//             onAdDismiss: () => isShowing.value = true,
//             onAdShow: () {},
//             onAdClick: () {},
//           );
//         });
//       });
//       return null;
//     }, []);
//
//     return isShowing.value
//         ? Container(
//             color: const Color(0xFFF5F5F5),
//             alignment: Alignment.bottomCenter,
//             width: double.infinity,
//             height: 50,
//             child: Platform.isAndroid
//                 ? PlatformViewLink(
//                     viewType: AdvertiseHelper.PLUGIN_PANGLE_BANNER,
//                     surfaceFactory: (context, controller) {
//                       return AndroidViewSurface(
//                         controller: controller as AndroidViewController,
//                         gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
//                         hitTestBehavior: PlatformViewHitTestBehavior.opaque,
//                       );
//                     },
//                     onCreatePlatformView: (params) {
//                       return PlatformViewsService.initSurfaceAndroidView(
//                         id: params.id,
//                         viewType: AdvertiseHelper.PLUGIN_PANGLE_BANNER,
//                         layoutDirection: TextDirection.ltr,
//                         // creationParams: creationParams,
//                         creationParamsCodec: const StandardMessageCodec(),
//                         onFocus: () => params.onFocusChanged(true),
//                       )
//                         ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
//                         ..create();
//                     },
//                   )
//                 : const UiKitView(
//                     viewType: AdvertiseHelper.PLUGIN_PANGLE_BANNER,
//                     layoutDirection: TextDirection.ltr,
//                     creationParamsCodec: StandardMessageCodec(),
//                   ),
//           )
//         : const SizedBox();
//   }
// }
