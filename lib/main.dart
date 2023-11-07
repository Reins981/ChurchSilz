import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'bible_verses.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const ChurchApp());
}

class ChurchApp extends StatelessWidget {
  const ChurchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2), // Duration for the fade-in animation
  );

  String bibleVerseContent = "Loading..."; // Initialize with a loading message
  String bibleVerseId = "";
  String selectedLanguageDefault = "Deutsch"; // You can set the selected language based on user selection
  String welcomeMessageGerman = "Willkommen in der Pfarrkirche Silz \n(Petrus u. Paulus)";
  String welcomeMessageEnglish = "Welcome to our church Pfarrkirche Silz \n(Peter and Paul)";
  String welcomeMessageDefault = "Willkommen in der Pfarrkirche Silz \n(Petrus u. Paulus)";
  List<String> currentVerseIds = [];
  String currentVerseIdComplete = "";
  Map<String, List<String>> bibleVerseContentBackup = {};


  @override
  void initState() {
    super.initState();
    bibleRandomizer(); // Fetch the random Bible verse when the screen loads
    animationController.forward(); // Start the fade-in animation
  }

  Future<dynamic> fetch(String lookupUrl, Map<String, String> headers) async {

    try {
      final url = Uri.parse(lookupUrl);
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final responseObject = responseData['data'];

        return responseObject;


      } else {
        String responseStatusCode = response.statusCode.toString();
        throw Exception("Failed to fetch bible books, Response Code: $responseStatusCode");
      }
    } catch (e) {
      String errorMessage = e.toString();
      throw Exception(errorMessage);

    }
  }

  Future<void> bibleRandomizer() async {

    String bookId;
    if (selectedLanguageDefault == "English") {
      bookId = "55212e3cf5d04d49-01"; // English book ID
    } else if (selectedLanguageDefault == "Deutsch") {
      bookId = "f492a38d0e52db0f-01"; // German book ID
    } else {
      // Handle other languages or provide a default book ID
      bookId = "f492a38d0e52db0f-01";
    }

    if (kDebugMode) {
      print("Fetching '$selectedLanguageDefault' bible verse of the day from book with id: $bookId...");
    }

    int randomizer = getBibleRandomizerId();

    if (randomizer == 0) {
      await fetchRandomBibleVerse(bookId);
    } else {
      await fetchRandomBibleVerseFromDefaultList(bookId);
    }

  }

  Future<void> fetchRandomBibleVerseFromDefaultList(String bookId) async {

    List<dynamic> resultVerseInfo = getRandomBibleVerseInfoFromDefaultList();

      String book = resultVerseInfo[0];
      String chapter = resultVerseInfo[1];
      String verseNumberComplete = resultVerseInfo[2];
      var verseNumbers = resultVerseInfo[3];
      String verseContent = "";

      for (var verseNumber in verseNumbers) {
        String resultVerseId = "$book.$chapter.$verseNumber";
        currentVerseIds.add(resultVerseId);

        Map<String, dynamic>? verse = await fetchVerseByVerseId(
            bookId, resultVerseId);

        if (verse != null) {

            String verseContentPart = verse['content'].trimLeft();
            verseContentPart = verseContentPart.trimRight();
            verseContent += verseContentPart + '\n';
        }
      }
      setState(() {
        verseContent = verseContent.trimRight();
        bibleVerseContent = '"' + verseContent + '"';
        bibleVerseId = "$book.$chapter.$verseNumberComplete";
      });
      bibleVerseContentBackup[selectedLanguageDefault] = [bibleVerseId, bibleVerseContent];
      currentVerseIdComplete = bibleVerseId;
  }

  Future<void> fetchRandomBibleVerse(String bookId) async {

    List<Map<String, dynamic>>? booksArray = await fetchBooksByBookId(bookId);

    if (booksArray != null) {
      List<Map<String, dynamic>> chapters = getChaptersFromARandomBookId(booksArray);
      String resultChapterId = getRandomIdFromResults(chapters);
      if (resultChapterId.isNotEmpty) {
        List<Map<String, dynamic>>? verses = await fetchVersesByChapterId(bookId, resultChapterId);

        if (verses != null) {
          String resultVerseId = getRandomIdFromResults(verses);
          currentVerseIds.add(resultVerseId);
          Map<String, dynamic>? verse = await fetchVerseByVerseId(bookId, resultVerseId);

          if (verse != null) {
            setState(() {
              String verseContent = verse['content'].trimLeft();
              verseContent = verseContent.trimRight();
              bibleVerseContent = '"' + verseContent + '"';
              bibleVerseId = verse['id'];
            });
            bibleVerseContentBackup[selectedLanguageDefault] = [bibleVerseId, bibleVerseContent];
            currentVerseIdComplete = bibleVerseId;
          }
        }
      }
    }
  }

  Future<List<Map<String, dynamic>>?> fetchBooksByBookId(String bookId) async {

    final url = "https://api.scripture.api.bible/v1/bibles/$bookId/books?include-chapters-and-sections=true";
    final headers = {
      'accept': 'application/json',
      'api-key': '974c50115078b14ad08870bb4f492b91',
    };

    try {
      final result = await fetch(url, headers);
      return List<Map<String, dynamic>>.from(result); // Ensure the correct data type;;
    } catch (e) {
      // Handle the exception here
      setState(() {
        bibleVerseContent = "Error: ${e.toString()}";
      });
      return null; // Return null or another appropriate value when an error occurs
    }
  }

  Future<List<Map<String, dynamic>>?> fetchVersesByChapterId(String bookId, String chapterId) async {

    final url = "https://api.scripture.api.bible/v1/bibles/$bookId/chapters/$chapterId/verses";
    final headers = {
      'accept': 'application/json',
      'api-key': '974c50115078b14ad08870bb4f492b91',
    };

    try {
      final result = await fetch(url, headers);
      return List<Map<String, dynamic>>.from(result);
    } catch (e) {
      // Handle the exception here
      setState(() {
        bibleVerseContent = "Error: ${e.toString()}";
      });
      return null; // Return null or another appropriate value when an error occurs
    }
  }

  Future<Map<String, dynamic>?> fetchVerseByVerseId(String bookId, String verseIdId) async {

    final url = "https://api.scripture.api.bible/v1/bibles/$bookId/verses/$verseIdId?content-type="
        "text&include-notes=false&include-titles=false&include-chapter-numbers=false&include-verse-numbers=false&"
        "include-verse-spans=false&use-org-id=false";
    final headers = {
      'accept': 'application/json',
      'api-key': '974c50115078b14ad08870bb4f492b91',
    };

    try {
      final result = await fetch(url, headers);
      return result as Map<String, dynamic>;
    } catch (e) {
      // Handle the exception here
      setState(() {
        bibleVerseContent = "Error: ${e.toString()}";
      });
      return null; // Return null or another appropriate value when an error occurs
    }
  }

  List<dynamic> getRandomBibleVerseInfoFromDefaultList() {

    // Generate a random index within the range of the list's length
    int randomIndex = Random().nextInt(modifiedBibleVerses.length);

    // Get the random entry from the list
    List<dynamic> verseInfo = modifiedBibleVerses[randomIndex];

    return verseInfo;
  }

  int getBibleRandomizerId() {

    List<int> bibleRandomizers = [0,1];

    // Generate a random index within the range of the list's length
    int randomIndex = Random().nextInt(bibleRandomizers.length);

    // Get the random entry from the list
    int randomizer = bibleRandomizers[randomIndex];

    return randomizer;
  }
  
  List<Map<String, dynamic>> getChaptersFromARandomBookId(List<Map<String, dynamic>> books) {

  // Generate a random index within the range of the list's length
    int randomIndex = Random().nextInt(books.length);

  // Get the random dictionary from the list
    Map<String, dynamic> randomDictionary = books[randomIndex];

    return List<Map<String, dynamic>>.from(randomDictionary['chapters']);
  }

  String getRandomIdFromResults(List<Map<String, dynamic>> results) {

    String result = "";
    // Check if the list has at least one element before excluding the first element
    if (results.isNotEmpty) {
      // Create a new list starting from the second element (index 1)
      // Exclude Intros which do not have bible verses
      List<Map<String, dynamic>> newChapters = [];

      results.forEach((element) {
        if (!element['id'].contains("intro")) {
          newChapters.add(element);
        }
      });

      // Generate a random index within the range of the list's length
      int randomIndex = Random().nextInt(newChapters.length);

      // Get the random dictionary from the list
      Map<String, dynamic> randomDictionary = newChapters[randomIndex];

      return randomDictionary['id'];
    }

    return result;
  }

  Future<void> updateLanguageOfCurrentBibleVerse() async {
    String bookId;
    if (selectedLanguageDefault == "English") {
      bookId = "55212e3cf5d04d49-01"; // English book ID
    } else if (selectedLanguageDefault == "Deutsch") {
      bookId = "f492a38d0e52db0f-01"; // German book ID
    } else {
      // Handle other languages or provide a default book ID
      bookId = "f492a38d0e52db0f-01";
    }

    if (currentVerseIds.isNotEmpty) {
      if (bibleVerseContentBackup.containsKey(selectedLanguageDefault)) {
        List<String>? currentContent = bibleVerseContentBackup[selectedLanguageDefault];

        if (currentContent != null) {

          if (kDebugMode) {
            print("Fetching bible verse from cache for language: $selectedLanguageDefault...");
          }

          setState(() {
            bibleVerseContent = currentContent[1];
            bibleVerseId = currentContent[0];
          });
        }
      } else {

        if (kDebugMode) {
          print("Trigger '$selectedLanguageDefault' bible verse update from book with id: $bookId...");
        }

        String verseContent = "";
        for (var verseId in currentVerseIds) {
          Map<String, dynamic>? verse = await fetchVerseByVerseId(
              bookId, verseId);

          if (verse != null) {
            String verseContentPart = verse['content'].trimLeft();
            verseContentPart = verseContentPart.trimRight();
            verseContent += verseContentPart + '\n';
          }
        }

        setState(() {
          verseContent = verseContent.trimRight();
          bibleVerseContent = '"' + verseContent + '"';
          bibleVerseId = currentVerseIdComplete;
        });
        bibleVerseContentBackup[selectedLanguageDefault] =
        [bibleVerseId, bibleVerseContent];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Pfarrkirche_Silz_2015.JPG',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            child: Image.asset(
              'assets/Wappen_at_silz.svg.png', // Replace 'crest.png' with the path to your crest image
              width: 70,
              height: 70, // Adjust the fit as needed
            ),
          ),
          // Language Selection Button
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Row(
              children: [
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 100.0, // Set a specific width for the dropdown
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2B48C),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: const Color(0xFFD2B48C), // Same background color for the dropdown menu
                      ),
                      child: DropdownButton<String>(
                        value: selectedLanguageDefault,
                        items: <String>['English', 'Deutsch'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 16.0, color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLanguageDefault = newValue;
                              welcomeMessageDefault = selectedLanguageDefault == "Deutsch" ? welcomeMessageGerman : welcomeMessageEnglish;
                            });
                            updateLanguageOfCurrentBibleVerse();
                          }
                        },
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                        underline: Container(
                          height: 0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent), // Remove the white background
                          ),
                        ),
                        isExpanded: true,
                        iconSize: 24.0,
                        elevation: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  welcomeMessageDefault,
                  style: const TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0), // Apply a text shadow
                        blurRadius: 3.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeIn,
                  )),
                  child: Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4), // Semi-transparent black overlay
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            bibleVerseContent,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 25.0,
                              color: Colors.white, // Text color on the dark overlay
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            bibleVerseId,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white, // Text color on the dark overlay
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Main Dashboard
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainDashboardScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD2B48C), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 4,
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text(
                    'ENTER',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose(); // Clean up the animation controller
    super.dispose();
  }
}
