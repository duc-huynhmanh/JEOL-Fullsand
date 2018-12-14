@isTest
private class JEOL_MaintenanceListToRenewAdd_ctrlTest {
    private static Date startDate = Date.newInstance(2015, 5, 1);
    private static Date endDate = Date.newInstance(2015, 5, 30);
    //User(ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    //Account(取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListToRenewAdd_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceListToRenewAdd_ctrl_Test01() {
        System.runAs (testUser) {
            //preparation
            List<SelectListManage__c> selectListManageList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', '東京支店', 'QuotationAreaCode', '東京支店', 6);
            List<Cookie> cookieList = setCurrentCookie();
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceListToRenewAdd;
            Test.setCurrentPage(testPage);
            ApexPages.currentPage().setCookies(cookieList);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListToRenewAdd_ctrl ctrl = new JEOL_MaintenanceListToRenewAdd_ctrl();
            ctrl.getCCategoryOptions();
            ctrl.getRegionOptions();
            ctrl.getListAccountTypeName();
            ctrl.getListAccountTypeCode();
            ctrl.getListNetMaintenance();
            ctrl.seriesSelectCancel();
            for(JEOL_MaintenanceListToRenewAdd_ctrl.OptionDetail od :ctrl.SeriesOptions){
                od.isSelected = true;
            }
            ctrl.seriesSelectApply();
            ctrl.seriesSelectAllSelect();
            ctrl.seriesSelectAllDeselect();
            for(JEOL_MaintenanceListToRenewAdd_ctrl.OptionDetail od :ctrl.SeriesOptions){
                od.isSelected = true;
            }
            ctrl.getSelectedSeries();
            ctrl.regionsSelectCancel();
            for(JEOL_MaintenanceListToRenewAdd_ctrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
            ctrl.RegionsSelectApply();
            ctrl.regionsSelectAllSelect();
            ctrl.regionsSelectAllDeselect();
            for(JEOL_MaintenanceListToRenewAdd_ctrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
            ctrl.getSelectedRegions();
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListToRenewAdd_ctrl_Test02
     */
    private static testMethod void JEOL_MaintenanceListToRenewAdd_ctrl_Test02() {
        System.runAs (testUser) {
            //preparation
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate);
            List<SelectListManage__c> selectListManageList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', '東京支店', 'QuotationAreaCode', '東京支店', 6);
            // SalesOrder(販売オーダ)
            RecordType salesOrderRecType = JEOL_TestDataFactory.getRecordType('SalesOrder__c');
            //SalesOrder
            SalesOrder__c salesOrder = new SalesOrder__c();
            salesOrder.RecordTypeId = salesOrderRecType.Id;
            salesOrder.Name = '0001';
            //salesOrder.MaintenanceStartDate__c = Datetime.newInstance(2016,5,1,5,30,30);
            //salesOrder.MaintenanceEndDate__c = Datetime.newInstance(2016,5,30,5,30,30);
            salesOrder.MaintenanceStartDate__c = Datetime.newInstance(date.today().year(), date.today().month(), 1,5,30,30);
            salesOrder.MaintenanceEndDate__c = Datetime.newInstance(date.today().year(), date.today().month(), 30,5,30,30);
            salesOrder.UpdateStatus__c = '契約中';
            salesOrder.Area__c = '東京';
            salesOrder.SalesStaffCode__c = 'S00000001';
            salesOrder.AssistantCode__c = 'A00000001';
            salesOrder.SalesOffice__c = '東京';
            insert salesOrder;
            SalesOrder__c selectSalesOrder = getSalesOrderTestData(salesOrder.Id);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListToRenewAdd_ctrl ctrl = new JEOL_MaintenanceListToRenewAdd_ctrl();
            Integer i = 1;
            for(JEOL_MaintenanceListToRenewAdd_ctrl.OptionDetail od :ctrl.SeriesOptions){
                if(i < 4){
                    od.isSelected = true;
                }
                i ++;
            }
            ctrl.getSelectedSeries();
            i = 1;
            for(JEOL_MaintenanceListToRenewAdd_ctrl.OptionDetail od :ctrl.RegionsOptions){
                if(i < 4){
                    od.isSelected = true;
                }
                i ++;
            }
            ctrl.getSelectedRegions();
            ctrl.doFormClear();
            ctrl.getMaintenanceContractManagements();
            ctrl.doSearch();
            ctrl.nextAndSaveCurrentPageNumber();
            ctrl.previousAndSaveCurrentPageNumber();
            ctrl.firstAndSaveCurrentPageNumber();
            ctrl.lastAndSaveCurrentPageNumber();
            ctrl.setJumpSaveCurrentPageSize();
            ctrl.setSizeSaveCurrentPageSize();
            ctrl.addContractMaintenance();
            ctrl.addContractMaintenanceAll();
            ctrl.dummyaction();
            JEOL_MaintenanceListToRenewAdd_ctrl.addContractMaintenanceBatch(10, new List<Integer>{0}, new List<String>{''});
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description:Create CurrentCookie
     * MethodName :setCurrentCookie
     * @ return Cookie List
     */
    private static List<Cookie> setCurrentCookie(){
        List<Cookie> cookieList = new List<Cookie>();
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_RenewalMonth', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_CustomerCode', '123456789',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_CustomerName', 'Customername',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_CustCodeType', 'CustCodeType',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_CustNameType', 'CustNameType',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_JeolPipelineResponsible', 'JeolPipelineResponsible',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_OrderNo', 'OrderNo',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_NetMaintenance', 'NetMaintenance',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_ShipmentAddress', 'ShipmentAddress',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_UnitBody', 'UnitBody',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenewAdd_TargetSeries', 'TargetSeries',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceInspectionList_TargetRegions', 'TargetRegions',null,-1,false));
        cookieList.add(new Cookie('PageNumber', '1',null,-1,false));
        cookieList.add(new Cookie('PageSize', '3',null,-1,false));
        cookieList.add(new Cookie('initSearchFlg', 'true',null,-1,false));
        return cookieList;
    }

    /*
     * Description: Create SalesOrder TestData(販売オーダテストデータ作成)
     * MethodName : createSalesOrderTestData
     * @ return SalesOrder(販売オーダ)
     */
    private static SalesOrder__c createSalesOrderTestData(){
        // SalesOrder (販売オーダ)
        RecordType salesOrderRecType = JEOL_TestDataFactory.getRecordType('SalesOrder__c');
        //SalesOrder
        SalesOrder__c salesOrder = new SalesOrder__c();
        salesOrder.RecordTypeId = salesOrderRecType.Id;
        salesOrder.Name = '0001';
        salesOrder.MaintenanceStartDate__c = Datetime.newInstance(2015,5,1,5,30,30);
        salesOrder.MaintenanceEndDate__c = Datetime.newInstance(2015,5,30,5,30,30);
        salesOrder.UpdateStatus__c = '契約中';
        salesOrder.Area__c = '東京';
        salesOrder.SalesStaffCode__c = 'S00000001';
        salesOrder.AssistantCode__c = 'A00000001';
        salesOrder.SalesOffice__c = '東京';
        insert salesOrder;
        return salesOrder;
    }

    /*
     * Description: get SalesOrder TestData(販売オーダテストデータ抽出)
     * MethodName : getSalesOrderTestData
     * @ return SalesOrder(販売オーダ)
     */
    private static SalesOrder__c getSalesOrderTestData(Id salesOrderId){
        String query = 'SELECT Id, ';
        query += 'Name, ';
        query += 'MaintenanceStartDate__c, ';
        query += 'MaintenanceEndDate__c, ';
        query += 'UpdateStatus__c, ';
        query += 'Area__c, ';
        query += 'SalesStaffCode__c, ';
        query += 'AssistantCode__c, ';
        query += 'MaintenanceEndDateFormula__c, ';
        query += 'SalesOffice__c ';
        query += 'FROM SalesOrder__c ';
        query += 'WHERE Id =:salesOrderId';
        SalesOrder__c resultRec = Database.query(query);
        return resultRec;
    }

    /*
     * Description: Create Department TestData(部署テストデータ作成)
     * MethodName : createDepartmentTestData
     * @ return Department (部署)
     */
    private static Department__c createDepartmentTestData(){
        Department__c department = new Department__c();
        department.Name = '東京';
        department.DepartmentCode__c = 'S0101';
        department.AddressLine1__c = '東京都千代田区大手町2-1-1';
        department.AddressLine2__c = '大手町野村ビル';
        department.AddressLine3__c = '住所3';
        department.SupervisorName__c = 'テスト名前 苗字';
        department.SupervisorPosition__c = '支店長';
        department.Phone__c = '00-1234-5678';
        department.PostalCode__c = '000-0001';
        department.SortNo__c = 1;
        insert department;
        return department;
    }

    /*
     * Description:Create UnitBody TestData(本体号機テストデータ作成)
     * MethodName :createUnitBodyTestData
     * @ return 本体号機
     */
    private static UnitBody__c createUnitBodyTestData(){
        // ProductItem(品目)
        ProductItem__c productItme = createProductItemTestData();
        // UnitBody(本体号機)
        UnitBody__c unitBody = new UnitBody__c();
        unitBody.Name = '本体号機テスト名';
        unitBody.ItemLink__c = productItme.Id;
        insert unitBody;
        return unitBody;
    }

    /*
     * Description:Create ProductItem TestData(品目テストデータ作成)
     * MethodName :createProductItemTestData
     * @ return 品目
     */
    private static ProductItem__c createProductItemTestData(){
        // ProductItem(品目)
        ProductItem__c productItme = new ProductItem__c();
        productItme.Name = 'テスト品目名';
        insert productItme;
        return productItme;
    }

    /*
     * Description: Create MaintenanceContractManagement TestData(保守契約管理テストデータ作成)
     * MethodName : createTestData01
     * @ parameter Date startDay (保守契約管理.保守契約開始日)
     * @ parameter Date endDay (保守契約管理.保守契約終了日)
     * @ return 保守契約管理
     */
    private static MaintenanceContractManagement__c createTestData01(Date startDay, Date endDay){
        // Department(部署)
        Department__c testDepartment = createDepartmentTestData();
        // UnitBody(本体号機)
        UnitBody__c testUnitBody = createUnitBodyTestData();
        //SalesOrder
        SalesOrder__c previousSalesOrder = createSalesOrderTestData();
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
        mcm.NewOdrDepartment__c = testDepartment.Id;
        mcm.UnitBody__c = testUnitBody.Id;
        mcm.PreviousYearOrder__c = previousSalesOrder.Id;
        insert mcm;
        return mcm;
    }
}