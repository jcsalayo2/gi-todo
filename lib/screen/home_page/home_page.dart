import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/constants/temporary_values.dart';
import 'package:gitodo/core/extensions/datetime.dart';
import 'package:gitodo/core/extensions/int.dart';
import 'package:gitodo/core/extensions/map.dart';
import 'package:gitodo/services/firebase_auth/firebase_auth.dart';
import 'package:gitodo/styles/attributes.dart';
import 'package:gitodo/styles/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('backgrounds/home_bg.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: HomeBody(auth: auth),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({
    super.key,
    required this.auth,
    this.tempDate = 1,
  });

  final FirebaseAuth auth;
  int tempDate;

  @override
  Widget build(BuildContext context) {
    Map<int, String> arrangeByFirstDay =
        days.arrangeByFirstDay(startOfTheWeek) as Map<int, String>;
    tempDate = 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: Attributes.borderRadiusAll30,
                border: Attributes.borderAll3,
                color: ColorStyles.whiteTransparent,
              ),
              height: 50,
              width: 200,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Row(
            children: [
              if (MediaQuery.of(context).size.width > 900) ...[
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: Attributes.borderRadiusAll30,
                    border: Attributes.borderAll3,
                    color: ColorStyles.whiteTransparent,
                  ),
                  width: 400,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            DateFormat("yyyy-MM-dd").format(DateTime.now()),
                            style: TextStyle(
                              fontFamily: 'Monday-Rain',
                              fontSize: 24,
                            ),
                          ),
                        ),
                        for (var i = 0; i < 5; i += 1)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: null,
                              ),
                              SizedBox(
                                width: 330,
                                child: Text(
                                  "Be Amazing.",
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Monday-Rain',
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: Attributes.borderRadiusAll30,
                    border: Attributes.borderAll3,
                    color: ColorStyles.whiteTransparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          for (var day in arrangeByFirstDay.entries)
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                day.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Monday-Rain',
                                ),
                              ),
                            )),
                        ],
                      ),
                      for (int row = 0;
                          row <
                              getMaxRows(
                                  displayedYear: displayedYear,
                                  displayedMonth: displayedMonth,
                                  startOfTheWeek: startOfTheWeek);
                          row++)
                        Expanded(
                          child: Row(
                            children: [
                              // for (int day = 1; day <= 7; day++)
                              for (var day in arrangeByFirstDay.entries)
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          Attributes.borderRadiusAll30,
                                      border: Attributes.borderAll3,
                                      color: ColorStyles.dateColor,
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    height: double.infinity,
                                    margin: EdgeInsets.all(5),
                                    child: displayPerDate(day: day.key),
                                  ),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  displayPerDate({required int day}) {
    String displayDate = '';
    if (tempDate >
        DateTime(displayedYear, displayedMonth, tempDate).lastDayOfMonth) {
      displayDate = '';
    } else if (DateTime(displayedYear, displayedMonth, tempDate).weekday ==
        day) {
      displayDate = tempDate.toString();
      tempDate++;
    }

    if (displayDate == '') return null;

    return Text(
      displayDate,
      style: TextStyle(
        fontFamily: "Monday-Rain",
        color: Colors.white,
      ),
    );
  }

  int getMaxRows(
      {required int displayedYear,
      required int displayedMonth,
      required int startOfTheWeek}) {
    var endOfWeek = startOfTheWeek.lastDayOfWeek;

    final selectedLastDate =
        DateTime(displayedYear, displayedMonth).lastDateOfMonth;

    int maxRows = 0;
    int lastDateOfEndOfWeek = 0;

    for (int i = 1; i <= selectedLastDate.day; i++) {
      if (DateTime(displayedYear, displayedMonth, i).weekday == endOfWeek) {
        maxRows++;
        lastDateOfEndOfWeek = DateTime(displayedYear, displayedMonth, i).day;
      }
    }

    if (lastDateOfEndOfWeek < selectedLastDate.day) {
      maxRows++;
    }

    return maxRows;
  }
}
