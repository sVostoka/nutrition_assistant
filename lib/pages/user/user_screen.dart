import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nutrition_assistant/database/DBProvider.dart';
import 'package:nutrition_assistant/models/target.dart';
import 'package:nutrition_assistant/pages/authorization/welcome_auth_screen.dart';
import 'package:nutrition_assistant/pages/user/user_states.dart';
import 'package:flutter/services.dart';

import 'package:nutrition_assistant/models/user.dart';

final userState = UserStates();

class UserScreen extends StatelessWidget {
  @override
  const UserScreen({Key? key}) : super(key: key);

  UserStates createState() => UserStates();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Личный кабинет"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showDialogChangeTarget(context, userState);
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                showDialogExit(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      FutureBuilder<User>(
                        future: DBProvider.db.getUser(),
                        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
                          if (userSnapshot.hasData) {
                            User user = userSnapshot.data!;
                            userState.initUserWeight(user.weight);
                            return _buildUserDataWidget(user);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      FutureBuilder<Target>(
                        future: DBProvider.db.getTarget(),
                        builder: (BuildContext context, AsyncSnapshot<Target> targetSnapshot) {
                          if (targetSnapshot.hasData) {
                            Target target = targetSnapshot.data!;
                            userState.setTarget(target);
                            return _buildTargetDataWidget(context);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }
}

void showDialogChangeTarget(BuildContext context, UserStates userStates) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Observer(
          builder: (_) => AlertDialog(
            scrollable: true,
            title: const Text('Изменение цели'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Тип цели",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButton(
                  value: userState.targets[userState.indexNewTarget],
                  items: userState.targets.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    userState.changeIndexNewTarget(value!);
                  },
                ),
                const SizedBox(height: 10),
                Visibility(
                    visible: userState.indexNewTarget != 1,
                    child: Column(
                      children: [
                        TextField(
                          controller: userState.newWeightController,
                          decoration: const InputDecoration(
                            hintText: 'Желаемый вес',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            userStates.checkActiveButton(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "${userState.currentSliderValue/ 10} кг/неделя",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Slider(
                            value: userState.currentSliderValue,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value) {
                              userState.changeSliderValue(value);
                            },
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Отмена'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: userStates.activeButtonChange || userStates.indexNewTarget == 1 ? () {
                  DBProvider.db.changeTarget(
                      userState.indexNewTarget,
                      userState.newWeightController.text == ""
                          ? userState.userWeight
                          : int.parse(userState.newWeightController.text),
                      userState.currentSliderValue/ 10
                  ).then((value) => userStates.changeTarget());
                  userStates.checkActiveButton("");
                  userStates.newWeightController.clear();
                  Navigator.of(context).pop();
                } : null,
                child: const Text('Изменить'),
              ),
            ],
          )
      )
  );
}

void showDialogExit(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удаление аккаунта'),
          content: const Text("Вы уверены что хотите удалить аккаунт?"),
          actions: [
            TextButton(
                onPressed: (){
                  DBProvider.db.deleteUser();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context){
                        return const WelcomeAuthScreen();
                      }));
                },
                child: const Text("Да")
            ),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("Нет")
            )
          ],
        );
      }
  );
}

Widget _buildUserDataWidget(User user) {
  userState.getLastPoint();
  return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundImage: AssetImage('assets/images/loginBackground.jpg'),
            ),
            const SizedBox(width: 20),
            Text(
                user.username,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                )
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(
              user.gender == Gender.man ? Icons.man : Icons.woman,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              user.gender == Gender.man ? 'мужчина' : 'женщина',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.straighten,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              '${user.height} см',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        Observer(
          builder: (_) => Row(
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                userState.lastPoint.id == 0 ? '${user.weight} кг'
                    : '${userState.lastPoint.weight} кг',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              '${user.dateOfBirth.day}-${user.dateOfBirth.month}-${user.dateOfBirth.year}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ]
  );
}

Widget _buildTargetDataWidget(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1), // changes position of shadow
          )
        ],
      ),
      child:Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 25),
              _buildProgressWidget(),
              const SizedBox(width: 40),
              Expanded(
                  child: Observer(
                    builder: (_) => Column(
                      children: [
                        Text(userState.target.type == TypeTarget.loseWeight ? "Сброс веса"
                            : userState.target.type == TypeTarget.holdWeight ? "Поддержание веса"
                            : "Набор веса",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Желаемый вес: ${userState.target.targetWeight.toString()}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        if(userState.target.type != TypeTarget.holdWeight)
                          Text(
                            "${userState.target.tempo} кг/неделю",
                            style: const TextStyle(fontSize: 20),
                          ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(55),
                              ),
                              onPressed: (){
                                showDialogControlPoint(context);
                              },
                              child: const Text('Фиксировать')
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ],
      )
  );
}

Widget _buildProgressWidget() {
  return Observer(
      builder: (_) => Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Прогресс",
            style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              value: !userState.progress.isNaN && !userState.progress.isInfinite
                  ? userState.progress > 1
                  ? 0 : userState.progress : 0,
              strokeWidth: 19,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            userState.progressPercentage > 100 ? "0%" : "${userState.progressPercentage}%",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
  );
}







void showDialogControlPoint(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Фиксация веса'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: userState.weightController,
              decoration: const InputDecoration(
                hintText: 'Введите текущий вес',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Изменить'),
            onPressed: () {
              String weight = userState.weightController.text;
              DBProvider.db.newControlPointParams(1, 1, int.parse(weight), DateTime.now());
              userState.getLastPoint();
              userState.weightController.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



