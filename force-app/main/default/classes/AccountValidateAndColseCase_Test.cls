@isTest
public class AccountValidateAndColseCase_Test {
    @testSetup
    static void testData(){
        List<Account> acclist = new List<Account>();
        acclist.add(new Account(Name = 'Test1', Active__c = 'No')); //acclist[0]
        acclist.add(new Account(Name = 'Test2', Active__c = 'No')); //acclist[1]
        acclist.add(new Account(Name = 'Test3', Active__c = 'No')); //acclist[2]
        acclist.add(new Account(Name = 'Test4', Active__c = 'No')); //acclist[3]
        acclist.add(new Account(Name = 'Test5', Active__c = 'Yes')); //acclist[4]
        acclist.add(new Account(Name = 'Test6', Active__c = 'Yes')); //acclist[5]
        insert acclist;
        
        List<Case> caslist = new List<Case>();
        caslist.add(new Case(AccountId = acclist[0].id, Status = 'Escalated', Origin = 'Web'));	//Test1
        caslist.add(new Case(AccountId = acclist[0].id, Status = 'New', Origin = 'Web'));		//Test1
        caslist.add(new Case(AccountId = acclist[0].id, Status = 'Working', Origin = 'Web'));	//Test1
        caslist.add(new Case(AccountId = acclist[1].id, Status = 'Escalated', Origin = 'Web'));	//Test2Ooo
        caslist.add(new Case(AccountId = acclist[1].id, Status = 'New', Origin = 'Web'));		//Test2
        caslist.add(new Case(AccountId = acclist[1].id, Status = 'Working', Origin = 'Web'));	//Test2
        caslist.add(new Case(AccountId = acclist[2].id, Status = 'Escalated', Origin = 'Web'));	//Test3
        caslist.add(new Case(AccountId = acclist[2].id, Status = 'New', Origin = 'Web'));		//Test3
        caslist.add(new Case(AccountId = acclist[2].id, Status = 'Working', Origin = 'Web'));	//Test3
        																						//Test4	//Test4
        caslist.add(new Case(AccountId = acclist[4].id, Status = 'Escalated', Origin = 'Web'));	//Test5
        caslist.add(new Case(AccountId = acclist[4].id, Status = 'Working', Origin = 'Web'));	//Test5
        caslist.add(new Case(AccountId = acclist[4].id, Status = 'Working', Origin = 'Web'));	//Test5
        caslist.add(new Case(AccountId = acclist[5].id, Status = 'Escalated', Origin = 'Web'));	//Test6
        caslist.add(new Case(AccountId = acclist[5].id, Status = 'Working', Origin = 'Web'));	//Test6
        caslist.add(new Case(AccountId = acclist[5].id, Status = 'Working', Origin = 'Web'));	//Test6
        insert caslist;
    }
    
    //If there is any Account having the cases with escaleted state then it should not update.
    @isTest
    static void escaCaseOfAcc(){
        List<Account> acclist = [Select Id, Active__c from Account where Name IN ('Test1', 'Test2')];
        for(Account acco : acclist){
            acco.Active__c = 'Yes';
        }
        Test.startTest();
        Database.update(acclist, False);
        Test.stopTest();
        
        List<Account> accolist = [Select Id, Active__c from Account where Name IN ('Test1','Test2')];
        system.assertEquals('Yes', acclist[0].Active__c, 'The value of active field in account object is not matched');
        system.assertEquals('Yes', acclist[1].Active__c, 'The value of active field in account object is not matched');
    }
    
    //If there is Account having no Cases or Cases with escaleted state then update that account.
    @isTest
    static void noescaCaseOfAcc(){
        List<Account> acclist = [Select Id, Active__c from Account where Name IN ('Test3','Test4')];
        for(Account acco : acclist){
            acco.Active__c = 'Yes';
        }
        Test.startTest();
        Database.update(acclist, False);
        Test.stopTest();
        
        List<Account> accolist = [Select Id, Active__c from Account where Name IN ('Test3','Test4')];
        system.assertEquals('Yes', acclist[0].Active__c, 'The value of active field in account object is not matched');
        system.assertEquals('Yes', acclist[1].Active__c, 'The value of active field in account object is not matched');
    }
    
    @isTest
    static void closeCaseStatus(){
        List<Account> acclist = [Select Id, Name, Active__c from Account where Name IN ('Test5','Test6')];
        for(Account acc: acclist){
            acc.Active__c = 'No';
        }
        Test.startTest();
        Database.update(acclist);
        Test.stopTest();
        
        List<Case> caslist = [Select Id, Status, Account.Name from Case where Account.Name IN('Test5','Test6')];
        system.assertEquals('Escalated', caslist[0].Status, 'Case Status does not match');
        system.assertEquals('Close', caslist[1].Status, 'Case Status does not match');
        system.assertEquals('Close', caslist[2].Status, 'Case Status does not match');
        system.assertEquals('Escalated', caslist[3].Status, 'Case Status does not match');
        system.assertEquals('Close', caslist[4].Status, 'Case Status does not match');
        system.assertEquals('Close', caslist[5].Status, 'Case Status does not match');

    }
}