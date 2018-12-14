@isTest
private class JEOL_MaintenanceMultipleAnnai_ctrlTest {
    private static Date startDate = Date.newInstance(2015, 5, 1);
    private static Date endDate = Date.newInstance(2015, 5, 30);
    //User(ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    //Account(取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceMultipleAnnai_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceMultipleAnnai_ctrl_Test01() {
        System.runAs (testUser) {
            // Preparation
            // MaintenanceContractManagement(保守契約管理)
            // exist LastYear
            Boolean existLastYear = true;
            List<MaintenanceContractManagement__c> mcmList = createTestData01(startDate, endDate,existLastYear);
            List<Id> mcmIdList = new List<Id>();
            for(MaintenanceContractManagement__c mcm :mcmList){
                mcmIdList.add(mcm.Id);
            }
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceMultipleAnnai;
            Test.setCurrentPage(testPage);
            Apexpages.currentpage().getparameters().put('Id', String.join(mcmIdList, ','));
            MaintenanceMultipleAnnai__c mma = createMMATestData(String.join(mcmIdList, ','));
            //Test Start
            Test.startTest();
            JEOL_MaintenanceMultipleAnnai_ctrl ctrl = new JEOL_MaintenanceMultipleAnnai_ctrl();
            ctrl.MultipleAnnaiSummary = mma;
            ctrl.indiceOption = 1;
            ctrl.getIsPrintForbidden();
            ctrl.getSalesPipelines();
            ctrl.PrintSogoAnnai1();
            ctrl.PrintSogoAnnai2();
            ctrl.getHidePicklistAnnai();
            ctrl.changeOrder2();
            ctrl.getNbOption();
            ctrl.lsOptions = JEOL_TestDataFactory.createMAOTestData('契約書を作成する', false, true, 3);
            ctrl.optionMoveUp();
            ctrl.indiceOption = 0;
            ctrl.optionMoveDown();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceMultipleAnnai_ctrl_Test02
     */
    private static testMethod void JEOL_MaintenanceMultipleAnnai_ctrl_Test02() {
        System.runAs (testUser) {
            // Preparation
            // MaintenanceContractManagement(保守契約管理)
            // exist LastYear
            Boolean existLastYear = true;
            List<MaintenanceContractManagement__c> mcmList = createTestData01(startDate, endDate,existLastYear);
            List<Id> mcmIdList = new List<Id>();
            for(MaintenanceContractManagement__c mcm :mcmList){
                mcmIdList.add(mcm.Id);
            }
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceMultipleAnnai;
            Test.setCurrentPage(testPage);
            Apexpages.currentpage().getparameters().put('Id', String.join(mcmIdList, ','));
            //Test Start
            Test.startTest();
            JEOL_MaintenanceMultipleAnnai_ctrl ctrl = new JEOL_MaintenanceMultipleAnnai_ctrl();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Create MaintenanceMultipleAnnai TestData
     * MethodName : createMMATestData
     * @ return maintenanceMultipleAnnai
     */
    private static MaintenanceMultipleAnnai__c createMMATestData(String urlParam){
        MaintenanceMultipleAnnai__c maintenanceMultipleAnnai = new MaintenanceMultipleAnnai__c();
        maintenanceMultipleAnnai.Name = '東京';
        maintenanceMultipleAnnai.ListId__c = urlParam;
        maintenanceMultipleAnnai.ListIdLong__c = urlParam;

        insert maintenanceMultipleAnnai;
        return maintenanceMultipleAnnai;
    }

    /*
     * Description: Create SalesOrder TestData(部署テストデータ作成)
     * MethodName : createSalesOrderTestData
     * @ return SalesOrder(販売オーダ)
     */
    private static SalesOrder__c createSalesOrderTestData(){
        // SalesOrder (販売オーダ)
        RecordType salesOrderRecType = JEOL_TestDataFactory.getRecordType('SalesOrder__c');
        //SalesOrder
        SalesOrder__c salesOrder = new SalesOrder__c();
        salesOrder.RecordTypeId = salesOrderRecType.Id;
        salesOrder.Name = 'TestSalesOrderNo.0001';
        salesOrder.MaintenanceStartDate__c = Datetime.newInstance(2015,5,1,5,30,30);
        salesOrder.MaintenanceEndDate__c = Datetime.newInstance(2015,5,30,5,30,30);
        salesOrder.UpdateStatus__c = '契約中';
        salesOrder.Area__c = '東京';
        salesOrder.SalesStaffCode__c = 'S00000001';
        salesOrder.AssistantCode__c = 'A00000001';
        salesOrder.SalesOffice__c = '東京';
        salesOrder.ConsumptionTax__c = 1000;
        insert salesOrder;
        return salesOrder;
    }

    /*
     * Description: Create Department TestData(部署テストデータ作成)
     * MethodName : createDepartmentTestData
     * @ return Department(部署)
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
     * @ parameter Boolean existLastYear (true:前年保守契約管理あり)
     * @ return MaintenanceContractManagementList(保守契約管理リスト)
     */
    private static List<MaintenanceContractManagement__c> createTestData01(Date startDay, Date endDay, Boolean existLastYear){
        // Department(部署)
        Department__c testDepartment = createDepartmentTestData();
        // UnitBody(本体号機)
        UnitBody__c testUnitBody = createUnitBodyTestData();
        // SalesOrder
        SalesOrder__c salesOrder = createSalesOrderTestData();
        // LastYear MaintenanceContractManagement (前年保守契約管理)
        // lastYearStartDate and lastYearEndDate
        Date lastYearStartDate = Date.newInstance(startDay.year() - 1, 5, 1);
        Date lastYearEndDate = Date.newInstance(startDay.year() - 1, 5, 30);
        MaintenanceContractManagement__c lastYearMcm = new MaintenanceContractManagement__c();
        if(existLastYear){
            lastYearMcm.NewOdrSalesAccount__c = testAccount.Id;
            lastYearMcm.NewOdrShipmentAccount__c = testAccount.Id;
            lastYearMcm.NewOdrSalesStaff__c = testUser.Id;
            lastYearMcm.NewOdrNetMaintenance__c = 'No';
            lastYearMcm.NewOdrSeries__c = 'CA';
            lastYearMcm.NewOdrRegion__c = '東京支店';
            lastYearMcm.QuotationSentDate__c = lastYearStartDate;
            lastYearMcm.NewOdrMaintenanceStartDate__c = lastYearStartDate;
            lastYearMcm.NewOdrMaintenanceEndDate__c = lastYearEndDate;
            lastYearMcm.BillingMethodHontai__c = '請求方法';
            lastYearMcm.BillingMethodHelium__c = '請求方法';
            lastYearMcm.SubAmountHontaiNoInspec__c = 3000;
            lastYearMcm.SubAmountHelium__c = 2000;
            lastYearMcm.NewOdrDepartment__c = testDepartment.Id;
            lastYearMcm.UnitBody__c = testUnitBody.Id;
            insert lastYearMcm;
        }
        //MaintenanceContractManagement(保守契約管理レコード作成)
        List<MaintenanceContractManagement__c> mcmList = new List<MaintenanceContractManagement__c>();
        for(Integer i = 1; i < 3; i++){
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
            mcm.NewContractAmount__c = 100000;
            mcm.RenewalAddress__c = '住所';
            mcm.RenewalCompanyName__c = '送付先会社名';
            mcm.RenewalTantoshya__c = '担当者名';
            mcm.JEOLContactPosition__c = '日本電子・連絡先（担当者所属）';
            mcm.JEOLReplyContactPosition__c = '日本電子・回答先（担当者所属）';
            mcm.JEOLRegionName__c = '日本電子・連絡先（支店）';
            mcm.JEOLReplyRegionName__c = '日本電子・回答先（支店）';
            mcm.JeolPipelineResponsible__c = testUser.Id;
            mcm.JeolPipelineResponsible2__c = testUser.Id;
            mcm.JEOLContactTel__c = '日本電子・連絡先（電話番号等）';
            mcm.JEOLReplyContactFax__c = '日本電子・回答先（FAX等）';
            mcm.RenewalCustomerNameReply__c = '客様名称';
            mcm.RenewalFooterComment__c = 'フッターコメント';
            if(i == 1){
                mcm.PreviousYearOrder__c = salesOrder.Id;
                mcm.PreviousYearPipeline__c = lastYearMcm.Id;
            }
            mcmList.add(mcm);
        }

        insert mcmList;
        return mcmList;
    }
}