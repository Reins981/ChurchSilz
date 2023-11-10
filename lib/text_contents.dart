

String getTextContentGerman(String textContentType) {

  Map<String, String> textContents = {
    "welcomeMessage": "Willkommen in der Pfarrkirche Silz \n(Petrus u. Paulus)",
    "dashboardMessageHeader": "Hauptmenü",
    "interactiveMapMessage": "Interaktive Karte",
    "virtualChurchDashboard": "Virtuelle Kirche",
    "churchHistoryDashboard": "Geschichte",
    "churchHistoryMessageHeader": "Kirchen Geschichte",
    "churchHistoryMessageTitle": "Pfarrkirche Silz zu Peter und Paulus",
    "churchHistoryMessage": "Die den Aposteln Petrus und Paulus geweihte Pfarrkirche von Silz wurde in den Jahren 1846 "
        "bis 1848 an Stelle eines älteren Baus unter der Leitung des Baumeisters Benedikt Perwög erbaut. "
        "Ursprünglich hätte der vom Architekten Alois Haas für 1400 Personen ausgelegte Bau noch um einiges "
        "größer werden sollen, als er dann tatsächlich zur Ausführung gelangte, aber für dieses Projekt konnte "
        "von der Regierung keine Genehmigung erlangt werden. Obwohl sich die überarbeiteten Haas´schen Pläne "
        "in technischer Beziehung als zweckmäßig und ausführbar erwiesen, hatten die Initiatoren des Kirchenneubaus, "
        "allen voran Pfarrer Peter Span, in der eigenen Gemeinde mit großem Widerständen zu kämpfen. "
        "Es kam dabei immer wieder zu unschönen Auseinandersetzungen zwischen Befürwortern und Gegnern "
        "des Kirchenneubaus, die in zahlreichen Beschwerdeschriften an das Gubernium gipfelten. "
        "Die Regierung setzte diesem Streit schließlich mit dem Dekret vom 26. September 1845 ein abruptes Ende, "
        "indem sie die Anordnung traf, den Bau sogleich, ohne die weiteren Einwendungen der opponierenden Parteien "
        "zu beachten, auszuführen. Noch am Tag, als dieses Dekret ausgefertigt wurde, wurde mit dem Abriss der "
        "alten Totenkapelle begonnen. Nach dem Abbruch der alten Kirche konnte endlich mit dem Neubau begonnen werden. "
        "Schon ein halbes Jahr nach der Grundsteinlegung am 2. Juli 1846 war der Rohbau des neuen Gotteshauses "
        "erstellt und der Turm bis zur Höhe des Kirchendachs aufgeführt. Zu Allerheiligen 1847 war dann auch der "
        "Innenausbau so weit fortgeschritten, dass die Pfarrgemeinde in die Kirche einziehen konnte. "
        "Am 14. November 1847 wurde sie vom Abt des Stiftes Stams geweiht. ",
    "actualNewsDashboard": "Aktuelles",
    "donationDashboard": "Spenden",
    "virtualChurchMessageHeader": "Virtuelle Kirche",
    "virtualChurchTourMessage": "Virtuelle Kirchen Tour",
    "churchHighlightTitle_1": "Hochaltar",
    "churchHighlightDescription_1": "Als Hochaltar bezeichnet man den erhöhten Hauptaltar in oder vor der Apsis einer katholischen Kirche. Er steht, vom Hauptschiff der Kirche aus gesehen, meist stirnseitig in der Apsis, in alten Grabeskirchen wie dem Petersdom auch zentral über der Memoria. "
        "Ursprünglich unterscheidet der Begriff den Hauptaltar einer Kirche von den Nebenaltären bzw. Seitenaltären, die bereits ab der Herrschaft des römischen Kaisers Konstantin I. in größeren Kirchen zusätzlich zum Hochaltar errichtet wurden und die sich in den Seitenapsiden, den Kapellenkränzen, an den Wänden der Seitenschiffe, an Pfeilern, in Seitenkapellen oder an den Seitenwänden befinden können. In Kirchen mit einem Lettner war auch ein Altar vor dem Lettner üblich, der häufig Kreuzaltar genannt wurde.",
    "churchHighlightTitle_2": "Seitenaltar L",
    "churchHighlightDescription_2": "Zusätzlich zum Hauptalter können in einer Kirche Seitenaltäre im Hauptschiff sowie den Seiten- oder Nebenschiffen aufgestellt werden. Mehrere Altäre waren nicht nur das Ergebnis frommer Stiftungen, sondern oft auch notwendig, weil bis in die Zeit nach dem Zweiten Vatikanischen Konzil jeder Priester jeden Tag wenigstens einmal Eucharistie feiern musste. Vor allem in den Klosterkirchen von Priesterorden musste es deshalb eine ausreichende Zahl von Seitenaltären geben, damit jeder Priester täglich Gelegenheit zur Zelebration hatte.",
    "newsMessageHeader": "Aktuelles",
    "newsTitle_1": "Kinder Gottesdienst",
    "newsTitle_2": "Allerheiligen",
    "newsDescription_1": "Wir bieten auf dieser Seite Entwürfe, Ideen, Arbeitshilfen und Informationen für kirchliche Arbeit mit Kindern im Kindergottesdienst und Kindergarten. Ihr könnt die hier zu findenden Materialien für eure Arbeit vor Ort nutzen und bearbeiten. "
        "Solltet Ihr eigene Ideen haben, einen schönen Kindergottesdienst oder anderes mit Kinder gefeiert haben, so lasst andere daran teilhaben. ",
    "newsDescription_2": "Allerheiligen (lateinisch Sollemnitas Omnium Sanctorum) ist ein christliches Hochfest, an dem aller Heiligen gedacht wird, der „verherrlichten Glieder der Kirche, die schon zur Vollendung gelangt sind“,[1] der bekannten wie der unbekannten.[2] Das Fest wird in der Westkirche am 1. November begangen, in den orthodoxen Kirchen am ersten Sonntag nach Pfingsten. Die Evangelische Kirche feiert den Gedenktag der Heiligen ebenfalls am 1. November.[3][4] Einige Diözesen und Ordensgemeinschaften begehen in der Woche vom 2. bis zum 8. November oder im weiteren Verlauf des Novembers das Gedenken ihrer Heiligen.",
    "donationMessageHeader": "Spenden",
    "bibleVerseContentDonation": "Jeder von euch soll geben, was er in seinem Herzen beschlossen hat zu geben, nicht widerwillig oder unter Zwang, denn Gott liebt einen fröhlichen Geber.",
    "bibleVerseIdDonation": "2. Korinther 9.6-8",
    "donationBankHeader": "Spende per Banküberweisung",
    "donationBankDetails": 'Bank: XYZ Bank\n'
        'Kontoinhaber: Name\n'
        'IBAN: XXXX XXXX XXXX XXXX XXXX\n'
        'BIC: XXXXXXXX',
    "donationMessageThankYou": 'Herzlichen Dank für Ihre Unterstützung! '
    'Ihre Spende ermöglicht es uns, die Botschaft Jesu Christi weiterzutragen. '
        'Möge Ihr Beitrag dazu beitragen, das Licht des Glaubens in die Herzen der Menschen zu tragen. '
        'Gott segne Sie reichlich! Zusätzlich verwenden wir einen Teil Ihrer Spendenmittel für die Erhaltung unserer Kirche.',
  };

  return textContents[textContentType] ?? "";

}

String getTextContentEnglish(String textContentType) {

  Map<String, String> textContents = {
    "welcomeMessage": "Welcome to church Pfarrkirche Silz \n(Peter and Paul)",
    "dashboardMessage": "Dashboard",
    "interactiveMapMessage": "Interactive Map",
    "virtualChurchDashboard": "Virtual Church",
    "churchHistoryDashboard": "Geschichte",
    "churchHistoryMessageHeader": "Church History",
    "churchHistoryMessageTitle": "Church Silz - Peter and Paul",
    "churchHistoryMessage": "The parish church of Silz, dedicated to the apostles Peter and Paul, "
        "was built between 1846 and 1848 on the site of an older building under the direction of master "
        "builder Benedikt Perwög. Originally, the building designed by architect Alois Haas for 1400 people "
        "was to have been much larger than it was actually built, but the government was unable to obtain "
        "permission for this project. Although the revised Haas plans proved to be technically appropriate and "
        "feasible, the initiators of the new church building, above all Pastor Peter Span, had to contend with "
        "great resistance from their own congregation. There were repeated unpleasant arguments between supporters "
        "and opponents of the new church building, which culminated in numerous letters of complaint to the Gubernium. "
        "The government finally put an abrupt end to this dispute with the decree of September 26, 1845, by ordering "
        "the construction to be carried out immediately without considering the further objections of the opposing "
        "parties. The demolition of the old mortuary chapel began on the very day this decree was issued. "
        "Once the old church had been demolished, work could finally begin on the new building. Just six months "
        "after the foundation stone was laid on July 2, 1846, the shell of the new church was completed and the "
        "tower was raised to the height of the church roof. By All Saints' Day 1847, the interior was also",
    "actualNewsDashboard": "News",
    "donationDashboard": "Donation",
    "virtualChurchMessageHeader": "Virtual Church",
    "virtualChurchTourMessage": "Virtual Church Tour",
    "churchHighlightTitle_1": "High Altar",
    "churchHighlightDescription_1": "The high altar is the raised main altar in or in front of the apse of a Catholic church. Seen from the main nave of the church, it is usually located at the front of the apse, and in old sepulchral churches such as St. Peter's Basilica it is also located centrally above the memoria. "
        "Originally, the term distinguished the main altar of a church from the side altars, which were erected in addition to the high altar in larger churches from the reign of the Roman Emperor Constantine I and which could be located in the side apses, the chapel chapels, on the walls of the side aisles, on pillars, in side chapels or on the side walls. In churches with a rood screen, an altar in front of the rood screen was also common and was often called a cross altar.",
    "churchHighlightTitle_2": "Side Altar L",
    "churchHighlightDescription_2": "In addition to the main altar, side altars can be set up in a church in the nave as well as the side or side aisles. Several altars were not only the result of pious donations, but were often also necessary because, until after the Second Vatican Council, every priest had to celebrate the Eucharist at least once a day. Above all in the monastery churches of priestly orders, there therefore had to be a sufficient number of side altars so that every priest had the opportunity to celebrate the Eucharist every day.",
    "newsMessageHeader": "News",
    "newsTitle_1": "Youth Church",
    "newsTitle_2": "All Saints' Day",
    "newsDescription_1": "On this page we offer drafts, ideas, work aids and information for church work with children in children's services and kindergarten. You can use and edit the materials you find here for your local work. "
        "If you have your own ideas or have celebrated a wonderful children's service or other event with children, please share them with others.",
    "newsDescription_2": "All Saints' Day (Latin: Sollemnitas Omnium Sanctorum) is a Christian feast day on which all saints are commemorated, the glorified members of the Church who have already reached perfection, "
        "[1] both known and unknown.[2] The feast is celebrated on 1 November in the Western Church and on the first Sunday after Pentecost in the Orthodox churches. The Protestant Church also celebrates the commemoration of the saints on November 1.[3][4] Some dioceses and religious communities commemorate their saints in the week from November 2 to 8 or later in November.",
    "donationMessageHeader": "Donation",
    "bibleVerseContentDonation": "Each of you should give what you have decided in your heart to give, "
                                  "not reluctantly or under compulsion, for God loves a cheerful giver.",
    "bibleVerseIdDonation": "2 Corinthians 9.6-8",
    "donationBankHeader": "Donate by bank transfer",
    "donationBankDetails": 'Bank: XYZ Bank\n'
        'Account Holder: Name\n'
        'IBAN: XXXX XXXX XXXX XXXX XXXX\n'
        'BIC: XXXXXXXX',
    "donationMessageThankYou": 'Thank you very much for your support! '
                                'Your donation enables us to spread the message of Jesus Christ. '
                                'May your contribution help to carry the light of faith into peoples hearts. '
                                'May God bless you abundantly! In addition, we will use part of your donation for the maintenance of our church,',
  };

  return textContents[textContentType] ?? "";

}