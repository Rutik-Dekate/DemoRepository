//Helper
trigger BackupInStudentHistory on Student__c (after update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            BackupInStudentHistoryHandler.backupInStudentHistoryMethod(trigger.new, trigger.newMap);
        }
    }
}