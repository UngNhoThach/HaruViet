import 'address_response.dart';

class AddressUser {
  const AddressUser({
    this.permanentAddress,
    this.temporaryResidenceAddress,
    this.hometownAddress,
    this.birthCertificateIssuanceAddress,
  });
  final AddressResponse? permanentAddress;
  final AddressResponse? temporaryResidenceAddress;
  final AddressResponse? hometownAddress;
  final AddressResponse? birthCertificateIssuanceAddress;

  AddressUser copyWith({
    AddressResponse? permanentAddress,
    AddressResponse? temporaryResidenceAddress,
    AddressResponse? hometownAddress,
    AddressResponse? birthCertificateIssuanceAddress,
  }) {
    return AddressUser(
      permanentAddress: permanentAddress,
      temporaryResidenceAddress: temporaryResidenceAddress,
      hometownAddress: hometownAddress,
      birthCertificateIssuanceAddress: birthCertificateIssuanceAddress,
    );
  }
}
