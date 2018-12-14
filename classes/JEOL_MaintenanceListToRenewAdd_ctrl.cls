public with sharing class JEOL_MaintenanceListToRenewAdd_ctrl extends JEOL_SearchBase_ctrl {
    
    public String renewalMonth{get; set;}
    public String customerCode{get; set;}
    public String customerName{get; set;}    
    public String custCodeType{get; set;}
    public String custNameType{get; set;}
    public String jeolPipelineResponsible{get; set;}
    public String orderNo{get; set;}
    public String netMaintenance{get; set;}
    public String shipmentAddress{get; set;}
    public String unitBody{get; set;}
    
    public id dataId{get; set;}

    private List<String> targetSeries;
    public List<OptionDetail> SeriesOptions{get; set;}
    private List<String> targetRegions;
    public List<OptionDetail> RegionsOptions{get; set;}
    
    private static final String COOKIE_LABEL_RENEWAL_MONTH = 'JEOL_MaintenanceListToRenewAdd_RenewalMonth';
    private static final String COOKIE_LABEL_CUSTOMER_CODE = 'JEOL_MaintenanceListToRenewAdd_CustomerCode';
    private static final String COOKIE_LABEL_CUSTOMER_NAME = 'JEOL_MaintenanceListToRenewAdd_CustomerName';
    private static final String COOKIE_LABEL_CUSTCODETYPE = 'JEOL_MaintenanceListToRenewAdd_CustCodeType';
    private static final String COOKIE_LABEL_CUSTNAMETYPE = 'JEOL_MaintenanceListToRenewAdd_CustNameType';
    private static final String COOKIE_LABEL_JEOLPIPELINERESPONSIBLE = 'JEOL_MaintenanceListToRenew_JeolPipelineResponsible';
    private static final String COOKIE_LABEL_ORDERNO = 'JEOL_MaintenanceListToRenewAdd_OrderNo';
    private static final String COOKIE_LABEL_NETMAINTENANCE = 'JEOL_MaintenanceListToRenewAdd_NetMaintenance';
    private static final String COOKIE_LABEL_SHIPMENTADDRESS = 'JEOL_MaintenanceListToRenewAdd_ShipmentAddress';
    private static final String COOKIE_LABEL_UNITBODY = 'JEOL_MaintenanceListToRenewAdd_UnitBody';
    private static final String COOKIE_LABEL_TARGETSERIES = 'JEOL_MaintenanceListToRenewAdd_TargetSeries';
    private static final String COOKIE_LABEL_TARGETREGIONS = 'JEOL_MaintenanceInspectionList_TargetRegions';
   
    private static final String COOKIE_LABEL_PAGE_NUMBER = 'PageNumber';
    private static final String COOKIE_LABEL_PAGE_SIZE = 'PageSize';
    private static final String COOKIE_PATH = '/apex/JEOL_MaintenanceListToRenewAdd';
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

    public JEOL_MaintenanceListToRenewAdd_ctrl() {

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
        for (SelectOption option: JEOLUtil.getSelectList(false, JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA, true)) { // For this screen the search is done by Label so the "true"
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
        if (cookies.containsKey(COOKIE_LABEL_CUSTOMER_CODE)) {
            this.customerCode = cookies.get(COOKIE_LABEL_CUSTOMER_CODE).getValue();
        }
        if (cookies.containsKey(COOKIE_LABEL_CUSTOMER_NAME)) {
            this.customerName = cookies.get(COOKIE_LABEL_CUSTOMER_NAME).getValue();
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
        if (cookies.containsKey(COOKIE_LABEL_ORDERNO)) {
            this.orderNo = cookies.get(COOKIE_LABEL_ORDERNO).getValue();
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
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMER_CODE, this.customerCode, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTOMER_NAME, this.customerName, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTCODETYPE, this.custCodeType, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_CUSTNAMETYPE, this.custNameType, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_JEOLPIPELINERESPONSIBLE, this.jeolPipelineResponsible, COOKIE_PATH, -1, true));
        cookies.add(new Cookie(COOKIE_LABEL_ORDERNO, this.orderNo, COOKIE_PATH, -1, true));
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

        
    public override void setStandardSetController() {

        String soql = ' SELECT ' +
                          '  Id, Name, Series__c, MaintenanceEndDateFormula__c, MaintenanceEndDate__c, ContractStopDate__c, MaintenanceRenewalMonth__c, Area__c, ' +
                          ' SalesAccount__c, SalesTantoshya__c, MaintenanceStartDateFormula__c, UnitBody__c, ConsumptionTax__c, ShipmentAccount__c, ModelPi__c, ' +
                          ' MaintenanceType__c ' +
                      ' FROM ' +
                          ' SalesOrder__c ';

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
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintRenewalAdd_Message_TooMuchData));
        } else {
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);
        }
    }
    
    public void doFormClear() {
        renewalMonth = null;
        customerCode = null;
        customerName = null;
        custCodeType = '1';
        custNameType = '1';
        jeolPipelineResponsible = null;
        orderNo = null;
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
        rows = new List<rowWrapper>();
        Integer currentCount = 0;
        
        if(ssc != null) {
            for (SalesOrder__c row: (List< SalesOrder__c >)ssc.getRecords()) {
                rowWrapper orderPlan = new rowWrapper(row, currentCount);
                rows.add(orderPlan);
                currentCount++;
            }
        }
        return rows;
    }
    
    /*  検索結果の設定　*/
    public class rowWrapper{
        public SalesOrder__c rec {get; set;}
        public Integer rowNumber {get; set;}
        
        public rowWrapper(SalesOrder__c rec, Integer rowNumber) {
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

    public void addContractMaintenance() {

        List<id> lsId = new List<id>();
        lsId.add(dataId);
        addContractMaintenanceList(lsId, false, null, null);
        setStandardSetController();

    }

    public void addContractMaintenanceAll() {

        List<id> lsId = new List<id>();
        for (rowWrapper row : rows) {
            lsId.add(row.rec.id);
        }
        addContractMaintenanceList(lsId, false, null, null);
        setStandardSetController();
    }

    public void dummyaction() {}
    
    private static boolean addContractMaintenanceList(List<id> lsId, boolean isBatch, List<Integer> nbRowsInserted, List<String> messageError) {

        if (nbRowsInserted != NULL && nbRowsInserted.size() > 0) {
            nbRowsInserted[0] = 0;
        }
        if (messageError != NULL && messageError.size() > 0) {
            messageError[0] = '';
        }

        try {

            List<MaintenanceContractManagement__c> lsToBeAded = new List<MaintenanceContractManagement__c>();
            
            List<SalesOrder__c> lsSO = [SELECT Id, Name, Series__c, MaintenanceEndDateFormula__c, MaintenanceEndDate__c, ContractStopDate__c, MaintenanceRenewalMonth__c, Area__c,
                                               SalesAccount__c, ConsumptionTax__c, MaintenanceStartDateFormula__c, UnitBodyLink__c, ShipmentAccount__c, NetMaintenance__c,
                                               SalesContactPosition__c, SalesContactPost__c, SalesTantoshya__c, SalesContactFax__c, SalesContactTel__c, ShipmentContactPosition__c, ShipmentContactPost__c,
                                               ShipmentTantosha__c, ShipmentContact_Tel__c, ShipmentContact_Fax__c, FlagshipProduct__c, SalesAccount__r.PostalCode__c, SalesOffice__c, TradingCompanyInvolved__c,
                                               OrdersMemp__c, SalesStaffCode__c, AssistantCode__c, RoutineCheck__c, Troubleshooting__c, Notices1__c, Notices2__c, RepairParts__c, Att__c, Other1__c, Other2__c,
                                               ShareOrderAmount__c, CommissionOrderAmount__c, MaintenanceType__c, SalesNoOfTimes__c, ProductNumber__c, ItemName__c, ShipmentAccount__r.Name, 
                                               SalesAccount__r.AddressLine1__c, SalesAccount__r.AddressLine2__c, SalesAccount__r.AddressLine3__c, SalesAccount__r.Name, SalesAccount__r.Undergraduate__c
                                        FROM SalesOrder__c
                                        WHERE id IN :lsId
                                        AND Id NOT IN (SELECT PreviousYearOrder__c FROM MaintenanceContractManagement__c)
                                       ];

            List<String> lsArea = new List<String>();
            List<String> lsUserCode = new List<String>();
            List<String> lsDepartment = new List<String>();
            
            for (SalesOrder__c so : lsSO) {
                if (so.Area__c != null && so.Area__c.length() > 0) {
                    lsArea.add(so.Area__c);
                }
                if (so.SalesStaffCode__c != null && so.SalesStaffCode__c.length() > 0) {
                    lsUserCode.add(so.SalesStaffCode__c);
                }
                if (so.AssistantCode__c != null && so.AssistantCode__c.length() > 0) {
                    lsUserCode.add(so.AssistantCode__c);
                }            
                if (so.SalesOffice__c != null && so.SalesOffice__c.length() > 0) {
                    lsDepartment.add(so.SalesOffice__c);
                }            
            }
            
            // Get the list of Area Code
            List<SelectListManage__c> lsAreaCode = [SELECT Value__c, Label__c
                                                    FROM SelectListManage__c
                                                    WHERE ReferenceName__c =: JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA
                                                    AND Label__c IN :lsArea
                                                    ORDER BY SortNo__c desc, Value__c desc
                                                   ];
                                                   
            Map<String, String> mpAreaCode = new Map<String, String>();
            if (lsAreaCode != null && lsAreaCode.size() > 0) {
                for (SelectListManage__c slm : lsAreaCode) {
                    mpAreaCode.put(slm.Label__c, slm.Value__c);
                }
            }


            // Get the list of the users
            List<User> lsUsers = [SELECT id, UserCode__c, Phone, Fax
                                  FROM User
                                  WHERE UserCode__c IN :lsUserCode
                                  ORDER BY LastModifiedDate desc
                                 ];
                                                   
            Map<String, User> mpUsers = new Map<String, User>();
            if (lsUsers != null && lsUsers.size() > 0) {
                for (User usr : lsUsers) {
                    mpUsers.put(usr.UserCode__c, usr);
                }
            }


            // Get the list of the departments
            List<Department__c> lsDept = [SELECT id, DepartmentCode__c
                                          FROM Department__c
                                          WHERE DepartmentCode__c IN :lsDepartment
                                          ORDER BY LastModifiedDate desc
                                         ];
                                                   
            Map<String, Department__c> mpDepts = new Map<String, Department__c>();
            if (lsDept != null && lsDept.size() > 0) {
                for (Department__c dpt : lsDept) {
                    mpDepts.put(dpt.DepartmentCode__c, dpt);
                }
            }


            // Get the list of the previous year pipelines
            List<MaintenanceContractManagement__c> lsPipeline = [SELECT id, UnitBody__c, AnnaiType__c, JeolPipelineResponsible__c, JeolPipelineResponsible2__c, RenewalPostalCode__c, RenewalAddress__c, RenewalAddress2__c, 
                                                                        JEOLRegionName__c, JEOLContactPosition__c, JEOLReplyRegionName__c, JEOLReplyContactPosition__c, NewOdrSalesOrder__c, RenewalCompanyName__c,
                                                                        RenewalUndergraduate__c, RenewalDeliveryLocation__c, RenewalItemsName__c, RenewalListOptions__c, RenewalCustomerNameReply__c, RenewalTopSectionText__c,
                                                                        RenewalFooterComment__c, RenewalOptionDateFormat__c, RenewalOptionCustomerNameLabel__c, RenewalOptionHideChangeInfo__c, JEOLContactTel__c, JEOLReplyContactFax__c,
                                                                        NewOdrSalesStaff__c, NewOdrAssistant__c, PreviousYearOrder__c
                                                                 FROM MaintenanceContractManagement__c
                                                                 WHERE NewOdrSalesOrder__c IN :lsId
                                                                 ORDER BY Name asc
                                                                ];
                                                   
            Map<id, MaintenanceContractManagement__c> mpPipelineRespObj = new Map<id, MaintenanceContractManagement__c>();
            if (lsPipeline != null && lsPipeline.size() > 0) {
                for (MaintenanceContractManagement__c pip : lsPipeline) {
                    mpPipelineRespObj.put(pip.NewOdrSalesOrder__c, pip);
                }
            }
                                       

            for (SalesOrder__c so : lsSO) {
            
                MaintenanceContractManagement__c row = new MaintenanceContractManagement__c();

                row.PreviousYearOrder__c = so.id;
                row.NewOdrSeries__c = so.Series__c;
                row.UnitBody__c = so.UnitBodyLink__c;
                
                if (mpAreaCode != null && mpAreaCode.containsKey(so.Area__c)) {
                    row.NewOdrRegion__c =  mpAreaCode.get(so.Area__c); //Insert the code, not the label
                }

                if (mpDepts != null && mpDepts.containsKey(so.SalesOffice__c)) {
                    row.NewOdrDepartment__c =  mpDepts.get(so.SalesOffice__c).id;
                }
                
                if (so.MaintenanceEndDateFormula__c != null) {
                    row.NewContractStartDate__c = so.MaintenanceEndDateFormula__c.addDays(1);
                    row.NewContractEndDate__c = row.NewContractStartDate__c.addYears(1).addDays(-1);      
                }
                
                if (so.MaintenanceEndDateFormula__c != null && so.MaintenanceStartDateFormula__c != null && (so.MaintenanceEndDateFormula__c == so.MaintenanceStartDateFormula__c.addYears(1).addDays(-1) || so.MaintenanceEndDateFormula__c == so.MaintenanceStartDateFormula__c.addYears(1))) {        
                    row.NewContractAmount__c = so.ConsumptionTax__c;
                }

                row.RenewalAccount__c = so.SalesAccount__c;

                row.RenewalContactPosition__c = so.SalesContactPosition__c;
                row.RenewalTantoshya__c = so.SalesTantoshya__c;
                row.RenewalContactFax__c = so.SalesContactFax__c;
                row.RenewalContactTel__c = so.SalesContactTel__c;

                if (mpPipelineRespObj != null && mpPipelineRespObj.containsKey(so.id)) {
                    row.PreviousYearPipeline__c =  mpPipelineRespObj.get(so.id).id; 
                    row.NewOdrSalesStaff__c = mpPipelineRespObj.get(so.id).NewOdrSalesStaff__c;
                    row.NewOdrAssistant__c = mpPipelineRespObj.get(so.id).NewOdrAssistant__c;    
                } else {
        
                    if (mpUsers != null && mpUsers.containsKey(so.SalesStaffCode__c)) {
                        row.NewOdrSalesStaff__c =  mpUsers.get(so.SalesStaffCode__c).id;
                    }
                    if (mpUsers != null && mpUsers.containsKey(so.AssistantCode__c)) {
                        row.NewOdrAssistant__c =  mpUsers.get(so.AssistantCode__c).id;
                    }

                }

                if (mpPipelineRespObj != null && mpPipelineRespObj.containsKey(so.id) &&
                                                 mpPipelineRespObj.get(so.id).PreviousYearOrder__c != null) {

                    row.AnnaiType__c = mpPipelineRespObj.get(so.id).AnnaiType__c; 

                    row.JeolPipelineResponsible__c = mpPipelineRespObj.get(so.id).JeolPipelineResponsible__c; 
                    row.JeolPipelineResponsible2__c = mpPipelineRespObj.get(so.id).JeolPipelineResponsible2__c;
                    row.RenewalPostalCode__c = mpPipelineRespObj.get(so.id).RenewalPostalCode__c;
                    row.RenewalAddress__c = mpPipelineRespObj.get(so.id).RenewalAddress__c;
                    row.RenewalAddress2__c = mpPipelineRespObj.get(so.id).RenewalAddress2__c;
                    row.JEOLRegionName__c = mpPipelineRespObj.get(so.id).JEOLRegionName__c;
                    row.JEOLContactPosition__c = mpPipelineRespObj.get(so.id).JEOLContactPosition__c;
                    row.JEOLContactTel__c = mpPipelineRespObj.get(so.id).JEOLContactTel__c;
                    row.JEOLReplyRegionName__c = mpPipelineRespObj.get(so.id).JEOLReplyRegionName__c;
                    row.JEOLReplyContactPosition__c = mpPipelineRespObj.get(so.id).JEOLReplyContactPosition__c;
                    row.JEOLReplyContactFax__c = mpPipelineRespObj.get(so.id).JEOLReplyContactFax__c;

                    row.RenewalCompanyName__c = mpPipelineRespObj.get(so.id).RenewalCompanyName__c;
                    row.RenewalUndergraduate__c = mpPipelineRespObj.get(so.id).RenewalUndergraduate__c;
                    row.RenewalDeliveryLocation__c = mpPipelineRespObj.get(so.id).RenewalDeliveryLocation__c;
                    row.RenewalItemsName__c = mpPipelineRespObj.get(so.id).RenewalItemsName__c;
                    row.RenewalListOptions__c = mpPipelineRespObj.get(so.id).RenewalListOptions__c;
                    row.RenewalCustomerNameReply__c = mpPipelineRespObj.get(so.id).RenewalCustomerNameReply__c;
                    row.RenewalTopSectionText__c = mpPipelineRespObj.get(so.id).RenewalTopSectionText__c;
                    row.RenewalFooterComment__c = mpPipelineRespObj.get(so.id).RenewalFooterComment__c;
                    row.RenewalOptionDateFormat__c = mpPipelineRespObj.get(so.id).RenewalOptionDateFormat__c;
                    row.RenewalOptionCustomerNameLabel__c = mpPipelineRespObj.get(so.id).RenewalOptionCustomerNameLabel__c;
                    row.RenewalOptionHideChangeInfo__c = mpPipelineRespObj.get(so.id).RenewalOptionHideChangeInfo__c;

        
                } else {
        
                    row.RenewalPostalCode__c = so.SalesAccount__r.PostalCode__c;
                    String sAddress1 = '';
                    String sAddress2 = '';
                    if (so.SalesAccount__c != null) {
                        if (so.SalesAccount__r.AddressLine1__c != null) {
                            sAddress1 += so.SalesAccount__r.AddressLine1__c;
                        }
                        if (so.SalesAccount__r.AddressLine2__c != null) {
                            sAddress1 += so.SalesAccount__r.AddressLine2__c;
                        }
                        if (so.SalesAccount__r.AddressLine3__c != null) {
                            sAddress2 += so.SalesAccount__r.AddressLine3__c;
                        }
                    }
                    row.RenewalAddress__c = sAddress1;
                    row.RenewalAddress2__c = sAddress2;

                    row.RenewalCompanyName__c = so.SalesAccount__r.Name;
                    row.RenewalUndergraduate__c = so.SalesAccount__r.Undergraduate__c;
                    row.RenewalDeliveryLocation__c = so.ShipmentAccount__r.Name;
                    row.RenewalItemsName__c = so.ItemName__c;
    //              row.RenewalListOptions__c = 
                    // Removed (UAT #120) row.RenewalCustomerNameReply__c = so.SalesAccount__r.Name; 
    //Default value used                row.RenewalTopSectionText__c = '   なお、ご契約手続につきましては、お手数ですが、年間保守契約継続依頼書に必要事項をご記入\nのうえ、ＦＡＸまたは郵送にてご返送いただければ幸いと存じます。　　　　　　　　　　　　　　　　　　　敬　具';
    //              row.RenewalFooterComment__c = 
    //              row.RenewalOptionDateFormat__c = 
    //              row.RenewalOptionCustomerNameLabel__c = 
    //              row.RenewalOptionHideChangeInfo__c = 

                    if (mpUsers != null && mpUsers.containsKey(so.SalesStaffCode__c)) {
                        row.JeolPipelineResponsible__c = mpUsers.get(so.SalesStaffCode__c).id;
                        // row.JEOLContactPosition__c = mpUsers.get(so.SalesStaffCode__c).XXX;
                        row.JEOLContactTel__c = mpUsers.get(so.SalesStaffCode__c).Phone;
                        
                    }
                    if (mpUsers != null && mpUsers.containsKey(so.AssistantCode__c)) {
                        row.JeolPipelineResponsible2__c =  mpUsers.get(so.AssistantCode__c).id;
                        // row.JEOLReplyContactPosition__c =  mpUsers.get(so.AssistantCode__c).XXX;
                        row.JEOLReplyContactFax__c =  mpUsers.get(so.AssistantCode__c).Fax;
                    }

                    row.JEOLRegionName__c = so.Area__c;
                    row.JEOLReplyRegionName__c =  so.Area__c;
                            
                }


                //row.NewOdrName__c = null;
                row.NewOdrNetMaintenance__c = so.NetMaintenance__c;
                row.NewOdrSalesAccount__c = so.SalesAccount__c;
                row.NewOdrSalesContactPosition__c = so.SalesContactPosition__c;
                row.NewOdrSalesContactPost__c = so.SalesContactPost__c;
                row.NewOdrSalesTantoshya__c = so.SalesTantoshya__c;
                row.NewOdrSalesContactTel__c = so.SalesContactTel__c;
                row.NewOdrSalesContactFax__c = so.SalesContactFax__c;
                row.NewOdrShipmentAccount__c = so.ShipmentAccount__c;
                row.NewOdrShipmentContactPosition__c = so.ShipmentContactPosition__c;
                row.NewOdrShipmentContactPost__c = so.ShipmentContactPost__c;
                row.NewOdrShipmentTantosha__c = so.ShipmentTantosha__c;
                row.NewOdrShipmentContact_Tel__c = so.ShipmentContact_Tel__c;
                row.NewOdrShipmentContact_Fax__c = so.ShipmentContact_Fax__c;

                row.NewOdrOrdersMemp__c = so.OrdersMemp__c;


                row.NewOdrFlagshipProduct__c = so.FlagshipProduct__c;
                row.NewOdrRoutineCheck__c = so.RoutineCheck__c;
                row.NewOdrTroubleshooting__c = so.Troubleshooting__c;
                row.NewOdrNotices1__c = so.Notices1__c;
                row.NewOdrNotices2__c = so.Notices2__c;
                row.NewOdrRepairParts__c = so.RepairParts__c;
                row.NewOdrAtt__c = so.Att__c;
                row.NewOdrOther1__c = so.Other1__c;
                row.NewOdrOther2__c = so.Other2__c;

                row.NewOdrMaintenanceStartDate__c = row.NewContractStartDate__c;
                row.NewOdrMaintenanceEndDate__c = row.NewContractEndDate__c;      
                row.NewOdrContractAmountt__c = row.NewContractAmount__c;     

                if (so.TradingCompanyInvolved__c != null && so.TradingCompanyInvolved__c.length() > 0) {
                    if (so.TradingCompanyInvolved__c == '有') {
                        row.NewOdrTradingCompanyInvolved__c = '1';     
                    } else if (so.TradingCompanyInvolved__c == '無') {
                        row.NewOdrTradingCompanyInvolved__c = '2';                     
                    }
                }

                row.NewOdrShareOrderAmount__c = so.ShareOrderAmount__c;
                row.NewOdrCommissionOrderAmount__c = so.CommissionOrderAmount__c;

                if (so.MaintenanceType__c != null && so.MaintenanceType__c.length() > 0) {
                    if (so.MaintenanceType__c == '基本契約１') {
                        row.NewOdrMaintenanceType__c = '1';     
                    } else if (so.MaintenanceType__c == '基本契約２') {
                        row.NewOdrMaintenanceType__c = '2';                     
                    } else if (so.MaintenanceType__c == '限定契約１') {
                        row.NewOdrMaintenanceType__c = '3';                     
                    } else if (so.MaintenanceType__c == '限定契約２') {
                        row.NewOdrMaintenanceType__c = '4';                     
                    } else if (so.MaintenanceType__c == 'その他') {
                        row.NewOdrMaintenanceType__c = '5';                     
                    } else if (so.MaintenanceType__c == 'He充填契約') {
                        row.NewOdrMaintenanceType__c = '6';                     
                    } else if (so.MaintenanceType__c == '未設定') {
                        row.NewOdrMaintenanceType__c = '99';                     
                    }
                }

                row.NewOdrNewUpdated__c = '2';
                row.NewOdrSalesNoOfTimes__c = so.SalesNoOfTimes__c;

                // Initialise the product number XM9391501014039
                //                               XM              系列
                //                                 939           Fixed for Maintenance
                //                                    15         Fiscal Year of the new contract
                //                                      010      地域
                //                                         14039 Code determined the 1st year (the 14 is the fiscal year of the 1st time)
                String sTmp = so.ProductNumber__c;
                if (sTmp != null && sTmp.length() == 15) {
                    if (row.NewContractStartDate__c != null) {
                        integer iFiscalYear = JEOLUtil.getFiscalYear(row.NewContractStartDate__c, true);
                        String sFiscalYear = ((iFiscalYear < 10) ? '0' : '') + iFiscalYear;
                        if (sTmp.substring(5, 7) != sFiscalYear) { // If it is the same, make it null by default (case 2 contracts the same year)
                            row.ProductNumber__c = sTmp.substring(0, 5) + sFiscalYear + sTmp.substring(7);
                        }
                    }
                }

                // row.QuotationCreated__c = false;
                // row.ContractSentDate__c = null;
                // row.QuotationSentDate__c = null;
                // row.RenewalNoticeSentDate__c = null;
                // row.RenewalNoticeCreated__c = false;
                // row.RenewalApproved__c = false;
                // row.PipelineStopped__c = false;
                // row.PipelineStoppedReason__c = null;

                // row.Memo__c = null;
                // row.NextYearNotes__c = null;          
                // row.LinkageStatus__c = default value;          
                
                lsToBeAded.add(row);
            }
            
            if (lsToBeAded != null && lsToBeAded.size() > 0) {
                insert lsToBeAded;

                if (nbRowsInserted != NULL && nbRowsInserted.size() > 0) {
                    nbRowsInserted[0] = lsToBeAded.size();
                }

                if (!isBatch) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Label.JEOL_MaintRenewalAdd_Message_DataAdded));
                }
            }

            return true;

        } catch(Exception e) {

            if (messageError != NULL && messageError.size() > 0) {
                messageError[0] = 'JEOL_MaintenanceListToRenewAdd_ctrl.addContractMaintenanceList でエラーが発生しました。' + e.getMessage();
            }
            return false;

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

    private String getSqlDate(Date dDate) {
        return ('' + dDate.year()).leftPad(4, '0') + '-' + ('' + dDate.month()).leftPad(2, '0') + '-' + ('' + dDate.day()).leftPad(2, '0');
    }
    
    private List<String> getWhereStrList() {
    
        date dTodayFirstDay = Date.newInstance(date.today().year(), date.today().month(), 1);

        this.errFlg = false;  // エラーフラグ初期化
        List<String> strList = new List<String>();

        strList.add('Id NOT IN (SELECT PreviousYearOrder__c from MaintenanceContractManagement__c)');
        strList.add('MaintenanceEndDateFormula__c >= ' + getSqlDate(dTodayFirstDay.addMonths(-6)));
        strList.add(JEOLUtil.appendEqualText('SalesOrderTypeCode__c', '4A1'));
        strList.add(JEOLUtil.appendEqualText('UpdateStatus__c', '契約中'));
        strList.add(JEOLUtil.appendNotEqualText('OrderStatus__c', '取消'));

        if (String.isNotBlank(this.renewalMonth)) {
            strList.add(JEOLUtil.appendAfterLikeText('MaintenanceRenewalMonth__c', this.renewalMonth));
        }
        if (this.targetSeries != null && this.targetSeries.size() > 0) {
            strList.add(JEOLUtil.appendInText('Series__c', this.targetSeries));
        }
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
             strList.add(JEOLUtil.appendInText('Area__c', this.targetRegions)); //compared to the label
        }

        // 販売先・出荷先コード
        if (String.isNotBlank(this.customerCode)) {
            if (custCodeType == '2') {
                // 出荷先
                strList.add(JEOLUtil.appendAfterLikeText('ShipmentAccountCode__c', this.customerCode));
            } else {
                // 販売先            
                strList.add(JEOLUtil.appendAfterLikeText('SalesAccountCode__c', this.customerCode));
            }
        }
        
        // 販売先・出荷先名称
        if (String.isNotBlank(this.customerName)) {
            if (custNameType == '2') {
                // 出荷先
                strList.add(JEOLUtil.appendLikeText('ShipmentAccountName__c', this.customerName));
            } else {
                // 販売先            
                strList.add(JEOLUtil.appendLikeText('SalesAccountName__c', this.customerName));
            }
        }

       // 更新担当者
        if (String.isNotBlank(this.jeolPipelineResponsible)) {
            strList.add('((' +
                        JEOLUtil.appendAfterLikeText('AssistantCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('Assistant__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('SalesStaffCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('SalesStaff__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrSalesStaff__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('MaintenanceContractManagement__r.NewOdrSalesStaff__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrAssistant__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('MaintenanceContractManagement__r.NewOdrAssistant__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.JeolPipelineResponsible__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('MaintenanceContractManagement__r.JeolPipelineResponsible__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.JeolPipelineResponsible2__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('MaintenanceContractManagement__r.JeolPipelineResponsible2__r.Name', this.jeolPipelineResponsible) +
                        '))' );
        }        
        
        // 住所               
        if (String.isNotBlank(this.shipmentAddress)) {
            strList.add(JEOLUtil.appendLikeText('ShipmentAddress__c', this.shipmentAddress));
        }

        // 本体号機
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('UnitBodyLink__r.Name', this.unitBody));
        }

        // 更新担当者
        if (String.isNotBlank(this.orderNo)) {
            strList.add(JEOLUtil.appendAfterLikeText('Name', this.orderNo));
        }
        
        // NET区分
        if (String.isNotBlank(this.netMaintenance)) {
            strList.add(JEOLUtil.appendEqualText('NetMaintenance__c', this.netMaintenance));
        }
        
        return strList;
    }

    /**
     * Add the contract maintenance from the SalesOrder table. 
     *
     * @param   nbRowsInserted Number of rows inserted
     * @param   messageError   Error messagethe location of the image, relative to the url argument
     * @return                 Indicates if the execution of the method has been a success
     */
     public static boolean addContractMaintenanceBatch(Integer nbRowsMax, List<Integer> nbRowsInserted, List<String> messageError) {

        try {
            date dTodayFirstDay = Date.newInstance(date.today().year(), date.today().month(), 1);
            
            List<SalesOrder__c> lsSO;

            if (nbRowsMax != NULL) {
                lsSO = [SELECT Id
                        FROM SalesOrder__c
                        WHERE Id NOT IN (SELECT PreviousYearOrder__c from MaintenanceContractManagement__c)
                        AND MaintenanceEndDateFormula__c >= :dTodayFirstDay
                        AND MaintenanceEndDateFormula__c < :dTodayFirstDay.addMonths(4)
                        AND SalesOrderTypeCode__c = '4A1'
                        AND UpdateStatus__c = '契約中'
                        AND OrderStatus__c <> '取消'
                        LIMIT :nbRowsMax];
            } else {
                lsSO = [SELECT Id
                        FROM SalesOrder__c
                        WHERE Id NOT IN (SELECT PreviousYearOrder__c from MaintenanceContractManagement__c)
                        AND MaintenanceEndDateFormula__c >= :dTodayFirstDay
                        AND MaintenanceEndDateFormula__c < :dTodayFirstDay.addMonths(4)
                        AND SalesOrderTypeCode__c = '4A1'
                        AND UpdateStatus__c = '契約中'
                        AND OrderStatus__c <> '取消'];
            }

            List<id> lsId = new List<id>();
            for (SalesOrder__c so : lsSO) {
                lsId.add(so.id);
            }

            return addContractMaintenanceList(lsId, true, nbRowsInserted, messageError);

        } catch (Exception e) {

            if (messageError != NULL && messageError.size() > 0) {
                messageError[0] = 'JEOL_MaintenanceListToRenewAdd_ctrl.addContractMaintenanceBatch でエラーが発生しました。' + e.getMessage();
            }
            return false;

        }

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