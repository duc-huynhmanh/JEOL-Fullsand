@isTest
private class JEOL_MaintenanceListNewAdd_ctrlTest {
    private static Date startDate = Date.newInstance(2015, 5, 1);
    private static Date endDate = Date.newInstance(2015, 5, 30);
    private static List<UnitBody__c> unitBodyList;
    private static List<UnitBody__c> selectUnitBodyList;
    //User(ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    //Account(取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListNewAdd_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceListNewAdd_ctrl_Test01() {
        System.runAs (testUser) {
            //preparation
            // UnitBody
            createUnitBodyTestData();
            // UnitBodyId
            List<Id> unitBodyIdList = new List<Id>();
            for(UnitBody__c ub:unitBodyList){
                unitBodyIdList.add(ub.Id);
            }
            getUnitBodyTestData(unitBodyIdList);
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c mcm = createTestData01(startDate, endDate);
            // SalesOrder
            createSalesOrderTestData();
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListNewAdd_ctrl.addContractMaintenanceBatch(10, new List<Integer>{0}, new List<String>{''});
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description:Create UnitBody TestData(本体号機テストデータ作成)
     * MethodName :createUnitBodyTestData
     * @ return
     */
    private static void createUnitBodyTestData(){
        // ProductItem(品目)
        ProductItem__c productItem = createProductItemTestData();
        unitBodyList = new List<UnitBody__c>();
        // UnitBody(本体号機)
        for(Integer i = 1; i < 4; i++){
            UnitBody__c unitBody = new UnitBody__c();
            unitBody.Name = '00' + String.valueOf(i);
            unitBody.ItemLink__c = productItem.Id;
            unitBody.ShippingDate__c = Datetime.newInstance(2015,6,i,5,30,30);
            unitBody.UnitBody__c = 'NM000000-000' + String.valueOf(i);
            unitBody.DeliveryAccount__c = testAccount.Id;
            unitBody.SalesAccount__c = testAccount.Id;
            unitBodyList.add(unitBody);
        }
        insert unitBodyList;
    }

    /*
     * Description:get UnitBody TestData(本体号機テストデータ抽出)
     * MethodName :createUnitBodyTestData
     * @ List<Id> unitBodyIdList
     * @ return unitBodyList
     */
    private static void getUnitBodyTestData(List<Id> unitBodyIdList){
        String query = 'SELECT Id, ';
        query += 'Name, ';
        query += 'ItemLink__c, ';
        query += 'ShippingDate__c, ';
        query += 'UnitBody__c, ';
        query += 'ShippingDateFormula__c, ';
        query += 'DeliveryAccount__r.phone, ';
        query += 'DeliveryAccount__r.fax, ';
        query += 'SalesAccount__r.phone, ';
        query += 'SalesAccount__r.fax, ';
        query += 'SalesAccount__r.Address__c ';
        query += 'FROM UnitBody__c ';
        query += 'WHERE Id IN : unitBodyIdList ';
        selectUnitBodyList = Database.query(query);
    }

    /*
     * Description:Create ProductItem TestData(品目テストデータ作成)
     * MethodName :createProductItemTestData
     * @ return 品目
     */
    private static ProductItem__c createProductItemTestData(){
        // ProductItem(品目)
        ProductItem__c productItem = new ProductItem__c();
        productItem.Name = 'テスト品目名';
        insert productItem;
        return productItem;
    }

    /*
     * Description: Create SalesOrder TestData(販売オーダテストデータ作成)
     * MethodName : createSalesOrderTestData
     * @ return
     */
    private static void createSalesOrderTestData(){
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
        salesOrder.UnitBodyLink__c = unitBodyList[1].Id;
        insert salesOrder;
    }

    /*
     * Description: Create MaintenanceContractManagement TestData(保守契約管理テストデータ作成)
     * MethodName : createTestData01
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
        mcm.UnitBody__c = unitBodyList[0].Id;
        insert mcm;
        return mcm;
    }
}