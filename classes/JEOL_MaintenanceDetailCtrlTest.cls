@isTest
private class JEOL_MaintenanceDetailCtrlTest {
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    // Test Account (取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '0001', true, '有効', true, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test01
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test01() {
        System.runAs (testUser) {
            // Preparation
            //MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            MaintenanceContractManagement__c selectTestMcm = testPreparation('7', true, true, false, true);

            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;

            // MaintenanceLinkOrder (BaaN連携データ)
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '2', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');


            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            JEOL_TestDataFactory.createBaaNSetting();
            List<MaintenanceAnnaiOptions__c> maintenanceAnnaiOptionList = JEOL_TestDataFactory.createMAOTestData('契約書を作成する', false, true, 3);

            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.ImportDataFromUnitBody();
            ctrl.checkBaaN();
            ctrl.getDepartments();
            ctrl.ImportDataFromSalesAccount();

            ctrl.getExistOtherPipeline();
            ctrl.getAreAllFieldsEditable();
            ctrl.getIsUnitBodyNull();
            ctrl.getRegionOptions();
            ctrl.getCurrentNewOdrArea();
            ctrl.redirectList();
            ctrl.redirectAccountBook();
            ctrl.redirectSupportList();
            ctrl.redirectNewQuotation();
            //ctrl.LinkageDeleteFromBaan();
            ctrl.ImportDataFromShipmentAccount();

            ctrl.ImportDataFromQuotation();
            ctrl.getNbOption();
            ctrl.indiceOption = 1;
            ctrl.optionMoveUp();
            ctrl.indiceOption = 0;
            ctrl.optionMoveDown();
            ctrl.PrintAnnai1();
            ctrl.PrintAnnai2();

            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test02
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test02() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '5', selectTestMcm.Id);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test03
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test03() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '3', selectTestMcm.Id);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test04_01
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test04_01() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '4', selectTestMcm.Id);
            List<MaintenanceLinkOrderLine__c> maintenanceLinkOrderLineList = createMaintenanceLinkOrderLineTestData(maintenanceLinkOrderList[0].Id, '3', 119600);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test04_02
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test04_02() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '4', selectTestMcm.Id);
            List<MaintenanceLinkOrderLine__c> maintenanceLinkOrderLineList = createMaintenanceLinkOrderLineTestData(maintenanceLinkOrderList[0].Id, '3', 219600);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test04_03
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test04_03() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '4', selectTestMcm.Id);
            List<MaintenanceLinkOrderLine__c> maintenanceLinkOrderLineList = createMaintenanceLinkOrderLineTestData(maintenanceLinkOrderList[0].Id, '3', 319600);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test04_04
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test04_04() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '4', selectTestMcm.Id);
            List<MaintenanceLinkOrderLine__c> maintenanceLinkOrderLineList = createMaintenanceLinkOrderLineTestData(maintenanceLinkOrderList[0].Id, '3', 419600);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test04_05
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test04_05() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('1', '4', selectTestMcm.Id);
            List<MaintenanceLinkOrderForm__c> maintenanceLinkOrderFormList = createMaintenanceLinkOrderFormTestData(maintenanceLinkOrderList[0].Id, '3', 119600, 'Mess Test Text');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test05
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test05() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '2', selectTestMcm.Id);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test06
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test06() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '5', selectTestMcm.Id);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test07
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test07() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceDetailCtrl_Test08
     */
    private static testMethod void JEOL_MaintenanceDetailCtrl_Test08() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '4', selectTestMcm.Id);
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Method ImportDataFromUnitBody
     * MethodName : ImportDataFromUnitBody_Test01
     */
    private static testMethod void ImportDataFromUnitBody_Test01() {
        System.runAs (testUser) {
            // Preparation
            // UnitBody(本体号機)
            UnitBody__c testUnitBody = createUnitBodyTestData();
            MaintenanceContractManagement__c mcm = new MaintenanceContractManagement__c();
            mcm.VersionNumber__c = 1;
            mcm.UnitBody__c = testUnitBody.Id;
            mcm.NewOdrSalesAccount__c = testAccount.Id;
            mcm.NewOdrShipmentAccount__c = testAccount.Id;
            mcm.NewOdrSalesStaff__c = testUser.Id;
            mcm.NewOdrNetMaintenance__c = 'No';
            mcm.NewOdrSeries__c = 'CA';
            mcm.NewOdrRegion__c = '010';
            insert mcm;

            ApexPages.StandardController sc = new ApexPages.StandardController(mcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = mcm;
            ctrl.ImportDataFromUnitBody();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Method LinkageSendToBaan
     * MethodName : LinkageSendToBaan_Test01
     */
    private static testMethod void LinkageSendToBaan_Test01() {
        System.runAs (testUser) {
            // Preparation
            // Custom Setting
            JEOL_TestDataFactory.createBaaNSetting();
            MaintenanceContractManagement__c mcm = testPreparation('2', true, false, false, true);

            // MaintenanceOrderDocument
            MaintenanceOrderDocument__c mod = new MaintenanceOrderDocument__c();
            mod.MaintenanceContractManagement__c = mcm.Id;
            mod.OrderNumber__c = 'ORD001';
            mod.PaymentTerms__c = '3';
            mod.Price__c = 2000;
            mod.ContractDate__c = Date.today();
            mod.PenaltyFlg__c = '1';
            mod.PenaltyRatio__c = '30';
            mod.PaymentFrequency__c = 3;
            mod.CashPromissoryDivision__c = '2';
            mod.SightDays__c = 20;
            mod.PaymentTogetherDivision__c = '1';
            mod.PaymentDayDivision__c = '1';
            mod.InspectionDeadlineDivision__c = '1';
            mod.PaymentDatePeriod__c = '4';
            mod.AcceptanceDeadline__c = '23';
            mod.Factoring__c = '1';
            insert mod;
            ApexPages.StandardController sc = new ApexPages.StandardController(mcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = mcm;

            ctrl.LinkageSendToBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test01
     */
    private static testMethod void save_Test01() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('1', false, false, false, true);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test02
     */
    private static testMethod void save_Test02() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('1', false, true, false, true);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test03
     */
    private static testMethod void save_Test03() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('1', false, false, true, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test04
     */
    private static testMethod void save_Test04() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('1', false, false, false, false);
            selectTestMcm.HidePipeline__c = true;
            update selectTestMcm;
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test05
     */
    private static testMethod void save_Test05() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('1', true, false, false, true);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test06
     */
    private static testMethod void save_Test06() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('1', true, true, false, true);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test07
     */
    private static testMethod void save_Test07() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, true, false, false);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Save Method
     * MethodName : save_Test08
     */
    private static testMethod void save_Test08() {
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, false, false, true);

            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.save();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test LinkageDeleteFromBaan Method
     * MethodName : LinkageDeleteFromBaan_Test01
     */
    private static testMethod void LinkageDeleteFromBaan_Test01() {
return;
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('2', true, true, false, true);
            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.LinkageDeleteFromBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test LinkageDeleteFromBaan Method
     * MethodName : LinkageDeleteFromBaan_Test02
     */
    private static testMethod void LinkageDeleteFromBaan_Test02() {
return;
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('3', true, true, false, true);
            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.LinkageDeleteFromBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test LinkageDeleteFromBaan Method
     * MethodName : LinkageDeleteFromBaan_Test03
     */
    private static testMethod void LinkageDeleteFromBaan_Test03() {
return;
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('4', true, true, false, true);
            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.LinkageDeleteFromBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test LinkageDeleteFromBaan Method
     * MethodName : LinkageDeleteFromBaan_Test04
     */
    private static testMethod void LinkageDeleteFromBaan_Test04() {
return;
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('5', true, true, false, true);
            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.LinkageDeleteFromBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test LinkageDeleteFromBaan Method
     * MethodName : LinkageDeleteFromBaan_Test05
     */
    private static testMethod void LinkageDeleteFromBaan_Test05() {
return;
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('6', true, true, false, true);
            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.LinkageDeleteFromBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test LinkageDeleteFromBaan Method
     * MethodName : LinkageDeleteFromBaan_Test06
     */
    private static testMethod void LinkageDeleteFromBaan_Test06() {
return;
        System.runAs (testUser) {
            // Preparation
            MaintenanceContractManagement__c selectTestMcm = testPreparation('7', true, true, false, true);
            selectTestMcm.PipelineStoppedReason__c = 'H99_TORIKESHI';
            update selectTestMcm;
            List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = createMaintenanceLinkOrderTestData('2', '3', selectTestMcm.Id);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceDetail;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('id', selectTestMcm.Id);
            testPage.getParameters().put('print', 'true');
            ApexPages.StandardController sc = new ApexPages.StandardController(selectTestMcm);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceDetailCtrl ctrl = new JEOL_MaintenanceDetailCtrl(sc);
            ctrl.so = selectTestMcm;
            ctrl.LinkageDeleteFromBaan();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description:Test Preparation
     * MethodName :testPreparation
     * @ return MaintenanceContractManagement(保守契約管理)
     */
    private static MaintenanceContractManagement__c testPreparation(String status, Boolean previousYearOrder, Boolean pipelineStopped, Boolean contractImpossible, Boolean renewalApproved){
        // Preparation
        Date startD = createDateInstance(2016, 5, 1);
        Date endD = createDateInstance(2016, 5, 30);
        // Department (部署)
        Department__c testDepartment = createDepartmentTestData();

        // ProductItem(品目)
        ProductItem__c productItem = createProductItemTestData();
        // UnitBody(本体号機)
        UnitBody__c testUnitBody = createUnitBodyTestData();
        // MaintenanceAnnaiOptions
        List<MaintenanceAnnaiOptions__c> maoList = JEOL_TestDataFactory.createMAOTestData('契約書を作成する', false, true, 3);
        // QuotationInformation(見積書情報)
        QuotationInformation__c quotationInformation = createQuotationInformationTestData('テスト見積書情報名');
        // SalesOrder (販売オーダ)
        SalesOrder__c salesOrder1 = createSalesOrderTestData(quotationInformation.Id);
        SalesOrder__c salesOrder2 = createSalesOrderTestData(quotationInformation.Id);
        // SalesPipeline (営業パイプライン)
        SalesPipeline__c salesPipeline = createSalesPipelineTestData(testDepartment.Id, productItem.Id);
        // 前年保守契約管理
        MaintenanceContractManagement__c preMcm = new MaintenanceContractManagement__c();
        preMcm.Status__c = status;
        preMcm.RenewalApproved__c = renewalApproved;
        // PipelingStop (契約中止)
        preMcm.PipelineStopped__c = pipelineStopped;
        if(pipelineStopped){
            preMcm.PipelineStoppedReason__c = 'H01';
            preMcm.PipelineStoppedDate__c = Date.today();
        }
        insert preMcm;

        //MaintenanceContractManagement(保守契約管理レコード作成)
        MaintenanceContractManagement__c mcm = new MaintenanceContractManagement__c();
        mcm.AnnaiType__c = '1page';
        mcm.Status__c = status;
        mcm.NewOdrSalesAccount__c = testAccount.Id;
        mcm.NewOdrShipmentAccount__c = testAccount.Id;
        mcm.NewOdrSalesStaff__c = testUser.Id;
        mcm.NewOdrAssistant__c = testUser.Id;
        mcm.NewOdrNetMaintenance__c = 'No';
        mcm.NewOdrSeries__c = 'CA';
        mcm.NewOdrRegion__c = '010';
        mcm.QuotationSentDate__c = startD;
        mcm.NewOdrMaintenanceStartDate__c = startD;
        mcm.NewOdrMaintenanceEndDate__c = endD;
        mcm.BillingMethodHontai__c = '請求方法';
        mcm.BillingMethodHelium__c = '請求方法';
        mcm.SubAmountHontaiNoInspec__c = 3000;
        mcm.SubAmountHelium__c = 2000;
        mcm.NewOdrDepartment__c = testDepartment.Id;
        mcm.UnitBody__c = testUnitBody.Id;
        mcm.RenewalListOptions__c = 'テストオプション\n オプション';
        mcm.ProductNumber__c = 'CA9391601000001';
        mcm.NewOdrQuotation__c = quotationInformation.Id;
        mcm.NewOdrFiscalYear__c = '16';
        if(previousYearOrder){
            mcm.PreviousYearOrder__c = salesOrder1.Id;
            mcm.PreviousYearPipeline__c = preMcm.Id;
        }
        // PipelingStop (契約中止)
        mcm.PipelineStopped__c = pipelineStopped;
        if(pipelineStopped){
            mcm.PipelineStoppedReason__c = 'H01';
            mcm.PipelineStoppedDate__c = Date.today();
        }
        // ContractImpossible (契約不可)
        mcm.ContractImpossible__c = contractImpossible;
        if(contractImpossible){
            mcm.ContractImpossibleReason__c = '契約不可案件';
        }
        mcm.NewOdrReferenceOrder__c = salesOrder1.Id;
        mcm.NewOdrSalesOrder__c = salesOrder2.Id;
        mcm.NewOdrFlagshipProduct__c = 'テスト商品名(2016/05)';
        mcm.NewOdrContractDivision__c = '2';
        mcm.NewOdrSalesPipeline__c = salesPipeline.Id;
        mcm.RenewalApproved__c = renewalApproved;
        mcm.NewOdrTroubleshooting__c = '故障修理';
        mcm.NewOdrNotices1__c = '特記事項１';
        mcm.NewOdrNotices2__c = '特記事項2';
        mcm.NewOdrRepairParts__c = '修理部品';
        mcm.NewOdrAtt__c = 'ATT';
        mcm.NewOdrOther1__c = 'その他１';
        mcm.NewOdrOther2__c = 'その他2';
        mcm.NewOdrSalesNoOfTimes__c = '2';
        mcm.NewOdrCommissionPayment__c = testAccount.Id;
        mcm.NewOdrMaintenanceType__c = '1';
        mcm.NewOdrRoutineCheck__c = 2;
        mcm.NewOdrTradingCompanyInvolved__c = '1';
        mcm.NewOdrNewUpdated__c = '1';
        mcm.NewOdrContractAmountt__c = 0.00;
        mcm.NewOdrShareOrderAmount__c = 0.00;
        mcm.NewOdrCommissionOrderAmount__c = 0.00;
        mcm.NewOdrOrderDate__c = Date.today();
        insert mcm;
        // getMaintenanceContractManagement(保守契約管理抽出)
        MaintenanceContractManagement__c selectTestMcm = getMaintenanceContractManagement(mcm.Id);
        // SelectListManage(選択リスト管理)
        List<SelectListManage__c> testSLMList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', 'TK', 'QuotationAreaCode', 'TK', 6);
        // Set Page
        PageReference testPage = Page.JEOL_MaintenanceDetailView;
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', selectTestMcm.Id);
        return selectTestMcm;
    }

    /*
     * Description:Create MaintenanceLinkOrder TestData(BaaN連携データテストデータ作成)
     * MethodName :createMaintenanceLinkOrderTestData
     * @ String clyn(削除)
     * @ String ifst(連携状況)
     * @ Id selectTestMcmId(保守契約管理Id)
     * @ return maintenanceLinkOrderList(BaaN連携データリスト)
     */
    private static List<MaintenanceLinkOrder__c> createMaintenanceLinkOrderTestData(String clyn, String ifst, Id selectTestMcmId){
        // MaintenanceLinkOrder(BaaN連携データ)
        List<MaintenanceLinkOrder__c> maintenanceLinkOrderList = new List<MaintenanceLinkOrder__c>();
            MaintenanceLinkOrder__c maintenanceLinkOrder = new MaintenanceLinkOrder__c();
            maintenanceLinkOrder.MaintenanceContractManagement__c = selectTestMcmId;
            maintenanceLinkOrder.clyn__c = clyn;
            maintenanceLinkOrder.ifst__c = ifst;
            maintenanceLinkOrderList.add(maintenanceLinkOrder);
        insert maintenanceLinkOrderList;
        return maintenanceLinkOrderList;
    }

    /*
     * Description:Create MaintenanceLinkOrderLine TestData
     * MethodName :createMaintenanceLinkOrderLineTestData
     * @ Id maintenanceLinkOrderId (BaaN連携データId)
     * @ String ifst
     * @ Decimal sqno
     * @ String mess
     * @ return MaintenanceLinkOrderFormList
     */
    private static List<MaintenanceLinkOrderForm__c> createMaintenanceLinkOrderFormTestData(Id maintenanceLinkOrderId, String ifst, Decimal sqno, String mess){
        // MaintenanceLinkOrderLine
        List<MaintenanceLinkOrderForm__c> maintenanceLinkOrderFormList = new List<MaintenanceLinkOrderForm__c>();
            MaintenanceLinkOrderForm__c maintenanceLinkOrderForm = new MaintenanceLinkOrderForm__c();
            maintenanceLinkOrderForm.MaintenanceLinkOrder__c = maintenanceLinkOrderId;
            maintenanceLinkOrderForm.sqno__c = sqno;
            maintenanceLinkOrderForm.ifst__c = ifst;
            maintenanceLinkOrderForm.mess__c = mess;
            maintenanceLinkOrderFormList.add(maintenanceLinkOrderForm);
        insert maintenanceLinkOrderFormList;
        return maintenanceLinkOrderFormList;
    }

    /*
     * Description:Create MaintenanceLinkOrderLine TestData
     * MethodName :createMaintenanceLinkOrderLineTestData
     * @ Id maintenanceLinkOrderId (BaaN連携データId)
     * @ String ifst
     * @ Decimal pono
     * @ return maintenanceLinkOrderLineList
     */
    private static List<MaintenanceLinkOrderLine__c> createMaintenanceLinkOrderLineTestData(Id maintenanceLinkOrderId, String ifst, Decimal pono){
        // MaintenanceLinkOrderLine
        List<MaintenanceLinkOrderLine__c> maintenanceLinkOrderLineList = new List<MaintenanceLinkOrderLine__c>();
            MaintenanceLinkOrderLine__c maintenanceLinkOrderLine = new MaintenanceLinkOrderLine__c();
            maintenanceLinkOrderLine.MaintenanceLinkOrder__c = maintenanceLinkOrderId;
            maintenanceLinkOrderLine.pono__c = pono;
            maintenanceLinkOrderLine.ifst__c = ifst;
            maintenanceLinkOrderLineList.add(maintenanceLinkOrderLine);
        insert maintenanceLinkOrderLineList;
        return maintenanceLinkOrderLineList;
    }

    /*
     * Description: Create Department TestData(部署テストデータ作成)
     * MethodName : createDepartmentTestData
     * @ return 部署
     */
    private static Department__c createDepartmentTestData(){
        Department__c department = new Department__c();
        department.Name = 'TK';
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
     * @ return unitBody(本体号機)
     */
    private static UnitBody__c createUnitBodyTestData(){
        // ProductItem(品目)
        ProductItem__c productItem = createProductItemTestData();
        // UnitBody(本体号機)
        UnitBody__c unitBody = new UnitBody__c();
        unitBody.Name = 'N0001';
        unitBody.UnitBody__c = 'N0001';
        unitBody.ItemLink__c = productItem.Id;
        unitBody.ShippingDate__c = Datetime.now();
        insert unitBody;
        return unitBody;
    }

    /*
     * Description:Create QuotationInformation TestData(見積書情報テストデータ作成)
     * MethodName :createQuotationInformationTestData
     * @ String name
     * @ return QuotationInformation(見積書情報)
     */
    private static QuotationInformation__c createQuotationInformationTestData(String name){
        // RecordType
        RecordType quotationInformationRct = JEOL_TestDataFactory.getRecordType('QuotationInformation__c');
        // QuotationInformation(見積書情報)
        QuotationInformation__c quotationInformation = new QuotationInformation__c();
        quotationInformation.RecordTypeId = quotationInformationRct.Id;
        quotationInformation.Name = name;
        quotationInformation.QuoteNo__c = 'Q01';
        quotationInformation.BranchNo__c = '1';
        quotationInformation.LinkageStatus__c = '未連携';
        quotationInformation.ContractAccount__c = testAccount.Id;
        insert quotationInformation;
        return quotationInformation;
    }

    /*
     * Description:Create ProductItem TestData(品目テストデータ作成)
     * MethodName :createProductItemTestData
     * @ return ProductItem(品目)
     */
    private static ProductItem__c createProductItemTestData(){
        // ProductItem(品目)
        ProductItem__c productItem = new ProductItem__c();
        productItem.Name = '0テスト品目名';
        insert productItem;
        return productItem;
    }

    /*
     * Description:Create SalesPipeline TestData(営業パイプラインテストデータ作成)
     * MethodName :createSalesPipelineTestData
     * @ Id departmentId(部署Id)
     * @ Id shohinId(商品Id)
     * @ return SalesPipeline(営業パイプライン)
     */
    private static SalesPipeline__c createSalesPipelineTestData(Id departmentId, Id shohinId){
        // SalesPipeline(営業パイプライン)
        SalesPipeline__c salesPipeline = new SalesPipeline__c();
        salesPipeline.PipelineType__c = 'A';
        salesPipeline.KigyoTani__c = 'T';
        salesPipeline.KigyoTaniPicklist__c = 'T';
        salesPipeline.CountryName__c = 'JPN';
        salesPipeline.CountryNamePicklist__c = 'JPN';
        salesPipeline.Series__c = 'CA';
        salesPipeline.SeriesPicklist__c = 'CA';
        salesPipeline.CustomerAccount__c = testAccount.Id;
        salesPipeline.YosanKakudoValue__c = 30;
        salesPipeline.Department__c = departmentId;
        salesPipeline.DepartmentPicklist__c = 'S0101';
        salesPipeline.Shohin__c = shohinId;
        salesPipeline.Shohin__c = shohinId;
        salesPipeline.RegionName__c = '010';
        salesPipeline.RegionNamePicklist__c = '010';
        salesPipeline.JuchuKakudoValue__c = 30;
        salesPipeline.Field13__c = 'MED';

        insert salesPipeline;
        return salesPipeline;
    }

    /*
     * Description: Create SalesOrder TestData(販売オーダテストデータ作成)
     * MethodName : createSalesOrderTestData
     * @ Id quotationInformationId(見積書情報Id)
     * @ return SalesOrder(販売オーダ)
     */
    private static SalesOrder__c createSalesOrderTestData(Id quotationInformationId){
        // SalesOrder (販売オーダ)
        RecordType salesOrderRecTypes = JEOL_TestDataFactory.getRecordType('SalesOrder__c');
        //SalesOrder
        SalesOrder__c salesOrder = new SalesOrder__c();
        salesOrder.RecordTypeId = salesOrderRecTypes.Id;
        salesOrder.Name = 'N0001';
        salesOrder.MaintenanceStartDate__c = Datetime.newInstance(2015,5,1,5,30,30);
        salesOrder.MaintenanceEndDate__c = Datetime.newInstance(2015,5,30,5,30,30);
        salesOrder.UpdateStatus__c = '契約中';
        salesOrder.Area__c = 'TK';
        salesOrder.SalesStaffCode__c = 'S0000001';
        salesOrder.AssistantCode__c = 'A0000001';
        salesOrder.SalesOffice__c = 'TK';
        salesOrder.QuotationInformation__c = quotationInformationId;
        insert salesOrder;
        return salesOrder;
    }

    /*
     * Description:Get MaintenanceContractManagement TestData(保守契約管理テストデータ抽出)
     * MethodName :getMaintenanceContractManagement
     * @ Id mcmId (保守契約管理ID)
     * @ return MaintenanceContractManagement
     */
    private static MaintenanceContractManagement__c getMaintenanceContractManagement(Id mcmId){
        String query = 'SELECT Id,';
        query += 'AnnaiType__c, ';
        query += 'VersionNumber__c, ';
        query += 'NewOdrOrderDate__c, ';
        query += 'LastLinkBaaN__c, ';
        query += 'PreviousYearPipeline__c, ';
        query += 'Status__c, ';
        query += 'ContractImpossible__c, ';
        query += 'ContractImpossibleReason__c, ';
        query += 'HidePipeline__c, ';
        query += 'NewOdrSalesAccount__c, ';
        query += 'NewOdrAssistant__c, ';
        query += 'NewOdrAssistant__r.UserCode__c, ';
        query += 'RenewalApproved__c, ';
        query += 'PipelineStopped__c, ';
        query += 'PipelineStoppedDate__c, ';
        query += 'PipelineStoppedReason__c, ';
        query += 'NewOdrShipmentAccount__c, ';
        query += 'NewOdrShipmentAccount__r.SalesAccountFlag__c, ';
        query += 'NewOdrShipmentAccount__r.SalesAccountSituation__c, ';
        query += 'NewOdrShipmentAccount__r.ShipmentAccountFlag__c, ';
        query += 'NewOdrShipmentAccount__r.ShipmentAccountSituation__c, ';
        query += 'UnitBody__c, ';
        query += 'UnitBody__r.UnitBody__c, ';
        query += 'RenewalListOptions__c, ';
        query += 'NewOdrSalesStaff__c, ';
        query += 'NewOdrSalesStaff__r.UserCode__c, ';
        query += 'NewOdrSalesStaff__r.RetiredFlag__c, ';
        query += 'NewOdrSalesStaff__r.RetiredDate__c, ';
        query += 'NewOdrNetMaintenance__c, ';
        query += 'NewOdrSeries__c, ';
        query += 'NewOdrRegion__c, ';
        query += 'QuotationSentDate__c, ';
        query += 'NewOdrMaintenanceStartDate__c, ';
        query += 'NewOdrMaintenanceEndDate__c, ';
        query += 'BillingMethodHontai__c, ';
        query += 'BillingMethodHelium__c, ';
        query += 'SubAmountHontaiNoInspec__c, ';
        query += 'SubAmountHelium__c, ';
        query += 'NewOdrDepartment__c, ';
        query += 'ProductNumber__c, ';
        query += 'NewOdrFlagshipProduct__c, ';
        query += 'NewOdrQuotation__c, ';
        query += 'NewOdrQuotation__r.QuoteNo__c, ';
        query += 'NewOdrQuotation__r.BranchNo__c, ';
        query += 'NewOdrQuotation__r.ContractAccount__c, ';
        query += 'NewOdrQuotation__r.ContractAccount__r.Code__c, ';
        query += 'NewOdrQuotation__r.RecordType.Name, ';
        query += 'NewOdrQuotation__r.LinkageStatus__c, ';
        query += 'NewOdrFiscalYear__c, ';
        query += 'PreviousYearOrder__c, ';
        query += 'NewOdrReferenceOrder__c, ';
        query += 'NewOdrReferenceOrder__r.Name, ';
        query += 'NewOdrSalesOrder__c, ';
        query += 'NewOdrSalesPipeline__c, ';
        query += 'NewOdrSalesPipeline__r.Name, ';
        query += 'NewOdrSalesPipeline__r.Series__c, ';
        query += 'NewOdrSalesPipeline__r.RegionName__c, ';
        query += 'PreviousYearOrder__r.MaintenanceStartDateFormula__c, ';
        query += 'PreviousYearOrder__r.MaintenanceEndDateFormula__c, ';
        query += 'PreviousYearOrder__r.QuotationInformation__c, ';
        query += 'NewOdrSalesAccount__r.SalesAccountFlag__c, ';
        query += 'NewOdrSalesAccount__r.SalesAccountSituation__c, ';
        query += 'NewOdrSalesAccount__r.SalesAccountStartDateFormula__c, ';
        query += 'NewOdrSalesAccount__r.SalesAccountEndDateFormula__c, ';
        query += 'NewOdrTroubleshooting__c, ';
        query += 'NewOdrNotices1__c, ';
        query += 'NewOdrNotices2__c, ';
        query += 'NewOdrRepairParts__c, ';
        query += 'NewOdrAtt__c, ';
        query += 'NewOdrOther1__c, ';
        query += 'NewOdrOther2__c, ';
        query += 'NewOdrSalesNoOfTimes__c, ';
        query += 'NewOdrCommissionPayment__c, ';
        query += 'NewOdrMaintenanceType__c, ';
        query += 'NewOdrRoutineCheck__c, ';
        query += 'NewOdrNewUpdated__c, ';
        query += 'NewOdrContractAmountt__c, ';
        query += 'NewOdrShareOrderAmount__c, ';
        query += 'NewOdrCommissionOrderAmount__c, ';
        query += 'NewOdrTradingCompanyInvolved__c, ';
        query += 'SalesAmountEstimateSum__c, ';
        query += 'SalesReturnAmountReal__c, ';
        query += 'ContractAmountLine__c, ';
        query += 'NewOdrDepartment__r.DepartmentCode__c ';
        query += 'FROM MaintenanceContractManagement__c ';
        query += 'WHERE Id =:mcmId';
        MaintenanceContractManagement__c resultRec = Database.query(query);
        return resultRec;
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