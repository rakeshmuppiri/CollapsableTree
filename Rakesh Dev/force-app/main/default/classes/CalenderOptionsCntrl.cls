public class CalenderOptionsCntrl {

    public PageReference Search() {
        return null;
    }

    public Date TodayDate{set;get;}
    public Integer numberOfDays{set;get;}
    public Date lastDayOfMonth{set;get;}
    public Case FromDate {set;get;}
    public Case toDate {set;get;}
    public CalenderOptionsCntrl(){
        TodayDate = system.Today();
        numberOfDays = Date.daysInMonth(system.today().year(), system.today().month());
        lastDayOfMonth = Date.newInstance(system.today().year(), system.today().month(), numberOfDays);
    }
}