import 'package:bridella/app_core/services/constants.dart';
import 'package:bridella/users/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeddingCounterChnunk extends StatelessWidget {
  const WeddingCounterChnunk({super.key});

  @override
  Widget build(BuildContext context) {
    final weddingDate =
        Provider.of<BridellaUser>(context, listen: false).weddingDate;
    if (weddingDate != null) {
      int endTime =
          DateFormat('yyyy-MM-dd').parseUtc(weddingDate).millisecondsSinceEpoch;
      return CountdownTimer(
          endTime: endTime,
          widgetBuilder: (_, CurrentRemainingTime? time) {
            if (time == null) {
              return const Text(
                '🤵 Happy Wedding 👰 ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildButton(context,
                    time.days == null ? '0' : time.days.toString(), 'Days'),
                const SizedBox(
                  width: 16,
                ),
                buildButton(context,
                    time.hours == null ? '0' : time.hours.toString(), 'Hours'),
                buildDivider(),
                buildButton(context,
                    time.min == null ? '0' : time.min.toString(), 'Minutes'),
                buildDivider(),
                buildButton(context,
                    time.min == null ? '0' : time.sec.toString(), 'Seconds'),
              ],
            );
          });
    } else {
      return const Text('It looks like your wedding date is missing :(');
    }
  }

  Widget buildDivider() => const SizedBox(
        width: 14,
        child: Text(
          ':',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        // onPressed: () {},
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      );
}
/*
class WeddingCounterChnunk extends StatelessWidget {
  const WeddingCounterChnunk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      width: getProportionateScreenWidth(260),
      child: Column(
        children: [
          Text(
            '100   8 :  40 :  22',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(26),
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Text('Days Hours Minutes Seconds')
        ],
      ),
    );
  }
}
*/