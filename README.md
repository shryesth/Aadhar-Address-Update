# Aadhar Address Update

### Application Flow
- The Operator will login using his alloted credentials (by UIDAI, for now using aadhar number and OTP)
- A welcome page will be displayed, where Operator can enter VID/UID/Aaddhar number (Preferred VID to enhance privacy and security) of the Client.
  (Client refers to individual, who wants to avail Address Update service).
- The client will receive an OTP on his Registered Mobile Number
- Sharing the OTP with Operator will allow Operator to access eKYC details of Client.
- On selecting "Update Address". a window with Camera Accessibilty will open.
- Operator will click image of POA (Proof of Address) of the Client.
- Using OCR the Address will be fectched from the image, and feilds with new Address will be Visible.
- Feilds will be classified into editable and uneditable as.
  
  - Uneditable Feilds :
       - VTC (village/town/city)
       - Sub District
       - District
       - State
       - Country
       - Postal Code

  - Editable Feilds :
       - Care Of
       - House Identifier
       - Street Name
       - Landmark
       - Locality
       - Post Office Name

- The changes will be saved, at local database (device) along with GPS location (co ordinates) where the changes      were made as log.
- If the co-ordinates and updated address will match, the app will sync the request wil a sever


### Fraud Prevention
- Application will not let Operator login if Developer Settings of Device are turned on.
    - This will not allow operator to fake his GPS location.
- Application only processess the change address requests, for which the Co-ordianates of Operator (stored in logs) and the Updated Address Match.
 
 ### API Used
 - Aadhar OTP API (to generate OTP)
 - Aadhar eKYC API (to Fetch Address details of Clients)
 - Geolocator API (to access GPS location of Operator)
 - Geocoding API (to convert scanned address into GPS co-ordinates, and match wil GPS location of Operator)

### Programming Tools Used
 - Flutter
 - Android Studio
 - Android SDK
 - Kotlin
 - Dart
 - Java




