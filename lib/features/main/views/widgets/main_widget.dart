// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/features/main/model/last_seen_drivers.dart';
import 'package:easy_plus_customer/features/main/views/manager/main_cubit/main_cubit.dart';
import 'package:easy_plus_customer/features/main/views/widgets/icon_app_bar.dart';
import 'package:easy_plus_customer/features/side_bar/views/pages/my_request_screens/my_request_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:easy_plus_customer/features/main/views/widgets/my_icons_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.7251918, 46.8225288),
    zoom: 8,
  );

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

LatLng? currentLatlong;

class _MainWidgetState extends State<MainWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> _markers = {};

  @override
  void initState() {
    // _getCurrentLocation();
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        backgroundColor: AppColors.TRANSPARENT,
        leadingWidth: 60.r,
        leading: IconAppBar(
          icon: const Icon(Icons.menu),
          onTap: () {
            MainCubit.get(context).drawerController.open();
            // MainCubit.get(context).zoomDrawerController.toggle!.call();
          },
        ),
        actions: [
          IconAppBar(
            icon: Image.asset('assets/images/ic_orders.png', width: 24.r),
            onTap: () {
              AppHelpers.navigationToPage(context, MyRequestScreen());
            },
          ),
          SizedBox(width: 16.w),
          IconAppBar(
            icon: const Icon(Icons.gps_fixed),
            onTap: () {
              getCurrentPosition();
            },
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<MainCubit, MainState>(
            listener: (context, state) async {
              if (state is GetLastSeenDriversSuccess) {
                log('getDataDrivires');
                LastSeenDrivers? lastSeenDrivers = MainCubit.get(
                  context,
                ).lastSeenDrivers;
                if (lastSeenDrivers != null) {
                  for (int i = 0; i < lastSeenDrivers.data!.length; i++) {
                    if (lastSeenDrivers.data![i].lat != null &&
                        lastSeenDrivers.data![i].lng != null) {
                      log(
                        '${lastSeenDrivers.data![i].lat!} ${lastSeenDrivers.data![i].lng!}',
                      );
                      await addLocation(
                        latLng: LatLng(
                          double.parse(lastSeenDrivers.data![i].lat!),
                          double.parse(lastSeenDrivers.data![i].lng!),
                        ),
                        namePerson: lastSeenDrivers.data![i].name ?? "",
                        icon2: 'assets/images/pin.png',
                        markId: "${(i + 1)}",
                      );
                    }
                  }
                }
              }
              if (state is GetLastSeenDriversFailed) {
                log('asdfasdfasdfasdfafsd');
              }
            },
            builder: (context, state) {
              return GoogleMap(
                layoutDirection: TextDirection.rtl,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                rotateGesturesEnabled: true,
                initialCameraPosition: MainWidget._kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
                gestureRecognizers: AppHelpers.getGesture(),
              );
            },
          ),
          const MyIconsMainWidget(),
        ],
      ),
    );
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Navigator.of(context).pop();
      AppDialogs.enabledLocation(context);

      AppHelpers.showSnackBar(
        context,
        message: AppLocalizations.of(context)!.descLocation,
      );

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Navigator.of(context).pop();
      await AppDialogs.enabledLocation(context);

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await AppDialogs.enabledLocation(context);
        Navigator.of(context).pop();
        AppHelpers.showSnackBar(
          context,
          message: AppLocalizations.of(context)!.locationPermissionsDenied,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await AppDialogs.enabledLocation(context);
      Navigator.of(context).pop();

      AppHelpers.showSnackBar(
        context,
        message: AppLocalizations.of(context)!.alwasDenid,
      );
      return false;
    }

    return true;
  }

  Future<void> getCurrentPosition() async {
    await Permission.location.request();

    Future.delayed(Duration(microseconds: 10), () {
      AppDialogs.showLoadingMapDialog(context);
    });

    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
          Navigator.of(context).pop();

          if (currentLatlong == null) {
            currentLatlong = LatLng(position.latitude, position.longitude);

            await addLocation();
            setState(() {});
          }

          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLatlong!, zoom: 13),
            ),
          );
        })
        .catchError((e) {
          debugPrint(e);
          Navigator.of(context).pop();
        });
  }

  Future<BitmapDescriptor> setCustomIcons(
    BuildContext context, {
    String? icon,
  }) async {
    final Uint8List markerIcon = await getBytesFromAsset(
      icon ?? 'assets/images/ic_location.png',
      100,
    );

    return BitmapDescriptor.fromBytes(markerIcon);

    // BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(size: Size(24.r, 24.r)),
    // );
  }

  Future addLocation({
    String? icon2,
    String? markId,
    String? namePerson,
    LatLng? latLng,
  }) async {
    BitmapDescriptor icon = await setCustomIcons(context, icon: icon2);
    _markers.add(
      Marker(
        icon: icon,
        markerId: MarkerId(markId ?? 'markMyLocation'),
        position: latLng ?? currentLatlong!,
        infoWindow: InfoWindow(
          title: namePerson ?? AppLocalizations.of(context)!.currentLocation,
        ),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }
}
