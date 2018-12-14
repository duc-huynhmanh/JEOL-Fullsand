@isTest
private class JEOL_MaintenanceAccountBookRed_ctrlTest {
    private static Date startDate = Date.newInstance(2015, 5, 1);
    private static Date endDate = Date.newInstance(2015, 5, 30);
    // User
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    // Account
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookRed_ctrl_Test01
     */
    private static testMethod void  JEOL_MaintenanceAccountBookRed_ctrl_Test01() {
        // preparation
        MaintenanceAccountBook__c testMab = createTestData();
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAccountBookRedirect;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('type', '2');
        ApexPages.StandardController sc = new ApexPages.StandardController(testMab);

        //Test Start
        Test.startTest();
        JEOL_MaintenanceAccountBookRedirect_ctrl ctrl = new JEOL_MaintenanceAccountBookRedirect_ctrl(sc);
        //Test Stop
        Test.stopTest();
	}

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookRed_ctrl_Test02
     */
    private static testMethod void  JEOL_MaintenanceAccountBookRed_ctrl_Test02() {
        // preparation
        MaintenanceAccountBook__c testMab = createTestData();
        MaintenanceAccountBook__c testMab2 = [SELECT Id, Name, Type__c,MaintenanceContractManagement__r.Id
                                              FROM MaintenanceAccountBook__c
                                              WHERE Id =:testMab.Id];
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAccountBookRedirect;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('type', '2');
        ApexPages.StandardController sc = new ApexPages.StandardController(testMab2);

        //Test Start
        Test.startTest();
        JEOL_MaintenanceAccountBookRedirect_ctrl ctrl = new JEOL_MaintenanceAccountBookRedirect_ctrl(sc);
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test redirect Method
     * MethodName : redirect_Test01
     */
    private static testMethod void  redirect_Test01() {
        // preparation
        MaintenanceAccountBook__c testMab = createTestData();
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAccountBookRedirect;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('type', '2');
        ApexPages.StandardController sc = new ApexPages.StandardController(testMab);

        //Test Start
        Test.startTest();
        JEOL_MaintenanceAccountBookRedirect_ctrl ctrl = new JEOL_MaintenanceAccountBookRedirect_ctrl(sc);
        ctrl.redirect();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Test redirect Method
     * MethodName : redirect_Test02
     */
    private static testMethod void  redirect_Test02() {
        // preparation
        MaintenanceAccountBook__c testMab = createTestData();
        MaintenanceAccountBook__c testMab2 = [SELECT Id, Name, Type__c,MaintenanceContractManagement__r.Id
                                              FROM MaintenanceAccountBook__c
                                              WHERE Id =:testMab.Id];
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceAccountBookRedirect;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('type', '2');
        ApexPages.StandardController sc = new ApexPages.StandardController(testMab2);

        //Test Start
        Test.startTest();
        JEOL_MaintenanceAccountBookRedirect_ctrl ctrl = new JEOL_MaintenanceAccountBookRedirect_ctrl(sc);
        ctrl.redirect();
        //Test Stop
        Test.stopTest();
    }

    /*
     * Description: Create Test Data (テストデータ作成)
     * MethodName: createTestData
     * @ return MaintenanceAccountBook__c(保守台帳管理)
     */
    private static MaintenanceAccountBook__c createTestData(){
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate);
        MaintenanceAccountBook__c mab = new MaintenanceAccountBook__c();
        mab.Type__c = '2';
        mab.MaintenanceContractManagement__c = testMcm.Id;
        System.runAs (testUser) {
            insert mab;
        }
        //insert mab;
        return mab;
    }

    /*
     * Create MaintenanceContractManagement TestData(保守契約管理テストデータ作成)
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
}