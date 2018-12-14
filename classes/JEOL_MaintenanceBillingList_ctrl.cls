public with sharing class JEOL_MaintenanceBillingList_ctrl extends JEOL_SearchBase_ctrl {
    
    public String month{get; set;}
    public String customerCode{get; set;}
    public String customerName{get; set;}
    public String unitBody{get; set;}
    public String type{get; set;}
    public String orderNo{get; set;}
    public String status{get; set;}
    public String netMaintenance{get; set;}
    public String invoiceNumber{get; set;}
    private List<String> targetSeries;
    public List<OptionDetail> SeriesOptions{get; set;}
    private List<String> targetRegions;
    public List<OptionDetail> RegionsOptions{get; set;}

    public String lastSearchMonth{get; set;}
    public String lastSearchCustomerCode{get; set;}
    public String lastSearchCustomerName{get; set;}
    public String lastSearchUnitBody{get; set;}
    public String lastSearchType{get; set;}
    public String lastSearchOrderNo{get; set;}
    public String lastSearchStatus{get; set;}
    public String lastSearchNetMaintenance{get; set;}
    public String lastSearchInvoiceNumber{get; set;}
    public String lastSearchTargetSeries{get; set;}
    public String lastSearchTargetRegions{get; set;}
    
    public boolean hasPermissionExcelOutput{get; set;}

    public id dataId{get; set;}
    public Map<String, String> mapRegionName { get; set; }

    
    private static final String COOKIE_LABEL_MONTH = 'JEOL_MaintenanceBillingList_Month';
    private static final String COOKIE_LABEL_CUSTOMERCODE = 'JEOL_MaintenanceBillingList_CustomerCode';
    private static final String COOKIE_LABEL_CUSTOMERNAME = 'JEOL_MaintenanceBillingList_CustomerName';
    private static final String COOKIE_LABEL_UNITBODY = 'JEOL_MaintenanceBillingList_UnitBody';
    private static final String COOKIE_LABEL_TYPE = 'JEOL_MaintenanceBillingList_Type';
    private static final String COOKIE_LABEL_ORDERNO = 'JEOL_MaintenanceBillingList_OrderNo';    
    private static final String COOKIE_LABEL_STATUS = 'JEOL_MaintenanceBillingList_Status';
    private static final String COOKIE_LABEL_NETMAINTENANCE = 'JEOL_MaintenanceBillingList_NetMaintenance';
    private static final String COOKIE_LABEL_INVOICENUMBER = 'JEOL_MaintenanceBillingList_InvoiceNumber';
    private static final String COOKIE_LABEL_TARGETSERIES = 'JEOL_MaintenanceBillingList_TargetSeries';
    private static final String COOKIE_LABEL_TARGETREGIONS = 'JEOL_MaintenanceInspectionList_TargetRegions';

    private static final String COOKIE_LABEL_PAGE_NUMBER = 'PageNumber';
    private static final String COOKIE_LABEL_PAGE_SIZE = 'PageSize';
    private static final String COOKIE_PATH = '/apex/JEOL_MaintenanceBillingList';
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
    
    public List<SelectOption> getTypeOptions() {
        List<SelectOption> lsReturn = new List<SelectOption>();
        lsReturn.add(new SelectOption('', ''));
        lsReturn.add(new SelectOption('1', '本体のみ,点検有'));
        lsReturn.add(new SelectOption('2', '本体のみ,点検無'));
        lsReturn.add(new SelectOption('3', 'アタッチのみ'));
        lsReturn.add(new SelectOption('4', 'ヘリウムのみ'));
        return lsReturn;
    }

    public List<SelectOption> getNetMaintenanceOptions() {
        List<SelectOption> lsReturn = new List<SelectOption>();
        lsReturn.add(new SelectOption('', ''));
        lsReturn.add(new SelectOption('Yes', 'Yes'));
        lsReturn.add(new SelectOption('No', 'No'));
        return lsReturn;
    }

    public List<SelectOption> getStatusOptions() {
        List<SelectOption> lsReturn = new List<SelectOption>();
        lsReturn.add(new SelectOption('', ''));
        lsReturn.add(new SelectOption('1', '請求済のみ'));
        lsReturn.add(new SelectOption('2', '未請求のみ'));
        return lsReturn;
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

    public JEOL_MaintenanceBillingList_ctrl() {

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
        Map<String, Cookie> cookies = Apexpages.currentPage().getCookies();
        Boolean hasSearchValues = false;
        if(cookies.containsKey(COOKIE_LABEL_MONTH)){
            this.month = cookies.get(COOKIE_LABEL_MONTH).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_CUSTOMERCODE)) {
            this.customerCode = cookies.get(COOKIE_LABEL_CUSTOMERCODE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_CUSTOMERNAME)) {
            this.customerName = cookies.get(COOKIE_LABEL_CUSTOMERNAME).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_UNITBODY)) {
            this.unitBody = cookies.get(COOKIE_LABEL_UNITBODY).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_TYPE)) {
            this.type = cookies.get(COOKIE_LABEL_TYPE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_ORDERNO)) {
            this.orderNo = cookies.get(COOKIE_LABEL_ORDERNO).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_INVOICENUMBER)) {
            this.invoiceNumber = cookies.get(COOKIE_LABEL_INVOICENUMBER).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_STATUS)) {
            this.status = cookies.get(COOKIE_LABEL_STATUS).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_NETMAINTENANCE)) {
            this.netMaintenance = cookies.get(COOKIE_LABEL_NETMAINTENANCE).getValue();
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
        
        cookies.add(new Cookie(COOKIE_LABEL_MONTH, this.month, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMERCODE, this.customerCode, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMERNAME, this.customerName, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_UNITBODY, this.unitBody, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_TYPE, this.type, COOKIE_PATH, -1, true));        
        cookies.add(new Cookie(COOKIE_LABEL_ORDERNO, this.orderNo, COOKIE_PATH, -1, true));        
        cookies.add(new Cookie(COOKIE_LABEL_INVOICENUMBER, this.invoiceNumber, COOKIE_PATH, -1, true));        
        cookies.add(new Cookie(COOKIE_LABEL_STATUS, this.status, COOKIE_PATH, -1, true));        
        cookies.add(new Cookie(COOKIE_LABEL_NETMAINTENANCE, this.netMaintenance, COOKIE_PATH, -1, true));        
        
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
        String soql = ' SELECT ' +
                    ' Id, Name, Month__c, MaintenanceContractManagement__r.NewOdrSeries__c, MaintenanceContractManagement__r.NewOdrRegion__c, ' +
                    ' MaintenanceContractManagement__r.ProductNumber__c, MaintenanceContractManagement__r.NewOdrFlagshipProduct__c, ' +
                    ' MaintenanceContractManagement__r.RenewalAccount__r.Name, MaintenanceContractManagement__r.NewOdrContractAmountt__c, ' +
                    ' MaintenanceContractManagement__r.UnitBody__c, Type__c, BillingDone__c, BillingAmountEstimate__c, ' +
                    ' MaintenanceContractManagement__r.NewOdrSalesOrder__c, MaintenanceContractManagement__r.NewOdrSalesOrder__r.Name, MaintenanceContractManagement__r.UnitBody__r.Model__c, ' +
                    ' MaintenanceContractManagement__r.NewOdrSalesAccount__c, MaintenanceContractManagement__r.NewOdrShipmentAccount__c, ' +
                    ' MaintenanceContractManagement__r.NewOdrMaintenancePeriodText__c, BillingMethod__c, MaintenanceContractManagement__c ' +
                ' FROM ' +
                    ' MaintenanceAccountBook__c ';                    

        List<String> whereStrElems = getWhereStrList();
        if (whereStrElems.size() > 0) {
            soql += JEOLUtil.joinWhereConditions(whereStrElems);
        }

        soql += ' ORDER BY ' + this.orderBy;
        if (this.orderDesc) {
            soql += ' DESC NULLS LAST';
        }
        
        soql += ' LIMIT 10000 ';
        ssc = new ApexPages.StandardSetController(Database.getQueryLocator(soql));

        if (this.errFlg) {
            ssc = null;
        } else if (ssc.getResultSize() >= 10000 ) {
            ssc = null;
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, '検索結果が１万件を超えました。検索条件を増やし、再度検索してください。'));
        } else {
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);
        }
    }
    
    public void doFormClear() {
        month = null;
        customerCode = null;
        customerName = null;
        unitBody = null;
        type = null;
        orderNo = null;
        invoiceNumber = null;
        status = null;
        netMaintenance = null;
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
    public List<rowWrapper> getSalesPipelines() {
        rows = new List<rowWrapper>();
        Integer currentCount = 0;
        mapRegionName = new Map<String, String>();
        
        if(ssc != null) {
            for (MaintenanceAccountBook__c row: (List<MaintenanceAccountBook__c>)ssc.getRecords()) {
                mapRegionName.put(row.MaintenanceContractManagement__r.NewOdrRegion__c, row.MaintenanceContractManagement__r.NewOdrRegion__c);
                rowWrapper orderPlan = new rowWrapper(row, currentCount);
                rows.add(orderPlan);
                currentCount++;
            }
        }
        
        for (SelectListManage__c reg : lsRegion) {
            mapRegionName.put(reg.Value__c, reg.Label__c);        
        }
        
        return rows;
    }
    /* 検索結果の設定 */
    public class rowWrapper{
        public MaintenanceAccountBook__c rec {get; set;}
        public Integer rowNumber {get; set;}
        
        public rowWrapper(MaintenanceAccountBook__c rec, Integer rowNumber) {
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

        for (rowWrapper row : rows) {
            if (row.rec.id == dataId) {
                upsert row.rec;
                break;
            }
        }

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

        lastSearchMonth = month;
        lastSearchCustomerCode = customerCode;
        lastSearchCustomerName = customerName;
        lastSearchUnitBody = unitBody;
        lastSearchType = type;
        lastSearchOrderNo = orderNo;
        lastSearchStatus = status;
        lastSearchNetMaintenance = netMaintenance;
        lastSearchInvoiceNumber = invoiceNumber;

        if (this.TargetSeries != null && this.TargetSeries.size() > 0) {
            lastSearchTargetSeries = String.join(this.TargetSeries, '_');
        }
        if (this.TargetRegions != null && this.TargetRegions.size() > 0) {
            lastSearchTargetRegions = String.join(this.TargetRegions, '_');
        }

        strList.add('BillingAmountEstimate__c > 0');
        
        if (String.isNotBlank(this.month)) {
            strList.add(JEOLUtil.appendAfterLikeText('month__c', this.month));
        }

        // 系列
        if (this.targetSeries != null && this.targetSeries.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('MaintenanceContractManagement__r.NewOdrSeries__c', this.targetSeries) + ')');
        }
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('MaintenanceContractManagement__r.NewOdrRegion__c', this.targetRegions) + ')');
        }
        if (String.isNotBlank(this.customerCode)) {
            strList.add('((' + JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.RenewalAccount__r.Code__c', this.customerCode) + ') OR ' +
                         '(' + JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Code__c', this.customerCode) + ') OR ' +
                         '(' + JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrSalesAccount__r.Code__c', this.customerCode) + '))');
        }
        if (String.isNotBlank(this.customerName)) {
            strList.add('((' + JEOLUtil.appendLikeText('MaintenanceContractManagement__r.RenewalAccount__r.Name', this.customerName) + ') OR ' +
                         '(' + JEOLUtil.appendLikeText('MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Name', this.customerName) + ') OR ' +
                         '(' + JEOLUtil.appendLikeText('MaintenanceContractManagement__r.NewOdrSalesAccount__r.Name', this.customerName) + '))');
        }
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.UnitBody__r.Name', this.unitBody));
        }
        if (String.isNotBlank(this.type)) {
            strList.add(JEOLUtil.appendEqualText('type__c', this.type));
        }

        if (String.isNotBlank(this.orderNo)) {
            strList.add(JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrSalesOrder__r.Name', this.orderNo));
        }
        if (String.isNotBlank(this.status)) {        
            if (this.status == '1') {
                strList.add('BillingDone__c = true');
            } else if (this.status == '2') {
                strList.add('BillingDone__c = false');
            }
        }        
        if (String.isNotBlank(this.netMaintenance)) {
            strList.add(JEOLUtil.appendEqualText('MaintenanceContractManagement__r.NewOdrNetMaintenance__c', this.netMaintenance));
        }
        if (String.isNotBlank(this.invoiceNumber)) {
            strList.add('((' + JEOLUtil.appendAfterLikeText('InvoiceNumber__c', this.invoiceNumber) + ') OR ' +
                         '(' + JEOLUtil.appendAfterLikeText('InvoiceNumberAuto__c', this.invoiceNumber) + '))');
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
        
        final String PARAM_MONTH = 'MONTH';
        final String PARAM_CUSTOMERCODE = 'CUSTOMERCODE';
        final String PARAM_CUSTOMERNAME = 'CUSTOMERNAME';
        final String PARAM_UNITBODY = 'UNITBODY';
        final String PARAM_TYPE = 'TYPE';
        final String PARAM_ORDERNO = 'ORDERNO';
        final String PARAM_STATUS = 'STATUS';
        final String PARAM_NETMAINTENANCE = 'NETMAINTENANCE';
        final String PARAM_INVOICENUMBER = 'INVOICENUMBER';
        final String PARAM_SERIES = 'SERIES';
        final String PARAM_REGIONS = 'REGIONS';

        // MONTH
        if (String.isNotBlank(this.lastSearchMonth)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_MONTH + '=' + this.lastSearchMonth;
        }

        if (String.isNotBlank(this.lastSearchCustomerCode)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_CUSTOMERCODE + '=' + this.lastSearchCustomerCode;        
        }

        if (String.isNotBlank(this.lastSearchCustomerName)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_CUSTOMERNAME + '=' + this.lastSearchCustomerName;        
        }

        // 本体号機
        if (String.isNotBlank(this.lastSearchUnitBody)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_UNITBODY + '=' + this.lastSearchUnitBody;        
        }

        // TYPE 
        if (String.isNotBlank(this.lastSearchType)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_TYPE + '=' + this.lastSearchType;
        }

        // ORDER NO 
        if (String.isNotBlank(this.lastSearchOrderNo)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_ORDERNO + '=' + this.lastSearchOrderNo;
        }

        // STATUS 
        if (String.isNotBlank(this.lastSearchStatus)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_STATUS + '=' + this.lastSearchStatus;
        }

        // NET MAINTENANCE 
        if (String.isNotBlank(this.lastSearchNetMaintenance)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_NETMAINTENANCE + '=' + this.lastSearchNetMaintenance;
        }

        // STATUS 
        if (String.isNotBlank(this.lastSearchInvoiceNumber)) {
            if (sParameters.length() > 0) {
                sParameters += '&';
            }
            sParameters += PARAM_INVOICENUMBER + '=' + this.lastSearchInvoiceNumber;
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
        
        return '/apex/JEOL_MaintenanceBillingListCsv' + (sParameters.length() > 0 ? '?' + sParameters : '');
    }

    
}