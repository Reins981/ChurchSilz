import 'package:flutter/material.dart';
import 'package:church_silz/app_footer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_contents.dart';

class DonationPage extends StatefulWidget {

  const DonationPage({super.key, required this.selectedLanguage});

  final String selectedLanguage;

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {

  late List<Item> _data;

  @override
  void initState() {
    super.initState();
    _data = generateItems(1, widget.selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {

    final String donationMessageHeader = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("donationMessageHeader"): getTextContentEnglish("donationMessageHeader");
    final String donationMessageThankYou = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("donationMessageThankYou"): getTextContentEnglish("donationMessageThankYou");
    final String bibleVerseIdDonation = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("bibleVerseIdDonation"): getTextContentEnglish("bibleVerseIdDonation");
    final String bibleVerseContentDonation = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("bibleVerseContentDonation"): getTextContentEnglish("bibleVerseContentDonation");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(donationMessageHeader, style: GoogleFonts.lato(fontSize: 20, letterSpacing: 1.0)),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/background_donation.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          bibleVerseContentDonation,
                          style: GoogleFonts.ebGaramond(
                            //fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: Colors.black,
                            letterSpacing: 0.5
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        bibleVerseIdDonation,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 4.0,
                  child: ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: const EdgeInsets.all(16),
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data[index].isExpanded = isExpanded;
                      });
                    },
                    children: _data.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              item.headerValue,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: const Color(0xFFD2B48C),
                                letterSpacing: 1.5,
                              ),
                            ),
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.expandedValue,
                                style: GoogleFonts.lato(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16,),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        donationMessageThankYou,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.grey[600],
                          letterSpacing: 1.0
                      ),
                    ),
                  ),
                ),
                AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.selectedLanguage,
    this.isExpanded = false,
  }) : headerValue = selectedLanguage == "Deutsch"
        ? getTextContentGerman("donationBankHeader")
        : getTextContentEnglish("donationBankHeader"),
        expandedValue = selectedLanguage == "Deutsch"
            ? getTextContentGerman("donationBankDetails")
            : getTextContentEnglish("donationBankDetails");

  String expandedValue;
  String headerValue;
  String selectedLanguage;
  bool isExpanded;

}

List<Item> generateItems(int numberOfItems, String selectedLanguage) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      selectedLanguage: selectedLanguage
    );
  });
}
