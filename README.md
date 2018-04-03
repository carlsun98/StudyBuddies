# StudyBuddies333

Mobile:
Linux/macOS
run npm-install to install node dependencies in the src/mobile folder

TODO:
- Create Database
- Write API:
  - Decide on Language
  - Learn SQL
  - Learn good, secure practices:
    - sanitize input (check that the input is not a SQL command or something)
    - set permissions (only certain users can edit things in the database)
- Learn how to use Maps
- confirm the navigation flow 
- color scheme, design scheme, logo
- build the views
- connect it up


Server:
server located at 34.214.169.181
access phpmyadmin at 34.214.169.181/phpmyadmin


DataBase Tables: 

Users
- ID (autogenerate)
- email 
- password (hash password to be secure)
- (salt)
- push Notifications (boolean t/f) — special key given by phone eg. APN key
- timestamp (when it was created)
- last interaction (time stamp) — checked regularly to remove people who haven’t been active
- name, class year
- Associated School ID
- Group ID ( = -1 if they’re not in a group)

Schools
- ID
- School Name
- Email Identifier (eg. princeton.edu)
- upper left bounding box (lat, long)
- lower right bounding box (lat, long)
- timestamp

Classes
- ID
- Abbreviation 
- Course Number
- Course Title
- Associated School ID
- timestamp

User_Classes
- ID
- User ID
- class ID
- timestamp

Groups
- ID
- Associated Class ID
- Associated Leader ID
- start time
- end time
- category
- location (lat)
- location (long)
- location (description)
- description
- Chat ID (—beta)

Sessions
- ID
- User_ID
- Token
- timestamp

Password Recovery
- ID
- User_ID
- expiration
- recovery token
- timestamp

APIs: 

Login API
in: username, password
out: token

Create User
in: user information
out: token (like login)

Update User
in: new user info
out: S/F

Delete User
in: user info
out: S/F

Classes List
in: search string 
out: classes that match the search string

Add Class (User’s Classes)
in: class info
out: S/F

Delete Class (User’s Classes)
in: class info
out: S/F

List User’s Classes
in: — 
out: all the user’s classes

Create Group
in: group info
out: S/F

Update Group
in: group info
out: S/F

Delete Group
in: group info
out: S/F

List Group
in: —
out: all groups of a certain class

Send Password Recovery (sending the email)
in: email ID
out: S/F

Account Recovery (take recovery password)
in: recovery token, new password (changed), email address
out: S/F


