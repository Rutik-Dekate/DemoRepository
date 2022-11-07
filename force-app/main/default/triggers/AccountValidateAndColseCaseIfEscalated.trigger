/*(2)When Account is Deactivated by updating its Active field to False
All of the Cases for this Account should be closed by updating their Status field to Closed if those are not in the Escalated Status.


(1)If Active field on the Account is updated to False.
Validation - 
Account should not be updated to Active if it has any Case that is in Escalated Status.
Error Message for Validation - There are some escalated cases for this account. Please close them first.

Description :- This trigger is applied on Account Object to Validate Account Field and to update case status to close
Author :- Rutik Radheshyam Dekate
Created Date :- 20-10-2022
LastModified Date :-20-10-2022
LastModified By :- Rutik Dekate

*/
//Helper
trigger AccountValidateAndColseCaseIfEscalated on Account (before update ,after update) {
    if(trigger.isbefore && trigger.isupdate){
        AccountValidateAndColseCaseHandler.accountValidationMethod(trigger.new);
    }
    
    else if(trigger.isafter && trigger.isupdate){
        AccountValidateAndColseCaseHandler.colseCaseIfEscalatedMethod(trigger.new);
    }
}