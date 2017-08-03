# PersonalizedBulkSMS
This is Expect script to send personalized Bulk SMS using Android device. Application used Termux and SMSDroid

Files Descriptions

1. SendSMS.tcl : Expect script to send personalized bulk SMS
2. configure.txt : Configuration file
3. counter.txt : Store SMS sent counter. 
4. JSN.csv : Name and mobile number (input database file to pick up name and mobilenumber)

Steps: 

1. Install following applications on your Android device

1.1 https://play.google.com/store/apps/details?id=com.tehforce.smsdroid
1.2 https://play.google.com/store/apps/details?id=com.termux

2. Connect your mobile device to any network. Wifi and/or cellular. Run SMSDroid. Set Password. Here password is set as "message". Click "Start Service" button. Note down displayed IP address

3. Customized / configure application as per your need. 

3.1 Set IP address value as per previous step.

3.2 Let Port value is 7777

3.3 Use Prefix value as per your choice. E.g. "Jai Gurudev !" , "Jai SwamiNarayan !", "Hi !", "Hello !" etc.

3.4 The file name to stroe 'sent SMS counter' is configurable. For the first time write 0 in the counter file. This feature is useful, in case you want to send 2000 SMS and daily you can send only 100 SMS. At the end of each execution, the counter value will be updated. Next day, the application will not send SMS again to same set of people, it will start from next available entry. 

3.5 Address book file name is also configurable.

3.6 The message. 

The actual SMS conten will be formed as below

 "Prefix from configure.txt" +  "name from CSV file" + "Message"

4. Customized the CSV file with your friends' name and number

5. Run Termux. Go to the path with cd command, where all the files are stored at your mobile. Run the command "tclsh SendSMS.tcl"

Enjoy ... !

Constrain: 

1. SMS size limit is 160 character. However with this utility, first character is always " " (space) so one can send SMS with 159 character only.
2. the mobile should have valid network interface up. So one needs to connect to WiFi or Cellular. The application does not use Internet. 
