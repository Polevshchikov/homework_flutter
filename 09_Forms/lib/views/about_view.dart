import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotels/models/hotel_detail.dart';

import 'components/about_view__textAdress.dart';
import 'components/about_view__textService.dart';

class AboutView extends StatefulWidget {
  static const routeName = '/about';
  final uuidData;

  AboutView({Key key, this.uuidData}) : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  HotelDetail hotelDetail;
  String errorMessage;
  bool hasError = false;
  bool isLoading = false;
  Dio _dio = Dio();
  @override
  void initState() {
    super.initState();
    getDataDio();
  }

  getDataDio() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _dio.get('https://run.mocky.io/v3/${widget.uuidData}');
      hotelDetail = HotelDetail.fromJson(response.data);
    } on DioError catch (e) {
      setState(() {
        errorMessage = e.response.data['message'];
        hasError = true;
      });
    }

    setState(() {
      if (hasError)
        isLoading = false;
      else
        isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hotelDetail == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Column(
          children: [
            if (hasError)
              Column(
                children: [
                  SizedBox(
                    height: 400,
                  ),
                  Center(
                    child: Text(errorMessage),
                  ),
                ],
              ),
            if (hasError == false)
              Column(
                children: [
                  SizedBox(
                    height: 400,
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(hotelDetail.name),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    height: 250,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8),
                items: hotelDetail.photos
                    .map(
                      (photos) => Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/$photos'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textAdressHotel('Страна: ', hotelDetail.address.country),
                    textAdressHotel('Город: ', hotelDetail.address.city),
                    textAdressHotel('Улица: ', hotelDetail.address.street),
                    Row(
                      children: [
                        Text('Рейтинг: '),
                        Text('${hotelDetail.rating}', style: TextStyle(fontWeight: FontWeight.w600)),
                        Icon(
                          Icons.star_border,
                          size: 18.0,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Text(
                        'Сервисы',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textServisHotel('Платные', hotelDetail.services.paid),
                        textServisHotel('Бесплатно', hotelDetail.services.free),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
