@isTest
private class JEOL_MaintenanceAnnaiPrintPageCtrlTest {
	private static Date startDate = Date.newInstance(2015, 5, 1);
    private static Date endDate = Date.newInstance(2015, 5, 30);
    //User(ユーザ)
    private static  User testUser = JEOL_TestDataFactory.createTestUser();
    // Account
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAnnaiPrintPageCtrl_Test01
     */
    private static testMethod void JEOL_MaintenanceAnnaiPrintPageCtrl_Test01() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, true, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAnnaiPrintPageCtrl_Test02
     */
    private static testMethod void JEOL_MaintenanceAnnaiPrintPageCtrl_Test02() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, false, false);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getPageSize Method
     * MethodName : getPageSize_Test
     */
    private static testMethod void getPageSize_Test() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, true, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        ctrl.getPageSize();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getPrintDate Method
     * MethodName : getPrintDate_Test
     */
    private static testMethod void getPrintDate_Test() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, true, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        ctrl.getPrintDate();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getNewContractStartDate Method
     * MethodName : getNewContractStartDate_Test
     */
    private static testMethod void getNewContractStartDate_Test() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, true, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        ctrl.getNewContractStartDate();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getNewContractEndDate Method
     * MethodName : getNewContractEndDate_Test
     */
    private static testMethod void getNewContractEndDate_Test() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, true, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        ctrl.getNewContractEndDate();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getMaintenanceStartDateFormula Method
     * MethodName : getMaintenanceStartDateFormula_Test
     */
    private static testMethod void getMaintenanceStartDateFormula_Test() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, true, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        ctrl.getMaintenanceStartDateFormula();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test getMaintenanceEndDateFormula Method
     * MethodName : getMaintenanceEndDateFormula_Test
     */
    private static testMethod void getMaintenanceEndDateFormula_Test() {
        // prepration
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate, false, true);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAnnaiPrintPage_1Page;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', testMcm.Id);
        testPage.getParameters().put('preview', 'preview');
        testPage.getParameters().put('print', 'print');
        //Test Start
        Test.startTest();
        JEOL_MaintenanceAnnaiPrintPageCtrl ctrl = new JEOL_MaintenanceAnnaiPrintPageCtrl();
        ctrl.getMaintenanceEndDateFormula();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description:Create MaintenanceContractManagement TestData(保守契約管理テストデータ作成)
     * MethodName :createTestData01
     * @ parameter Date startDay (保守契約管理.保守契約開始日)
     * @ parameter Date endDay (保守契約管理.保守契約終了日)
     * @ parameter Boolean existAccount (true:保守契約管理.客先名あり)
     * @ parameter Boolean existSalesOrder (true:保守契約管理.販売オーだあり)
     * @ return 保守契約管理
     */
    private static MaintenanceContractManagement__c createTestData01(Date startDay, Date endDay, Boolean existAccount, Boolean existSalesOrder){
        // SalesOrder (販売オーダ)
        RecordType salesOrderRecTypes = JEOL_TestDataFactory.getRecordType('SalesOrder__c');
        Datetime startDt = Datetime.newInstance(2014, 5, 1, 19, 30, 30);
        Datetime endDt = Datetime.newInstance(2015, 5, 1, 19, 30, 30);
        //SalesOrder
        SalesOrder__c salesOrder = new SalesOrder__c();
        salesOrder.RecordTypeId = salesOrderRecTypes.Id;
        salesOrder.Name = 'TestSalesOrderNo.0001';
        salesOrder.MaintenanceStartDate__c = startDt;
        salesOrder.MaintenanceEndDate__c = endDt;
        System.runAs (testUser) {
            insert salesOrder;
        }
        //insert salesOrder;

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
        mcm.NewContractStartDate__c = startDay;
        mcm.NewContractEndDate__c = endDay;
        if(existAccount){
            mcm.RenewalOptionDateFormat__c = '1';
        }else{
            mcm.RenewalOptionDateFormat__c = '2';
        }

        mcm.NewOdrMaintenanceEndDate__c = endDay;
        mcm.BillingMethodHontai__c = '請求方法';
        mcm.BillingMethodHelium__c = '請求方法';
        mcm.SubAmountHontaiNoInspec__c = 3000;
        mcm.SubAmountHelium__c = 2000;
        if(existAccount){
            mcm.RenewalAccount__c = testAccount.Id;
        }
        if(existSalesOrder){
            mcm.PreviousYearOrder__c = salesOrder.Id;
        }
        System.runAs (testUser) {
            insert mcm;
        }
        //insert mcm;
        return mcm;
    }
}