import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/constants/temporary_values.dart';
import 'package:gitodo/core/extensions/datetime.dart';
import 'package:gitodo/core/extensions/int.dart';
import 'package:gitodo/core/extensions/map.dart';
import 'package:gitodo/screen/home_page/monthly_view_bloc/home_page.dart';
import 'package:gitodo/services/checklist_service.dart';
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
              if (isWebView) ...[
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: Attributes.borderRadiusAll30,
                    border: Attributes.borderAll3,
                    color: ColorStyles.whiteTransparent,
                  ),
                  width: 400,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Checklist(),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BlocBuilder<HomePageBloc, HomePageState>(
                              builder: (context, state) {
                                return IconButton(
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext _) {
                                        return AddTaskDialog(
                                            initialDate: state.selectedDate,
                                            addTask: (DateTime pickedDate,
                                                String task) {
                                              BlocProvider.of<HomePageBloc>(
                                                      context)
                                                  .add(AddTaskEvent(
                                                      date: pickedDate,
                                                      task: task));
                                            });
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  int month = state.displayMonth;
                                  int year = state.displayYear;
                                  if (state.displayMonth == 1) {
                                    month = 12;
                                    year -= 1;
                                  } else {
                                    month -= 1;
                                  }
                                  BlocProvider.of<HomePageBloc>(context).add(
                                      ChangeDisplayedMonthYear(
                                          month: month, year: year));
                                },
                                icon: const Icon(Icons.arrow_left_rounded),
                              ),
                              Text(
                                DateFormat('MMMM')
                                    .format(DateTime(0, state.displayMonth)),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Monday-Rain',
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  int month = state.displayMonth;
                                  int year = state.displayYear;
                                  if (state.displayMonth == 12) {
                                    month = 1;
                                    year += 1;
                                  } else {
                                    month += 1;
                                  }
                                  BlocProvider.of<HomePageBloc>(context).add(
                                      ChangeDisplayedMonthYear(
                                          month: month, year: year));
                                },
                                icon: const Icon(Icons.arrow_right_rounded),
                              ),
                            ],
                          ),
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
                                      final int? date = getDatePerCell(
                                          day: day.key,
                                          displayedYear: state.displayYear,
                                          displayedMonth: state.displayMonth);
                                      return Expanded(
                                        child: InkWell(
                                          onTap: date != null
                                              ? isWebView
                                                  ? () {
                                                      BlocProvider.of<
                                                                  HomePageBloc>(
                                                              context)
                                                          .add(
                                                              ChangeSelectedDateEvent(
                                                                  date: date));
                                                    }
                                                  : () {
                                                      BlocProvider.of<
                                                                  HomePageBloc>(
                                                              context)
                                                          .add(
                                                              ChangeSelectedDateEvent(
                                                                  date: date));
                                                      showDialog(
                                                        barrierDismissible:
                                                            true,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            insetPadding:
                                                                EdgeInsets.all(
                                                                    50),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(15),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const Expanded(
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      child:
                                                                          Checklist(),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        BlocBuilder<
                                                                            HomePageBloc,
                                                                            HomePageState>(
                                                                          builder:
                                                                              (context, state) {
                                                                            return IconButton(
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                  barrierDismissible: false,
                                                                                  context: context,
                                                                                  builder: (BuildContext _) {
                                                                                    return AddTaskDialog(
                                                                                        initialDate: state.selectedDate,
                                                                                        addTask: (DateTime pickedDate, String task) {
                                                                                          BlocProvider.of<HomePageBloc>(context).add(AddTaskEvent(date: pickedDate, task: task));
                                                                                        });
                                                                                  },
                                                                                );
                                                                              },
                                                                              icon: const Icon(Icons.add),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                          // return Container(
                                                          //     margin: EdgeInsets
                                                          //         .all(50),
                                                          //     child:
                                                          //         Checklist());
                                                        },
                                                      );
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
                                            child: displayPerDate(
                                                date: date,
                                                displayedMonth:
                                                    state.displayMonth,
                                                displayedYear:
                                                    state.displayYear,
                                                selectedDate:
                                                    state.selectedDate),
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
    );
  }

  int? getDatePerCell({
    required int day,
    required int displayedYear,
    required int displayedMonth,
  }) {
    int? cellDate;
    if (tempDate > DateTime(displayedYear, displayedMonth).lastDayOfMonth) {
      cellDate = null;
    } else if (DateTime(displayedYear, displayedMonth, tempDate).weekday ==
        day) {
      cellDate = tempDate;
      tempDate++;
    }
    return cellDate;
  }

  displayPerDate(
      {required int? date,
      required int displayedMonth,
      required int displayedYear,
      required DateTime selectedDate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 35,
          decoration: BoxDecoration(
            color: date != null &&
                    DateTime(displayedYear, displayedMonth, date) ==
                        selectedDate
                ? Colors.orange
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (date ?? "").toString(),
              style: TextStyle(fontFamily: "Monday-Rain", color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    super.key,
    required this.initialDate,
    required this.addTask,
  });

  final DateTime initialDate;
  final Function(DateTime pickedDate, String task) addTask;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  DateTime? pickedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        pickedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate = widget.initialDate;
  }

  TextEditingController taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _selectDate(context),
            child: Text(
              DateFormat("yyyy-MM-dd").format(pickedDate!),
            ),
          ),
          TextField(
            onChanged: (String value) {
              setState(() {});
            },
            controller: taskNameController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "Task",
              counterText: "",
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: taskNameController.text != ""
              ? () {
                  widget.addTask(pickedDate!, taskNameController.text);
                  Navigator.pop(context);
                }
              : null,
          child: Text('ADD'),
        ),
      ],
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
            SelectedDateTitle(state: state),
            for (var task in state.checklist)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: task.isDone,
                    onChanged: task.isDone
                        ? null
                        : (value) {
                            BlocProvider.of<HomePageBloc>(context)
                                .add(MarkAsDoneEvent(id: task.id));
                          },
                  ),
                  Expanded(
                    child: Text(
                      task.task,
                      maxLines: 10,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null,
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
    required this.state,
  });

  final HomePageState state;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        state.selectedDate.isSameDate(DateTime.now())
            ? "Today"
            : DateFormat("MMM d yyyy").format(state.selectedDate),
        style: const TextStyle(
          fontFamily: 'Monday-Rain',
          fontSize: 24,
        ),
      ),
    );
  }
}
