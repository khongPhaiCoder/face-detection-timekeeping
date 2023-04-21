import 'package:fda_app/data/home/bloc/home_bloc.dart';
import 'package:fda_app/utils/dialog.dart';
import 'package:fda_app/widgets/LoadingScreen.dart';
import 'package:fda_app/widgets/MyDropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: KeyboardDismisser(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Thông tin điểm danh",
            ),
            titleTextStyle: const TextStyle(
              color: Color(0xFFF8F8F8),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.deepOrange,
            shadowColor: Colors.deepOrange,
          ),
          body: Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.all(10.0), // Khoảng cách đệm trong khung chứa
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black), // Đường viền màu xanh dương
                    borderRadius: BorderRadius.circular(5.0), // Bo góc 5 đơn vị
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Chọn tháng và năm:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          width: 10.0), // Khoảng cách giữa nhãn và giá trị
                      Expanded(
                        child: BlocBuilder<HomeBloc, HomeState>(
                            buildWhen: (previous, current) =>
                                previous.textWhen != current.textWhen,
                            builder: ((context, state) {
                              return GestureDetector(
                                onTap: () async {
                                  String text = await DialogUtil()
                                      .showDateSearch(context);
                                  if (text.length > 0) {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(setTimeWhen(text));
                                  }
                                },
                                child: Text(
                                  state.textWhen != null &&
                                          state.textWhen!.length > 0
                                      ? state.textWhen.toString()
                                      : "Nhấn vào để chọn",
                                ),
                              );
                            })),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.statusLoad != current.statusLoad,
                    builder: ((context, state) {
                      if (state.statusLoad ==
                          FormzSubmissionStatus.inProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          Text(
                            "Total Salary: ${state.totalSalary}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: Center(
                            child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.deepOrange),
                              dataRowColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.green),
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Ngày',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Trạng thái',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Số giờ ',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                ...BlocProvider.of<HomeBloc>(context)
                                    .state
                                    .historyList
                                    .map(
                                      (e) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(e.date.toString())),
                                          DataCell(Text(e.absent == 'none'
                                              ? 'Attendance'
                                              : e.absent.toString())),
                                          DataCell(Text(e.time.toString())),
                                        ],
                                      ),
                                    ),
                              ],
                            ),
                          ))
                        ],
                      );
                    })),
              ],
            ),
          ))),
    ));
  }
}
