/*
There should be 2 count fields on the Account, and those should be updated for case updates if case status changes
New Cases Count
Escalated Cases Count

Description :- This trigger is applied on Case Object to get the count of New as well Escalated Status
Author :- Rutik Radheshyam Dekate
Created Date :- 20-10-2022
LastModified Date :-20-10-2022
LastModified By :- Rutik Dekate
*/

//Handler
public class CountCaseNewAndEscalatedHandler {
    public static boolean isRecursion = True;
    public static boolean isRecursionDel = True;
    public static void CountCaseNewAndEscalatedMethode(List<Case> CasList){
        Set<Id> accsetid = new Set<Id>();
        try{
            for(Case cas : CasList){
                if(cas.AccountId != Null){
                    accsetid.add(cas.AccountId);
                }
            }
            Map<Id, Account> escalatedcasemap = new Map<Id, Account> ([Select Id, (Select Id, Status from Cases where Status = 'Escalated') from Account where Id IN : accsetid ]);
            Map<Id, Account> newcasemap =  new Map<Id, Account> ([Select Id, (Select Id, Status from Cases where Status = 'New') from Account where Id IN : accsetid ]);
            
            List<Account> AccList = new List<Account>();
            
            for(Account acc : [Select Id, Count_Of_Escalated_Cases__c, Count_Of_New_Cases__c from Account where Id IN : accsetid]){
                acc.Count_Of_Escalated_Cases__c = escalatedcasemap.get(acc.Id).Cases.size();
                acc.Count_Of_New_Cases__c = newcasemap.get(acc.Id).Cases.size();
                AccList.add(acc);
            }
            if(AccList != Null){
                update AccList;
            }
        }
        catch(Exception ex){
            System.debug('Exception :- ' + ex.getMessage() + 'Line No. :' + ex.getLineNumber());
        }
    }
    //Delete
    public static void CountCaseNewAndEscalatedDeleteMethode(List<Case> CasList){
        Set<Id> accsetid = new Set<Id>();
        try{
            for(Case cas : CasList){
                if(cas.AccountId != Null){
                    accsetid.add(cas.AccountId);
                }
            }
            Map<Id, Account> escalatedcasemap = new Map<Id, Account> ([Select Id, (Select Id, Status from Cases where Status = 'Escalated') from Account where Id IN : accsetid ]);
            Map<Id, Account> newcasemap =  new Map<Id, Account> ([Select Id, (Select Id, Status from Cases where Status = 'New') from Account where Id IN : accsetid ]);
            
            List<Account> AccList = new List<Account>();
            
            for(Account acc : [Select Id, Count_Of_Escalated_Cases__c, Count_Of_New_Cases__c from Account where Id IN : accsetid]){
                acc.Count_Of_Escalated_Cases__c = escalatedcasemap.get(acc.Id).Cases.size();
                acc.Count_Of_New_Cases__c = newcasemap.get(acc.Id).Cases.size();
                AccList.add(acc);
            }
            if(AccList != Null){
                update AccList;
            }
        }
        catch(Exception ex){
            System.debug('Exception :- ' + ex.getMessage() + 'Line No. :' + ex.getLineNumber());
        }
    }
}