//Handler
public class BackupInStudentHistoryHandler {
    public static void backupInStudentHistoryMethod(List<Student__c> studList, Map<Id, Student__c> studNewMap){
        List<Student_History__c> emptyHistoryList = new List<Student_History__c>();
        try{
            for(Student__c stud : studList){
                Map<String, Object> infoOfFields = stud.getPopulatedFieldsAsMap();	//Returns a map of populated field names and their corresponding values.
                for(String fieldName : infoOfFields.keySet()){
                    if(fieldName == 'LastModifiedDate' || fieldName == 'SystemModstam'){
                        continue;
                    }
                    else if(trigger.oldMap.get(stud.Id).get(fieldName) != studNewMap.get(stud.Id).get(fieldName)){
                        Student_History__c studentHistory = new Student_History__c();
                        studentHistory.Name = fieldName;
                        studentHistory.Record_Id__c = stud.Id;
                        studentHistory.Old_Value__c = String.valueOf(trigger.oldMap.get(stud.Id).get(fieldName));
                        studentHistory.New_Value__c = String.valueOf(studNewMap.get(stud.Id).get(fieldName));
                        emptyHistoryList.add(studentHistory);
                        
                    }
                }
            }
            if(!emptyHistoryList.isEmpty()){
                insert emptyHistoryList;
            }
        }
        catch(Exception ex){
            System.debug('Exception :- ' + ex.getMessage() + 'Line No. :' + ex.getLineNumber());
        }
    }
}