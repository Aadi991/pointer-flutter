GIVEN The user has installed the app and is using it for the first time
WHEN He opens it
THEN He is prompted to sign in

GIVEN The user has a valid phone number
WHEN He enters it
THEN He is sent an otp

GIVEN The user received the OTP
WHEN He enters it
THEN He is allowed to access the app

GIVEN The user has enter his data
WHEN He pressed sumbit
THEN His data is saved onto the database and he is taken to the home screen

GIVEN The user wants to add a learner
WHEN He pressed the button
THEN He is taken to the add learner screen

GIVEN The user has enter his learners data
WHEN He pressed sumbit
THEN His learners data is saved onto the database and he is taken to the home screen

GIVEN the user wants to open a learners profile
WHEN He chooses a learner and clicks on them
THEN He is taken to the learners page

GIVEN THe user wants to penalise his learner
WHEN He presses the action
THEN The learners points will fall by the value

GIVEN THe user wants to reward his learner
WHEN He presses the action
THEN The learners points will rise by the value

GIVEN THe user wants to add a new action
WHEN He presses the button
THEN A dialog asks the amount and value and adds the action to the database

GIVEN The user wants to view his learners history
WHEN He presses the button
THEN He is taken to the history screen

GIVEN The user wants to filter the  history
WHEN He selects a filter
THEN He is given a dialog to choose a date, the list is then filtered

GIVEN The user wants to remove the filer
WHEN He presses the cross
THEN THe filter is removed and the list is reset
