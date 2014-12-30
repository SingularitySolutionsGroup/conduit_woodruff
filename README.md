*Screen Sharing*

presentation_url value in user data is displayed to the user.  This is the link to the screen share initiated by the rep.  The rep sees a url built from:

https://www6331.ssldomain.com/bryancollegeteam/interview-guide/default.cfm?txtName=Gregory&LocationID=Springfield&ProgramID=13&txtDiSC=S

txtName - first name of student/prospect
LocationID - Columbia, Rogers, Springfield, Topeka, or Online
ProgramID - Screen share Program ID set on the student’s program in the collection tagged “program_of_interest"
txtDiSC - D, I, S, or C

* Referral Tag *

"Note Referrals" will cause any referrals to be posted to Velocify.


*Program Data Replace Tags*

tag a collection with “program_of_interest” and give it a template value “programs”
then use replace tags like “{{program_of_interest.total_cost}}"



*Bryan Financial Aid Notifications*

step with tag: Financial Aid Notification
notification with tag: Financial Aid Notification
campus collection has financial_aid_notification_group value and is tagged “campuses"
collection with a matching financial_aid_notification_group tag value to campus.data['financial_aid_notification_group ‘] will dictate recipients


#Tags

## Set Acceptance Letter

Will update a form id to match a form named "BU - Exec Director Acceptance Letter (#{campus_of_interest})"

## Set Program Info

Will update a form id to match a form named "BU - Program Info - #{program_of_interest}"

## Program Selection

Will update a form id to match a form named "BU - Program Selection(#{the program group that has the most tallies})"

The program group with the most tallies is calculated by counting "Yes" answers to user data that starts with ps_... like "ps_it_1" and "ps_it_2"

## Must Be Enrolled

Will complete the step if the registrant has been in status of "Enrolled" at some point.

## Must Have Interviewed

Will complete the step if the registrant has been in status of "Interviewed" at some point.

## Ground Only

Will complete and hide the step if the registrant is not on a ground campus.

## Online Only

Will complete and hide the step if the registrant is not on an online campus.


## financial aid block

Will set any step with this tag to error state until the "Unblock Financial Aid" button is pressed.

## Update Velocify Afterwards

Will send the lead's information to Velocify after the step is completed

## student_viewable

The student can download the file.

## 'Dependents Only'

Only dependents can see the step.

## 'Independents Only'

Only independents can see the step.
