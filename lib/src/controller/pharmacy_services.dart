
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyService{


  void launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    final String url = phoneUri.toString();
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'could not launch $url';
    }
  }

  void launchGoogleMaps(double latitude,double longitude) async{
    var googleMapsUrl="https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving";
    if(await canLaunchUrl(Uri.parse(googleMapsUrl))){
      await launchUrl(Uri.parse(googleMapsUrl));
    }
    else{
      throw 'Could not open the map.';
    }
  }

  Future<double> calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  int calculateTravelTime(double distance, double averageSpeed) {
    double timeInHours = distance / averageSpeed;
    int timeInMinutes = (timeInHours * 60).round();
    return timeInMinutes;
  }
}