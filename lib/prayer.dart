import 'package:flutter/material.dart';
import 'text_contents.dart';
import 'mail_settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({Key? key, required this.selectedLanguage}) : super(key: key);

  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {

    final String prayerMessageHeader = selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerMessageHeader"): getTextContentEnglish("prayerMessageHeader");
    final String prayerMessageHeadline = selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerMessageHeadline"): getTextContentEnglish("prayerMessageHeadline");
    final String prayerInfoMessage = selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerInfoMessage"): getTextContentEnglish("prayerInfoMessage");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(prayerMessageHeader),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              prayerMessageHeadline,
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
              child: Image.asset(
                'assets/prayer.jpg', // Replace with your image asset
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              prayerInfoMessage,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            PrayerForm(selectedLanguage: selectedLanguage,),
          ],
        ),
      ),
    );
  }
}

class PrayerForm extends StatefulWidget {
  const PrayerForm({super.key, required this.selectedLanguage});

  final String selectedLanguage;

  @override
  _PrayerFormState createState() => _PrayerFormState();
}

class _PrayerFormState extends State<PrayerForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _prayerRequestController = TextEditingController();
  String selectedLanguageDropdown = "Deutsch";

  Future<void> _sendPrayerRequest(
      String firstName,
      String lastName,
      String emailAddress,
      String selectedLanguage,
      String prayerRequest,
      ) async {
    final String prayerRequestSuccess = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerRequestSuccess"): getTextContentEnglish("prayerRequestSuccess");
    final String prayerRequestError = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerRequestError"): getTextContentEnglish("prayerRequestError");
    // Replace "YOUR_API_KEY" with your actual SendGrid API key
    final sendgrid = Mailer(mailPassword);

    final String name = "$firstName $lastName";
    final fromAddress = Address(mailDefaultSender, name);
    const toAddress = Address(mailRecipient, 'Pfarrkirche Silz');
    final htmlContent = Content('text/html', '''
      <html>
        <body style="font-family: 'Arial', sans-serif; padding: 20px;">
          <h2 style="color: #333;">Details</h2>
          <p><strong>Name:</strong> $firstName $lastName</p>
          <p><strong>Email:</strong> $emailAddress</p>
          <p><strong>Bevorzugte Sprache:</strong> $selectedLanguage</p>
          <p><strong>Gebetsanliegen:</strong><br> $prayerRequest</p>
          <p style="color: #888; font-size: 12px;">Diese Gebetsanfrage wurde gesendet mit der Pfarrkirche Silz app.</p>
        </body>
      </html>
    ''');

    final subject = 'Neue Gebets Anfrage von $firstName';
    const personalization = Personalization([toAddress]);

    final email = Email([personalization], fromAddress, subject, content: [htmlContent]);

    try {
      await sendgrid.send(email).then((result) {
        _showDialog(prayerRequestSuccess, messageType: 'Info');
      }).catchError((e) {
        _showDialog("$prayerRequestError$e");
      });
    } catch (e) {
      _showDialog("$prayerRequestError$e");
    }
  }

  bool _validateForm() {
    if (_firstNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _prayerRequestController.text.isEmpty) {
      // Show an error message or handle the validation as needed
      return false;
    }
    return true;
  }

  void _showDialog(String message, {String messageType = "Error"}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(messageType, style: GoogleFonts.lato(letterSpacing: 1.0)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD2B48C),
                backgroundColor: Colors.grey[200], // Set the text color
              ),
              child: Text('OK', style: GoogleFonts.lato(letterSpacing: 1.0)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final String prayerPreferredLanguage = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerPreferredLanguage"): getTextContentEnglish("prayerPreferredLanguage");
    final String prayerFirstName = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerFirstName"): getTextContentEnglish("prayerFirstName");
    final String prayerLastName = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerLastName"): getTextContentEnglish("prayerLastName");
    final String prayerEmail = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerEmail"): getTextContentEnglish("prayerEmail");
    final String prayerSendText = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerSendText"): getTextContentEnglish("prayerSendText");
    final String prayerSendError = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerSendError"): getTextContentEnglish("prayerSendError");

    List<String> languages = ["Deutsch", "English"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(prayerFirstName, _firstNameController),
        const SizedBox(height: 4),
        _buildTextField(prayerLastName, _lastNameController),
        const SizedBox(height: 4),
        _buildTextField(prayerEmail, _emailController,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        _buildDropdown(prayerPreferredLanguage, languages),
        const SizedBox(height: 16),
        PrayerTextField(
            controller: _prayerRequestController,
            maxCharacters: 500,
            selectedLanguage: widget.selectedLanguage,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {

            String firstName = _firstNameController.text;
            String lastName = _lastNameController.text;
            String email = _emailController.text;
            String prayerRequest = _prayerRequestController.text;

            if (_validateForm()) {
              // Add logic to handle the prayer request submission
              _sendPrayerRequest(firstName, lastName, email, selectedLanguageDropdown, prayerRequest);
            } else {
              _showDialog(prayerSendError);
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFD2B48C),
          ),
          child: Text(prayerSendText, style: GoogleFonts.lato(letterSpacing: 1.0)),
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      cursorColor: const Color(0xFFD2B48C),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.lato(color: Color(0xFFD2B48C), letterSpacing: 1.0), // Set label text color
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD2B48C)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD2B48C)),
        ),
        // You can also set other border-related properties if needed
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdown(String labelText, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD2B48C)),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedLanguageDropdown,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedLanguageDropdown = newValue;
            });
          }
        },
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: GoogleFonts.lato(color: const Color(0xFFD2B48C), letterSpacing: 1.0)),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.lato(color: const Color(0xFFD2B48C), letterSpacing: 1.0),
          border: InputBorder.none,
        ),
      ),
    );
  }


}

class PrayerTextField extends StatefulWidget {
  final TextEditingController controller;
  final int maxCharacters;
  final String selectedLanguage;

  const PrayerTextField({
    required this.controller,
    required this.maxCharacters,
    required this.selectedLanguage,
  });

  @override
  _PrayerTextFieldState createState() => _PrayerTextFieldState();
}

class _PrayerTextFieldState extends State<PrayerTextField> {
  late int _currentLength;

  @override
  void initState() {
    super.initState();
    _currentLength = widget.controller.text.length;
    widget.controller.addListener(_updateLength);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateLength);
    super.dispose();
  }

  void _updateLength() {
    setState(() {
      _currentLength = widget.controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {

    final String prayerDetailsPart1 = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerDetailsPart1"): getTextContentEnglish("prayerDetailsPart1");
    final String prayerDetailsPart2 = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerDetailsPart2"): getTextContentEnglish("prayerDetailsPart2");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFD2B48C)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFD2B48C)),
              ),
              labelStyle: GoogleFonts.lato(color: Color(0xFFD2B48C), letterSpacing: 1.0),
            ),
          ),
          child: TextField(
            controller: widget.controller,
            cursorColor: const Color(0xFFD2B48C),
            decoration: InputDecoration(
              labelText: prayerDetailsPart1 + widget.maxCharacters.toString() + prayerDetailsPart2,
              counterText: '$_currentLength/${widget.maxCharacters}',
              counterStyle: GoogleFonts.lato(color: Color(0xFFD2B48C), letterSpacing: 1.0),
            ),
            maxLength: widget.maxCharacters,
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}




