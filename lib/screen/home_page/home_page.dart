import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/constants/temporary_values.dart';
import 'package:gitodo/core/extensions/datetime.dart';
import 'package:gitodo/core/extensions/int.dart';
import 'package:gitodo/core/extensions/map.dart';
import 'package:gitodo/screen/home_page/monthly_view_bloc/home_page.dart';
import 'package:gitodo/services/firebase_auth/checklist_service.dart';
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

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.auth,
  });

  final FirebaseAuth auth;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int tempDate = 1;
  @override
  Widget build(BuildContext context) {
    bool isWebView = MediaQuery.of(context).size.width > 900;
    Map<int, String> arrangeByFirstDay =
        days.arrangeByFirstDay(startOfTheWeek) as Map<int, String>;
    return BlocProvider(
      create: (context) => HomePageBloc()
        ..add(const MonthlyViewComputeForMaxRowsEvent(
          startOfTheWeek: startOfTheWeek,
        ))
        ..add(const ChangeChecklistEvent()),
      child: Column(
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
                if (isWebView) ...[
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: Attributes.borderRadiusAll30,
                      border: Attributes.borderAll3,
                      color: ColorStyles.whiteTransparent,
                    ),
                    width: 400,
                    height: double.infinity,
                    child: const SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Checklist(),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(isWebView ? 15 : 0),
                    decoration: BoxDecoration(
                      borderRadius: Attributes.borderRadiusAll30,
                      border: Attributes.borderAll3,
                      color: ColorStyles.whiteTransparent,
                    ),
                    child: BlocBuilder<HomePageBloc, HomePageState>(
                      builder: (context, state) {
                        tempDate = 1;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                for (var weekDay in arrangeByFirstDay.entries)
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.all(15),
                                    child: Text(
                                      isWebView
                                          ? weekDay.value
                                          : weekDay.value[0],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Monday-Rain',
                                      ),
                                    ),
                                  )),
                              ],
                            ),
                            for (int row = 0;
                                row < state.monthlyViewMaxRows;
                                row++)
                              Expanded(
                                child: Row(
                                  children: [
                                    // for (int day = 1; day <= 7; day++)
                                    for (var (index, day)
                                        in arrangeByFirstDay.entries.indexed)
                                      Builder(builder: (context) {
                                        final int? date =
                                            getDatePerCell(day: day.key);
                                        return Expanded(
                                          child: InkWell(
                                            onTap: date != null
                                                ? () {
                                                    BlocProvider.of<
                                                                HomePageBloc>(
                                                            context)
                                                        .add(
                                                            ChangeSelectedDateEvent(
                                                                date: date));
                                                  }
                                                : null,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: () {
                                                  if (isWebView) {
                                                    return Attributes
                                                        .borderRadiusAll30;
                                                  } else if (row ==
                                                          state.monthlyViewMaxRows -
                                                              1 &&
                                                      index == 0) {
                                                    return Attributes
                                                        .borderRadiusBottomLeft30;
                                                  } else if (row ==
                                                          state.monthlyViewMaxRows -
                                                              1 &&
                                                      index == 6) {
                                                    return Attributes
                                                        .borderRadiusBottomRight30;
                                                  }
                                                  return null;
                                                }(),
                                                border: isWebView
                                                    ? Attributes.borderAll3
                                                    : Attributes.borderAll1,
                                                color: ColorStyles.dateColor,
                                              ),
                                              padding: const EdgeInsets.all(15),
                                              height: double.infinity,
                                              margin: EdgeInsets.all(
                                                  isWebView ? 5 : 0),
                                              child: displayPerDate(date: date),
                                            ),
                                          ),
                                        );
                                      }),
                                  ],
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int? getDatePerCell({required int day}) {
    int? cellDate;
    if (tempDate >
        DateTime(displayedYear, displayedMonth, tempDate).lastDayOfMonth) {
      cellDate = null;
    } else if (DateTime(displayedYear, displayedMonth, tempDate).weekday ==
        day) {
      cellDate = tempDate;
      tempDate++;
    }
    return cellDate;
  }

  displayPerDate({required int? date}) {
    return Text(
      (date ?? "").toString(),
      style: const TextStyle(
        fontFamily: "Monday-Rain",
        color: Colors.white,
      ),
    );
  }
}

class Checklist extends StatelessWidget {
  const Checklist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SelectedDateTitle(),
            for (var task in state.checklist)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: task.isDone,
                    onChanged: null,
                  ),
                  SizedBox(
                    width: 330,
                    child: Text(
                      task.task,
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
        );
      },
    );
  }
}

class SelectedDateTitle extends StatelessWidget {
  const SelectedDateTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topLeft,
          child: Text(
            state.selectedDate.isSameDate(DateTime.now())
                ? "Today"
                : DateFormat("yyyy-MM-dd").format(state.selectedDate),
            style: const TextStyle(
              fontFamily: 'Monday-Rain',
              fontSize: 24,
            ),
          ),
        );
      },
    );
  }
}
