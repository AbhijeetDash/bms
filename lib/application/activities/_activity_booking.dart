import 'package:bms/application/activities/activities.dart';
import 'package:bms/application/models/_model_booking.dart';
import 'package:bms/application/services/_service_booking.dart';
import 'package:flutter/material.dart';

import '../models/_model_amenity.dart';

class ActivityBooking extends StatefulWidget {
  final Amenity amenity;
  final BookingService service;
  const ActivityBooking({
    super.key,
    required this.amenity,
    required this.service,
  });

  @override
  State<ActivityBooking> createState() => _ActivityBookingState();
}

class _ActivityBookingState extends State<ActivityBooking> {
  DateTime? selectedDate;
  TimeOfDay? selectedFromTime, selectedToTime;

  Future<void> _selectHour(BuildContext context, bool isFrom) async {
    final TimeOfDay picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text('Select Hour'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 24,
                  itemBuilder: (BuildContext context, int index) {
                    final hour = index;
                    return ListTile(
                      title: Text('$hour:00'),
                      onTap: () {
                        Navigator.of(context)
                            .pop(TimeOfDay(hour: hour, minute: 0));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (isFrom && picked != selectedFromTime) {
      setState(() {
        selectedFromTime = picked;
      });
    } else if (picked != selectedToTime) {
      setState(() {
        selectedToTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.amenity.amenity,
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const Text(
                            "Book your prefered amenities here.",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Date of Booking",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 30.0,
                          ),
                          Text(
                            selectedDate != null
                                ? '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}'
                                : 'Select a date',
                            style: const TextStyle(fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Select Time of Booking",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 30.0,
                        ),
                        InkWell(
                          onTap: () {
                            _selectHour(context, true);
                          },
                          child: Row(
                            children: [
                              const Text(
                                "FROM",
                                style: TextStyle(fontSize: 26),
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                selectedFromTime != null
                                    ? '${selectedFromTime?.hour}:${selectedFromTime?.minute.toString().padLeft(2, '0')}'
                                    : 'TIME',
                                style: const TextStyle(fontSize: 26),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _selectHour(context, false);
                          },
                          child: Row(
                            children: [
                              const Text(
                                "TO",
                                style: TextStyle(fontSize: 26),
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                selectedToTime != null
                                    ? '${selectedToTime?.hour}:${selectedToTime?.minute.toString().padLeft(2, '0')}'
                                    : 'TIME',
                                style: const TextStyle(fontSize: 26),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      if (selectedDate != null && selectedFromTime != null) {
                        DateTime from = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedFromTime!.hour,
                            selectedFromTime!.minute);
                        DateTime to = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedToTime!.hour,
                            selectedToTime!.minute);
                        double finalCost = 0;
                        if (widget.amenity.costType == CostType.hourBased) {
                          finalCost =
                              (selectedToTime!.hour - selectedFromTime!.hour) *
                                  widget.amenity.cost;
                        } else {
                          finalCost = widget.amenity.cost;
                        }
                        final Booking booking = Booking(
                          from,
                          to,
                          widget.amenity.amenity,
                          finalCost,
                        );
                        bool res = widget.service.saveBooking(booking);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActivityConfirm(
                              isSuccess: res,
                              booking: booking,
                            ),
                          ),
                        );
                      }
                    },
                    fillColor: Colors.blue,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: Text(
                        "OKAY",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
