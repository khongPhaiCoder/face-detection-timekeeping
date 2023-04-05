import 'package:fda_app/data/home/bloc/home_bloc.dart';
import 'package:fda_app/widgets/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: ((context, state) {
          if (state.status == FormzSubmissionStatus.inProgress) {
            return LoadingScreen();
          }
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.black87,
              body: Container(
                  child: Center(
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.deepOrange),
                  dataRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Ngày',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Trạng thái',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Số giờ ',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: <DataRow>[
                    ...BlocProvider.of<HomeBloc>(context).state.historyList.map(
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
              )),
            ),
          );
        }));
  }
}
