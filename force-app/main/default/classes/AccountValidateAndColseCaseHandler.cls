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

//Handler

public class AccountValidateAndColseCaseHandler {

    //Adding comment to test repository
    
    //Validation on Account
    public static void accountValidationMethod(List<Account> accList){
        Map<Id, Account> accValiMap = new Map<Id, Account>([Select Id, (Select Id, Status from Cases where Status = 'Escalated') from Account where Id IN : AccList]);
        try{
            for(Account acco : accList){
                if((acco.Active__c == 'Yes') && (accValiMap.get(acco.Id).Cases.size() != 0)){
                    acco.Active__c.adderror('There are some escalated cases for this account. Please close them first.');
                }
            } 
        }
        catch(Exception ex){
            System.debug('Exception :- ' + ex.getMessage() + 'Line No. :' + ex.getLineNumber());
        }
    }
    
    //All Cases Should be close in status rather then Escalate when Account Active field is updated to false 
    public static void colseCaseIfEscalatedMethod(List<Account> accList){
        Set<Id> accsetid = new Set<Id>();
        try{
            for(Account acco : accList){
                if(acco.Active__c == 'No'){
                    accsetid.add(acco.id);
                }
            } 
            List<Case> casList = [Select Id, Status from Case where AccountId =: accsetid and Status !='Escalated'];
            for(Case cas : casList){
                cas.Status = 'Close';
                
            }
            if(CasList != Null){
                update CasList;
            }
        }
        catch(Exception ex){
            System.debug('Exception :- ' + ex.getMessage() + 'Line No' + ex.getLineNumber());
        }
    }
}


// and Status != 'New'