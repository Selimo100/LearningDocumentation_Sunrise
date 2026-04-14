NUTE messenger is a MS application that provides a Rest API for sending emails.

It offers:
 - Abstraction from email server
 - Capability to only sending the email at specific times
 - Rate limiting

What it doesn't do:
 - Templating of emails
 - Any modifications to the subject of the email.

So it is up to the caller systems to send all the information of how the email should be sent (from, to , subject and full email body)

For your use case, you could integrate with our API, to send the email to the customer.

For that you would have to have to generate the email body on your side and then send that together with the from address (the mailbox you created), the to (customer email) and subject.

From our side, we just need to create credentials and a particular configuration for your use case, this is around 2-3 MD of work for our team, including any integration support to help you use the API.

A couple of questions:

 1 - What is the expected load? How many such emails per hour for example
 2 - How urgent are these emails, should they be sent immediately or could be queued for later processing?
 3 - Can they be sent outside of working hours?

Based on that we can create a particular configuration for this use case.

Finally, a more admin topic. I will need a WBS to be able to assign a developer to work on this. Do you already have one? 