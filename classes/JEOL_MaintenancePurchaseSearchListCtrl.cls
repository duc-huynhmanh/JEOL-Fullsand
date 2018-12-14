public with sharing class JEOL_MaintenancePurchaseSearchListCtrl extends JEOL_SearchBase_ctrl  {
    
    //VFPage binded properties
    public String purchasingOffice {get;set;}
    public String supplierCustomerCode{get;set;}
    public String paymentType {get;set;}
    public String unitBodyNumber {get;set;}
    public String scheduledDeliverDate{get;set;}
    public Date contractStartDateFrom {get;set;}
    public Date contractStartDateTo {get;set;}
    public Date contractEndDateFrom {get;set;}
    public Date contractEndDateTo {get;set;}
    public String shippingCustomerName {get;set;}
    public String isAcceptanceSettled {get;set;}

    private List<String> targetRegions;
    public List<OptionDetail> RegionsOptions{get; set;}

    public Map<String, String> mapRegionName { get; set; }

    //For storing paging-preference of the user in cookies, for searched table
    private static final String COOKIE_LABEL_PAGE_NUMBER = 'PageNumber';
    private static final String COOKIE_LABEL_PAGE_SIZE = 'PageSize';
    private static final String COOKIE_PATH = '/apex/JEOL_MaintenancePurchaseSearchListPage';
    private static final String COOKIE_LABEL_INIT_SEARCH_FLG = 'initSearchFlg';  // 画面起動時検索フラグ

    //For storing user-entered values in cookies
    private static final String COOKIE_VALUE_PURCHASING_OFFICE = 'PurchasingOfficeVal';
    private static final String COOKIE_VALUE_SHIPTO_CUSTOMER = 'ShipToCustomerVal';
    private static final String COOKIE_VALUE_SUPPLIERCUSTOMER_CODE = 'SupplierCustomerCodeVal';
    private static final String COOKIE_VALUE_PAYMENT_TYPE = 'PaymentTypeVal';
    private static final String COOKIE_VALUE_UNITBODY_NUMBER = 'UnitBodyNumberVal';
    private static final String COOKIE_VALUE_MAINTENANCE_CONTRACTSTARTDATE_FROM = 'MaintenanceContractStartDateFromVal';
    private static final String COOKIE_VALUE_MAINTENANCE_CONTRACTSTARTDATE_TO = 'MaintenanceContractStartDateToVal';
    private static final String COOKIE_VALUE_MAINTENANCE_CONTRACTENDDATE_FROM = 'MaintenanceContractEndDateFromVal';
    private static final String COOKIE_VALUE_MAINTENANCE_CONTRACTENDDATE_TO = 'MaintenanceContractEndDateToVal';
    private static final String COOKIE_VALUE_SCHEDULED_DELIVERYDATE  = 'ScheduledDeliveryDateVal';
    private static final String COOKIE_VALUE_ISACCEPTANCESETTLED = 'IsAcceptanceSettled';
    private static final String COOKIE_LABEL_TARGETREGIONS = 'JEOL_MaintenanceInspectionList_TargetRegions';

    private List<SelectListManage__c> lsRegion;

    //Payment types
    public String paymentTypeBLANK {
        get{return JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeBLANK;}
    }
    public String paymentTypeNR {
        get{return JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeNR;}
    }
    public String paymentTypeNS {
        get{return JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeNS;}
    }
    public String paymentTypeHELIUM {
        get{return JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM;}
    }
    //

    public List<SelectOption> getIsAcceptanceSettledOptions() {
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', ''));
        options.add(new SelectOption('Yes', '検収済'));
        options.add(new SelectOption('No', '未検収'));    
        return options;
    }

    public void regionsSelectCancel() {
        List<OptionDetail> regionsOptions = this.RegionsOptions;
        for (OptionDetail detail: RegionsOptions) {
            detail.cancel();
        }
    }

    public void RegionsSelectApply() {
        Set<String> regions = new Set<String>();
        List<OptionDetail> regionsOptions = this.RegionsOptions;
        for (OptionDetail detail: regionsOptions) {
            detail.apply();
            if (detail.isSelected) {
                regions.add(detail.option.getValue());
            }
        }
        targetRegions = new List<String>(regions);
    }

    public void regionsSelectAllSelect() {
        List<OptionDetail> regionsOptions = this.RegionsOptions;
        for (OptionDetail detail: regionsOptions) {
            detail.isSelected = true;
        }
    }

    public void regionsSelectAllDeselect() {
        List<OptionDetail> regionsOptions = this.RegionsOptions;
        for (OptionDetail detail: regionsOptions) {
            detail.isSelected = false;
        }
    }
    
    public String getSelectedRegions() {
        String value = 'なし';
        Integer selectedCount = 0;
        Set<String> regions = new Set<String>();
        for (OptionDetail detail: this.RegionsOptions) {
            if (detail.isSelected) {
                regions.add(detail.option.getLabel());
                selectedCount++;
            }
        }
        if (selectedCount == this.RegionsOptions.size()) {
            value = 'すべて';
        } else if (regions.size() > 0) {
            value = String.join(new List<String>(regions), ', ');
        }
        return value;
    }


    private String initSearchFlg = '';
    //
    public class appException extends Exception {}

    public JEOL_MaintenancePurchaseSearchListCtrl() {

        lsRegion = [SELECT id, Value__c, Label__c from SelectListManage__c where ReferenceName__c = :JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA];

        //mpm = new MaintenancePurchaseManagement__c();
        initSortingOrderVars();
        //Read and Parse values in Cookies
        initFieldFromCookie();


        List<optionDetail> regionsOptions = new List<optionDetail>();
        Set<String> regions;
        if (this.targetRegions != null) {
            regions = new Set<String>(this.targetRegions);
        }
        for (SelectOption option: JEOLUtil.getSelectList(false, JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA)) {
            Boolean isSelected = false;
            if (regions != null) {
                isSelected = regions.contains(option.getValue());
            }
            regionsOptions.add(new OptionDetail(option, isSelected)); 
        }
        this.regionsOptions = regionsOptions;


        Boolean hasSearchValues = (this.initSearchFlg == 'true') ? true : false;
        if(hasSearchValues) //should search if cookies are present or params are passed
            setStandardSetController();
    }

    //When Search button is pressed on VFPage
    public void doSearch() {
        this.initSearchFlg = 'true';

        setStandardSetController();
        saveInputValuesInCookies();    }

    //When Clear button is pressed on VFPage
    public void doClear() {

        //clear properties
        this.initSearchFlg = '';
        this.contractStartDateFrom = null;
        this.contractStartDateTo = null;
        this.contractEndDateFrom = null;
        this.contractEndDateTo = null;
        this.scheduledDeliverDate = null;

        this.purchasingOffice = null;
        this.paymentType = null;
        this.purchasingOffice = null;
        this.shippingCustomerName = null;
        //this.mpm.ShipmentCustomerAccount__c = null;

        this.targetRegions = null;
        for (OptionDetail detail: this.RegionsOptions) {
            detail.setSelected(false);
        }

        ssc = null;
        // 画面起動時検索フラグOFF
        this.initSearchFlg = '';
        //ページ初期化
        pageNo = 1;
        pageSize = 50;
        saveInputValuesInCookies();
    }


    private String addWhereClauses(String soql){
        Boolean useAnd = false;

        //Purchasing office
        if((purchasingOffice != null) && (purchasingOffice != '')){
            if(!useAnd) soql += ' WHERE ';
            soql += JEOLUtil.appendAfterLikeText(' PurchasingOffice__c', purchasingOffice);
            useAnd = true;
        }

        //Supplier code
        if((supplierCustomerCode != null) && (supplierCustomerCode != '')){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += JEOLUtil.appendAfterLikeText(' SupplierCustomerCode__c', supplierCustomerCode);
            useAnd = true;
        }

        //Payment type
        if((paymentType != null) && (paymentType != paymentTypeBLANK)){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += JEOLUtil.appendEqualText(' PaymentType__c', paymentType);
            useAnd = true;
        }

        //UnitBody
        if((unitBodyNumber != null) && (unitBodyNumber != '')){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += JEOLUtil.appendAfterLikeText(' UnitBodyNumber__c', unitBodyNumber);
            useAnd = true;
        }

        //Region name
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += JEOLUtil.appendInText('RegionName__c', this.targetRegions);
            useAnd = true;
        }

        //Customer name
        if((shippingCustomerName != null) && (shippingCustomerName != '')){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += JEOLUtil.appendLikeText(' ShipmentCustomerAccount__c', shippingCustomerName);
            useAnd = true;
        }

        //isAcceptanceSettled
        if((isAcceptanceSettled != null) && (isAcceptanceSettled != '')){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += JEOLUtil.appendAfterLikeText('isAcceptanceSettled__c', isAcceptanceSettled);
            useAnd = true;
        }

        //Delivery date
        if((scheduledDeliverDate != null) && (scheduledDeliverDate != '')){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += '(WarehousePlanningMonth__c != null AND WarehousePlanningMonth__c <= \'' + (String.escapeSingleQuotes(scheduledDeliverDate) + '999999').substring(0, 6) + '\')';
            useAnd = true;
        }

        //Contract Start Date
        if(contractStartDateFrom != null){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += ' MaintenanceContractPeriodStart__c >= ' + String.valueOf(contractStartDateFrom) ;
            useAnd = true;
        }
        if(contractStartDateTo != null){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += ' MaintenanceContractPeriodStart__c <= ' + String.valueOf(contractStartDateTo); 
            useAnd = true;
        }

        //Contract End Date
        if(contractEndDateFrom != null){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += ' MaintenanceContractPeriodEnd__c >= ' + String.valueOf(contractEndDateFrom) ;
            useAnd = true;
        }
        if(contractEndDateTo != null){
            if(!useAnd) soql += ' WHERE '; else soql += ' AND ';
            soql += ' MaintenanceContractPeriodEnd__c <= ' + String.valueOf(contractEndDateTo); 
            useAnd = true;
        }

        return soql;
    }

    //
    protected override void setStandardSetController() {

        //basic query string
        String soql = ' SELECT ' 
                    + '   Id,Name,PurchasingOffice__c,ShipmentCustomerAccount__c,SupplierCustomerCode__c,PaymentType__c,UnitBodyNumber__c'
                    + '   ,RegionName__c,MaintenanceContractPeriod__c,PurchasingOrder__c,WarehousePlanningDate__c '
                    + '   ,HeliumFillingImplementationDate__c,NSNRInspectionImplementationDate__c,NSRegularInspectionImplementationDate__c,ProductNumber__c'
                    + ' FROM '
                    + '   MaintenancePurchaseManagement__c ';

        //where
        soql = addWhereClauses(soql);

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
        else if(ssc.getResultSize() == 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Label.JEOL_MaintSVCHistory_Message_NoData));
                return;
        } else{
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);
        }


        mapRegionName = new Map<String, String>();
        
        if(ssc != null) {
            for (MaintenancePurchaseManagement__c row : (List<MaintenancePurchaseManagement__c>)ssc.getRecords()) {
                mapRegionName.put(row.RegionName__c, row.RegionName__c);
            }
        }
        
        for (SelectListManage__c reg : lsRegion) {
            mapRegionName.put(reg.Value__c, reg.Label__c);        
        }


    }

    //returns filtered search-records to VF-page
    public List<MaintenancePurchaseManagement__c> getSearchedRecords()
    {
        if(ssc != null) {
            List<MaintenancePurchaseManagement__c> searchedSupportCases = (List<MaintenancePurchaseManagement__c>)ssc.getRecords();
            return searchedSupportCases;
        }
        else {
            return new List<MaintenancePurchaseManagement__c>();
        }
    }
  
    //Initializes variables for deciding sorting order
    private void initSortingOrderVars(){
      //orderBy= 'ReceptionDate__c';
      //currentOrder = 'ReceptionDate__c';
      orderBy= 'Name';
      currentOrder = 'Name';
      orderDesc = false;
    }

    //For paging of table
     private void saveInputValuesInCookies() {
        List<Cookie> cookies = new List<Cookie>();

        addToCookie(pageNo, COOKIE_LABEL_PAGE_NUMBER, cookies);
        addToCookie(pageSize, COOKIE_LABEL_PAGE_NUMBER, cookies);
        addToCookie(this.initSearchFlg, COOKIE_LABEL_INIT_SEARCH_FLG, cookies);

        addToCookie(this.purchasingOffice, COOKIE_VALUE_PURCHASING_OFFICE, cookies);
        addToCookie(this.shippingCustomerName, COOKIE_VALUE_SHIPTO_CUSTOMER, cookies);
        addToCookie(this.paymentType, COOKIE_VALUE_PAYMENT_TYPE, cookies);
        addToCookie(this.unitBodyNumber, COOKIE_VALUE_UNITBODY_NUMBER, cookies);
        addToCookie(this.contractStartDateFrom, COOKIE_VALUE_MAINTENANCE_CONTRACTSTARTDATE_FROM, cookies);
        addToCookie(this.contractStartDateTo, COOKIE_VALUE_MAINTENANCE_CONTRACTSTARTDATE_TO, cookies);
        addToCookie(this.contractEndDateFrom, COOKIE_VALUE_MAINTENANCE_CONTRACTENDDATE_FROM, cookies);
        addToCookie(this.contractEndDateTo, COOKIE_VALUE_MAINTENANCE_CONTRACTENDDATE_TO, cookies);
        addToCookie(this.scheduledDeliverDate, COOKIE_VALUE_SCHEDULED_DELIVERYDATE, cookies);
        addToCookie(this.isAcceptanceSettled, COOKIE_VALUE_ISACCEPTANCESETTLED, cookies);

        String targetRegionsText = '';
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            targetRegionsText = String.join(this.targetRegions, '&&');
        }
        cookies.add(new Cookie(COOKIE_LABEL_TARGETREGIONS, targetRegionsText, COOKIE_PATH, -1, true));

        Apexpages.currentPage().setCookies(cookies);
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

    private Date getDateValueFromCookie(Map<String, Cookie> cookies, String cookieLabel){
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

    private void initFieldFromCookie() {
        Map<String, Cookie> cookies = Apexpages.currentPage().getCookies();

        PageNo = getIntegerValueFromCookie(cookies,COOKIE_LABEL_PAGE_NUMBER, PageNo);
        PageSize = getIntegerValueFromCookie(cookies,COOKIE_LABEL_PAGE_SIZE, PageSize);

        this.initSearchFlg = getTextValueFromCookie(cookies, COOKIE_LABEL_INIT_SEARCH_FLG);

        this.contractStartDateFrom = getDateValueFromCookie(cookies, COOKIE_VALUE_MAINTENANCE_CONTRACTSTARTDATE_FROM);
        this.contractStartDateTo = getDateValueFromCookie(cookies, COOKIE_VALUE_MAINTENANCE_CONTRACTSTARTDATE_TO);
        this.contractEndDateFrom = getDateValueFromCookie(cookies, COOKIE_VALUE_MAINTENANCE_CONTRACTENDDATE_FROM);
        this.contractEndDateTo = getDateValueFromCookie(cookies, COOKIE_VALUE_MAINTENANCE_CONTRACTENDDATE_TO);
        this.scheduledDeliverDate = getTextValueFromCookie(cookies, COOKIE_VALUE_SCHEDULED_DELIVERYDATE);

        this.purchasingOffice = getTextValueFromCookie(cookies, COOKIE_VALUE_PURCHASING_OFFICE);
        this.paymentType = getTextValueFromCookie(cookies, COOKIE_VALUE_PAYMENT_TYPE);
        this.purchasingOffice = getTextValueFromCookie(cookies, COOKIE_VALUE_PURCHASING_OFFICE);
        this.shippingCustomerName = getTextValueFromCookie(cookies,COOKIE_VALUE_SHIPTO_CUSTOMER);
        //this.mpm.ShipmentCustomerAccount__c = getTextValueFromCookie(cookies,COOKIE_VALUE_SHIPTO_CUSTOMER);

        if (cookies.containsKey(COOKIE_LABEL_TARGETREGIONS)) {
            String targetRegionsText = cookies.get(COOKIE_LABEL_TARGETREGIONS).getValue();
            if (String.isNotBlank(targetRegionsText)) {
                this.targetRegions = targetRegionsText.split('&&');
            }
        }   

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
    }
    public void previousAndSaveCurrentPageNumber() {
        previous();
        setCookieCurrentPageNumber();
    }
    public void firstAndSaveCurrentPageNumber() {
        first();
        setCookieCurrentPageNumber();
    }
    public void lastAndSaveCurrentPageNumber() {
        last();
        setCookieCurrentPageNumber();
    }
    public void setJumpSaveCurrentPageSize() {
        jump();
        setCookieCurrentPageSize();
        setCookieCurrentPageNumber();
    }

    public class OptionDetail {
        public Boolean isSelected{get; set;}
        public Boolean beforeSelected{get; set;}
        public SelectOption option{get; set;}
        public String val{get; set;}
        public OptionDetail(SelectOption option, Boolean isSelected) {
            this.option = option;
            this.isSelected = isSelected;
            this.beforeSelected = this.isSelected;
        }
        
        public void cancel() {
            this.isSelected = this.beforeSelected;
        }

        public void apply() {
            this.beforeSelected = this.isSelected;
        }
        
        public void setSelected(Boolean isSelected) {
            this.isSelected = isSelected;
            this.beforeSelected = this.isSelected;
        }
    }
    
}