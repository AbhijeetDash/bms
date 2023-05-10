import 'package:bms/application/models/_model_booking.dart';
import 'package:flutter/material.dart';

class ActivityConfirm extends StatefulWidget {
  final bool isSuccess;
  final Booking booking;

  const ActivityConfirm({
    super.key,
    required this.isSuccess,
    required this.booking,
  });

  @override
  State<ActivityConfirm> createState() => _ActivityConfirmState();
}

class _ActivityConfirmState extends State<ActivityConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isSuccess
              ? const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    size: 50,
                  ),
                )
              : const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    size: 50,
                  ),
                ),
          const SizedBox(height: 50.0),
          widget.isSuccess
              ? Text("Booked, ${widget.booking.cost}")
              : Text("Booking Failed"),
          const SizedBox(height: 50.0),
          RawMaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            fillColor: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
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
    ));
  }
}
