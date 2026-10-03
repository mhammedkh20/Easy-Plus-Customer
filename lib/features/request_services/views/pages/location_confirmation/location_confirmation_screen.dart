import 'dart:async';
import 'package:easy_plus_customer/core/utils/app_dialogs.dart';
import 'package:easy_plus_customer/core/utils/app_helpers.dart';
import 'package:easy_plus_customer/core/widgets/loading_widget.dart';
import 'package:easy_plus_customer/core/widgets/my_contianer_shape.dart';
import 'package:easy_plus_customer/core/widgets/my_elevated_button.dart';
import 'package:easy_plus_customer/features/main/views/widgets/main_widget.dart';
import 'package:easy_plus_customer/features/request_services/model/places/response_place_details.dart';
import 'package:easy_plus_customer/features/request_services/views/manager/service_cubit/service_cubit.dart';
import 'package:easy_plus_customer/features/request_services/views/widgets/item_search_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_plus_customer/core/utils/app_colors.dart';
import 'package:easy_plus_customer/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationConfirmationScreen extends StatefulWidget {
  LocationConfirmationScreen({super.key});

  @override
  State<LocationConfirmationScreen> createState() =>
      _LocationConfirmationScreenState();
}

class _LocationConfirmationScreenState
    extends State<LocationConfirmationScreen> {
  var _keyForm = GlobalKey<FormState>();
  late final TextEditingController _detialsLocation;
  late final TextEditingController _addressController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _markers = {};

  LatLng? _currentLatlong;

  final CameraPosition _kGooglePlex = CameraPosition(
    target: currentLatlong ?? const LatLng(24.7251918, 46.8225288),
    zoom: 12,
  );

  @override
  void initState() {
    _detialsLocation = TextEditingController();
    _addressController = TextEditingController();
    if (currentLatlong != null) {
      currentLocation(currentLatlong!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _detialsLocation.dispose();
    _addressController.dispose();
    _markers.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppDialogs.showLocationDetailsDialog(
          context,
          onPressedNo: () {
            Navigator.of(context).pop();
          },
          onPressedYes: () {
            Navigator.of(context).pop();
            Navigator.pop(context);
          },
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.BG_SCAFOLLD,
        appBar: MyAppBar(
          backgroundColor: AppColors.BG_SCAFOLLD,
          title: AppLocalizations.of(context)!.locationConfirmation,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Form(
                  key: _keyForm,
                  child: ItemSearchLocation(controller: _addressController),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 450.h,
                  child: MyContainerShape(
                    borderRadius: 11,
                    child: BlocConsumer<ServiceCubit, ServiceState>(
                      listener: (context, state) async {
                        if (state is PlaceDetailsSuccess) {
                          ResponsePlaceDetails? detils =
                              ServiceCubit.get(context).placeDetails!;
                          if (detils.result != null) {
                            LatLng latLng = LatLng(
                              detils.result!.geometry!.location!.lat!,
                              detils.result!.geometry!.location!.lng!,
                            );
                            _currentLatlong = latLng;
                            BitmapDescriptor icon =
                                await setCustomIcons(context);
                            _markers.clear();
                            _markers.add(
                              Marker(
                                icon: icon,
                                markerId: const MarkerId('10'),
                                position: latLng,
                                infoWindow: InfoWindow(
                                  title: AppLocalizations.of(context)!
                                      .currentLocation,
                                ),
                              ),
                            );
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: latLng,
                                  zoom: 12,
                                ),
                              ),
                            );
                            setState(() {});
                          }
                        }
                      },
                      builder: (context, state) {
                        return Stack(
                          children: [
                            GoogleMap(
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              onTap: (latlng) async {
                                await currentLocation(latlng);
                              },
                              markers: _markers,
                              gestureRecognizers: AppHelpers.getGesture(),
                            ),
                            if (state is PlaceDetailsLoading)
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: AppColors.BLACK.withOpacity(.2),
                                child: Center(
                                  child: LoadingWidget(),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                MyElevatedButton(
                  title: AppLocalizations.of(context)!.locationConfirmation,
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      if (_currentLatlong != null) {
                        Navigator.pop(context, {
                          'lat': _currentLatlong!.latitude,
                          'lng': _currentLatlong!.longitude,
                          'details_location': _addressController.text.trim(),
                        });
                      }
                    }
                  },
                  fontWeight: FontWeight.bold,
                  iconStart: false,
                  iconPath: Icons.arrow_forward,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<BitmapDescriptor> setCustomIcons(BuildContext context) async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(/*devicePixelRatio: 2.0*/),
        'assets/images/ic_location.png');
  }

  Future currentLocation(LatLng latlng) async {
    _currentLatlong = latlng;
    BitmapDescriptor icon = await setCustomIcons(context);

    _markers.clear();
    _markers.add(
      Marker(
        icon: icon,
        markerId: MarkerId('${_markers.length}'),
        position: latlng,
        infoWindow: InfoWindow(
          title: AppLocalizations.of(context)!.currentLocation,
        ),
      ),
    );
    GeoData data = await Geocoder2.getDataFromCoordinates(
      latitude: latlng.latitude,
      longitude: latlng.longitude,
      googleMapApiKey: "AIzaSyBmYbeBrpmYzA1noCpt_xXG6typcMP6PWc",
    );
    _addressController.clear();
    _addressController.text = '${data.country},${data.city},${data.address},';
    setState(() {});
  }
}
