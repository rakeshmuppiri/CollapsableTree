public class duplicateManagementCntrl {
    public List<selectOption> Objects {set;get;}
    public List<selectOption> fieldNames {set;get;}
    public String selectedField {set;get;}
    public String selectedObject{set;get;}
    set<String> invalidFields = new set<String>();
    public duplicateManagementCntrl(){
        Objects = new List<selectOption>();
        Objects.add( new selectOption('','--select--'));
        for(String objName : Label.ObjectToSelect.split(',')){
            selectOption selOpt = new selectOption(objName, objName);
            Objects.add(selOpt);
        }
        invalidFields.add('ID');
        invalidFields.add('ADDRESS');
        invalidFields.add('TEXTAREA');
        
    }
    public Map<String, String> criteriaFieldMap{set;get;}
    public void addFieldsToCriteria(){
        if(criteriaFieldMap == null)
            criteriaFieldMap = new Map<String, String>();
        if(selectedField != null)
            criteriaFieldMap.put(selectedField, '');
        
    }
    public SObject obj{set;get;}
    public void loadFields(){
        fieldNames = new List<selectOption>();
      
        if(selectedObject != null){
            obj = Schema.getGlobalDescribe().get(selectedObject).newSobject();
            Map<String,Schema.SObjectField> fieldsMap =Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
            fieldNames.add(new selectOption('', '--select--'));
            for(String res : fieldsMap.keySet()) {
                if(fieldsMap.get(res).getDescribe().isPermissionable() == true && invalidFields.contains(String.valueOf(fieldsMap.get(res).getDescribe().getType())) == false){
                    String name = fieldsMap.get(res).getDescribe().getname().toupperCase();
                    String label = fieldsMap.get(res).getDescribe().getlabel().toupperCase();
                      system.debug('SSS'+name);
                    selectOption selOpt = new selectOption(name, label);
                    fieldNames.add(selOpt); 
                }   
            }
        }
    }
}