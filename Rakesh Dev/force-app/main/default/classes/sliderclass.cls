public class sliderclass {

    public sliderclass(parentChildRcecordsCntrl controller) {

    }


    public list<wrapClass> getRecords() {
        Integer i =0;
        for(Account a : [select id,name from account limit 10]){
            i++;
            wrapClass w = new wrapClass(i,a);
            wlist.add(w);
        }
        return wlist;
    }
    public List<wrapClass> wlist = new List<wrapClass>();
    public class wrapClass{
        public Account acc{get;set;}
        public Integer i{set;get;}
        wrapClass(Integer j, Account a){
            acc = a;
            i = j;
        }
    }
}