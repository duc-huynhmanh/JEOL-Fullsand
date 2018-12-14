@isTest
private class JEOL_MaintenanceBillingList_ctrlTest {
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    // Test Account (取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceBillingList_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceBillingList_ctrl_Test01() {
        //preparation
        List<Cookie> cookieList = setCurrentCookie();
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceBillingList;
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().setCookies(cookieList);
        //Test Start
        Test.startTest();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getCCategoryOptions Method
     * MethodName : getCCategoryOptions_Test
     */
    private static testMethod void getCCategoryOptions_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.getCCategoryOptions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getRegionOptions Method
     * MethodName : getRegionOptions_Test
     */
    private static testMethod void getRegionOptions_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.getRegionOptions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getTypeOptions Method
     * MethodName : getTypeOptions_Test
     */
    private static testMethod void getTypeOptions_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.getTypeOptions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getNetMaintenanceOptions Method
     * MethodName : getNetMaintenanceOptions_Test
     */
    private static testMethod void getNetMaintenanceOptions_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.getNetMaintenanceOptions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getStatusOptions Method
     * MethodName : getStatusOptions_Test
     */
    private static testMethod void getStatusOptions_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.getStatusOptions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test seriesSelectCancel Method
     * MethodName : seriesSelectCancel_Test
     */
    private static testMethod void seriesSelectCancel_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.seriesSelectCancel();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test seriesSelectApply Method
     * MethodName : seriesSelectApply_Test
     */
    private static testMethod void seriesSelectApply_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        for(JEOL_MaintenanceBillingList_ctrl.OptionDetail od : ctrl.SeriesOptions){
            od.isSelected = true;
        }
        //Test Start
        Test.startTest();
        ctrl.seriesSelectApply();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test seriesSelectAllSelect Method
     * MethodName : seriesSelectAllSelect_Test
     */
    private static testMethod void seriesSelectAllSelect_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.seriesSelectAllSelect();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test seriesSelectAllDeselect Method
     * MethodName : seriesSelectAllDeselect_Test
     */
    private static testMethod void seriesSelectAllDeselect_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.seriesSelectAllDeselect();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getSelectedSeries Method
     * MethodName : getSelectedSeries_Test01
     */
    private static testMethod void getSelectedSeries_Test01() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        for(JEOL_MaintenanceBillingList_ctrl.OptionDetail od : ctrl.SeriesOptions){
            od.isSelected = true;
        }
        //Test Start
        Test.startTest();
        ctrl.getSelectedSeries();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getSelectedSeries Method
     * MethodName : getSelectedSeries_Test02
     */
    private static testMethod void getSelectedSeries_Test02() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        Integer i = 1;
        for(JEOL_MaintenanceBillingList_ctrl.OptionDetail od : ctrl.SeriesOptions){
            if(Math.mod(i, 2) == 1 ){
                od.isSelected = true;
            }
            i ++;
        }
        //Test Start
        Test.startTest();
        ctrl.getSelectedSeries();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test regionsSelectCancel Method
     * MethodName : regionsSelectCancel_Test
     */
    private static testMethod void regionsSelectCancel_Test() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.regionsSelectCancel();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test RegionsSelectApply Method
     * MethodName : RegionsSelectApply_Test
     */
    private static testMethod void RegionsSelectApply_Test() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        for(JEOL_MaintenanceBillingList_ctrl.OptionDetail od : ctrl.RegionsOptions){
            od.isSelected = true;
        }
        //Test Start
        Test.startTest();
        ctrl.RegionsSelectApply();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test regionsSelectAllSelect Method
     * MethodName : regionsSelectAllSelect_Test
     */
    private static testMethod void regionsSelectAllSelect_Test() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.regionsSelectAllSelect();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test regionsSelectAllDeselect Method
     * MethodName : regionsSelectAllDeselect_Test
     */
    private static testMethod void regionsSelectAllDeselect_Test() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.regionsSelectAllDeselect();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getSelectedRegions Method
     * MethodName : getSelectedRegions_Test01
     */
    private static testMethod void getSelectedRegions_Test01() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        for(JEOL_MaintenanceBillingList_ctrl.OptionDetail od : ctrl.RegionsOptions){
            od.isSelected = true;
        }
        //Test Start
        Test.startTest();
        ctrl.getSelectedRegions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getSelectedRegions Method
     * MethodName : getSelectedRegions_Test02
     */
    private static testMethod void getSelectedRegions_Test02() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        Integer i = 1;
        for(JEOL_MaintenanceBillingList_ctrl.OptionDetail od : ctrl.RegionsOptions){
            if(i == 1 ){
                od.isSelected = true;
            }
            i ++;
        }
        //Test Start
        Test.startTest();
        ctrl.getSelectedRegions();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test doFormClear Method
     * MethodName : getSelectedRegions_Test
     */
    private static testMethod void doFormClear_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.doFormClear();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getSalesPipelines Method
     * MethodName : getSalesPipelines_Test
     */
    private static testMethod void getSalesPipelines_Test() {
        //preparation
        List<SelectListManage__c> testSLMList = createTestData();
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.getSalesPipelines();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test doSearch Method
     * MethodName : doSearch_Test01
     */
    private static testMethod void doSearch_Test01() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        ctrl.status = '1';
        //Test Start
        Test.startTest();
        ctrl.doSearch();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test doSearch Method
     * MethodName : doSearch_Test02
     */
    private static testMethod void doSearch_Test02() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        ctrl.status = '2';
        //Test Start
        Test.startTest();
        ctrl.doSearch();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test nextAndSaveCurrentPageNumber Method
     * MethodName : nextAndSaveCurrentPageNumber_Test
     */
    private static testMethod void nextAndSaveCurrentPageNumber_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        ctrl.doSearch();
        //Test Start
        Test.startTest();
        ctrl.nextAndSaveCurrentPageNumber();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test previousAndSaveCurrentPageNumber Method
     * MethodName : previousAndSaveCurrentPageNumber_Test
     */
    private static testMethod void previousAndSaveCurrentPageNumber_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.previousAndSaveCurrentPageNumber();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test firstAndSaveCurrentPageNumber Method
     * MethodName : firstAndSaveCurrentPageNumber_Test
     */
    private static testMethod void firstAndSaveCurrentPageNumber_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.firstAndSaveCurrentPageNumber();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test lastAndSaveCurrentPageNumber Method
     * MethodName : lastAndSaveCurrentPageNumber_Test
     */
    private static testMethod void lastAndSaveCurrentPageNumber_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.lastAndSaveCurrentPageNumber();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test setJumpSaveCurrentPageSize Method
     * MethodName : setJumpSaveCurrentPageSize_Test
     */
    private static testMethod void setJumpSaveCurrentPageSize_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        ctrl.doSearch();
        //Test Start
        Test.startTest();
        ctrl.setJumpSaveCurrentPageSize();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test saveFlags Method
     * MethodName : saveFlags_Test
     */
    private static testMethod void saveFlags_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);

        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startD, endD);

        //MaintenanceAccountBook(保守台帳管理)
        MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
        testMab.BillingDone__c = true;
        testMab.SalesAmountEstimate__c = 2000.000;
        testMab.MaintenanceContractManagement__c = testMcm.Id;
        testMab.SalesAuto__c = true;
        testMab.InvoiceNumber__c = 'M00000001';
        testMab.InvoiceNumberAuto__c = 'J00000001';
        testMab.TaxCode__c = 'B01';
        testMab.ItemName__c = 'テストアイテム名';
        testMab.BillingAmountEstimate__c = 1000;
        testMab.Month__c = '201505';
        System.runAs (testUser) {
            insert testMab;
        }
        //insert testMab;

        ctrl.dataId = testMab.Id;
        ctrl.getSalesPipelines();
        //Test Start
        Test.startTest();
        ctrl.saveFlags();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test setSizeSaveCurrentPageSize Method
     * MethodName : setSizeSaveCurrentPageSize_Test
     */
    private static testMethod void setSizeSaveCurrentPageSize_Test() {
        //preparation
        JEOL_MaintenanceBillingList_ctrl ctrl = new JEOL_MaintenanceBillingList_ctrl();
        //Test Start
        Test.startTest();
        ctrl.setSizeSaveCurrentPageSize();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description:Create SelectListManage TestData(選択リスト管理テストデータ作成)
     * MethodName :createTestData
     * @ return 選択リスト管理リスト
     */
    private static List<SelectListManage__c> createTestData(){
        List<SelectListManage__c> selectListManageList = new List<SelectListManage__c>();
        for(Integer i = 0; i < 6; i++){
            SelectListManage__c selectListManage = new SelectListManage__c();
            selectListManage.Name = 'サービスエリア';
            selectListManage.Label__c = '東京';
            selectListManage.ReferenceName__c = 'QuotationAreaCode';
            selectListManage.Value__c = '東京';
            selectListManageList.add(selectListManage);
        }
        System.runAs (testUser) {
            insert selectListManageList;
        }
        //insert selectListManageList;
        return selectListManageList;
    }

    /*
     * Description:Create CurrentCookie
     * MethodName :setCurrentCookie
     * @ return Cookie List
     */
    private static List<Cookie> setCurrentCookie(){
        List<Cookie> cookieList = new List<Cookie>();
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_Month', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_Region', '東京',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_CustomerCode', '000000001',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_CustomerName', 'TestAccountName',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_UnitBody', '本体号機テスト名',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_Type', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_OrderNo', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_InvoiceNumber', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_Status', '1',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_NetMaintenance', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceBillingList_TargetSeries', 'CA',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceInspectionList_TargetRegions', '東京',null,-1,false));
        cookieList.add(new Cookie('PageNumber', '1',null,-1,false));
        cookieList.add(new Cookie('PageSize', '3',null,-1,false));
        cookieList.add(new Cookie('initSearchFlg', 'true',null,-1,false));
        return cookieList;
    }

    /*
     * Description : Create MaintenanceContractManagement TestData(保守契約管理テストデータ作成)
     * MethodName :createTestData01
     * @ parameter Date startDay (保守契約管理.保守契約開始日)
     * @ parameter Date endDay (保守契約管理.保守契約終了日)
     * @ return 保守契約管理
     */
    private static MaintenanceContractManagement__c createTestData01(Date startDay, Date endDay){
        //MaintenanceContractManagement(保守契約管理レコード作成)
        MaintenanceContractManagement__c mcm = new MaintenanceContractManagement__c();
        mcm.NewOdrSalesAccount__c = testAccount.Id;
        mcm.NewOdrShipmentAccount__c = testAccount.Id;
        mcm.NewOdrSalesStaff__c = testUser.Id;
        mcm.NewOdrNetMaintenance__c = 'No';
        mcm.NewOdrSeries__c = 'CA';
        mcm.NewOdrRegion__c = '東京支店';
        mcm.QuotationSentDate__c = startDay;
        mcm.NewOdrMaintenanceStartDate__c = startDay;
        mcm.NewOdrMaintenanceEndDate__c = endDay;
        mcm.BillingMethodHontai__c = '請求方法';
        mcm.BillingMethodHelium__c = '請求方法';
        mcm.SubAmountHontaiNoInspec__c = 3000;
        mcm.SubAmountHelium__c = 2000;
        System.runAs (testUser) {
            insert mcm;
        }
        //insert mcm;
        return mcm;
    }

    /*
     * Create Date (日付作成)
     * @ parameter Integer year (年)
     * @ parameter Integer month (月)
     * @ parameter Integer day (日)
     * @ return 日付
     */
    private static Date createDateInstance(Integer year, Integer month, Integer day){
        Date targetDate = Date.newInstance(year, month, day);
        return targetDate;
    }
}