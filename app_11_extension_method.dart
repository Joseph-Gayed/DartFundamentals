
//Assume this class is from a closed source lib
class TaxesCalculater {
  double _govPercent = 0.1;
  double _nonGovPercent = 0.2;
  double revenue = 0;


  void setRevenue(double rev){
    this.revenue=rev;
  }

  double calculateTaxesForGovOrg() {
    return revenue*_govPercent;
  }

  double calculateTaxesForNonGovOrg() {
    return revenue*_nonGovPercent;
  }
}



extension PartnerShipOrgTax on TaxesCalculater{
  double calculateTaxesForPartnershipOrg(){
    this._nonGovPercent=0.5;
    return revenue*0.15;
  }
}

extension StringExt on String {
  bool isValidEamil() {
    return this.contains("@");
  }

  bool isValidMobile() {
    return this.length == 11;
  }
}

void main() {
  String input1 = "1111222";
  String input2 = "valid@email.com";

  print("$input1 is valid mobile = ${input1.isValidMobile()}");
  print("$input2 is valid email = ${input2.isValidEamil()}");




  TaxesCalculater tc = TaxesCalculater();
  tc.setRevenue(1000);
  double taxesOfGov = tc.calculateTaxesForGovOrg();
  double taxesOfNonGov = tc.calculateTaxesForNonGovOrg();
  double taxesOfPartnership = tc.calculateTaxesForPartnershipOrg();

  print("Taxes ------------");
  print(taxesOfGov);
  print(taxesOfNonGov);
  print(taxesOfPartnership);
}


