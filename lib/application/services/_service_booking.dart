import 'package:bms/application/models/_model_amenity.dart';
import 'package:bms/application/models/_model_booking.dart';

import '../constants/const_amenities.dart';

abstract class BookingService {
  List<Amenity> getAmenities();

  bool isSlotAvailable(Booking booking);

  bool saveBooking(Booking booking);
}

class BookingServiceImpl extends BookingService {
  List<Booking> bookings = [];

  @override
  List<Amenity> getAmenities() {
    List<Amenity> amenities = [];
    for (var element in data) {
      amenities.add(Amenity.fromJson(element));
    }
    return amenities;
  }

  @override
  bool isSlotAvailable(Booking booking) {
    bool isAvailable = true;
    for (var element in bookings) {
      if (element.amenity == booking.amenity) {
        // If its exactly same.
        if (booking.to.compareTo(element.to) == 0 ||
            booking.from.compareTo(element.from) == 0) {
          isAvailable = false;
          break;
        }

        // Start time is in between some other slot.
        if (booking.from.compareTo(element.from) > 0 &&
            booking.from.compareTo(element.to) < 0) {
          isAvailable = false;
          break;
        }

        // End time is in between some other slot.
        if (booking.to.compareTo(element.from) > 0 &&
            booking.to.compareTo(element.to) < 0) {
          isAvailable = false;
          break;
        }

        // if entire time is between other slots.
        if (booking.from.compareTo(element.from) < 0 &&
            booking.to.compareTo(element.to) > 0) {
          isAvailable = false;
          break;
        }
      }
    }

    return isAvailable;
  }

  @override
  bool saveBooking(Booking booking) {
    if (isSlotAvailable(booking)) {
      bookings.add(booking);
      return true;
    }
    return false;
  }
}
