@isTest
private class JEOL_MaintenanceListToRenewCsv_ctrlTest {
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    // Test Account (取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListToRenewCsv_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceListToRenewCsv_ctrl_Test01() {
        // Preparation
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD);
            String setTpye = '1';
            //　MaintenanceAccountBook(保守管理台帳)
            MaintenanceAccountBook__c testMab = createMaintenanceAccountBookTestData(testMcm.Id, setTpye);
            // Test Start
            Test.startTest();
            JEOL_MaintenanceListToRenewCsv_ctrl ctrl = new JEOL_MaintenanceListToRenewCsv_ctrl();
            ctrl.getFileName();
            ctrl.custCodeType = setTpye;
            ctrl.custNameType = setTpye;
            // Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListToRenewCsv_ctrl_Test02
     */
    private static testMethod void JEOL_MaintenanceListToRenewCsv_ctrl_Test02() {
        // Preparation
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD);
            String setTpye = '3';
            //　MaintenanceAccountBook(保守管理台帳)
            MaintenanceAccountBook__c testMab = createMaintenanceAccountBookTestData(testMcm.Id, setTpye);
            // Test Start
            Test.startTest();
            JEOL_MaintenanceListToRenewCsv_ctrl ctrl = new JEOL_MaintenanceListToRenewCsv_ctrl();
            ctrl.custCodeType = setTpye;
            ctrl.custNameType = setTpye;
            // Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListToRenewCsv_ctrl_Test03
     */
    private static testMethod void JEOL_MaintenanceListToRenewCsv_ctrl_Test03() {
        // Preparation
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD);
            String setTpye = '4';
            //　MaintenanceAccountBook(保守管理台帳)
            MaintenanceAccountBook__c testMab = createMaintenanceAccountBookTestData(testMcm.Id, setTpye);
            // Test Start
            Test.startTest();
            JEOL_MaintenanceListToRenewCsv_ctrl ctrl = new JEOL_MaintenanceListToRenewCsv_ctrl();
            ctrl.custCodeType = setTpye;
            ctrl.custNameType = setTpye;
            // Test Stop
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
        cookieList.add(new Cookie('MONTH', '2015',null,-1,false));
        cookieList.add(new Cookie('LASTYEARSO', '2015',null,-1,false));
        cookieList.add(new Cookie('SERIES', 'CA',null,-1,false));
        cookieList.add(new Cookie('REGIONS', '東京',null,-1,false));
        cookieList.add(new Cookie('CUSTOMERCODE', 'CustNameDode',null,-1,false));
        cookieList.add(new Cookie('CUSTOMERNAME', 'CustName',null,-1,false));
        cookieList.add(new Cookie('CUSTCODETYPE', '2',null,-1,false));
        cookieList.add(new Cookie('CUSTNAMETYPE', '2',null,-1,false));
        cookieList.add(new Cookie('JEOLPIPELINERESPONSIBLE', 'pipelineresponsible',null,-1,false));
        cookieList.add(new Cookie('NETMAINTENANCE', 'netmaintenance',null,-1,false));
        cookieList.add(new Cookie('SHIPMENTADDRESS', 'ShipmentAddress',null,-1,false));
        cookieList.add(new Cookie('UNITBODY', 'unitBody',null,-1,false));
        return cookieList;
    }

    /*
     * Description: Create SalesOrder TestData(部署テストデータ作成)
     * MethodName : createSalesOrderTestData
     * @ return SalesOrder(販売オーダ)
     */
    private static SalesOrder__c createSalesOrderTestData(){
        // SalesOrder (販売オーダ)
        RecordType salesOrderRecTypes = JEOL_TestDataFactory.getRecordType('SalesOrder__c');
        //SalesOrder
        SalesOrder__c salesOrder = new SalesOrder__c();
        salesOrder.RecordTypeId = salesOrderRecTypes.Id;
        salesOrder.Name = 'TestSalesOrderNo.0001';
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
     * Description: get Date (レコードタイプ取得)
     * MethodName :
     * @ parameter String targetOBJ (対象オブジェクト)
     * @ return RecordType (レコードタイプ)
     */
    /*private static RecordType getRecordType(String targetOBJ){
        List<RecordType> resultRec = [select Id from RecordType where SobjectType = :targetOBJ];
        if (resultRec == null || resultRec.size() <= 0) {
            resultRec = new List<RecordType>();
        }
        return resultRec[0];
    }*/

    /*
     * Description: Create Department TestData(部署テストデータ作成)
     * MethodName : createDepartmentTestData
     * @ return 部署
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
     * Description: Create MaintenanceAccountBook TestData(保守管理台帳テストデータ作成)
     * MethodName : createMaintenanceAccountBookTestData
     * @ Id mcmId(保守契約管理Id)
     * @ String setTpye(保守管理台帳タイプ)
     * @ return MaintenanceAccountBook(保守管理台帳)
     */
    private static MaintenanceAccountBook__c createMaintenanceAccountBookTestData(Id mcmId, String setTpye){
        MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
        testMab.Type__c = setTpye;
        testMab.BillingDone__c = true;
        testMab.SalesAmountEstimate__c = 2000.000;
        testMab.MaintenanceContractManagement__c = mcmId;
        testMab.SalesAuto__c = true;
        testMab.InvoiceNumber__c = 'M00000001';
        testMab.InvoiceNumberAuto__c = 'J00000001';
        testMab.TaxCode__c = 'B01';
        testMab.ItemName__c = 'テストアイテム名';
        testMab.Inspection__c = true;
        testMab.BillingAmountEstimate__c = 3000;
        testMab.InspectionDone__c = true;
        insert testMab;
        return testMab;
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
        // SalesOrder(販売オーダ)
        SalesOrder__c salesOrder = createSalesOrderTestData();
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
        mcm.RenewalApproved__c = false;
        mcm.PipelineStopped__c = false;
        mcm.PreviousYearOrder__c = salesOrder.Id;
        insert mcm;
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