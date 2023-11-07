List<String> bibleVerses = [
  "Genesis.1.1",
  "John.3.16",
  "Psalm.23.1",
  "Proverbs.3.5",
  "Romans.8.28",
  "Philippians.4.13",
  "Jeremiah.29.11",
  "Matthew.11.28",
  "1Corinthians.16.14",
  "Proverbs.16.9",
  "Isaiah.41.10",
  "Exodus.20.3",
  "Luke.2.11",
  "Matthew.28.19",
  "Mark.12.30",
  "Galatians.5.22-23",
  "Matthew.6.33",
  "Romans.12.2",
  "1Peter.5.7",
  "Romans.8.31",
  "John.14.6",
  "Ephesians.2.8-9",
  "Psalm.118.24",
  "1John.4.19",
  "1Corinthians.13.4-7",
  "Psalm.46.10",
  "Proverbs.14.30",
  "1Corinthians.10.13",
  "Romans.15.13",
  "Matthew.22.39",
  "John.14.27",
  "Romans.8.38-39",
  "Matthew.5.16",
  "2Timothy.1.7",
  "Romans.8.18",
  "James.1.5",
  "Psalm.118.6",
  "Colossians.3.23",
  "Romans.12.12",
  "1Peter.2.9",
  "John.16.33",
  "Hebrews.11.1",
  "Galatians.2.20",
  "Isaiah.40.31",
  "Matthew.7.7",
  "Psalm.136.26",
  "Romans.15.7",
  "1Peter.1.3",
  "Isaiah.53.5",
  "John.15.13",
  "Ephesians.4.32",
  "2Corinthians.5.17",
  "Psalm.46.1",
  "Isaiah.26.3",
  "Romans.5.8",
  "Philippians.4.6",
  "Romans.10.9",
  "John.10.10",
  "Proverbs.3.6",
  "Romans.8.26",
  "Matthew.11.29",
  "Romans.8.1",
  "Psalm.34.8",
  "Galatians.5.16",
  "1John.1.9",
  "Romans.14.11",
  "1Corinthians.6.19-20",
  "Philippians.4.8",
  "Psalm.37.4",
  "Matthew.6.34",
  "1Corinthians.13.13",
  "Psalm.139.14",
  "John.16.13",
  "Romans.15.4",
  "2Corinthians.4.18",
  "Romans.12.21",
  "Isaiah.41.13",
  "Romans.8.32",
  "John.14.1",
  "Hebrews.13.8",
  "Proverbs.3.1-2",
  "Psalm.119.105",
  "Romans.5.1",
  "1Corinthians.16.13",
  "Matthew.28.20",
  "Romans.12.14",
  "Psalm.118.8",
  "Galatians.5.25",
  "Romans.8.15",
  "Psalm.19.14",
  "Romans.6.23",
  "Isaiah.55.8-9",
  "Romans.10.17",
  "1Peter.5.8",
  "Matthew.10.28",
  "Isaiah.43.2",
  "Romans.3.23",
  "1John.4.16",
  "2Timothy.3.16-17",
  "Proverbs.16.3",
];

List<List<dynamic>> modifiedBibleVerses = bibleVerses.map((verse) {
  var parts = verse.split(".");
  var book = getAbbreviation(parts[0]);
  var chapter = parts[1];
  var verseNumberComplete = parts[2];
  var verseNumbers = verseNumberComplete.split("-");
  return [book, chapter, verseNumberComplete, verseNumbers];
}).toList();

String getAbbreviation(String bookName) {
  // Define a map of book abbreviations
  Map<String, String> bookAbbreviations = {
    "Genesis": "GEN",
    "Exodus": "EXO",
    "Leviticus": "LEV",
    "Numbers": "NUM",
    "Deuteronomy": "DEU",
    "Joshua": "JOS",
    "Judges": "JDG",
    "Ruth": "RUT",
    "1Samuel": "1SA",
    "2Samuel": "2SA",
    "1Kings": "1KI",
    "2Kings": "2KI",
    "1Chronicles": "1CH",
    "2Chronicles": "2CH",
    "Ezra": "EZR",
    "Nehemiah": "NEH",
    "Esther": "EST",
    "Job": "JOB",
    "Psalms": "PSA",
    "Proverbs": "PRO",
    "Ecclesiastes": "ECC",
    "Song of Solomon": "SNG",
    "Isaiah": "ISA",
    "Jeremiah": "JER",
    "Lamentations": "LAM",
    "Ezekiel": "EZK",
    "Daniel": "DAN",
    "Hosea": "HOS",
    "Joel": "JOL",
    "Amos": "AMO",
    "Obadiah": "OBA",
    "Jonah": "JON",
    "Micah": "MIC",
    "Nahum": "NAM",
    "Habakkuk": "HAB",
    "Zephaniah": "ZEP",
    "Haggai": "HAG",
    "Zechariah": "ZEC",
    "Malachi": "MAL",
    "Matthew": "MAT",
    "Mark": "MRK",
    "Luke": "LUK",
    "John": "JHN",
    "Acts": "ACT",
    "Romans": "ROM",
    "1Corinthians": "1CO",
    "2Corinthians": "2CO",
    "Galatians": "GAL",
    "Ephesians": "EPH",
    "Philippians": "PHP",
    "Colossians": "COL",
    "1Thessalonians": "1TH",
    "2Thessalonians": "2TH",
    "1Timothy": "1TI",
    "2Timothy": "2TI",
    "Titus": "TIT",
    "Philemon": "PHM",
    "Hebrews": "HEB",
    "James": "JAS",
    "1Peter": "1PE",
    "2Peter": "2PE",
    "1John": "1JN",
    "2John": "2JN",
    "3John": "3JN",
    "Jude": "JUD",
    "Revelation": "REV",
  };

  // Look up the book abbreviation in the map, or use the original book name if not found
  return bookAbbreviations[bookName] ?? bookName;
}