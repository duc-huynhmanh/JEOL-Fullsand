public with sharing class JEOL_MaintenanceListNew_ctrl extends JEOL_SearchBase_ctrl {
    
    public String customerCode{get; set;}
    public String customerName{get; set;}
    public String custCodeType{get; set;}
    public String custNameType{get; set;}
    public String salesResponsible{get; set;}
    public String shipmentAddress{get; set;}
    public String unitBody{get; set;}
    public String inquiryRepayment{get; set;}
    public String shippingDateYearFrom{get; set;}
    public String shippingDateYearTo{get; set;}
    public String inquiryMaintenancePossibility{get; set;}
    public String acceptanceDateYearFrom{get; set;}
    public String acceptanceDateYearTo{get; set;}
    public String inquiryQuotation{get; set;}
    public String existLastActivityDate{get; set;}
    public Date lastActivityDateFrom{get; set;}
    public Date lastActivityDateTo{get; set;}
    public Date quotationSentDateFrom{get; set;}
    public Date quotationSentDateTo{get; set;}
    public Date periodFrom{get; set;}
    public Date periodTo{get; set;}
    public String orderProbabilityFrom{get; set;}
    public String orderProbabilityTo{get; set;}


    private List<String> targetSeries;
    public List<OptionDetail> SeriesOptions{get; set;}
    private List<String> targetRegions;
    public List<OptionDetail> RegionsOptions{get; set;}

    public String lastSearchTargetSeries{get; set;}
    public String lastSearchTargetRegions{get; set;}
    
    public String lastSearchCustomerCode{get; set;}
    public String lastSearchCustomerName{get; set;}
    public String lastSearchCustCodeType{get; set;}
    public String lastSearchCustNameType{get; set;}
    public String lastSearchSalesResponsible{get; set;}
    public String lastSearchShipmentAddress{get; set;}
    public String lastSearchUnitBody{get; set;}
    public String lastSearchInquiryRepayment{get; set;}
    public String lastSearchShippingDateYearFrom{get; set;}
    public String lastSearchShippingDateYearTo{get; set;}
    public String lastSearchInquiryMaintenancePossibility{get; set;}
    public String lastSearchAcceptanceDateYearFrom{get; set;}
    public String lastSearchAcceptanceDateYearTo{get; set;}
    public String lastSearchInquiryQuotation{get; set;}
    public String lastSearchExistLastActivityDate{get; set;}
    public Date lastSearchLastActivityDateFrom{get; set;}
    public Date lastSearchLastActivityDateTo{get; set;}
    public Date lastSearchQuotationSentDateFrom{get; set;}
    public Date lastSearchQuotationSentDateTo{get; set;}
    public Date lastSearchPeriodFrom{get; set;}
    public Date lastSearchPeriodTo{get; set;}
    public String lastSearchOrderProbabilityFrom{get; set;}
    public String lastSearchOrderProbabilityTo{get; set;}

    public boolean hasPermissionExcelOutput{get; set;}
       
    public id dataId{get; set;}
    List<id> lsIdChecked = new List<id>();
    public Map<String, String> mapRegionName { get; set; }

    private static final String COOKIE_LABEL_CUSTOMERCODE = 'JEOL_MaintenanceListNew_CustomerCode';
    private static final String COOKIE_LABEL_CUSTOMERNAME = 'JEOL_MaintenanceListNew_CustomerName';
    private static final String COOKIE_LABEL_CUSTCODETYPE = 'JEOL_MaintenanceListNew_CustCodeType';
    private static final String COOKIE_LABEL_CUSTNAMETYPE = 'JEOL_MaintenanceListNew_CustNameType';
    private static final String COOKIE_LABEL_SALESRESPONSIBLE = 'JEOL_MaintenanceListNew_SalesResponsible';
    private static final String COOKIE_LABEL_SHIPMENTADDRESS = 'JEOL_MaintenanceListNew_ShipmentAddress';
    private static final String COOKIE_LABEL_UNITBODY = 'JEOL_MaintenanceListNew_UnitBody';
    private static final String COOKIE_LABEL_INQUIRYREPAYMENT = 'JEOL_MaintenanceListNew_InquiryRepayment';
    private static final String COOKIE_LABEL_SHIPPINGDATEYEARFROM = 'JEOL_MaintenanceListNew_ShippingDateYearFrom';
    private static final String COOKIE_LABEL_SHIPPINGDATEYEARTO = 'JEOL_MaintenanceListNew_ShippingDateYearTo';
    private static final String COOKIE_LABEL_INQUIRYMAINTENANCEPOSSIBILITY = 'JEOL_MaintenanceListNew_InquiryMaintenancePossibility';
    private static final String COOKIE_LABEL_ACCEPTANCEDATEYEARFROM = 'JEOL_MaintenanceListNew_AcceptanceDateYearFrom';
    private static final String COOKIE_LABEL_ACCEPTANCEDATEYEARTO = 'JEOL_MaintenanceListNew_AcceptanceDateYearTo';
    private static final String COOKIE_LABEL_INQUIRYQUOTATION = 'JEOL_MaintenanceListNew_InquiryQuotation';
    private static final String COOKIE_LABEL_EXISTLASTACTIVITYDATE = 'JEOL_MaintenanceListNew_ExistLastActivityDate';
    private static final String COOKIE_LABEL_LASTACTIVITYDATEFROM = 'JEOL_MaintenanceListNew_LastActivityDateFrom';
    private static final String COOKIE_LABEL_LASTACTIVITYDATETO = 'JEOL_MaintenanceListNew_LastActivityDateTo';
    private static final String COOKIE_LABEL_QUOTATIONSENTDATEFROM = 'JEOL_MaintenanceListNew_QuotationSentDateFrom';
    private static final String COOKIE_LABEL_QUOTATIONSENTDATETO = 'JEOL_MaintenanceListNew_QuotationSentDateTo';
    private static final String COOKIE_LABEL_PERIODFROM = 'JEOL_MaintenanceListNew_PeriodFrom';
    private static final String COOKIE_LABEL_PERIODTO = 'JEOL_MaintenanceListNew_PeriodTo';
    private static final String COOKIE_LABEL_ORDERPROBABILITYFROM = 'JEOL_MaintenanceListNew_OrderProbabilityFrom';
    private static final String COOKIE_LABEL_ORDERPROBABILITYTO = 'JEOL_MaintenanceListNew_OrderProbabilityTo';

    private static final String COOKIE_LABEL_TARGETSERIES = 'JEOL_MaintenanceListNew_TargetSeries';
    private static final String COOKIE_LABEL_TARGETREGIONS = 'JEOL_MaintenanceListToRenew_TargetRegions';


    

    
    private static final String COOKIE_LABEL_PAGE_NUMBER = 'PageNumber';
    private static final String COOKIE_LABEL_PAGE_SIZE = 'PageSize';
    private static final String COOKIE_PATH = '/apex/JEOL_MaintenanceListNew';
    private static final String COOKIE_LABEL_INIT_SEARCH_FLG = 'initSearchFlg';  // 画面起動時検索フラグ

    public AggregateResult bookTotal{get; set;}

    private List<SelectListManage__c> lsRegion;
    
    List<rowWrapper> rows = new List<rowWrapper>();

    // 顧客カテゴリ選択リスト値取得
    public List<SelectOption> getCCategoryOptions() {
        return JEOLUtil.getCategoryNameOptions();
    }
    
    public List<SelectOption> getRegionOptions() {
        return JEOLUtil.getSelectList(JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA);
    }
    
    public List<SelectOption> getListAccountTypeName() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('1', '販売先'));
        options.add(new SelectOption('2', '出荷先名称'));
        return options;

    }

    public List<SelectOption> getListAccountTypeCode() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('1', '販売先'));
        options.add(new SelectOption('2', '出荷先コード'));
        return options;

    }

    public List<SelectOption> getListInquiryRepayment() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', ''));
        options.add(new SelectOption('1', '有'));
        options.add(new SelectOption('2', '無'));
        options.add(new SelectOption('0', '未設定'));
        return options;

    }

    public List<SelectOption> getListInquiryMaintenancePossibility() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', ''));
        options.add(new SelectOption('1', '有'));
        options.add(new SelectOption('2', '無'));
        options.add(new SelectOption('0', '未設定'));
        return options;

    }

    public List<SelectOption> getListInquiryQuotation() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', ''));
        options.add(new SelectOption('1', '要'));
        options.add(new SelectOption('2', '無'));
        options.add(new SelectOption('0', '未設定'));
        return options;

    }

    public List<SelectOption> getListExistLastActivityDate() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', ''));
        options.add(new SelectOption('1', '有'));
        options.add(new SelectOption('2', '無'));
        return options;

    }
    
    public void seriesSelectCancel() {
        List<OptionDetail> seriesOptions = this.SeriesOptions;
        for (OptionDetail detail: seriesOptions) {
            detail.cancel();
        }
    }

    public void seriesSelectApply() {
        Set<String> series = new Set<String>();
        List<OptionDetail> seriesOptions = this.SeriesOptions;
        for (OptionDetail detail: seriesOptions) {
            detail.apply();
            if (detail.isSelected) {
                series.add(detail.option.getValue());
            }
        }
        targetSeries = new List<String>(series);
    }

    public void seriesSelectAllSelect() {
        List<OptionDetail> seriesOptions = this.SeriesOptions;
        for (OptionDetail detail: seriesOptions) {
            detail.isSelected = true;
        }
    }

    public void seriesSelectAllDeselect() {
        List<OptionDetail> seriesOptions = this.SeriesOptions;
        for (OptionDetail detail: seriesOptions) {
            detail.isSelected = false;
        }
    }
    
    public String getSelectedSeries() {
        String value = 'なし';
        Integer selectedCount = 0;
        Set<String> series = new Set<String>();
        for (OptionDetail detail: this.SeriesOptions) {
            if (detail.isSelected) {
                series.add(detail.option.getLabel());
                selectedCount++;
            }
        }
        if (selectedCount == this.SeriesOptions.size()) {
            value = 'すべて';
        } else if (series.size() > 0) {
            value = String.join(new List<String>(series), ', ');
        }
        return value;
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
    

        
    // 画面起動時検索フラグ（'true'の場合に検索する）
    private String initSearchFlg = '';

    // エラーフラグ
    private Boolean errFlg = false;

    public JEOL_MaintenanceListNew_ctrl() {

        // Forbid the button if the user has not the adequate permission set and ia not an admin
        hasPermissionExcelOutput = true;
        Profile p = [Select Name from Profile where Id =: userinfo.getProfileid()];
        if (p.Name != 'System Admin' && 
            p.Name != 'System Administrator' && 
            p.Name != 'システム管理者' 
           ) {

            List<PermissionSetAssignment> lsPerm = [SELECT PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId() AND PermissionSet.Name = 'Maintenance_PermSet_02'];
            if (lsPerm == NULL || lsPerm.size() == 0) {
                hasPermissionExcelOutput = false;
            }
                
        }
        
        lsRegion = [SELECT id, Value__c, Label__c from SelectListManage__c where ReferenceName__c = :JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA];
        orderBy= 'name';
        currentOrder = 'name';
        orderDesc = false;
        Boolean hasSearchValue = initFieldFromCookie();

        List<optionDetail> seriesOptions = new List<optionDetail>();
        Set<String> series;
        if (this.targetSeries != null) {
            series = new Set<String>(this.targetSeries);
        }

        List<SelectOption> options = new List<SelectOption>();
            
        Schema.DescribeFieldResult fieldResult = MaintenanceContractManagement__c.NewOdrSeries__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple)
        {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       

        for (SelectOption option: options) { //JEOLUtil.getSelectList(false, JEOLUtil.REFERENCE_NAME_SERIES)
            Boolean isSelected = false;
            if (series != null) {
                isSelected = series.contains(option.getValue());
            }
            seriesOptions.add(new OptionDetail(option, isSelected)); 
        }
        this.seriesOptions = seriesOptions;
        
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
        
        if (hasSearchValue) {
            setStandardSetController();
        }
        
    }
    
    private Boolean initFieldFromCookie() {

        this.custCodeType = '1';
        this.custNameType = '1';
        
        Map<String, Cookie> cookies = Apexpages.currentPage().getCookies();
        Boolean hasSearchValues = false;
        if (cookies.containsKey(COOKIE_LABEL_CUSTOMERCODE)) {
            this.customerCode = cookies.get(COOKIE_LABEL_CUSTOMERCODE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_CUSTOMERNAME)) {
            this.customerName = cookies.get(COOKIE_LABEL_CUSTOMERNAME).getValue();
        }

        if (cookies.containsKey(COOKIE_LABEL_CUSTCODETYPE)) {
            this.custCodeType = cookies.get(COOKIE_LABEL_CUSTCODETYPE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_CUSTNAMETYPE)) {
            this.custNameType = cookies.get(COOKIE_LABEL_CUSTNAMETYPE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_SALESRESPONSIBLE)) {
            this.salesResponsible = cookies.get(COOKIE_LABEL_SALESRESPONSIBLE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_SHIPMENTADDRESS)) {
            this.shipmentAddress = cookies.get(COOKIE_LABEL_SHIPMENTADDRESS).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_UNITBODY)) {
            this.UnitBody = cookies.get(COOKIE_LABEL_UNITBODY).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_INQUIRYREPAYMENT)) {
            this.inquiryRepayment = cookies.get(COOKIE_LABEL_INQUIRYREPAYMENT).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_SHIPPINGDATEYEARFROM)) {
            this.shippingDateYearFrom = cookies.get(COOKIE_LABEL_SHIPPINGDATEYEARFROM).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_SHIPPINGDATEYEARTO)) {
            this.shippingDateYearTo = cookies.get(COOKIE_LABEL_SHIPPINGDATEYEARTO).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_INQUIRYMAINTENANCEPOSSIBILITY)) {
            this.inquiryMaintenancePossibility = cookies.get(COOKIE_LABEL_INQUIRYMAINTENANCEPOSSIBILITY).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_ACCEPTANCEDATEYEARFROM)) {
            this.acceptanceDateYearFrom = cookies.get(COOKIE_LABEL_ACCEPTANCEDATEYEARFROM).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_ACCEPTANCEDATEYEARTO)) {
            this.acceptanceDateYearTo = cookies.get(COOKIE_LABEL_ACCEPTANCEDATEYEARTO).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_INQUIRYQUOTATION)) {
            this.inquiryQuotation = cookies.get(COOKIE_LABEL_INQUIRYQUOTATION).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_EXISTLASTACTIVITYDATE)) {
            this.existLastActivityDate = cookies.get(COOKIE_LABEL_EXISTLASTACTIVITYDATE).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_LASTACTIVITYDATEFROM)) {
            try{
                this.lastActivityDateFrom = Date.parse(cookies.get(COOKIE_LABEL_LASTACTIVITYDATEFROM).getValue());
            } catch(Exception ex){
            }
        }  
        if (cookies.containsKey(COOKIE_LABEL_LASTACTIVITYDATETO)) {
            try{
                this.lastActivityDateTo = Date.parse(cookies.get(COOKIE_LABEL_LASTACTIVITYDATETO).getValue());
            } catch(Exception ex){
            }
        }  
        if (cookies.containsKey(COOKIE_LABEL_QUOTATIONSENTDATEFROM)) {
            try{
                this.quotationSentDateFrom = Date.parse(cookies.get(COOKIE_LABEL_QUOTATIONSENTDATEFROM).getValue());
            } catch(Exception ex){
            }
        }  
        if (cookies.containsKey(COOKIE_LABEL_QUOTATIONSENTDATETO)) {
            try{
                this.quotationSentDateTo = Date.parse(cookies.get(COOKIE_LABEL_QUOTATIONSENTDATETO).getValue());
            } catch(Exception ex){
            }
        }  
        if (cookies.containsKey(COOKIE_LABEL_PERIODFROM)) {
            try{
                this.periodFrom = Date.parse(cookies.get(COOKIE_LABEL_PERIODFROM).getValue());
            } catch(Exception ex){
            }
        }  
        if (cookies.containsKey(COOKIE_LABEL_PERIODTO)) {
            try{
                this.periodTo = Date.parse(cookies.get(COOKIE_LABEL_PERIODTO).getValue());
            } catch(Exception ex){
            }
        }  

        if (cookies.containsKey(COOKIE_LABEL_ORDERPROBABILITYFROM)) {
            this.orderProbabilityFrom = cookies.get(COOKIE_LABEL_ORDERPROBABILITYFROM).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_ORDERPROBABILITYTO)) {
            this.orderProbabilityTo = cookies.get(COOKIE_LABEL_ORDERPROBABILITYTO).getValue();
        }


        if (cookies.containsKey(COOKIE_LABEL_TARGETSERIES)) {
            String targetSeriesText = cookies.get(COOKIE_LABEL_TARGETSERIES).getValue();
            if (String.isNotBlank(targetSeriesText)) {
                this.targetSeries = targetSeriesText.split('&&');
            }
        }    
        if (cookies.containsKey(COOKIE_LABEL_TARGETREGIONS)) {
            String targetRegionsText = cookies.get(COOKIE_LABEL_TARGETREGIONS).getValue();
            if (String.isNotBlank(targetRegionsText)) {
                this.targetRegions = targetRegionsText.split('&&');
            }
        }    
            
        if(cookies.containsKey(COOKIE_LABEL_PAGE_NUMBER) && cookies.get(COOKIE_LABEL_PAGE_NUMBER).getValue().length() != 0){
            PageNo = Integer.valueOf(cookies.get(COOKIE_LABEL_PAGE_NUMBER).getValue());
        }
        if(cookies.containsKey(COOKIE_LABEL_PAGE_SIZE) && cookies.get(COOKIE_LABEL_PAGE_SIZE).getValue().length() != 0){
            PageSize = Integer.valueOf(cookies.get(COOKIE_LABEL_PAGE_SIZE).getValue());
        }
        if(cookies.containsKey(COOKIE_LABEL_INIT_SEARCH_FLG) && cookies.get(COOKIE_LABEL_INIT_SEARCH_FLG).getValue().length() != 0){
            this.initSearchFlg = cookies.get(COOKIE_LABEL_INIT_SEARCH_FLG).getValue();
            hasSearchValues = (this.initSearchFlg == 'true') ||  hasSearchValues ? true : false;
        }

        return hasSearchValues;
    }
    
    private void saveInputValues() {
        List<Cookie> cookies = new List<Cookie>();
        
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMERCODE, this.customerCode, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMERNAME, this.customerName, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTCODETYPE, this.custCodeType, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTNAMETYPE, this.custNameType, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_SALESRESPONSIBLE, this.salesResponsible, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_SHIPMENTADDRESS, this.shipmentAddress, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_UNITBODY, this.unitBody, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_INQUIRYREPAYMENT, this.inquiryRepayment, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_SHIPPINGDATEYEARFROM, this.shippingDateYearFrom, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_SHIPPINGDATEYEARTO, this.shippingDateYearTo, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_INQUIRYMAINTENANCEPOSSIBILITY, this.inquiryMaintenancePossibility, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_ACCEPTANCEDATEYEARFROM, this.acceptanceDateYearFrom, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_ACCEPTANCEDATEYEARTO, this.acceptanceDateYearTo, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_INQUIRYQUOTATION, this.inquiryQuotation, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_EXISTLASTACTIVITYDATE, this.existLastActivityDate, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_LASTACTIVITYDATEFROM, (this.lastActivityDateFrom == null ? null : this.lastActivityDateFrom.format()), COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_LASTACTIVITYDATETO, (this.lastActivityDateTo == null ? null : this.lastActivityDateTo.format()), COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_QUOTATIONSENTDATEFROM, (this.quotationSentDateFrom == null ? null : this.quotationSentDateFrom.format()), COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_QUOTATIONSENTDATETO, (this.quotationSentDateTo == null ? null : this.quotationSentDateTo.format()), COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_PERIODFROM, (this.periodFrom == null ? null : this.periodFrom.format()), COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_PERIODTO, (this.periodTo == null ? null : this.periodTo.format()), COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_ORDERPROBABILITYFROM, this.orderProbabilityFrom, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_ORDERPROBABILITYTO, this.orderProbabilityTo, COOKIE_PATH, -1, true));

        String targetSeriesText = '';
        if (this.targetSeries != null && this.targetSeries.size() > 0) {
            targetSeriesText = String.join(this.targetSeries, '&&');
        }
        cookies.add(new Cookie(COOKIE_LABEL_TARGETSERIES, targetSeriesText, COOKIE_PATH, -1, true));

        String targetRegionsText = '';
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            targetRegionsText = String.join(this.targetRegions, '&&');
        }
        cookies.add(new Cookie(COOKIE_LABEL_TARGETREGIONS, targetRegionsText, COOKIE_PATH, -1, true));

        cookies.add(new Cookie(COOKIE_LABEL_PAGE_NUMBER, String.valueOf(pageNo), COOKIE_PATH, -1, true));  // ページ番号
        cookies.add(new Cookie(COOKIE_LABEL_PAGE_SIZE, String.valueOf(pageSize), COOKIE_PATH, -1, true));  // ページサイズ
        cookies.add(new Cookie(COOKIE_LABEL_INIT_SEARCH_FLG, this.initSearchFlg, COOKIE_PATH, -1, true));  // 画面起動時検索フラグ
        
        Apexpages.currentPage().setCookies(cookies);
    }
    
    protected override void setStandardSetController() {
    
        lsIdChecked.clear();
        
        String soql = ' SELECT ' +
                          ' Id, Name, PreviousYearOrder__c, ' +
                          ' ContractSentDate__c, QuotationSentDate__c, RenewalNoticeSentDate__c, LastActivityDate, QuotationCreated__c, ' +
                          ' RenewalContactPosition__c, RenewalTantoshya__c, TechnicalAlwaysFalse__c, UnitBody__c, NewOdrContractAmountt__c, ' +
                          ' NewOdrSalesAccount__c, NewOdrShipmentAccount__c, UnitBody__r.Model__c, UnitBody__r.SerialNo__c, UnitBodyShippingDateFormula__c, UnitBodyAcceptanceDateFormula__c, UnitBodyEFEndDateFormula__c,' +
                          ' InquiryRepayment__c, InquiryMaintenancePossibity__c, InquiryPriceList__c, InquiryQuotation__c, JuchuKakudoValue__c, NewOdrSalesPipeline__c, HighlightEFEndDate__c, Memo__c' +
                      ' FROM ' +
                          ' MaintenanceContractManagement__c ';
//                          ' InquiryRepayment__c, InquiryMaintenancePossibity__c, InquiryPriceList__c, InquiryQuotation__c, JuchuKakudoValue__c, NewOdrSalesPipeline__c ' +

        List<String> whereStrElems = getWhereStrList();
        if (whereStrElems.size() > 0) {
            soql += JEOLUtil.joinWhereConditions(whereStrElems);
        }

        soql += ' ORDER BY ' + this.orderBy;
        if (this.orderDesc) {
            soql += ' DESC NULLS LAST';
        }
        
        ssc = new ApexPages.StandardSetController(Database.getQueryLocator(soql + ' LIMIT 10000 '));

        if (this.errFlg) {
            ssc = null;
        } else if (ssc.getResultSize() >= 10000 ) {
            ssc = null;
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintList_Message_TooMuchData));
        } else {
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);

            // Get the total amount
            String sQuery = 'Select SUM(NewOdrContractAmountt__c) sumAmount from MaintenanceContractManagement__c';
            if (whereStrElems.size() > 0) {
                sQuery += JEOLUtil.joinWhereConditions(whereStrElems);
            }
                
            for (AggregateResult lsBook : (List<AggregateResult>)Database.query(sQuery)) {
                bookTotal = lsBook;           
            }
        }
    }
    
    public void doFormClear() {
        customerCode = null;
        customerName = null;
        custCodeType = '1';
        custNameType = '1';
        salesResponsible = null;
        shipmentAddress = null;
        unitBody = null;
        inquiryRepayment = null;
        shippingDateYearFrom = null;
        shippingDateYearTo = null;
        inquiryMaintenancePossibility = null;
        acceptanceDateYearFrom = null;
        acceptanceDateYearTo = null;
        inquiryQuotation = null;
        existLastActivityDate = null;
        lastActivityDateFrom = null;
        lastActivityDateTo = null;
        quotationSentDateFrom = null;
        quotationSentDateTo = null;
        periodFrom = null;
        periodTo = null;
        orderProbabilityFrom = null;
        orderProbabilityTo = null;
    
        this.targetSeries = null;
        for (OptionDetail detail: this.SeriesOptions) {
            detail.setSelected(false);
        }
        this.targetRegions = null;
        for (OptionDetail detail: this.RegionsOptions) {
            detail.setSelected(false);
        }
                
        ssc = null;
        this.pageNo = 1;

        // 画面起動時検索フラグOFF
        this.initSearchFlg = '';

        //ページ初期化
        pageNo = 1;
        pageSize = 50;

        saveInputValues();
    }
   

    /*  検索結果の取得   */
    public List<rowWrapper> getMaintenanceContractManagements() {
        List<rowWrapper> rows = new List<rowWrapper>();
        Integer currentCount = 0;
        
        if(ssc != null) {
            for (MaintenanceContractManagement__c row: (List<MaintenanceContractManagement__c>)ssc.getRecords()) {
                rowWrapper orderPlan = new rowWrapper(row, currentCount);
                rows.add(orderPlan);
                currentCount++;
            }
        }
        return rows;
    }
    
    /* 検索結果の設定 */
    public class rowWrapper{
        public MaintenanceContractManagement__c rec {get; set;}
        public Integer rowNumber {get; set;}
        
        public rowWrapper(MaintenanceContractManagement__c rec, Integer rowNumber) {
            this.rec = rec;
            this.rowNumber = rowNumber;
        }
    }
    public void doSearch() {
        this.initSearchFlg = 'true';  // 画面起動時検索フラグON

        //ページ初期化
        pageNo = 1;
        pageSize = 50;

        orderBy= 'name';
        currentOrder = 'name';
        orderDesc = false;
        
        setStandardSetController();
        if(ssc != null) {
            ssc.setPageNumber(1);
        }
        saveInputValues();
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
    public void setSizeSaveCurrentPageSize() {
        changeSize();
        setCookieCurrentPageSize();
        setCookieCurrentPageNumber();
    }
    public void saveFlags() {

        integer iIdx = -1; 
        if (lsIdChecked != null && lsIdChecked.size() > 0) {
            for (integer i = 0; i < lsIdChecked.size(); i++) {
                if (lsIdChecked[i] == dataId) {
                    iIdx = i;
                    break;
                }
            }
        }
        
        if (iIdx == -1) {
            lsIdChecked.add(dataId);        
        } else {
            lsIdChecked.remove(iIdx);        
        }
    }

    public PageReference redirectMultiAnnai(){

        lsIdChecked.clear();

        for (MaintenanceContractManagement__c row: (List<MaintenanceContractManagement__c>)ssc.getRecords()) {
            if (row.TechnicalAlwaysFalse__c) {
                lsIdChecked.add(row.id);
            }
        }
        
        if (lsIdChecked == null || lsIdChecked.size() < 2) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, Label.JEOL_MaintList_Message_Select2Rows));
            return null;
        }

//        join(lsIdChecked, ',')

//        String sListID = '';
//        for (id idid : lsIdChecked) {
//            if (sListID.length() > 0) {
//                sListID += ',';
//            }
//            sListID += idid;            
//        }
        
        PageReference pr = new PageReference('/apex/JEOL_MaintenanceMultipleAnnai');
        pr.getParameters().put('id', String.join(lsIdChecked, ','));
        pr.setRedirect(true);
        return pr;

    }

    public PageReference redirectExportCsv(){
        
        PageReference pr = new PageReference('/apex/JEOL_MaintenanceListNewCsv');
        //pr.getParameters().put('id', String.join(lsIdChecked, ','));
        pr.setRedirect(true);
        return pr;

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

    private List<String> getWhereStrList() {
    
        this.errFlg = false;  // エラーフラグ初期化

        // Check that orderProbabilityFrom & orderProbabilityTo are numeric
        try {
            Integer iTmp1 = Integer.valueOf(orderProbabilityFrom);
        } catch (Exception ex) {
            orderProbabilityFrom = null;
        }
        try {
            Integer iTmp1 = Integer.valueOf(orderProbabilityTo);
        } catch (Exception ex) {
            orderProbabilityTo = null;
        }


        List<String> strList = new List<String>();

        if (this.TargetSeries != null && this.TargetSeries.size() > 0) {
            lastSearchTargetSeries = String.join(this.TargetSeries, '_');
        }
        if (this.TargetRegions != null && this.TargetRegions.size() > 0) {
            lastSearchTargetRegions = String.join(this.TargetRegions, '_');
        }
        lastSearchCustomerCode = customerCode;
        lastSearchCustomerName = customerName;
        lastSearchCustCodeType = custCodeType;
        lastSearchCustNameType = custNameType;
        lastSearchSalesResponsible = salesResponsible;
        lastSearchShipmentAddress = shipmentAddress;
        lastSearchUnitBody = unitBody;
        lastSearchInquiryRepayment = inquiryRepayment;
        lastSearchShippingDateYearFrom = shippingDateYearFrom;
        lastSearchShippingDateYearTo = shippingDateYearTo;
        lastSearchInquiryMaintenancePossibility = inquiryMaintenancePossibility;
        lastSearchAcceptanceDateYearFrom = acceptanceDateYearFrom;
        lastSearchAcceptanceDateYearTo = acceptanceDateYearTo;
        lastSearchInquiryQuotation = inquiryQuotation;
        lastSearchExistLastActivityDate = existLastActivityDate;
        lastSearchLastActivityDateFrom = lastActivityDateFrom;
        lastSearchLastActivityDateTo = lastActivityDateTo;
        lastSearchQuotationSentDateFrom = quotationSentDateFrom;
        lastSearchQuotationSentDateTo = quotationSentDateTo;
        lastSearchPeriodFrom = periodFrom;
        lastSearchPeriodTo = periodTo;
        lastSearchOrderProbabilityFrom = orderProbabilityFrom;
        lastSearchOrderProbabilityTo = orderProbabilityTo;
        
        strList.add('HidePipeline__c = false');
        strList.add('ContractImpossible__c = false');
        strList.add('PreviousYearOrder__c = null');
        strList.add('LastLinkBaaN__c = null');
        // Changed for UAT #141 strList.add('(LastLinkBaaN__c = null OR LastLinkBaaN__r.HontaiAmount__c = 0)');

        // 系列
        if (this.targetSeries != null && this.targetSeries.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('NewOdrSeries__c', this.targetSeries) + ')');
        }
                
        // 地域
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('NewOdrRegion__c', this.targetRegions) + ')');
        }

        // 販売先・出荷先コード
        if (String.isNotBlank(this.customerCode)) {
            if (custCodeType == '2') {
                // 出荷先
                strList.add(JEOLUtil.appendAfterLikeText('NewOdrShipmentAccount__r.Code__c', this.customerCode));
            } else {
                // 販売先            
                strList.add(JEOLUtil.appendAfterLikeText('NewOdrSalesAccount__r.Code__c', this.customerCode));
            }
        }
        
        // 販売先・出荷先名称
        if (String.isNotBlank(this.customerName)) {
            if (custNameType == '2') {
                // 出荷先
                strList.add(JEOLUtil.appendLikeText('NewOdrShipmentAccount__r.Name', this.customerName));
            } else {
                // 販売先            
                strList.add(JEOLUtil.appendLikeText('NewOdrSalesAccount__r.Name', this.customerName));
            }
        }
        
        // 更新担当者
        if (String.isNotBlank(this.salesResponsible)) {
            strList.add('((' +
                        JEOLUtil.appendAfterLikeText('NewOdrSalesStaff__r.UserCode__c', this.salesResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrSalesStaff__r.Name', this.salesResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('NewOdrAssistant__r.UserCode__c', this.salesResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrAssistant__r.Name', this.salesResponsible) +
                        '))' );
        }        

        // 住所               
        if (String.isNotBlank(this.shipmentAddress)) {
            strList.add(JEOLUtil.appendLikeText('NewOdrShipmentAccount__r.Address__c', this.shipmentAddress));
        }

        // 本体号機
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('UnitBody__r.Name', this.unitBody));
        }

        // 返却有無
        if (String.isNotBlank(this.inquiryRepayment)) {
            if (inquiryRepayment == '1') {
                strList.add(JEOLUtil.appendEqualText('InquiryRepayment__c', '1'));
            } else if (inquiryRepayment == '2') {
                strList.add(JEOLUtil.appendEqualText('InquiryRepayment__c', '2'));
            } else {
                strList.add('InquiryRepayment__c = null');
            }
        }
        
        // 出荷年度
        if (String.isNotBlank(this.shippingDateYearFrom)) {
            try {
                integer iYear = integer.valueof(this.shippingDateYearFrom);
                date dDateFrom = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.ShippingDateFormula__c >= ' +  String.valueOf(ddateFrom));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
        if (String.isNotBlank(this.shippingDateYearTo)) {
            try {
                integer iYear = integer.valueof(this.shippingDateYearTo) + 1;
                date dDateTo = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.ShippingDateFormula__c < ' +  String.valueOf(ddateTo));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
       
        // 保守可能性
        if (String.isNotBlank(this.inquiryMaintenancePossibility)) {
            if (inquiryMaintenancePossibility == '1') {
                strList.add(JEOLUtil.appendEqualText('InquiryMaintenancePossibity__c', '1'));
            } else if (inquiryMaintenancePossibility == '2') {
                strList.add(JEOLUtil.appendEqualText('InquiryMaintenancePossibity__c', '2'));
            } else {
                strList.add('InquiryMaintenancePossibity__c = null');
            }
        }

        // 検収年度
        if (String.isNotBlank(this.acceptanceDateYearFrom)) {
            try {
                integer iYear = integer.valueof(this.acceptanceDateYearFrom);
                date dDateFrom = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.AcceptanceDateFormula__c >= ' +  String.valueOf(ddateFrom));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
        if (String.isNotBlank(this.acceptanceDateYearTo)) {
            try {
                integer iYear = integer.valueof(this.acceptanceDateYearTo) + 1;
                date dDateTo = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.AcceptanceDateFormula__c < ' +  String.valueOf(ddateTo));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
       
        // 見積書有無
        if (String.isNotBlank(this.inquiryQuotation)) {
            if (inquiryQuotation == '1') {
                strList.add(JEOLUtil.appendEqualText('InquiryQuotation__c', '1'));
            } else if (inquiryQuotation == '2') {
                strList.add(JEOLUtil.appendEqualText('InquiryQuotation__c', '2'));
            } else {
                strList.add('InquiryQuotation__c = null');
            }
        }

        // 対応日付
        if (this.lastActivityDateFrom != null) {
            strList.add('LastActivityDate >= ' + String.valueOf(this.lastActivityDateFrom));
        }
        if (this.lastActivityDateTo != null) {
            strList.add('LastActivityDate <= ' + String.valueOf(this.lastActivityDateTo));
        }

        // 見積書有無
        if (String.isNotBlank(this.existLastActivityDate)) {
            if (existLastActivityDate == '1') {
                strList.add('LastActivityDate != null');
            } else if (existLastActivityDate == '2') {
                strList.add('LastActivityDate = null');
            }
        }

        // 受注確度
        if (this.orderProbabilityFrom != NULL) {
            strList.add('NewOdrSalesPipeline__r.JuchuKakudoValue__c >= ' + orderProbabilityFrom);
        }
        if (this.orderProbabilityTo != NULL) {
            strList.add('NewOdrSalesPipeline__r.JuchuKakudoValue__c <= ' + orderProbabilityTo);
        }

        // 見積書送付日
        if (this.quotationSentDateFrom != null) {
            strList.add('QuotationSentDate__c >= ' + String.valueOf(this.quotationSentDateFrom));
        }
        if (this.quotationSentDateTo != null) {
            strList.add('QuotationSentDate__c <= ' + String.valueOf(this.quotationSentDateTo));
        }

        // 予定開始日
        if (this.periodFrom != null) {
            strList.add('NewOdrMaintenanceStartDate__c >= ' + String.valueOf(this.periodFrom));
        }
        if (this.periodTo != null) {
            strList.add('NewOdrMaintenanceStartDate__c <= ' + String.valueOf(this.periodTo));
        }     
        
        return strList;
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
    
    Public String getRedirectExportCsvURL(){
        String sParameters = '';
        
        final String PARAM_SERIES = 'SERIES';
        final String PARAM_REGIONS = 'REGIONS';
        final String PARAM_CUSTOMERCODE = 'CUSTOMERCODE';
        final String PARAM_CUSTOMERNAME = 'CUSTOMERNAME';
        final String PARAM_CUSTCODETYPE = 'CUSTCODETYPE';
        final String PARAM_CUSTNAMETYPE = 'CUSTNAMETYPE';
        final String PARAM_SALESRESPONSIBLE = 'SALESRESPONSIBLE';
        final String PARAM_SHIPMENTADDRESS = 'SHIPMENTADDRESS';
        final String PARAM_UNITBODY = 'UNITBODY';
        final String PARAM_INQUIRYREPAYMENT = 'INQUIRYREPAYMENT';
        final String PARAM_SHIPPINGDATEYEARFROM = 'SHIPPINGDATEYEARFROM';
        final String PARAM_SHIPPINGDATEYEARTO = 'SHIPPINGDATEYEARTO';
        final String PARAM_INQUIRYMAINTENANCEPOSSIBILITY = 'INQUIRYMAINTENANCEPOSSIBILITY';
        final String PARAM_ACCEPTANCEDATEYEARFROM = 'ACCEPTANCEDATEYEARFROM';
        final String PARAM_ACCEPTANCEDATEYEARTO = 'ACCEPTANCEDATEYEARTO';
        final String PARAM_INQUIRYQUOTATION = 'INQUIRYQUOTATION';
        final String PARAM_EXISTLASTACTIVITYDATE = 'EXISTLASTACTIVITYDATE';
        final String PARAM_LASTACTIVITYDATEFROM = 'LASTACTIVITYDATEFROM';
        final String PARAM_LASTACTIVITYDATETO = 'LASTACTIVITYDATETO';
        final String PARAM_QUOTATIONSENTDATEFROM = 'QUOTATIONSENTDATEFROM';
        final String PARAM_QUOTATIONSENTDATETO = 'QUOTATIONSENTDATETO';
        final String PARAM_PERIODFROM = 'PERIODFROM';
        final String PARAM_PERIODTO = 'PERIODTO';
        final String PARAM_ORDERPROBABILITYFROM = 'ORDERPROBABILITYFROM';
        final String PARAM_ORDERPROBABILITYTO = 'ORDERPROBABILITYTO';

       
        // 系列
        if (String.isNotBlank(this.lastSearchTargetSeries)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_SERIES + '=' + this.lastSearchTargetSeries;
        }

        // 地域
        if (String.isNotBlank(this.lastSearchTargetRegions)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_REGIONS + '=' + this.lastSearchTargetRegions;
        }
        
        // 販売先・出荷先コード
        if (sParameters.length() > 0) {
            sParameters += '&';
        }
        if (lastSearchCustCodeType == '2') {
            sParameters += PARAM_CUSTCODETYPE + '=2';        
        } else {
            sParameters += PARAM_CUSTCODETYPE + '=1';        
        }
        
        if (String.isNotBlank(this.lastSearchCustomerCode)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_CUSTOMERCODE + '=' + this.lastSearchCustomerCode;        
        }
        
        // 販売先・出荷先名称
        if (sParameters.length() > 0) {
            sParameters += '&';
        }
        if (lastSearchCustNameType == '2') {
            sParameters += PARAM_CUSTNAMETYPE + '=2';        
        } else {
            sParameters += PARAM_CUSTNAMETYPE + '=1';        
        }

        if (String.isNotBlank(this.lastSearchCustomerName)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_CUSTOMERNAME + '=' + this.lastSearchCustomerName;        
        }

        // 営業担当者            
        if (String.isNotBlank(this.lastSearchSalesResponsible)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_SALESRESPONSIBLE + '=' + this.lastSearchSalesResponsible;        
        }

        // 住所               
        if (String.isNotBlank(this.lastSearchShipmentAddress)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_SHIPMENTADDRESS + '=' + this.lastSearchShipmentAddress;        
        }

        // 本体号機
        if (String.isNotBlank(this.lastSearchUnitBody)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_UNITBODY + '=' + this.lastSearchUnitBody;        
        }
      
        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchInquiryRepayment)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_INQUIRYREPAYMENT + '=' + this.lastSearchInquiryRepayment;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchShippingDateYearFrom)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_SHIPPINGDATEYEARFROM + '=' + this.lastSearchShippingDateYearFrom;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchShippingDateYearTo)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_SHIPPINGDATEYEARTO + '=' + this.lastSearchShippingDateYearTo;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchInquiryMaintenancePossibility)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_INQUIRYMAINTENANCEPOSSIBILITY + '=' + this.lastSearchInquiryMaintenancePossibility;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchAcceptanceDateYearFrom)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_ACCEPTANCEDATEYEARFROM + '=' + this.lastSearchAcceptanceDateYearFrom;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchAcceptanceDateYearTo)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_ACCEPTANCEDATEYEARTO + '=' + this.lastSearchAcceptanceDateYearTo;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchInquiryQuotation)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_INQUIRYQUOTATION + '=' + this.lastSearchInquiryQuotation;        
        }

        // XXXXXXXXX
        if (String.isNotBlank(this.lastSearchExistLastActivityDate)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_EXISTLASTACTIVITYDATE + '=' + this.lastSearchExistLastActivityDate;        
        }

        // XXXXXXXXX
        if (this.lastSearchLastActivityDateFrom != null) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_LASTACTIVITYDATEFROM + '=' + this.lastSearchLastActivityDateFrom.format();        
        }

        // XXXXXXXXX
        if (this.lastSearchLastActivityDateTo != null) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_LASTACTIVITYDATETO + '=' + this.lastSearchLastActivityDateTo.format();        
        }

        // XXXXXXXXX
        if (this.lastSearchQuotationSentDateFrom != null) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_QUOTATIONSENTDATEFROM + '=' + this.lastSearchQuotationSentDateFrom.format();        
        }

        // XXXXXXXXX
        if (this.lastSearchQuotationSentDateTo != null) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_QUOTATIONSENTDATETO + '=' + this.lastSearchQuotationSentDateTo.format();        
        }

        // XXXXXXXXX
        if (this.lastSearchPeriodFrom != null) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_PERIODFROM + '=' + this.lastSearchPeriodFrom.format();        
        }

        // XXXXXXXXX
        if (this.lastSearchPeriodTo != null) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_PERIODTO + '=' + this.lastSearchPeriodTo.format();        
        }

        // XXXXXXXXX
        if (this.lastSearchOrderProbabilityFrom != NULL) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_ORDERPROBABILITYFROM + '=' + this.lastSearchOrderProbabilityFrom;        
        }

        // XXXXXXXXX
        if (this.lastSearchOrderProbabilityTo != NULL) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_ORDERPROBABILITYTO + '=' + this.lastSearchOrderProbabilityTo;        
        }

        return '/apex/JEOL_MaintenanceListNewCsv' + (sParameters.length() > 0 ? '?' + sParameters : '');
    }
}