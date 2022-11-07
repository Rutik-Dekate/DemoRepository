({
    init: function(component, event, helper) {
        var action = component.get("c.getAllObjectName");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {           
                var allObjValues = response.getReturnValue();
                component.set("v.valuesobj", allObjValues);
            }                    
            else if (state === "ERROR") {
                var errors = response.getError();
                console.log("Unknown Error");
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchAllFields: function(component, event, helper){
        console.log(component.get("v.selectedValue"));
        var objectName= component.get("v.selectedValue");
        //component.set("v.objectNameattri", objectName);
        var action = component.get("c.getAllFieldName");
        action.setParams({
            objectName: objectName
        });
        component.set("v.objectNameattri", objectName);
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allFieValues = response.getReturnValue();
                console.log(allFieValues);
                component.set("v.optionsForField", allFieValues);
                console.log(allFieValues);
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                console.log("Unknown Error");
            }
        });
        $A.enqueueAction(action);
    },
    
    selectedFieldChange: function(component, event, helper){
        var selectedOptionValue = event.getParam("selectedFieldValue");
        console.log('selectedOptionValue'+selectedOptionValue.toString());
        var separatedlist = component.set("v.separatedlist",selectedOptionValue.toString());
        var getvalue = component.get("v.separatedlist");
    },
    
    queryCreator: function(component, event, helper){
        var queryVar = component.find("objectFieldId").get("v.value");
        var objName = component.get("v.objectNameattri");
        var createQuery = "Select" +" "+ queryVar + " " + "From" +" " +objName ;
        console.log("This query is created :" + createQuery);
        console.log(typeof createQuery);
        component.set("v.createdQuery", createQuery);
    },
    
    getRecordTable: function(component, event, helper){
        var getListOfRec = component.get("v.createdQuery");
        var action = component.get("c.getRecordByQuery");
        action.setParams({
            queryRecord : getListOfRec
        });        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allRecordValues = response.getReturnValue();
                console.log("All Record" + allRecordValues);
                component.set("v.getListOfRec", allRecordValues);
                const selectedField= component.find("objectFieldId").get("v.value");
                console.log("Sleceted fields" + selectedField);
                const fullfield =  component.find("objectFieldId").get("v.options");
                console.log("All fields" + fullfield);
                const getcolums =[];
                for(let i=0 ; i<selectedField.length;i++){
                    for(let key in fullfield){
                		if(fullfield[key].value === selectedField[i]){
                    		getcolums.push({
                        		'label' : fullfield[key].label,
                        		'fieldName' : fullfield[key].value
                    		});
                		}
                        console.log("getting columns" + getcolums);
            		}
                }
                component.set("v.columns",getcolums);
                component.set("v.data", response.getReturnValue());
            }
            else if(state === "ERROR"){
                var errors = response.getError();
            } 
        });
        $A.enqueueAction(action);   
    }    
})