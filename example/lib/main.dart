import 'package:flutter/material.dart';
import 'package:windows_ocr/Barcode.dart';
import 'package:windows_ocr/Languages.dart';
import 'package:windows_ocr/Mrz.dart';
import 'package:windows_ocr/windows_ocr.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MaterialApp(
    title: 'Windows OCR',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Windows OCR Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('OCR'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyOcr()),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: const Text('Barcode'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBarcode()),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: const Text('MRZ'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyMrz()),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: const Text('MRZDate'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyMrzData()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyBarcode extends StatefulWidget {
  const MyBarcode({super.key});

  @override
  _MyBarcodeState createState() => _MyBarcodeState();
}

class _MyBarcodeState extends State<MyBarcode> {
  List<Barcode> _listBarcode = [];
  bool isLoading = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    setState(() {
      isLoading = true;
      _listBarcode = [];
    });

    List<Barcode> listBarcode = [];
    // Platform messages may fail, so we use a try/catch.
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        listBarcode = await WindowsOcr.getBarcode(result.paths[0]!);
      }
    } catch (error) {
      debugPrint('Error: $error');
    }

    setState(() {
      isLoading = false;
      _listBarcode = listBarcode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initPlatformState();
        },
        child: const Icon(Icons.image),
      ),
      appBar: AppBar(
        title: const Text('Barcode'),
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : _listBarcode.length > 0
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _listBarcode.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${_listBarcode[index].value}'),
                          subtitle: Text('${_listBarcode[index].type}'),
                        );
                      },
                    )
                  : const Text("Select Image")),
    );
  }
}

class MyOcr extends StatefulWidget {
  const MyOcr({super.key});

  @override
  _MyOcr createState() => _MyOcr();
}

class _MyOcr extends State<MyOcr> {
  String _ocr = '';
  bool isLoading = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    setState(() {
      isLoading = true;
      _ocr = '';
    });

    String ocr = '';
    // Platform messages may fail, so we use a try/catch.
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        ocr = await WindowsOcr.getOcr(result.paths[0]!, language: Languages.English);
      }
    } catch (error) {
      debugPrint('Error: $error');
    }

    setState(() {
      isLoading = false;
      _ocr = ocr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initPlatformState();
        },
        child: const Icon(Icons.image),
      ),
      appBar: AppBar(
        title: const Text('OCR'),
      ),
      body: Center(
        child: isLoading ? const CircularProgressIndicator() : Text('$_ocr'),
      ),
    );
  }
}

class MyMrz extends StatefulWidget {
  const MyMrz({super.key});

  @override
  _MyMrz createState() => _MyMrz();
}

class _MyMrz extends State<MyMrz> {
  Mrz? _mrz;
  bool isLoading = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    setState(() {
      isLoading = true;
    });

    Mrz? mrz;
    // Platform messages may fail, so we use a try/catch.
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        mrz = await WindowsOcr.getMrz(result.paths[0]!);
      }
    } catch (error) {
      debugPrint('Error: $error');
    }

    setState(() {
      isLoading = false;
      _mrz = mrz;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initPlatformState();
        },
        child: const Icon(Icons.image),
      ),
      appBar: AppBar(
        title: const Text('MRZ'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _mrz == null ? [] : [Text(_mrz!.lastName), Text(_mrz!.name), Text(_mrz!.docNumber)],
              ),
      ),
    );
  }
}

class MyMrzData extends StatefulWidget {
  const MyMrzData({super.key});

  @override
  _MyMrzData createState() => _MyMrzData();
}

class _MyMrzData extends State<MyMrzData> {
  Mrz? _mrz;
  bool isLoading = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    setState(() {
      isLoading = true;
    });

    Mrz? mrz;
    // Platform messages may fail, so we use a try/catch.
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, withData: true);

      if (result != null) {
        for (var file in result.files) {
          mrz = await WindowsOcr.getMrzFromData(file.bytes!);
          print(file.path! + "//" + mrz.toString());
        }
      }
    } catch (error) {
      debugPrint('Error: $error');
    }

    setState(() {
      isLoading = false;
      _mrz = mrz;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initPlatformState();
        },
        child: const Icon(Icons.image),
      ),
      appBar: AppBar(
        title: const Text('MRZData'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _mrz == null ? [] : [Text(_mrz!.lastName), Text(_mrz!.name), Text(_mrz!.docNumber)],
              ),
      ),
    );
  }
}
