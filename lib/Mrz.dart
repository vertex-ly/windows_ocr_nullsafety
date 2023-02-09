class Mrz {
  String linesCnt = '';
  String docType = '';
  String docSubType = '';
  String country = '';
  String lastName = '';
  String name = '';
  String docNumber = '';
  String nationality = '';
  String birthDate = '';
  String expDate = '';
  String sex = '';
  String personalNumber = '';
  String optionalData1 = '';
  String optionalData2 = '';
  String docNumCheck = '';
  String docNumberVerified = '';
  String birthDateCheck = '';
  String birthDateVerified = '';
  String expDateCheck = '';
  String expDateVerified = '';
  String personalNumberCheck = '';
  String personalNumberVerified = '';
  String compositeCheck = '';
  String compositeVerified = '';

  Mrz(
      {this.linesCnt = '',
      this.docType = '',
      this.docSubType = '',
      this.country = '',
      this.lastName = '',
      this.name = '',
      this.docNumber = '',
      this.nationality = '',
      this.birthDate = '',
      this.expDate = '',
      this.sex = '',
      this.personalNumber = '',
      this.optionalData1 = '',
      this.optionalData2 = '',
      this.docNumCheck = '',
      this.docNumberVerified = '',
      this.birthDateCheck = '',
      this.birthDateVerified = '',
      this.expDateCheck = '',
      this.expDateVerified = '',
      this.personalNumberCheck = '',
      this.personalNumberVerified = '',
      this.compositeCheck = '',
      this.compositeVerified = ''});

  Mrz.fromData(dynamic data) {
    linesCnt = data.getAttribute('LinesCnt');
    docType = data.getAttribute('DocType');
    docSubType = data.getAttribute('DocSubType');
    country = data.getAttribute('Country');
    lastName = data.getAttribute('LastName');
    name = data.getAttribute('Name');
    docNumber = data.getAttribute('DocNumber');
    nationality = data.getAttribute('Nationality');
    birthDate = data.getAttribute('BirthDate');
    expDate = data.getAttribute('ExpDate');
    sex = data.getAttribute('Sex');
    personalNumber = data.getAttribute('PersonalNumber');
    optionalData1 = data.getAttribute('OptionalData1');
    optionalData2 = data.getAttribute('OptionalData2');
    docNumCheck = data.getAttribute('DocNumCheck');
    docNumberVerified = data.getAttribute('DocNumberVerified');
    birthDateCheck = data.getAttribute('BirthDateCheck');
    birthDateVerified = data.getAttribute('BirthDateVerified');
    expDateCheck = data.getAttribute('ExpDateCheck');
    expDateVerified = data.getAttribute('ExpDateVerified');
    personalNumberCheck = data.getAttribute('PersonalNumberCheck');
    personalNumberVerified = data.getAttribute('PersonalNumberVerified');
    compositeCheck = data.getAttribute('CompositeCheck');
    compositeVerified = data.getAttribute('CompositeVerified');
  }

  @override
  String toString() {
    return name + " " + lastName + " " + docNumber;
  }
}
