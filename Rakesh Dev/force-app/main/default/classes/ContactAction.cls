public class ContactAction {
  @InvocableMethod(label='Send Email' description='Send email to contact with parent account attachments')
  public static List<String> sendEmailWithAttachments(List<ID> ids) {
    List<Contact> contacts = [SELECT Name,AccountId FROM Contact WHERE Id in :ids];
    EmailTemplate et=[Select id from EmailTemplate where name = 'New Contact' LIMIT 1];
    List<Id> accountIds = new List<Id>();
    for(contact con : contacts){
        accountIds.add(con.AccountId);
    }
    Map<Id, List<Attachment>> accountIdAtts = new Map<Id, List<Attachment>>();
    for(Attachment att : [SELECT Name, Body, ParentId FROM Attachment WHERE ParentId IN: accountIds]){
        if(accountIdAtts.get(att.ParentId) == null){
            accountIdAtts.put(att.ParentId, new List<Attachment>{att});
        }else{
            List<Attachment> temp = accountIdAtts.get(att.ParentId);
            temp.add(att);
            accountIdAtts.put(att.ParentId, temp);
        }
        
    }
    
    Messaging.SingleEmailMessage[] emailList = new Messaging.SingleEmailMessage[]{};
    
    for (Contact con : contacts) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(con.Id);
        mail.setSenderDisplayName('System Admin');
        mail.setTemplateId(et.id);
        
        for(Attachment a : accountIdAtts.get(con.AccountId)){
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(a.Name);
            efa.setBody(a.Body);
            fileAttachments.add(efa);
            mail.setFileAttachments(fileAttachments);
        }
         
        emailList.add(mail);
    }
    Messaging.sendEmail(emailList);

    return null;
  }
}