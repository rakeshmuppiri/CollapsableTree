trigger futuretrigger on Account(after update) {

       for(Account acc : Trigger.new){
       system.debug('===='+acc.Name);
       }

}