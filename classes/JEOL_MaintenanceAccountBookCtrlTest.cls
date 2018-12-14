@isTest
private class JEOL_MaintenanceAccountBookCtrlTest {
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    // Test Account (取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データがあるパターン)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test01
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test01() {
        //Preparation
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データがないパターン)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test02
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test02() {
        //Preparation
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '2');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト保守管理台帳データないパターン,且つ,保守契約管理.保守契約開始日 > 保守契約管理.保守契約終了日)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test03
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test03() {
        //Preparation
        Date startD = createDateInstance(2015, 6, 1);
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '3');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データないパターン,且つ,保守契約管理.保守契約終了日がnullのパターン)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test04
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test04() {
        //Preparation
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = null;
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データないパターン,且つ,保守契約管理.保守契約開始日がnullのパターン)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test05
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test05() {
        //Preparation
        Date startD = null;
        Date endD = createDateInstance(2015, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データないパターン,且つ,保守契約管理.保守契約開始日と保守終了日共にnullのパターン)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test06
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test06() {
        //Preparation
        Date startD = null;
        Date endD = null;
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データないパターン,且つ,保守契約管理.保守契約開始日の年 + 10 < 保守契約終了日の年)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test07
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test07() {
        //Preparation
        Date startD = createDateInstance(2001, 1, 30);
        Date endD = createDateInstance(2015, 1, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト,保守管理台帳データがないパターン,かつ,保守契約管理.保守契約開始日の月+1 > 12のパターン)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test08
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test08() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test09
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test09() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.BillingDone__c = true;
            testMab.SalesAmountEstimate__c = 2000.000;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.SalesAuto__c = true;
            testMab.InvoiceNumber__c = 'M00000001';
            testMab.InvoiceNumberAuto__c = 'J00000001';
            testMab.TaxCode__c = 'B01';
            testMab.ItemName__c = 'テストアイテム名';
            insert testMab;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test10
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test10() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.BillingDone__c = false;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.SalesAuto__c = true;
            insert testMab;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '2');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test11
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test11() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.BillingDone__c = false;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.SalesAuto__c = false;
            testMab.InvoiceNumber__c = 'M00000001';
            insert testMab;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test12
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test12() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.BillingDone__c = false;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.SalesAuto__c = false;
            testMab.InvoiceNumberAuto__c = 'J00000001';
            insert testMab;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test13
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test13() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.BillingDone__c = false;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.SalesAuto__c = false;
            testMab.TaxCode__c = 'B01';
            insert testMab;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceAccountBookCtrl_Test14
     */
    private static testMethod void JEOL_MaintenanceAccountBookCtrl_Test14() {
        //Preparation
        Date startD = createDateInstance(2015, 12, 1);
        Date endD = createDateInstance(2015, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.BillingDone__c = false;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.SalesAuto__c = false;
            testMab.ItemName__c = 'テストアイテム名';
            insert testMab;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');

            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test save Method
     * MethodName : save_Test01
     */
    private static testMethod void save_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '2');


            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = true;
                m.SalesAmountReal__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test save Method
     * MethodName : save_Test02
     */
    private static testMethod void save_Test02() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test save Method
     * MethodName : save_Test03
     */
    private static testMethod void save_Test03() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2500.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test save Method
     * MethodName : save_Test04
     */
    private static testMethod void save_Test04() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            testMcm.SubAmountHelium__c = null;
            testMcm.SubAmountHontaiNoInspec__c = null;
            update testMcm;
            String setTpye = '4';
            MaintenanceAccountBook__c testMab = new MaintenanceAccountBook__c();
            testMab.SalesReturn__c = true;
            testMab.SalesAmountEstimate__c = 2000.000;
            testMab.MaintenanceContractManagement__c = testMcm.Id;
            testMab.Type__c = '1';
            insert testMab;
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addFirstRow Method
     * MethodName : addFirstRow_Test01
     */
    private static testMethod void addFirstRow_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addFirstRow Method
     * MethodName : addFirstRow_Test02
     */
    private static testMethod void addFirstRow_Test02() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '2');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addFirstRow Method
     * MethodName : addFirstRow_Test03
     */
    private static testMethod void addFirstRow_Test03() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '3');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addFirstRow Method
     * MethodName : addFirstRow_Test04
     */
    private static testMethod void addFirstRow_Test04() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addFirstRow Method
     * MethodName : addFirstRow_Test05
     */
    private static testMethod void addFirstRow_Test05() {
        //Preparation
        Date startD = createDateInstance(2014, 1, 1);
        Date endD = createDateInstance(2014, 1, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addFirstRow Method
     * MethodName : addFirstRow_Test06
     */
    private static testMethod void addFirstRow_Test06() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.lsAccountBookRow = new List<MaintenanceAccountBook__c>();
            ctrl.addFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addLastRow Method
     * MethodName : addLastRow_Test01
     */
    private static testMethod void addLastRow_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addLastRow Method
     * MethodName : addLastRow_Test02
     */
    private static testMethod void addLastRow_Test02() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '2');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addLastRow Method
     * MethodName : addLastRow_Test03
     */
    private static testMethod void addLastRow_Test03() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '3');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addLastRow Method
     * MethodName : addLastRow_Test04
     */
    private static testMethod void addLastRow_Test04() {
        //Preparation
        Date startD = createDateInstance(2014, 5, 1);
        Date endD = createDateInstance(2014, 5, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addLastRow Method
     * MethodName : addLastRow_Test05
     */
    private static testMethod void addLastRow_Test05() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000.000;
            }
            insert ctrl.lsAccountBookRow;

            ctrl.save();
            ctrl.addLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test addLastRow Method
     * MethodName : addLastRow_Test06
     */
    private static testMethod void addLastRow_Test06() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.lsAccountBookRow = new List<MaintenanceAccountBook__c>();
            ctrl.addLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test removeFirstRow Method
     * MethodName : removeFirstRow_Test01
     */
    private static testMethod void removeFirstRow_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.AlreadyBilled__c = true;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.removeFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test removeFirstRow Method
     * MethodName : removeFirstRow_Test02
     */
    private static testMethod void removeFirstRow_Test02() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesAmountReal__c = 3000;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.removeFirstRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test removeLastRow Method
     * MethodName : removeLastRow_Test01
     */
    private static testMethod void removeLastRow_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '4');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.removeLastRow();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test01
     */
    private static testMethod void importPreviousYearData_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '1');
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test02
     */
    private static testMethod void importPreviousYearData_Test02() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(前年保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c afterMcm = new MaintenanceContractManagement__c();
            afterMcm.NewOdrSalesAccount__c = testMcm.NewOdrSalesAccount__c;
            afterMcm.NewOdrShipmentAccount__c = testMcm.NewOdrShipmentAccount__c;
            afterMcm.NewOdrSalesStaff__c = testMcm.NewOdrSalesStaff__c;
            afterMcm.NewOdrNetMaintenance__c = 'No';
            afterMcm.NewOdrSeries__c = 'CA';
            afterMcm.NewOdrRegion__c = '東京支店';
            afterMcm.QuotationSentDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceStartDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceEndDate__c = createDateInstance(2015, 12, 30);
            afterMcm.BillingMethodHontai__c = '請求方法';
            afterMcm.BillingMethodHelium__c = '請求方法';
            afterMcm.SubAmountHontaiNoInspec__c = 3000;
            afterMcm.SubAmountHelium__c = 2000;
            afterMcm.PreviousYearPipeline__c = testMcm.Id;
            insert afterMcm;
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('type', '2');
            ApexPages.StandardController sc = new ApexPages.StandardController(afterMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test03
     */
    private static testMethod void importPreviousYearData_Test03() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(前年保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c afterMcm = new MaintenanceContractManagement__c();
            afterMcm.NewOdrSalesAccount__c = testMcm.NewOdrSalesAccount__c;
            afterMcm.NewOdrShipmentAccount__c = testMcm.NewOdrShipmentAccount__c;
            afterMcm.NewOdrSalesStaff__c = testMcm.NewOdrSalesStaff__c;
            afterMcm.NewOdrNetMaintenance__c = 'No';
            afterMcm.NewOdrSeries__c = 'CA';
            afterMcm.NewOdrRegion__c = '東京支店';
            afterMcm.QuotationSentDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceStartDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceEndDate__c = createDateInstance(2015, 12, 30);
            afterMcm.BillingMethodHontai__c = '請求方法';
            afterMcm.BillingMethodHelium__c = '請求方法';
            afterMcm.SubAmountHontaiNoInspec__c = 3000;
            afterMcm.SubAmountHelium__c = 2000;
            afterMcm.PreviousYearPipeline__c = testMcm.Id;
            insert afterMcm;
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '3';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(afterMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000;
                m.Type__c = setTpye;
                m.MaintenanceContractManagement__c = afterMcm.PreviousYearPipeline__c;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.save();
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test04
     */
    private static testMethod void importPreviousYearData_Test04() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(前年保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c afterMcm = new MaintenanceContractManagement__c();
            afterMcm.NewOdrSalesAccount__c = testMcm.NewOdrSalesAccount__c;
            afterMcm.NewOdrShipmentAccount__c = testMcm.NewOdrShipmentAccount__c;
            afterMcm.NewOdrSalesStaff__c = testMcm.NewOdrSalesStaff__c;
            afterMcm.NewOdrNetMaintenance__c = 'No';
            afterMcm.NewOdrSeries__c = 'CA';
            afterMcm.NewOdrRegion__c = '東京支店';
            afterMcm.QuotationSentDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceStartDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceEndDate__c = createDateInstance(2015, 12, 30);
            afterMcm.BillingMethodHontai__c = '請求方法';
            afterMcm.BillingMethodHelium__c = '請求方法';
            afterMcm.SubAmountHontaiNoInspec__c = 3000;
            afterMcm.SubAmountHelium__c = 2000;
            afterMcm.PreviousYearPipeline__c = testMcm.Id;
            insert afterMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '4';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(afterMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000;
                m.Type__c = setTpye;
                m.MaintenanceContractManagement__c = afterMcm.PreviousYearPipeline__c;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.save();
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test05
     */
    private static testMethod void importPreviousYearData_Test05() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(前年保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c afterMcm = new MaintenanceContractManagement__c();
            afterMcm.NewOdrSalesAccount__c = testMcm.NewOdrSalesAccount__c;
            afterMcm.NewOdrShipmentAccount__c = testMcm.NewOdrShipmentAccount__c;
            afterMcm.NewOdrSalesStaff__c = testMcm.NewOdrSalesStaff__c;
            afterMcm.NewOdrNetMaintenance__c = 'No';
            afterMcm.NewOdrSeries__c = 'CA';
            afterMcm.NewOdrRegion__c = '東京支店';
            afterMcm.QuotationSentDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceStartDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceEndDate__c = createDateInstance(2015, 12, 30);
            afterMcm.BillingMethodHontai__c = '請求方法';
            afterMcm.BillingMethodHelium__c = '請求方法';
            afterMcm.SubAmountHontaiNoInspec__c = 3000;
            afterMcm.SubAmountHelium__c = 2000;
            afterMcm.PreviousYearPipeline__c = testMcm.Id;
            insert afterMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '1';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(afterMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 2000;
                m.Type__c = setTpye;
                m.MaintenanceContractManagement__c = afterMcm.PreviousYearPipeline__c;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.save();
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test06
     */
    private static testMethod void importPreviousYearData_Test06() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(前年保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c afterMcm = new MaintenanceContractManagement__c();
            afterMcm.NewOdrSalesAccount__c = testMcm.NewOdrSalesAccount__c;
            afterMcm.NewOdrShipmentAccount__c = testMcm.NewOdrShipmentAccount__c;
            afterMcm.NewOdrSalesStaff__c = testMcm.NewOdrSalesStaff__c;
            afterMcm.NewOdrNetMaintenance__c = 'No';
            afterMcm.NewOdrSeries__c = 'CA';
            afterMcm.NewOdrRegion__c = '東京支店';
            afterMcm.QuotationSentDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceStartDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceEndDate__c = createDateInstance(2015, 12, 30);
            afterMcm.BillingMethodHontai__c = '請求方法';
            afterMcm.BillingMethodHelium__c = '請求方法';
            afterMcm.SubAmountHontaiNoInspec__c = 3000;
            afterMcm.SubAmountHelium__c = 2000;
            afterMcm.PreviousYearPipeline__c = testMcm.Id;
            insert afterMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(afterMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000;
                m.Type__c = setTpye;
                m.MaintenanceContractManagement__c = afterMcm.PreviousYearPipeline__c;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.save();
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test importPreviousYearData Method
     * MethodName : importPreviousYearData_Test07
     */
    private static testMethod void importPreviousYearData_Test07() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(前年保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c afterMcm = new MaintenanceContractManagement__c();
            afterMcm.NewOdrSalesAccount__c = testMcm.NewOdrSalesAccount__c;
            afterMcm.NewOdrShipmentAccount__c = testMcm.NewOdrShipmentAccount__c;
            afterMcm.NewOdrSalesStaff__c = testMcm.NewOdrSalesStaff__c;
            afterMcm.NewOdrNetMaintenance__c = 'No';
            afterMcm.NewOdrSeries__c = 'CA';
            afterMcm.NewOdrRegion__c = '東京支店';
            afterMcm.QuotationSentDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceStartDate__c = createDateInstance(2015, 12, 1);
            afterMcm.NewOdrMaintenanceEndDate__c = createDateInstance(2015, 12, 30);
            afterMcm.BillingMethodHontai__c = '請求方法';
            afterMcm.BillingMethodHelium__c = '請求方法';
            afterMcm.SubAmountHontaiNoInspec__c = 3000;
            afterMcm.SubAmountHelium__c = 2000;
            afterMcm.PreviousYearPipeline__c = testMcm.Id;
            insert afterMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(afterMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m:ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.SalesAmountEstimate__c = 3000;
                m.AlreadyBilled__c = true;
                m.Type__c = setTpye;
                m.MaintenanceContractManagement__c = afterMcm.PreviousYearPipeline__c;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.save();
            ctrl.importPreviousYearData();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test01
     */
    private static testMethod void doProportionalAmount_Test01() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '1';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test02
     */
    private static testMethod void doProportionalAmount_Test02() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test03
     */
    private static testMethod void doProportionalAmount_Test03() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '4';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test04
     */
    private static testMethod void doProportionalAmount_Test04() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            testMcm.SubAmountHelium__c = null;
            update testMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '4';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test05
     */
    private static testMethod void doProportionalAmount_Test05() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            testMcm.SubAmountHontaiNoInspec__c = null;
            update testMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test06
     */
    private static testMethod void doProportionalAmount_Test06() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m :ctrl.lsAccountBookRow){
                m.SalesReturn__c = true;
                m.SalesAmountReal__c = 2000;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test07
     */
    private static testMethod void doProportionalAmount_Test07() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m :ctrl.lsAccountBookRow){
                m.AlreadyBilled__c = true;
                m.SalesAmountEstimate__c = 2000;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test doProportionalAmount Method
     * MethodName : doProportionalAmount_Test08
     */
    private static testMethod void doProportionalAmount_Test08() {
        //Preparation
        Date startD = createDateInstance(2014, 12, 1);
        Date endD = createDateInstance(2014, 12, 30);
        System.runAs (testUser) {
            //MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
            testMcm.SubAmountHontaiNoInspec__c = 0;
            update testMcm;

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetailView;
            Test.setCurrentPage(testPage);
            String setTpye = '2';
            testPage.getParameters().put('type', setTpye);
            ApexPages.StandardController sc = new ApexPages.StandardController(testMcm);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceAccountBookCtrl ctrl = new JEOL_MaintenanceAccountBookCtrl(sc);
            for(MaintenanceAccountBook__c m :ctrl.lsAccountBookRow){
                m.SalesReturn__c = false;
                m.AlreadyBilled__c = false;
            }
            insert ctrl.lsAccountBookRow;
            ctrl.doProportionalAmount();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceContractManagement Insert Trigger(before and after)
     * MethodName : MaintenanceContractManagementTriggerInsert_Test
     */
    private static testMethod void MaintenanceContractManagementTriggerInsert_Test() {
        //Preparation
        Date startD = createDateInstance(2016, 5, 1);
        Date endD = createDateInstance(2016, 5, 30);
        System.runAs (testUser) {
            //Test Start
            Test.startTest();
            // Insert
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, true);
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceContractManagement Update Trigger(update)
     * MethodName : MaintenanceContractManagementTriggerUpdate_Test01
     * TargetOBJ :MaintenanceContractManagement (保守契約管理)
     */
    private static testMethod void MaintenanceContractManagementTriggerUpdate_Test01() {
        //Preparation
        Date startD = createDateInstance(2016, 5, 1);
        Date endD = createDateInstance(2016, 5, 30);
        System.runAs (testUser) {
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, true);
            testMcm.NewOdrSeries__c = 'CA';
            testMcm.BypassTriggerCheck__c = true;
            testMcm.IncrementVersionNumber__c = true;
            //Test Start
            Test.startTest();
            // Update
            update testMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceContractManagement Update Trigger(update)
     * MethodName : MaintenanceContractManagementTriggerUpdate_Test02
     * TargetOBJ :MaintenanceContractManagement (保守契約管理)
     */
    private static testMethod void MaintenanceContractManagementTriggerUpdate_Test02() {
        //Preparation
        Date startD = createDateInstance(2016, 5, 1);
        Date endD = createDateInstance(2016, 5, 30);
        System.runAs (testUser) {
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, true);
            testMcm.BypassTriggerCheck__c = false;
            testMcm.IncrementVersionNumber__c = false;
            //Test Start
            Test.startTest();
            // Update
            update testMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceContractManagement delete Trigger(delete)
     * MethodName : MaintenanceContractManagementTriggerDelete_Test01
     * TargetOBJ :MaintenanceContractManagement (保守契約管理)
     */
    private static testMethod void MaintenanceContractManagementTriggerDelete_Test01() {
        System.runAs (testUser) {
            //Preparation
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c mcm = new MaintenanceContractManagement__c();
            mcm.VersionNumber__c = 1000;
            insert mcm;
            MaintenanceContractManagement__c deleteTargetMcm = new MaintenanceContractManagement__c();
            deleteTargetMcm.VersionNumber__c = 1000;
            insert deleteTargetMcm;
            //Test Start
            Test.startTest();
            // Delete
            delete deleteTargetMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceAccountBook delete Trigger(delete)
     * MethodName : MaintenanceAccountBook_BeforeTrigger_Test
     * TargetOBJ :MaintenanceAccountBook （保守管理台帳）
     */
    private static testMethod void MaintenanceAccountBook_BeforeTrigger_Test(){
        System.runAs (testUser) {
            // Preparation
            MaintenanceAccountBook__c mab = createTestData(false, false,null, false);
            //Test Start
            Test.startTest();
            // Delete
            delete mab;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceOrderDocument Before Trigger(Insert，Update)
     * MethodName : MaintenanceOrderDocument_BeforeTrigger_Test01
     * TargetOBJ :MaintenanceOrderDocument 注文書（保守契約管理）
     */
    private static testMethod void MaintenanceOrderDocument_BeforeTrigger_Test01(){
        System.runAs (testUser) {
            //Test Start
            Test.startTest();
            // Insert
            MaintenanceOrderDocument__c mod = createMaintenanceOrderDocumentTestData(true);
            // Update
            mod.BypassTriggerCheck__c = false;
            update mod;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test MaintenanceOrderDocument Before Trigger(Delete)
     * MethodName : MaintenanceOrderDocument_BeforeTrigger_Test02
     * TargetOBJ :MaintenanceOrderDocument 注文書（保守契約管理）
     */
    private static testMethod void MaintenanceOrderDocument_BeforeTrigger_Test02(){
        System.runAs (testUser) {
            //Test Start
            Test.startTest();
            // Insert
            MaintenanceOrderDocument__c mod = createMaintenanceOrderDocumentTestData(false);
            // Delete
            delete mod;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Create MaintenanceContractManagement TestData(保守契約管理テストデータ作成)
     * @ parameter Date startDay (保守契約管理.保守契約開始日)
     * @ parameter Date endDay (保守契約管理.保守契約終了日)
     * @ return 保守契約管理
     */
    private static MaintenanceContractManagement__c createTestData01(Date startDay, Date endDay, Boolean lastLinkBaaN){
        // SalesOrder(販売オーダ)
        SalesOrder__c salesOrder = createSalesOrderTestData();
        //MaintenanceContractManagement(保守契約管理レコード作成)
        // MaintenanceLinkOrder(BaaN連携データ)
        MaintenanceLinkOrder__c maintenanceLinkOrder = createmaintenanceLinkOrderTestData();
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
        mcm.NewOdrSalesOrder__c = salesOrder.Id;
        mcm.BypassTriggerCheck__c = false;
        if(lastLinkBaaN){
            mcm.LastLinkBaaN__c = maintenanceLinkOrder.Id;
        }
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

    /*
     * Description: Create maintenanceLinkOrder TestData(BaaN連携データテストデータ作成)
     * MethodName : createmaintenanceLinkOrderTestData
     * @ return maintenanceLinkOrder(BaaN連携データ)
     */
    private static MaintenanceLinkOrder__c createmaintenanceLinkOrderTestData(){
        MaintenanceContractManagement__c mcm = new MaintenanceContractManagement__c();
        mcm.VersionNumber__c = 1000;
        insert mcm;
        //maintenanceLinkOrder
        MaintenanceLinkOrder__c maintenanceLinkOrder = new MaintenanceLinkOrder__c();
        maintenanceLinkOrder.MaintenanceContractManagement__c = mcm.Id;
        maintenanceLinkOrder.clyn__c = '1';
        maintenanceLinkOrder.ifst__c = '2';
        insert maintenanceLinkOrder;
        return maintenanceLinkOrder;
    }

    /*
     * Description: Create SalesOrder TestData(販売オーダテストデータ作成)
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
        System.runAs (testUser) {
            insert salesOrder;
        }
        //insert salesOrder;
        return salesOrder;
    }

    /*
     * Description: Create  MaintenanceAccountBook Test Data (テストデータ作成)
     * MethodName: createTestData
     * @ return MaintenanceAccountBook(保守台帳管理)
     */
    private static MaintenanceAccountBook__c createTestData(Boolean bypassTriggerCheck, Boolean alreadyBilled, Decimal salesAmountReal, Boolean salesReturn){
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
        MaintenanceAccountBook__c mab = new MaintenanceAccountBook__c();
        mab.Type__c = '2';
        mab.MaintenanceContractManagement__c = testMcm.Id;
        mab.Month__c ='201605';
        mab.BypassTriggerCheck__c = bypassTriggerCheck;
        mab.AlreadyBilled__c = alreadyBilled;
        mab.SalesAmountReal__c = salesAmountReal;
        mab.SalesReturn__c = salesReturn;
        insert mab;
        return mab;
    }

    /*
     * Description: Create MaintenanceOrderDocument Test Data (テストデータ作成)
     * MethodName: createMaintenanceOrderDocumentTestData
     * @ Boolean bypassTriggerCheck
     * @ return MaintenanceOrderDocument(注文書（保守契約管理）)
     */
    private static MaintenanceOrderDocument__c createMaintenanceOrderDocumentTestData(Boolean bypassTriggerCheck){
        Date startD = createDateInstance(2015, 5, 1);
        Date endD = createDateInstance(2015, 5, 30);
        //MaintenanceContractManagement(保守契約管理)
        MaintenanceContractManagement__c testMcm = createTestData01(startD, endD, false);
        MaintenanceOrderDocument__c mod = new MaintenanceOrderDocument__c();
        mod.MaintenanceContractManagement__c = testMcm.Id;
        mod.AccountingValidation__c = bypassTriggerCheck;
        mod.BypassTriggerCheck__c = bypassTriggerCheck;
        insert mod;
        return mod;
    }
}