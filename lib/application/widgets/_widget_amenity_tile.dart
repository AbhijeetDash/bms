import 'package:bms/application/models/_model_amenity.dart';
import 'package:bms/application/services/_service_booking.dart';
import 'package:flutter/material.dart';

import '../activities/activities.dart';

class AmenityTile extends StatelessWidget {
  final Amenity amenity;
  final BookingService service;
  const AmenityTile({
    super.key,
    required this.amenity,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ActivityBooking(
                  amenity: amenity,
                  service: service,
                )));
      },
      child: Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(amenity.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black.withOpacity(0.7),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amenity.amenity,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
