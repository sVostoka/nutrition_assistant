import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/core/colors.dart';
import 'package:nutrition_assistant/pages/calendar/calendar_states.dart';

final calendarState = CalendarStates();

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    calendarState.initMeal();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Календарь"),
          actions: [
            IconButton(
                onPressed: (){
                  calendarState.initMeal();
                },
                icon: const Icon(Icons.restart_alt)
            )
          ],
        ),
        body: Align(
            alignment: Alignment.center,
            child: Observer(
              builder: (_) => CellCalendar(
                todayMarkColor: kGreenColor,
                cellCalendarPageController: calendarState.cellCalendarPageController,
                events: calendarState.shortEvents.toList(),
                daysOfTheWeekBuilder: (dayIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      calendarState.labels[dayIndex],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                monthYearLabelBuilder: (datetime) {
                  calendarState.setYearMonth(datetime!);
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          "${calendarState.month}  ${calendarState.year}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            calendarState.cellCalendarPageController.animateToDate(
                              DateTime.now(),
                              curve: Curves.linear,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
                onCellTapped: (date) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        scrollable: true,
                        title: Text("${date.month.monthName} ${date.day}"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: calendarState.fullEvents.toList().where((element) => element.eventDate == date)
                              .map((event) => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.only(bottom: 12),
                            color: Colors.white,
                            child: Text(
                              event.eventName,
                              style: event.eventTextStyle,
                            ),
                          ),
                          ).toList(),
                        ),
                      ));
                },
              ),
            )
        )
      )
    );
  }
}