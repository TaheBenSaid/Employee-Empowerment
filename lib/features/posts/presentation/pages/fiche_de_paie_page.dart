import 'package:flutter/material.dart';

class FicheDePaiePage extends StatefulWidget {
  final double salaire;
  final int hoursPerWeek;
  final double sodexo;
  final double taxes;
  final double bonus;
  final DateTime hireDate;
  final DateTime endOfContract;

  const FicheDePaiePage(
      {Key? key,
      required this.salaire,
      required this.sodexo,
      required this.taxes,
      required this.bonus,
      required this.hireDate,
      required this.endOfContract,
      required String status,
      required this.hoursPerWeek})
      : super(key: key);

  @override
  _FicheDePaiePageState createState() => _FicheDePaiePageState();
}

class _FicheDePaiePageState extends State<FicheDePaiePage> {
  String status = 'Full Time';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiche de Paie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailItem('Salaire', '\$${widget.salaire}'),
            _buildDetailItem('Jours/Week', widget.hoursPerWeek.toString()),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Benefits:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildDetailItem('Sodexo', '\$${widget.sodexo}'),
                  _buildDetailItem('Taxes', '\$${widget.taxes}'),
                  _buildDetailItem('Bonus', '\$${widget.bonus}'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            _buildStatusText(),
            const SizedBox(height: 16.0),
            _buildDetailItem('Hire Date', widget.hireDate.toString()),
            _buildDetailItem(
              'End of Contract',
              widget.endOfContract.toString(),
            ),
            const SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ViewContractPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'View Contract',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          value,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  Widget _buildStatusText() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            status,
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

class ViewContractPage extends StatelessWidget {
  const ViewContractPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Contract')),
      body: Center(
        child: Container(
          width: 400.0,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contract',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Text(
                        _getContractContent(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRoundedPopup(context);
        },
        child: Icon(Icons.question_mark),
      ),
    );
  }

  String _getContractContent() {
    return '''
This Employment Agreement (the "Agreement") is made and entered into on [Date], by and between:

[Employer Name] (the "Employer"), with a principal place of business at [Address], and

[Employee Name] (the "Employee"), residing at [Address].

1. Term of Employment:
The Employee's employment with the Employer shall begin on [Start Date] and shall continue until terminated as provided in this Agreement.

2. Position and Duties:
The Employee shall be employed in the position of [Job Title] and shall perform the duties and responsibilities associated with that position as assigned by the Employer.

3. Compensation:
The Employee shall be paid a salary of [Salary Amount] per [Pay Period]. Additional compensation and benefits may be provided as outlined in the Employee Handbook or other applicable policies.

4. Termination:
Either party may terminate this Agreement at any time by providing written notice to the other party. Termination may also occur as a result of other circumstances outlined in the Agreement or applicable laws and regulations.

5. Severability:
If any provision of this Agreement shall be held to be invalid or unenforceable for any reason, the remaining provisions shall continue to be valid and enforceable. If a court finds that any provision of this Agreement is invalid or unenforceable, but that by limiting such provision it would become valid and enforceable, then such provision shall be deemed to be written, construed, and enforced as so limited.

''';
  }

  void _showRoundedPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rounded Popup',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'This is a cool rounded popup!',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
