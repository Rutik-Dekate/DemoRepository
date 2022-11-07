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

//Helper
trigger CountCaseNewAndEscalated on Case (after insert, after update, after delete, after undelete) {
    if(trigger.isafter){
        if(trigger.isinsert || trigger.isupdate || trigger.isundelete){
            if(CountCaseNewAndEscalatedHandler.isRecursion == True){
                CountCaseNewAndEscalatedHandler.isRecursion = False;
            	CountCaseNewAndEscalatedHandler.CountCaseNewAndEscalatedMethode(trigger.new);
            }
        }
        if(trigger.isupdate || trigger.isdelete){
            if(CountCaseNewAndEscalatedHandler.isRecursionDel == True){
                CountCaseNewAndEscalatedHandler.isRecursionDel = False;
				CountCaseNewAndEscalatedHandler.CountCaseNewAndEscalatedDeleteMethode(trigger.old);
            }
        }
    }
}