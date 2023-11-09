import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nutrition_assistant/models/target.dart';

import 'package:nutrition_assistant/pages/progress/progress_states.dart';

final progressState = ProgressState();

class Progress extends StatelessWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    progressState.initControlPoint();
    progressState.getTargetUser();
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Прогресс"),
            actions: [
              IconButton(
                  onPressed: (){
                    progressState.initControlPoint();
                    progressState.getTargetUser();
                  },
                  icon: const Icon(Icons.restart_alt)
              )
            ],
          ),
          body: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                      bottom: 20
                    ),
                  child: _buildSegmentedButton(),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5,
                          top: 10,
                          right: 5,
                          bottom: 40
                      ),
                      child: Observer(
                        builder: (_){
                          if(progressState.flSpots.isNotEmpty){
                            return LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey,
                                      strokeWidth: 1,
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey,
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                    show: true,
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            interval: 1,
                                            getTitlesWidget: bottomTitleWidgets
                                        )
                                    )
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(color: Colors.grey),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                      spots: progressState.flSpots.toList(),
                                      barWidth: 4,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(
                                        show: true,
                                      ),
                                      color: _color()
                                  ),
                                ],
                              ),
                              swapAnimationDuration: const Duration(seconds: 1),
                              swapAnimationCurve: Curves.easeInOut,
                            );
                          }else{
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "В данный момент у вас нет контрольных точек для отслеживания",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Добавить их вы можете в личном кабинете пользователя",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  )
                                ],
                            );
                          }
                        }
                      )
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}

Color _color(){
  TypeTarget target = progressState.targetUser.type;
  switch(target){
    case TypeTarget.loseWeight:
      if(progressState.progress! < 0){
        return Colors.red;
      }else if(progressState.progress! == 0){
        return Colors.orange;
      }else{
        return Colors.green;
      }
    case TypeTarget.holdWeight:
      if(progressState.progress! < 0){
        return Colors.orange;
      }else if(progressState.progress! == 0){
        return Colors.green;
      }else{
        return Colors.orange;
      }
    case TypeTarget.gainWeight:
      if(progressState.progress! < 0){
        return Colors.green;
      }else if(progressState.progress! == 0){
        return Colors.orange;
      }else{
        return Colors.red;
      }
    default:
      return Colors.green;
  }

  return Colors.green;
}

Widget _buildSegmentedButton(){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          child: Observer(
            builder: (_) => SegmentedButton<MyCalendar>(
              segments: const <ButtonSegment<MyCalendar>>[
                ButtonSegment<MyCalendar>(
                    value: MyCalendar.week,
                    label: Text('Неделя'),
                    icon: Icon(Icons.calendar_view_week)),
                ButtonSegment<MyCalendar>(
                    value: MyCalendar.month,
                    label: Text('Месяц'),
                    icon: Icon(Icons.calendar_view_month)),
                ButtonSegment<MyCalendar>(
                    value: MyCalendar.year,
                    label: Text('Год'),
                    icon: Icon(Icons.calendar_today)),
              ],
              selected: <MyCalendar>{ progressState.calendarView},
              onSelectionChanged: (Set<MyCalendar> newSelection) {
                progressState.changeCalendarView(newSelection);
                progressState.fillByType();
              },
            ),
          )
        ),
      ]
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  String text;
  if (progressState.calendarView == MyCalendar.week) {
    switch (value.toInt()) {
      case 0:
        text = 'Понедельник';
        break;
      case 1:
        text = 'Вторник';
        break;
      case 2:
        text = 'Среда';
        break;
      case 3:
        text = 'Четверг';
        break;
      case 4:
        text = 'Пятница';
        break;
      case 5:
        text = 'Суббота';
        break;
      case 6:
        text = 'Воскресенье';
        break;
      default:
        return Container();
    }
  } else if(progressState.calendarView == MyCalendar.month) {
    text = value.toInt().toString();
  } else if (progressState.calendarView == MyCalendar.year) {
    switch (value.toInt()) {
      case 0:
        text = 'янв';
        break;
      case 1:
        text = 'февр';
        break;
      case 2:
        text = 'март';
        break;
      case 3:
        text = 'апр';
        break;
      case 4:
        text = 'май';
        break;
      case 5:
        text = 'июнь';
        break;
      case 6:
        text = 'июль';
        break;
      case 7:
        text = 'авг';
        break;
      case 8:
        text = 'сент';
        break;
      case 9:
        text = 'окт';
        break;
      case 10:
        text = 'нояб';
        break;
      case 11:
        text = 'дек';
        break;
      default:
        return Container();
    }
  } else {text = "error";}
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(
          leadingDistribution: TextLeadingDistribution.proportional,
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
}



