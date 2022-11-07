public class salesforceMetadataTaskController {
    
   @AuraEnabled
    public static List<String> getAllObjectName(){
        List<String> objects = new List<String>();
        List<Schema.SObjectType> allObjects = Schema.getGlobalDescribe().Values();	//Returns a map of all sObject names (keys) to sObject tokens (values) 
        																			//for the standard and custom objects defined in your organization.  
        for(SObjectType sObjTyp:allObjects){
            objects.add(sObjTyp.getDescribe().getName());
            objects.sort();  
        }
        return objects;
    }
    
    @AuraEnabled
    public static List<Map<String, String>> getAllFieldName(String objectName){
        List<String> fields = new List<String>();
        SObjectType objValues = Schema.getGlobalDescribe().get(objectName);
        
        List<Map<String, String>> listMapStr = new List<Map<String, String>>();
        
        Map<String, Schema.SObjectField> getFieldMap = objValues.getdescribe().fields.getMap();
        for(String sObjStr: getFieldMap.keySet()){
            Map<String, String> strMap = new Map<String, String>();
            Schema.DescribeFieldResult resultFieldVar =  getFieldMap.get(sObjStr).getdescribe();
            String label = resultFieldVar.getlabel() ;
            String name = resultFieldVar.getname();
            strMap.put('label', label);
            strMap.put('value', name);
            listMapStr.add(strMap);
        }
        system.debug(listMapStr);
        return listMapStr;
    }
    
    @AuraEnabled
    public static list<sObject> getRecordByQuery(String queryRecord){
        List<sObject> recordList = Database.query(queryRecord);
        return recordList;   
    } 
}