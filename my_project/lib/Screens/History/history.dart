import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
            child: Center(
          child: MyStatelessWidget(),
        )),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor:
          MaterialStateProperty.resolveWith((states) => Colors.deepOrange),
      dataRowColor: MaterialStateProperty.resolveWith((states) => Colors.green),
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
              'Vào',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Ra',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('25/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('24/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('23/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('22/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('21/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('20/10/2023')),
            DataCell(Text('Absent')),
            DataCell(Text('Absent')),
          ],
          color: MaterialStatePropertyAll(Colors.yellow),
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('19/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('18/10/2023')),
            DataCell(Text('13:30')),
            DataCell(Text('17:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('18/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('17/10/2023')),
            DataCell(Text('9:00')),
            DataCell(Text('11:30')),
          ],
        ),
      ],
    );
  }
}
