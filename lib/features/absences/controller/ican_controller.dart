
import 'package:url_launcher/url_launcher.dart';

class IcaController{


  void launchOutlookEvent({
    required String subject,
    required String location,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // Format date and time strings
    String formattedStartDate = startDate.toUtc().toIso8601String();
    String formattedEndDate = endDate.toUtc().toIso8601String();

    // Construct URL for creating a new event in Outlook
    String url = 'https://outlook.office.com/calendar/0/deeplink/compose'
        '?subject=${Uri.encodeComponent(subject)}'
        '&location=${Uri.encodeComponent(location)}'
        '&startdt=$formattedStartDate'
        '&enddt=$formattedEndDate';

    // Launch the URL using url_launcher
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchOutlookEventButtonPressed(DateTime startDate,DateTime endDate) {
    String subject = 'Absences Meeting with Client';
    String location = 'Virtual Meeting';
    print("startDate:$startDate");
    print("endDate:$endDate");
    launchOutlookEvent(
      subject: subject,
      location: location,
      startDate: startDate,
      endDate: endDate,
    );
  }
}