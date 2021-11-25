import 'package:auth/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataProcessingPage extends StatefulWidget {
  const DataProcessingPage({Key? key}) : super(key: key);

  @override
  _DataProcessingPageState createState() => _DataProcessingPageState();
}

class _DataProcessingPageState extends State<DataProcessingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  //------Pasek Górny------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 35,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Dokumenty',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //------Napis Ustawienia------
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Przetwarzanie Danych',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  //------Ustawienia------
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: const [
                        Text(
                          '1. Administratorem danych osobowych jest drużyna "Różowe Jednorożce Patatające Po Łące W Szpileczkach"',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '2. Administrator wyznaczył inspektora ochrony danych osobowych. Dane kontaktowe inspektora: ',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '3. Przekazane dane osobowe przetwarzane będą w celu realizacji usług, obsługi zgłoszeń i udzielania odpowiedzi na zgłoszenia;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '4. Kategorie danych osobowych obejmują m.in. imię i nazwisko, datę urodzenia, adres e-mail, dane dedykowane do procesu/usługi/projektu;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '5. Pani / Pana dane osobowe mogą być przekazywane podmiotom przetwarzającym dane osobowe na zlecenie administratora: dostawcy usług IT;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '6. Państwa dane osobowe będą przechowywane przez okres istnienia prawnie uzasadnionego interesu administratora, chyba że Pani / Pan wyrazi sprzeciw wobec przetwarzania danych;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '7. Państwa dane mogą być przekazywane do państwa trzeciego lub organizacji międzynarodowej;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '8. Posiadają Państwo prawo dostępu do treści swoich danych oraz prawo ich sprostowania, usunięcia, ograniczenia przetwarzania, prawo do przenoszenia danych, prawo wniesienia sprzeciwu, prawo do cofnięcia zgody w dowolnym momencie bez wpływu na zgodność z prawem przetwarzania, którego dokonano na podstawie zgody przed jej cofnięciem;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '9. Dane udostępnione przez Panią/Pana nie będą podlegały zautomatyzowanemu podejmowaniu decyzji oraz profilowaniu;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '10. Dane pochodzą od osób, których dane dotyczą;',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '11. Podanie przez Państwa danych osobowych jest dobrowolne; ',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '12. Powyższy dokument jest tylko przykładowym dokumentem i twórcy aplikacji nie ponoszą żadnej odpowiedzialności za nie wywiązanie się z któregoś z powyższych punktów.',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
