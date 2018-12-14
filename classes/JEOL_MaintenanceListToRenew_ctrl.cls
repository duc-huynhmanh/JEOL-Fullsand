public with sharing class JEOL_MaintenanceListToRenew_ctrl extends JEOL_SearchBase_ctrl {
    
    public String renewalMonth{get; set;}
    public String lastYearSalesOrder{get; set;}
    public String customerCode{get; set;}
    public String customerName{get; set;}
    public String custCodeType{get; set;}
    public String custNameType{get; set;}
    public String jeolPipelineResponsible{get; set;}
    public String netMaintenance{get; set;}
    public String shipmentAddress{get; set;}
    public String unitBody{get; set;}

    private List<String> targetSeries;
    public List<OptionDetail> SeriesOptions{get; set;}
    private List<String> targetRegions;
    public List<OptionDetail> RegionsOptions{get; set;}

    public String lastSearchRenewalMonth{get; set;}
    public String lastSearchLastYearSalesOrder{get; set;}
    public String lastSearchTargetSeries{get; set;}
    public String lastSearchTargetRegions{get; set;}
    public String lastSearchCustomerCode{get; set;}
    public String lastSearchCustomerName{get; set;}
    public String lastSearchCustCodeType{get; set;}
    public String lastSearchCustNameType{get; set;}
    public String lastSearchJeolPipelineResponsible{get; set;}
    public String lastSearchNetMaintenance{get; set;}
    public String lastSearchShipmentAddress{get; set;}
    public String lastSearchUnitBody{get; set;}
    public String lastSearchResults{get; set;}

    public boolean hasPermissionExcelOutput{get; set;}
       
    public id dataId{get; set;}
    List<id> lsIdChecked = new List<id>();
    public Map<String, String> mapRegionName { get; set; }

    private static final String COOKIE_LABEL_RENEWAL_MONTH = 'JEOL_MaintenanceListToRenew_RenewalMonth';
    private static final String COOKIE_LABEL_LAST_YEAR_SALES_ORDER = 'JEOL_MaintenanceListToRenew_LastYearSalesOrder';

    private static final String COOKIE_LABEL_CUSTOMERCODE = 'JEOL_MaintenanceListToRenew_CustomerCode';
    private static final String COOKIE_LABEL_CUSTOMERNAME = 'JEOL_MaintenanceListToRenew_CustomerName';

    private static final String COOKIE_LABEL_CUSTCODETYPE = 'JEOL_MaintenanceListToRenew_CustCodeType';
    private static final String COOKIE_LABEL_CUSTNAMETYPE = 'JEOL_MaintenanceListToRenew_CustNameType';
    private static final String COOKIE_LABEL_JEOLPIPELINERESPONSIBLE = 'JEOL_MaintenanceListToRenew_JeolPipelineResponsible';
    private static final String COOKIE_LABEL_NETMAINTENANCE = 'JEOL_MaintenanceListToRenew_NetMaintenance';
    private static final String COOKIE_LABEL_SHIPMENTADDRESS = 'JEOL_MaintenanceListToRenew_ShipmentAddress';
    private static final String COOKIE_LABEL_UNITBODY = 'JEOL_MaintenanceListToRenew_UnitBody';
    private static final String COOKIE_LABEL_TARGETSERIES = 'JEOL_MaintenanceListToRenew_TargetSeries';
    private static final String COOKIE_LABEL_TARGETREGIONS = 'JEOL_MaintenanceListToRenew_TargetRegions';
    
    private static final String COOKIE_LABEL_PAGE_NUMBER = 'PageNumber';
    private static final String COOKIE_LABEL_PAGE_SIZE = 'PageSize';
    private static final String COOKIE_PATH = '/apex/JEOL_MaintenanceListToRenew';
    private static final String COOKIE_LABEL_INIT_SEARCH_FLG = 'initSearchFlg';  // 画面起動時検索フラグ

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

    public List<SelectOption> getListNetMaintenance() {

        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('', ''));
        options.add(new SelectOption('Yes', 'Yes'));
        options.add(new SelectOption('No', 'No'));
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

    public JEOL_MaintenanceListToRenew_ctrl() {

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
        if(cookies.containsKey(COOKIE_LABEL_RENEWAL_MONTH)){
            this.renewalMonth = cookies.get(COOKIE_LABEL_RENEWAL_MONTH).getValue();
        }
        if(cookies.containsKey(COOKIE_LABEL_LAST_YEAR_SALES_ORDER)){
            this.lastYearSalesOrder = cookies.get(COOKIE_LABEL_LAST_YEAR_SALES_ORDER).getValue();
        }
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
        if (cookies.containsKey(COOKIE_LABEL_JEOLPIPELINERESPONSIBLE)) {
            this.jeolPipelineResponsible = cookies.get(COOKIE_LABEL_JEOLPIPELINERESPONSIBLE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_NETMAINTENANCE)) {
            this.netMaintenance = cookies.get(COOKIE_LABEL_NETMAINTENANCE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_SHIPMENTADDRESS)) {
            this.shipmentAddress = cookies.get(COOKIE_LABEL_SHIPMENTADDRESS).getValue();
        }  
        if (cookies.containsKey(COOKIE_LABEL_UNITBODY)) {
            this.UnitBody = cookies.get(COOKIE_LABEL_UNITBODY).getValue();
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
        
        cookies.add(new Cookie(COOKIE_LABEL_RENEWAL_MONTH, this.renewalMonth, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_LAST_YEAR_SALES_ORDER, this.lastYearSalesOrder, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMERCODE, this.customerCode, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMERNAME, this.customerName, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTCODETYPE, this.custCodeType, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTNAMETYPE, this.custNameType, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_JEOLPIPELINERESPONSIBLE, this.jeolPipelineResponsible, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_NETMAINTENANCE, this.netMaintenance, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_SHIPMENTADDRESS, this.shipmentAddress, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_UNITBODY, this.unitBody, COOKIE_PATH, -1, true));
        
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
        
        // TODOBP: Add the following once the Quotation table is created: "PreviousYearOrder__r.QuotationInformation__r.QuoteNo__c,"
        String soql = ' SELECT ' +
                          ' Id, Name, PreviousYearOrder__c, PreviousYearOrder__r.Name, PreviousYearOrder__r.NetMaintenance__c, PreviousYearOrder__r.ModelPI__c, ' +
                          ' PreviousYearOrder__r.SalesAccount__c, PreviousYearOrder__r.ContactDateFormula__c, PrevYrOrderMaintenanceEndDateFormula__c, ' +
                          ' PreviousYearOrder__r.MaintenanceStartDateFormula__c, PreviousYearOrder__r.MaintenanceEndDateFormula__c, ' +
                          ' PreviousYearOrder__r.MaintenanceType__c,  RenewalMonthFormula__c, PreviousYearPipeline__c, PreviousYearPipeline__r.Name, ' +
                          ' PreviousYearOrder__r.Series__c, PreviousYearOrder__r.Area__c, PreviousYearOrder__r.MaintenancePeriodText__c, ' +
                          ' ContractSentDate__c, QuotationSentDate__c, RenewalNoticeSentDate__c, RenewalNoticeCreated__c, QuotationCreated__c, ' +
                          ' RenewalContactPosition__c, RenewalTantoshya__c, TechnicalAlwaysFalse__c, UnitBody__c, NewOdrContractAmountt__c, NewOdrMaintenancePeriodText__c, Memo__c, ' +
                          ' NewOdrSalesAccount__c, NewOdrShipmentAccount__c' +
                      ' FROM ' +
                          ' MaintenanceContractManagement__c ';

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
            lastSearchResults = '';
            for (MaintenanceContractManagement__c row : (List<MaintenanceContractManagement__c>)Database.Query(soql + ' LIMIT 500 ')) {
                if (lastSearchResults != null && lastSearchResults.length() > 0) {
                    lastSearchResults += ',';
                }
                lastSearchResults += row.Name;
            }
                    
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);
        }
    }
    
    public void doFormClear() {
        renewalMonth = null;
        lastYearSalesOrder = null;
        customerCode = null;
        customerName = null;
        custCodeType = '1';
        custNameType = '1';
        jeolPipelineResponsible = null;
        netMaintenance = null;
        shipmentAddress = null;
        unitBody = null;
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
    
    /*  検索結果の設定　*/
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
        
        lsIdChecked.sort();
        PageReference pr = new PageReference('/apex/JEOL_MaintenanceMultipleAnnai');
        pr.getParameters().put('id', String.join(lsIdChecked, ','));
        pr.setRedirect(true);
        return pr;

    }

    public PageReference redirectExportCsv(){
        
        PageReference pr = new PageReference('/apex/JEOL_MaintenanceListToRenewCsv');
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
        List<String> strList = new List<String>();

        lastSearchRenewalMonth = renewalMonth;
        lastSearchLastYearSalesOrder = lastYearSalesOrder;
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
        lastSearchJeolPipelineResponsible = jeolPipelineResponsible;
        lastSearchNetMaintenance = netMaintenance;
        lastSearchShipmentAddress = shipmentAddress;
        lastSearchUnitBody = unitBody;

        strList.add('(RenewalApproved__c = false or LastLinkBaaN__c = null)');
        strList.add('PipelineStopped__c = false');
        strList.add('PreviousYearOrder__c != null');

        // 更新月
        if (String.isNotBlank(this.renewalMonth)) {
            strList.add('RenewalMonthFormula__c <= \'' + (String.escapeSingleQuotes(renewalMonth) + '999999').substring(0, 6) + '\'');
            //strList.add(JEOLUtil.appendAfterLikeText('RenewalMonthFormula__c', this.renewalMonth));
        }

        // 前年オーダ番号 
        if (String.isNotBlank(this.lastYearSalesOrder)) {
            strList.add(JEOLUtil.appendLikeText('PreviousYearOrder__r.Name', this.lastYearSalesOrder));
        }

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
        
        // 住所               
        if (String.isNotBlank(this.shipmentAddress)) {
            strList.add(JEOLUtil.appendLikeText('NewOdrShipmentAccount__r.Address__c', this.shipmentAddress));
        }

        // 本体号機
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('UnitBody__r.Name', this.unitBody));
        }

       // 更新担当者
        if (String.isNotBlank(this.jeolPipelineResponsible)) {
            strList.add('((' +
                        JEOLUtil.appendAfterLikeText('NewOdrSalesStaff__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrSalesStaff__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('NewOdrAssistant__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrAssistant__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('JeolPipelineResponsible__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('JeolPipelineResponsible__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('JeolPipelineResponsible2__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('JeolPipelineResponsible2__r.Name', this.jeolPipelineResponsible) +
                        '))' );
        }        
        
        // NET区分
        if (String.isNotBlank(this.netMaintenance)) {
            strList.add(JEOLUtil.appendEqualText('NewOdrNetMaintenance__c', this.netMaintenance));
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
        
        final String PARAM_RENEWALMONTH = 'MONTH';
        final String PARAM_LASTYEARSO = 'LASTYEARSO';
        final String PARAM_SERIES = 'SERIES';
        final String PARAM_REGIONS = 'REGIONS';
        final String PARAM_CUSTOMERCODE = 'CUSTOMERCODE';
        final String PARAM_CUSTOMERNAME = 'CUSTOMERNAME';
        final String PARAM_CUSTCODETYPE = 'CUSTCODETYPE';
        final String PARAM_CUSTNAMETYPE = 'CUSTNAMETYPE';
        final String PARAM_JEOLPIPELINERESPONSIBLE = 'JEOLPIPELINERESPONSIBLE';
        final String PARAM_NETMAINTENANCE = 'NETMAINTENANCE';
        final String PARAM_SHIPMENTADDRESS = 'SHIPMENTADDRESS';
        final String PARAM_UNITBODY = 'UNITBODY';

        // 更新月
        if (String.isNotBlank(this.lastSearchRenewalMonth)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_RENEWALMONTH + '=' + this.lastSearchRenewalMonth;
        }

        // 前年オーダ番号 
        if (String.isNotBlank(this.lastSearchLastYearSalesOrder)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_LASTYEARSO + '=' + this.lastSearchLastYearSalesOrder;
        }

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

        // 更新担当者
        if (String.isNotBlank(this.lastSearchJeolPipelineResponsible)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_JEOLPIPELINERESPONSIBLE + '=' + this.lastSearchJeolPipelineResponsible;        
        }
        
        // NET区分
        if (String.isNotBlank(this.lastSearchNetMaintenance)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_NETMAINTENANCE + '=' + this.lastSearchNetMaintenance;        
        }
      
        return '/apex/JEOL_MaintenanceListToRenewCsv' + (sParameters.length() > 0 ? '?' + sParameters : '');
    }
}