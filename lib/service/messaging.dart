import 'package:dio/dio.dart';
import 'package:mqtt_test/constant/app_url.dart';
import 'package:mqtt_test/screen/firstpage.dart';

class InboxMSG {
  static Future<bool> addMsg({required String pid, required String msg}) async {
    bool result = false;
    Object datainput;
    datainput = {"pid": pid, "msg": msg};
    final response = await Dio().post(UrlApp.addMsgUrl, data: datainput);
    try {
      if (response.statusCode == 200) {
        if (response.data["status"] == "OK") {
          result = true;
        }
      }
      return result;
    } catch (e) {
      logger.e(e);
      result = false;
    }
    return result;
  }
}
