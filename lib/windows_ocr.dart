import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:windows_ocr/Mrz.dart';
import 'package:xml/xml.dart';

import 'Barcode.dart';

class WindowsOcr {
  static const MethodChannel _channel = const MethodChannel('windows_ocr');

  static Future<String> getOcrFromData(Uint8List bytes, {language = "English"}) async {
    final String res = await _channel.invokeMethod('getOcrFromData', <String, dynamic>{
      'bytes': bytes,
      'bytesSize': bytes.length,
      'language': 'Languages/$language',
    });
    return res;
  }

  static Future<String> getOcr(String filePath, {language = "English"}) async {
    final String res = await _channel.invokeMethod('getOcr', <String, dynamic>{
      'path': filePath,
      'language': 'Languages/$language',
    });
    return res;
  }

  static Future<Mrz?> getMrzFromData(Uint8List bytes) async {
    final res = await _channel.invokeMethod<String>('getMrzFromData', <String, dynamic>{
      'bytes': bytes,
      'bytesSize': bytes.length,
    });
    try {
      final cleanXml = <int>[];
      for (var char in res!.codeUnits) {
        if (char == 0) continue;
        cleanXml.add(char);
      }
      var xml = String.fromCharCodes(cleanXml);
      final document = XmlDocument.parse(xml);
      final mrzNodes = document.findAllElements('MRZ').toList();
      Mrz? mrz;
      if (mrzNodes.length > 0) {
        XmlElement element = mrzNodes[0];
        mrz = Mrz.fromData(element);
      }
      return mrz;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Mrz?> getMrz(String filePath) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + '\\' + 'out.xml';
    final res = await _channel.invokeMethod('getMrz', <String, dynamic>{
      'path': filePath,
      'pathXml': tempPath,
    });
    final document = XmlDocument.parse(res);
    final mrzNodes = document.findAllElements('MRZ').toList();
    Mrz? mrz;
    if (mrzNodes.length > 0) {
      XmlElement element = mrzNodes[0];
      mrz = Mrz.fromData(element);
    }
    return mrz;
  }

  static Future<List<Barcode>> getBarcode(String filePath) async {
    final res = await _channel.invokeMethod<List<dynamic>>('getBarcode', <String, dynamic>{
      'path': filePath,
    });
    debugPrint(res.toString());
    final barcodes = <Barcode>[];
    if (res == null) {
      return [];
    }
    for (final barcode in res) {
      barcodes.add(Barcode.fromData(barcode));
    }
    return barcodes;
  }
}
