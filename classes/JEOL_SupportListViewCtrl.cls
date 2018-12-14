public class JEOL_SupportListViewCtrl extends JEOL_SearchBase_ctrl {

    //Properties to be read from VFPage components
    public Date startDateTimeFrom {get; set;}
    public Date startDateTimeTo {get; set;}
    public String unitBodyName {get; set;}
    public Date endDateTimeFrom {get;set;}
    public Date endDateTimeTo {get;set;}
    public String secondSupportPerson {get;set;}
    public String customerContactPerson {get;set;}

    public Boolean isUnitBodyFieldDisable {get; set;}
	
    //Params related
    private Boolean hasParam {get;set;}
    private String unitBodyParameterText = 'UnitBody';
    private String startDateParameterText = 'StartDate';
    private String endDateParameterText = 'EndDate';

    //For storing paging-preference of the user in cookies, for searched table
    private static final String COOKIE_LABEL_PAGE_NUMBER = 'PageNumber';
    private static final String COOKIE_LABEL_PAGE_SIZE = 'PageSize';
    private static final String COOKIE_PATH = '/apex/JEOL_SupportListViewPage';
    private static final String COOKIE_LABEL_INIT_SEARCH_FLG = 'initSearchFlg';  // 画面起動時検索フラグ

    //For storing user-entered values in cookies
    private static final String COOKIE_VALUE_UNITBODY = 'UnitBodyVal';
    private static final String COOKIE_VALUE_PERIODFROM = 'PeriodFromVal';
    private static final String COOKIE_VALUE_PERIODTO = 'PeriodToVal';
    private static final String COOKIE_VALUE_CUSTOMERCONTACT = 'CustomerContactVal';
    private static final String COOKIE_VALUE_SECONDSUPPORT = 'SecondSupportVal';
    private static final String COOKIE_VALUE_SERVICEENDDATE_FROM = 'endDateTimeFromVal';
    private static final String COOKIE_VALUE_SERVICEENDDATE_TO = 'endDateTimeToVal';
	private Map<String,String> mpFieldIds;
    private List<Support__c> searchedSupportCases = new List<Support__c>();
    private String initSearchFlg = '';
    public class appException extends Exception {}
    public string reportUrl{
        get;
        set;
    }
    //For UnitPartsSummary support: Vaib(2016-03-30)
    public Map<Id,Decimal> amountSummaryMap {get; private set;}
    public String rptID{
        get;
        set;
    }
   
    //Constructor
    public JEOL_SupportListViewCtrl(){

        //Read and Parse URL Params
        initParamVars();
        //
        initSortingOrderVars();
        
        //Read and Parse values in Cookies
        initFieldFromCookie();
        Boolean hasSearchValues = (this.initSearchFlg == 'true') ? true : false;
        if(hasSearchValues || hasParam) //should search if cookies are present or params are passed
            setStandardSetController();
        mpFieldIds=new Map<String,String>();
        //Find field Id from SobjectDescribe
        SObjectType SupportType = Schema.getGlobalDescribe().get('Support__c');
		Map<String,Schema.SObjectField> mfields = SupportType.getDescribe().fields.getMap();
        for(String sField:mfields.keySet()){
            System.debug('mfields.get'+mfields.get(sField));
        }        
    }

    //Fetches and Initializes URL parameters
    private void initParamVars(){
      hasParam = false;
      fetchParamUnitBody();

      try{ fetchParamStartDate();}
      catch(Exception exp){
          System.debug(exp.getMessage());
          startDateTimeFrom = null;}

      try{fetchParamEndDate();}
      catch(Exception exp){
          System.debug(exp.getMessage());
          startDateTimeTo = null;
      }
    }

    //Initializes variables for deciding sorting order
    private void initSortingOrderVars(){
      orderBy= 'Name';
      currentOrder = 'Name';
      orderDesc = false;
    }

    private String getTextValueFromCookie(Map<String, Cookie> cookies, String cookieLabel){
        String returnValue = null;
        if(cookies.containsKey(cookieLabel) && cookies.get(cookieLabel).getValue().length() != 0){
            try{
                returnValue = cookies.get(cookieLabel).getValue();}
            catch(Exception exp){
                System.debug(exp.getMessage());
                returnValue = null;
            }
        }
        System.debug('cookieLabel: ' + cookieLabel + ' returnValue ' + returnValue);
        return returnValue;
    }

    private Integer getIntegerValueFromCookie(Map<String, Cookie> cookies, String cookieLabel, Integer defaultValue){
        Integer returnValue = defaultValue;
        if(cookies.containsKey(cookieLabel) && cookies.get(cookieLabel).getValue().length() != 0){
            try{
                returnValue = Integer.valueOf(cookies.get(cookieLabel).getValue());
            }
            catch(Exception exp){
                System.debug(exp.getMessage());
                returnValue = defaultValue;
            }
        }
        System.debug('cookieLabel: ' + cookieLabel + ' returnValue ' + returnValue);
        return returnValue;
    }


    private Date getstartDateTimeFromCookie(Map<String, Cookie> cookies, String cookieLabel){
        Date returnValue = null;
        if(cookies.containsKey(cookieLabel) && cookies.get(cookieLabel).getValue().length() != 0)
        {
            try{
                returnValue = Date.parse(cookies.get(cookieLabel).getValue());
            }
            catch(Exception exp){
                System.debug(exp.getMessage());
                 return returnValue;
            }
        }
        return returnValue;
    }

    private void initFieldFromCookie() {
        Map<String, Cookie> cookies = Apexpages.currentPage().getCookies();

        PageNo = getIntegerValueFromCookie(cookies,COOKIE_LABEL_PAGE_NUMBER, PageNo);
        PageSize = getIntegerValueFromCookie(cookies,COOKIE_LABEL_PAGE_SIZE, PageSize);

        this.initSearchFlg = getTextValueFromCookie(cookies, COOKIE_LABEL_INIT_SEARCH_FLG);
        
        if(!this.hasParam){
          this.startDateTimeFrom = getstartDateTimeFromCookie(cookies, COOKIE_VALUE_PERIODFROM);
          this.startDateTimeTo = getstartDateTimeFromCookie(cookies, COOKIE_VALUE_PERIODTO);
          this.endDateTimeTo = getstartDateTimeFromCookie(cookies, COOKIE_VALUE_SERVICEENDDATE_TO);
          this.endDateTimeFrom = getstartDateTimeFromCookie(cookies, COOKIE_VALUE_SERVICEENDDATE_FROM);

          this.unitBodyName = getTextValueFromCookie(cookies, COOKIE_VALUE_UNITBODY);
          this.customerContactPerson = getTextValueFromCookie(cookies,COOKIE_VALUE_CUSTOMERCONTACT);
          this.secondSupportPerson = getTextValueFromCookie(cookies,COOKIE_VALUE_SECONDSUPPORT);
        }
    }

    //Returns Date from parsed param date-string
    private Date getParsedDate(String dateString){
        List<String> splits = dateString.split('-');
        if(splits.size() != 3) throw new appException('Date Parameters not in correct format i.e YYYY-MM-DD');
        return Date.newInstance(Integer.valueOf(splits[0]), Integer.valueOf(splits[1]), Integer.valueOf(splits[2]));
    }

    //Fetches UnitBody Param
    private void fetchParamUnitBody(){
        String unitBodyParamVal = ApexPages.currentPage().getParameters().get(unitBodyParameterText);
        if((unitBodyParamVal == null) || (unitBodyParamVal == '')){
            isUnitBodyFieldDisable = false;
        }
        else {
            isUnitBodyFieldDisable = true;
            unitBodyName = unitBodyParamVal;
            hasParam = true;
        }
    }

    //Fetches StartDate Param
    private void fetchParamStartDate(){
        String stDateParamVal = ApexPages.currentPage().getParameters().get(startDateParameterText);
        if(stDateParamVal != null){
            startDateTimeFrom = getParsedDate(stDateParamVal);
            hasParam = true;
        }
    }

     //Fetches EndDate Param
    private void fetchParamEndDate(){
        String endDateParamVal = ApexPages.currentPage().getParameters().get(endDateParameterText);
        if(endDateParamVal != null){
            startDateTimeTo =  getParsedDate(endDateParamVal);
            hasParam = true;
        }
    }

    //Returns 2-digit Month value
    private String getMonth(Date temp){
        String val = (temp.month()/10 < 1)? ('0'+temp.month()): ('' + temp.month());
        return val;}

    //Returns 2-digit Day value
    private String getDay(Date temp){
        String val = (temp.day()/10 < 1)? ('0'+temp.day()): ('' + temp.day());
        return val;}

    //returns true if 'WHERE' clause should be added to main SOQL query
    private Boolean shallSOQLWithWhereClause(){
        if((unitBodyName != null) && (unitBodyName != '') 
            || (startDateTimeTo != null) || (startDateTimeFrom != null)
            || ((customerContactPerson != null) && (customerContactPerson != ''))
            || ((secondSupportPerson != null) && (secondSupportPerson != ''))
            || (endDateTimeTo != null) || (endDateTimeFrom != null)){
            return true;
        }
        else return false;
    }

    protected override void setStandardSetController() {

        //Fetch records
        String soql = ' SELECT ' +
                        'Id,Name, EndDate__c, StartDate__c,Memo__c,Support__c, Support__r.Name, Support__r.UnitBody__c,'+ 
                        'Support__r.CustomerContactPerson__c, ResponcedBy__c'+
            			',PeriodSummary__c,(SELECT AmountSummary__c  FROM OperationHistoryUsedParts__r)'+
                     ' FROM ' +
                          ' OperationHistory__c ';

        //Where clauses
        Boolean useAnd = false;
        if(shallSOQLWithWhereClause()){
            soql+= ' WHERE ';

            //Name restriction
            soql+= ' Name =  \'二次\' AND ';

            //UnitBody input support
            if((unitBodyName != null) && (unitBodyName != '')){
                soql += JEOLUtil.appendAfterLikeText(' Support__r.UnitBody__c', unitBodyName);
                useAnd = true;}

            //Date-to input support
            if(startDateTimeTo != null){
                if(useAnd) soql += ' AND';
                soql += ' StartDate__c <= ' + startDateTimeTo.year() + '-' + getMonth(startDateTimeTo)+ '-' + getDay(startDateTimeTo);
                useAnd = true;}

            //Date-from input support
            if(startDateTimeFrom != null){
                if(useAnd) soql += ' AND';
                soql += ' StartDate__c >= ' + startDateTimeFrom.year() + '-' + getMonth(startDateTimeFrom)+ '-' + getDay(startDateTimeFrom);
                useAnd = true;}

            //serviceEndDate-to input support
            if(endDateTimeTo != null){
                if(useAnd) soql += ' AND';
                soql += ' EndDate__c <= ' + endDateTimeTo.year() + '-' + getMonth(endDateTimeTo)+ '-' + getDay(endDateTimeTo);
                useAnd = true;}

            //serviceEndDate-from input support
            if(endDateTimeFrom != null){
                if(useAnd) soql += ' AND';
                soql += ' EndDate__c >= ' + endDateTimeFrom.year() + '-' + getMonth(endDateTimeFrom)+ '-' + getDay(endDateTimeFrom);
                useAnd = true;}

            //secondSupportPerson support
            if((secondSupportPerson != null) && (secondSupportPerson != '')){
                if(useAnd) soql += ' AND';
                soql += JEOLUtil.appendAfterLikeText(' ResponcedBy__c', secondSupportPerson);
                useAnd = true;}

            //customerContactPerson support
            if((customerContactPerson != null) && (customerContactPerson != '')){
                if(useAnd) soql += ' AND';
                soql += JEOLUtil.appendAfterLikeText(' Support__r.CustomerContactPerson__c', customerContactPerson);
                useAnd = true;}
        }
        //order by
        soql += ' ORDER BY ' + this.orderBy;
        if (this.orderDesc) {
            soql += ' DESC NULLS LAST';
        }

        //limit
        soql += ' LIMIT 10000 ';

        //Validate extracted records
        System.debug('soql: ' + soql);
        ssc = new ApexPages.StandardSetController(Database.getQueryLocator(soql));
        if (ssc.getResultSize() >= 10000 ) {
            ssc = null;
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintSVCHistory_Message_TooMuchData));
            return;
        }
        /*else if(ssc.getResultSize() == 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Label.JEOL_MaintSVCHistory_Message_NoData));
                return;
        }*/
        else{
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);
            initAmountSummaryMap(); //For UnitPartsSummary support: Vaib(2016-03-30)
        }
    }
	
    //For UnitPartsSummary support: Vaib(2016-03-30)
    private void initAmountSummaryMap(){
        amountSummaryMap = new Map<Id,Decimal>();
        if(ssc != null) {
            List<OperationHistory__c> searchedSupportCases = (List<OperationHistory__c>)ssc.getRecords();
            for(OperationHistory__c supportCase:searchedSupportCases){
                Decimal totalAmountSummary = 0;
                if(supportCase == null) continue;
                for(OperationHistoryUsedParts__c usedPart: supportCase.OperationHistoryUsedParts__r){
                    if(usedPart == null) continue;
                    totalAmountSummary += usedPart.AmountSummary__c;
                }
                amountSummaryMap.put(supportCase.Id, totalAmountSummary);
            }
        }
    }
    private String extractParamForQS(String reportName){
        List<ReportFieldDescribe__c> mcs = ReportFieldDescribe__c.getall().values();
        String text_startDateFrom='';
        String text_startDateTo='';
        String text_endDateFrom='';
        String text_endDateTo='';
        String text_unitBodyName='';
        String text_secondSupportPerson='';
        String text_customerContactPerson='';
        String text_startDateId='';
        String text_endDateId='';
        String text_unitBodyNameId='';
        String text_secondSupportPersonId='';
        String text_customerContactPersonId='';
        String queryString='';
        for(ReportFieldDescribe__c df:mcs){
            if(df.Name!=reportName) continue;
                text_startDateId=df.StartDate_TEXT_ID__c;
                text_endDateId=df.EndDate_TEXT_ID__c;
                text_customerContactPersonId=df.Ref_CustomerContactPerson_ID__c;
                text_unitBodyNameId=df.Ref_UnitBody_ID__c;
                text_secondSupportPersonId=df.ResponcedBy_ID__c;
                this.rptID=df.ReportId__c;
        }
        Boolean isConcated=false;
        if(this.startDateTimeFrom!=null){            
            queryString +=(isConcated?'&':'')+'pc0='+text_startDateId+'&pn0=ge&pv0='+String.valueOf(startDateTimeFrom);
            isConcated=true;
        }
        if(this.startDateTimeTo!=null){
            queryString +=(isConcated?'&':'')+'pc1='+text_startDateId+'&pn1=le&pv1='+String.valueOf(startDateTimeTo);
            isConcated=true;
        }
        if(this.endDateTimeFrom!=null){
            queryString +=(isConcated?'&':'')+'pc2='+text_endDateId+'&pn2=ge&pv2='+String.valueOf(endDateTimeFrom);
            isConcated=true;
        }
        if(this.endDateTimeTo!=null){
            queryString +=(isConcated?'&':'')+'pc3='+text_endDateId+'&pn3=le&pv3='+String.valueOf(endDateTimeTo);
            isConcated=true;
        }
        if(!String.isBlank(this.customerContactPerson)){
            queryString +=(isConcated?'&':'')+'pc4='+text_customerContactPersonId+'&pn4=sw&pv4='+customerContactPerson;
            isConcated=true;
        }
        if(!String.isBlank(this.secondSupportPerson)){
            queryString +=(isConcated?'&':'')+'pc5='+text_secondSupportPersonId+'&pn5=sw&pv5='+secondSupportPerson;
            isConcated=true;
        }
        if(!String.isBlank(unitBodyName)){
            queryString +=(isConcated?'&':'')+'pc6='+text_unitBodyNameId+'&pn6=sw&pv6='+unitBodyName;
            isConcated=true;
        }
        return queryString;
    }
    //For opening of report
    public PageReference doRunReport1() {
        string queryString=extractParamForQS('OperationHistoryPeriod_Report__c');
		reportUrl='/'+rptID+'?'+queryString;            
        return null;
    }
    public PageReference doRunReport2() {
        string queryString=extractParamForQS('OperationHistoryUsedParts_Report__c');
		reportUrl='/'+rptID+'?'+queryString; 
        return null;
    }    
    public PageReference doRunReport3() {
     	string queryString=extractParamForQS('OperationHistoryAmount_Report_New__c');
		reportUrl='/'+rptID+'?'+queryString; 
        return null;
    }

    //When Search button is pressed on VFPage
    public void doSearch() {
        this.initSearchFlg = 'true';
        //ページ初期化
        pageNo = 1;
        pageSize = 50;
        initSortingOrderVars();
        
        setStandardSetController();
        saveInputValues();
    }

    //When Clear button is pressed on VFPage
    public void doClear() {
        searchedSupportCases.clear();
        unitBodyName = null; startDateTimeFrom = null; startDateTimeTo = null;
        secondSupportPerson =null; customerContactPerson=null; 
        endDateTimeTo = null; endDateTimeFrom = null;
        isUnitBodyFieldDisable = false;
        
        ssc = null;

        // 画面起動時検索フラグOFF
        this.initSearchFlg = '';

        //ページ初期化
        pageNo = 1;
        pageSize = 50;
        
        saveInputValues();
    }

    //Queries for the VF Page based on the date-range arguments (fetched from VFPage input)
    public List<OperationHistory__c> getSupportContracts()
    {
        if(ssc != null) {
            List<OperationHistory__c> searchedSupportCases = (List<OperationHistory__c>)ssc.getRecords();
            return searchedSupportCases;
        }
        else {
            return new List<OperationHistory__c>();
        }
    }

    //For paging of table
     private void saveInputValues() {
        List<Cookie> cookies = new List<Cookie>();

        addToCookie(pageNo, COOKIE_LABEL_PAGE_NUMBER, cookies);
        addToCookie(pageSize, COOKIE_LABEL_PAGE_NUMBER, cookies);
        addToCookie(this.initSearchFlg, COOKIE_LABEL_INIT_SEARCH_FLG, cookies);

        if(!this.hasParam){
            addToCookie(this.unitBodyName, COOKIE_VALUE_UNITBODY, cookies);
            addToCookie(this.startDateTimeTo, COOKIE_VALUE_PERIODTO, cookies);
            addToCookie(this.startDateTimeFrom, COOKIE_VALUE_PERIODFROM, cookies);
            addToCookie(this.endDateTimeTo, COOKIE_VALUE_SERVICEENDDATE_TO, cookies);
            addToCookie(this.endDateTimeFrom, COOKIE_VALUE_SERVICEENDDATE_FROM, cookies);
            addToCookie(this.customerContactPerson, COOKIE_VALUE_CUSTOMERCONTACT, cookies);
            addToCookie(this.secondSupportPerson, COOKIE_VALUE_SECONDSUPPORT, cookies);
        }
        Apexpages.currentPage().setCookies(cookies);
    }

    private void addToCookie(Integer value, String cookieLabel, List<Cookie> cookies){
        if(value != null)
            cookies.add(new Cookie(cookieLabel, String.valueOf(value), COOKIE_PATH, -1, true));
    }

    private void addToCookie(String value, String cookieLabel, List<Cookie> cookies){
        if(value != null)
            cookies.add(new Cookie(cookieLabel, value, COOKIE_PATH, -1, true));
        else
            cookies.add(new Cookie(cookieLabel, null, COOKIE_PATH, -1, true)); //added to nullify previous cookie value
    }

    private void addToCookie(Date value, String cookieLabel, List<Cookie> cookies){
        if(value != null)
            cookies.add(new Cookie(cookieLabel, value.format(), COOKIE_PATH, -1, true));
        else
            cookies.add(new Cookie(cookieLabel, null, COOKIE_PATH, -1, true)); //added to nullify previous cookie value
    }

     public void setSizeSaveCurrentPageSize() {
        changeSize();
        setCookieCurrentPageSize();
        setCookieCurrentPageNumber();
        initAmountSummaryMap(); //For UnitPartsSummary support: Vaib(2016-03-30)
    }

    private void setCookieCurrentPageNumber() {
        if (ssc != null) {
            Apexpages.currentPage().setCookies(new List<Cookie>{new Cookie(COOKIE_LABEL_PAGE_NUMBER, String.valueOf(ssc.getPageNumber()), COOKIE_PATH, -1, true)});
        }
    }
    private void setCookieCurrentPageSize() {
        if (ssc != null) {
            Apexpages.currentPage().setCookies(new List<Cookie>{new Cookie(COOKIE_LABEL_PAGE_SIZE, String.valueOf(ssc.getPageSize()), COOKIE_PATH, -1, true)});
        }
    }

    public void nextAndSaveCurrentPageNumber() {
        next();
        setCookieCurrentPageNumber();
        initAmountSummaryMap();//For UnitPartsSummary support: Vaib(2016-03-30)
    }
    public void previousAndSaveCurrentPageNumber() {
        previous();
        setCookieCurrentPageNumber();
        initAmountSummaryMap();//For UnitPartsSummary support: Vaib(2016-03-30)
    }
    public void firstAndSaveCurrentPageNumber() {
        first();
        setCookieCurrentPageNumber();
        initAmountSummaryMap();//For UnitPartsSummary support: Vaib(2016-03-30)
    }
    public void lastAndSaveCurrentPageNumber() {
        last();
        setCookieCurrentPageNumber();
        initAmountSummaryMap();//For UnitPartsSummary support: Vaib(2016-03-30)
    }
    public void setJumpSaveCurrentPageSize() {
        jump();
        setCookieCurrentPageSize();
        setCookieCurrentPageNumber();
        initAmountSummaryMap();//For UnitPartsSummary support: Vaib(2016-03-30)
    }
}