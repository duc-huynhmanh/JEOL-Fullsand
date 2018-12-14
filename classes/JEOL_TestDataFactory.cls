@isTest
public class JEOL_TestDataFactory {

    private static String TEST_FACTORY_ERROR_MESSAGE = 'The following exception has occurred in JEOL_TestDataFactory: ';

    //creates and returns the OperationHistory__c custom object based on input params
    public static OperationHistory__c createOperationHistoryTestObject(String name, DateTime endDate, DateTime startDate, String responsedBy, String memo, Support__c supportObj ) {
        OperationHistory__c rec = new OperationHistory__c();

        rec.Name = name;
        rec.EndDatetime__c = endDate;
        rec.StartDatetime__c = startDate;
        rec.ResponcedBy__c = responsedBy;
        rec.Memo__c = memo;
        rec.CallCenterReceptionNo__c = supportObj.Name;

        try{
            insert rec;
        }
        catch(DmlException e){
            System.debug(TEST_FACTORY_ERROR_MESSAGE + e.getMessage());
        }
        return rec;
    }

    //creates and returns the Support__c custom object based on input params
    public static Support__c createSupportTestObject(String name, String customerContactName, String unitBodyName, DateTime receptionDateTime){
        Support__c rec = new Support__c();

        rec.Name = name;
        rec.CustomerContactPerson__c = customerContactName;
        rec.UnitBody__c = unitBodyName;
        rec.ReceptionDatetime__c = receptionDateTime;

        try{
            insert rec;
        }
        catch(DmlException e){
            System.debug(TEST_FACTORY_ERROR_MESSAGE + e.getMessage());
        }
        return rec;
    }

    //creates and returns bulk of Support__c custom object based on input params
    public static List<Support__c> createSupportTestObject_Bulk(Integer bulkSize, String namePrefix, String customerContactNamePrefix,
        String unitBodyNamePrefix, DateTime receptionDateTimeBase){
        List<Support__c> recBulk = new List<Support__c>();

        if(bulkSize<1) {
            System.debug('Bulk size is incorrect!');
            return recBulk;
        }
        for(Integer i=0; i<bulkSize; i++){
            Support__c rec = new Support__c();
            rec.Name = namePrefix + String.valueOf(i);
            rec.CustomerContactPerson__c = customerContactNamePrefix + String.valueOf(i);
            rec.UnitBody__c = unitBodyNamePrefix + String.valueOf(i);
            rec.ReceptionDatetime__c = receptionDateTimeBase.addDays(i);
            recBulk.add(rec);
        }
        try{
            insert recBulk;
        }
        catch(DmlException e){
            System.debug(TEST_FACTORY_ERROR_MESSAGE + e.getMessage());
        }

        return recBulk;
    }

    //creates and returns  bulk of the OperationHistory__c custom object based on input params
    public static List<OperationHistory__c> createOperationHistoryTestObject_Bulk(Integer bulkSize, String namePrefix, DateTime endDateBase,
        DateTime startDateBase, String responsedByPrefix, String memoPrefix, List<Support__c> supportObjBulk) {

        List<OperationHistory__c> recBulk = new List<OperationHistory__c>();
        if(bulkSize<1) {
            System.debug('Bulk size is incorrect!');
            return recBulk;
        }
        if(supportObjBulk.size() != bulkSize) {
            System.debug('Bulk size and Support__c object\'s list-size do not match!');
            return recBulk;
        }
        for(Integer i=0; i<bulkSize; i++){
            OperationHistory__c rec = new OperationHistory__c();
            rec.Name = namePrefix + String.valueOf(i);
            rec.EndDatetime__c = endDateBase.addDays(i);
            rec.StartDatetime__c = startDateBase.addDays(i);
            rec.ResponcedBy__c = responsedByPrefix + String.valueOf(i);
            rec.Memo__c = memoPrefix + String.valueOf(i);
            rec.CallCenterReceptionNo__c = supportObjBulk[i].Name;
            recBulk.add(rec);
        }
        try{
            insert recBulk;
        }
        catch(DmlException e){
            System.debug(TEST_FACTORY_ERROR_MESSAGE + e.getMessage());
        }
        return recBulk;
    }

    //creates and returns a user account
    // 2016.5.23 weijian mod start
    /** @ String accountName
      * @ String accountCode
      * @ Boolean salesAccountFlag
      * @ String salessituation
      * @ Boolean shipmentAccountFlag
      * @ String shipmentAccountSituation
      * @ return account
      */
    public static Account createAccountTestObject(String accountName, String accountCode, Boolean salesAccountFlag, String salessituation,Boolean shipmentAccountFlag, String shipmentAccountSituation){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        RecordType accountRecType = [select Id from RecordType where SobjectType = 'Account' AND DeveloperName = 'JEOL_ACCOUNT'];
        Account a = new Account(Name=accountName,
                                Code__c = accountCode,
                                RecordTypeId = accountRecType.Id,
                                SalesAccountFlag__c = salesAccountFlag,
                                SalesAccountSituation__c = salessituation,
                                ShipmentAccountFlag__c = shipmentAccountFlag,
                                ShipmentAccountSituation__c = shipmentAccountSituation
                                );
        System.runAs (testUser) {
            insert a;
        }
        return a;
    }
    //public static Account createAccountTestObject(String accountName){
    //    Account a = new Account(Name=accountName,Code__c = '123456');
    //    insert a;
    //    return a;
    //}
    // 2016.5.23 weijian mod end

    //creates and returns bulk user accounts
    // 2016.5.23 weijian mod start
    /** @ String accountNamePrefix
      * @ Integer bulkSize
      * @ String accountCode
      * @ return accountList
      */
    public static List<Account> createAccountTestObject_Bulk(String accountNamePrefix, Integer bulkSize, String accountCode){
        List<Account> accBulk = new List<Account>();
        for(Integer i=0; i<bulkSize; i++){
            Account a = new Account(Name=accountNamePrefix + i, Code__c = accountCode + String.valueOf(i + 1));
            accBulk.add(a);
        }
        insert accBulk;
        return accBulk;
    }

    //public static List<Account> createAccountTestObject_Bulk(String accountNamePrefix, Integer bulkSize){
    //    List<Account> accBulk = new List<Account>();
    //    for(Integer i=0; i<bulkSize; i++){
    //        Account a = new Account(Name=accountNamePrefix + i);
    //        accBulk.add(a);
    //    }
    //    insert accBulk;
    //    return accBulk;
    //}
    // 2016.5.23 weijian mod end

    //creates and returns MaintenancePurchaseManagement__c with input Params
    public static MaintenancePurchaseManagement__c createMaintenancePurchaseManagementTestObject(String purchasingOffice, String shippingCustomerName,
        String supplierCustomerCode, String unitBodyNumber, String paymentType, Date plannedDate, String regionName,
        Date contractDateFrom, Date contractDateTo){
        MaintenancePurchaseManagement__c obj = new MaintenancePurchaseManagement__c();
        // 2015.5.26 weijian add start
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        // Account
        Account testAccount = createAccountTestObject(shippingCustomerName, '12', false, '有効', false, '有効');
        // UnitBody(本体号機)
        UnitBody__c testUnitBody = createUnitBodyTestData();
        MaintenanceContractManagement__c mcm = new MaintenanceContractManagement__c();
        // 2015.5.26 weijian add end
        // 2015.5.26 weijian add start
        mcm.NewOdrShipmentAccount__c = testAccount.Id;
        mcm.UnitBody__c = testUnitBody.Id;
        mcm.NewOdrRegion__c = regionName;

        // 2015.5.26 weijian add end
        System.runAs (testUser) {
            insert mcm;
        }
        //insert mcm;
        obj.MaintenanceContractManagement__c = mcm.Id;
        obj.PurchasingOffice__c = purchasingOffice;
        obj.PaymentType__c = paymentType;
        obj.LinkageStatus__c = '連携済';
        // 2015.5.26 weijian add start
        obj.WarehousePlanningDate__c = contractDateTo;
        // 2015.5.26 weijian add end
        if(paymentType == JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM)
            obj.HeliumFillingCompletionDate__c = plannedDate;
        else if((paymentType == JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeNR) || (paymentType == JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeNS))
                obj.NSNRInspectionPlannedDate__c = plannedDate;
        obj.SupplierCustomerCode__c = supplierCustomerCode;
        obj.PurchasingManager__c = testUser.id;

        System.runAs (testUser) {
            insert obj;
        }
        //insert obj;
        return obj;
    }

    //creates and returns MaintenancePurchaseManagement__c with-out input Params
    public static MaintenancePurchaseManagement__c createMaintenancePurchaseManagementTestObject_NoParams(){
        MaintenancePurchaseManagement__c mpm = JEOL_TestDataFactory.createMaintenancePurchaseManagementTestObject('PR033',
            'shippingCustomerName', '123456789', 'unitBodyNumber', JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM,
            date.today().addDays(-1) ,'regionName', date.today().addDays(-1), date.today());
        return mpm;
    }

    /*
     * Description:Create SelectListManage TestData(選択リスト管理テストデータ作成)
     * MethodName :createSelectListManageData
     * @ return SelectListManage(選択リスト管理リスト)
     */
    public static List<SelectListManage__c> createSelectListManageData(String selectName, String label, String referenceName, String value, Integer recordQuantity){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        List<SelectListManage__c> selectListManageList = new List<SelectListManage__c>();
        for(Integer i = 0; i < recordQuantity; i++){
            SelectListManage__c selectListManage = new SelectListManage__c();
            selectListManage.Name = selectName;
            selectListManage.Label__c = label;
            selectListManage.ReferenceName__c = referenceName;
            selectListManage.Value__c = value;
            selectListManage.SortNo__c = String.valueOf(i + 1);
            selectListManageList.add(selectListManage);
        }
        System.runAs (testUser) {
            insert selectListManageList;
        }
        //insert selectListManageList;
        return selectListManageList;
    }

    /*
     * Description:Create UnitBody TestData(本体号機テストデータ作成)
     * MethodName :createUnitBodyTestData
     * @ return unitBody(本体号機)
     */
    public static UnitBody__c createUnitBodyTestData(){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        // ProductItem(品目)
        ProductItem__c productItem = createProductItemTestData('01');
        // UnitBody(本体号機)
        UnitBody__c unitBody = new UnitBody__c();
        unitBody.Name = '01';
        unitBody.UnitBody__c = '01';
        unitBody.ItemLink__c = productItem.Id;
        System.runAs (testUser) {
            insert unitBody;
        }
        //insert unitBody;
        return unitBody;
    }

    /*
     * Description:Create ProductItem TestData(品目テストデータ作成)
     * MethodName :createProductItemTestData
     * @ String name (ProductItem Name)
     * @ return ProductItem(品目)
     */
    public static ProductItem__c createProductItemTestData(String name){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        // ProductItem(品目)
        ProductItem__c productItme = new ProductItem__c();
        productItme.Name = name;
        System.runAs (testUser) {
            insert productItme;
        }
        //insert productItme;
        return productItme;
    }

    /*
     * Description: Create MaintenanceMultipleAnnai TestData
     * MethodName : createMMATestData
     * @ String mmaName (MaintenanceMultipleAnnai name)
     * @ String targetId
     * @ String renewalOpDateFormat (西暦/和暦)
     * @ Date startD StartDate
     * @ Date endD EndDate
     * @ return maintenanceMultipleAnnai
     */
    public static MaintenanceMultipleAnnai__c createMMATestData(String mmaName, String targetId, String renewalOpDateFormat, Date startD, Date endD){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        MaintenanceMultipleAnnai__c maintenanceMultipleAnnai = new MaintenanceMultipleAnnai__c();
        maintenanceMultipleAnnai.Name = mmaName;
        maintenanceMultipleAnnai.ListId__c = targetId;
        maintenanceMultipleAnnai.ListIdLong__c = targetId;
        maintenanceMultipleAnnai.RenewalOptionDateFormat__c = renewalOpDateFormat;
        maintenanceMultipleAnnai.StartDate__c = startD;
        maintenanceMultipleAnnai.EndDate__c = endD;
        System.runAs (testUser) {
            insert maintenanceMultipleAnnai;
        }
        //insert maintenanceMultipleAnnai;
        return maintenanceMultipleAnnai;
    }

    /*
     * Description: Create MaintenanceAnnaiOptions Test Data
     * MethodName : createMAOTestData
     * @ String label
     * @ Boolean obsolete
     * @ Boolean technicalAlwaysFalse
     * @ Integer recordQuantity (record quantity)
     * @ return MaintenanceAnnaiOptionList
     */
    public static List<MaintenanceAnnaiOptions__c> createMAOTestData(String label, Boolean obsolete, Boolean technicalAlwaysFalse, Integer recordQuantity){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        List<MaintenanceAnnaiOptions__c> maintenanceAnnaiOptionList = new List<MaintenanceAnnaiOptions__c>();
        for(Integer i = 1; i < recordQuantity; i++){
            MaintenanceAnnaiOptions__c maintenanceAnnaiOption = new MaintenanceAnnaiOptions__c();
            maintenanceAnnaiOption.Label__c = label;
            maintenanceAnnaiOption.SortNo__c = i;
            maintenanceAnnaiOption.Obsolete__c = obsolete;
            maintenanceAnnaiOption.TechnicalAlwaysFalse__c = true;
            maintenanceAnnaiOptionList.add(maintenanceAnnaiOption);
        }
        System.runAs (testUser) {
            insert maintenanceAnnaiOptionList;
        }
        //insert maintenanceAnnaiOptionList;
        return maintenanceAnnaiOptionList;
    }

    /*
     * Description: get Date (レコードタイプ取得)
     * MethodName : getRecordType
     * @ parameter String targetOBJ (対象オブジェクト)
     * @ return RecordType (レコードタイプ)
     */
    public static RecordType getRecordType(String targetOBJ){
        List<RecordType> resultRec = [select Id from RecordType where SobjectType = :targetOBJ];
        if (resultRec == null || resultRec.size() <= 0) {
            resultRec = new List<RecordType>();
        }
        return resultRec[0];
    }

    /*
     * Description: create BaaNSettings(CostomSetting)
     * MethodName : createCostomSetting
     * @ return
     */
    public static void createBaaNSetting(){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        // Set CostomSetting(カスタム設定の初期化)
        BaaNSettings__c setting = new BaaNSettings__c();
        setting.Name = 'Default';
        setting.NbDaysSendOK__c = 365;
        System.runAs (testUser) {
            insert setting;
        }
        //insert setting;
    }

    /*
     * Description: create JapaneseEraNameMaster(CostomSetting)
     * MethodName : createJapaneseEraNameMaster
     * @ return
     */
    public static List<JapaneseEraNameMaster__c> createJapaneseEraNameMaster(){
        User testUser = [SELECT Id, UserName FROM User WHERE UserName = 'testuser@globalway.test'];
        if(testUser == null){
            testUser = createTestUser();
        }
        // Set CostomSetting(カスタム設定の初期化)
        List<JapaneseEraNameMaster__c> japaneseEraNameMasterList = new List<JapaneseEraNameMaster__c>();
        String name = '';
        Date startDate = Date.newInstance(1989, 1, 8);
        for(Integer i = 1; i < 5; i++){
            JapaneseEraNameMaster__c japaneseEraNameMaster = new JapaneseEraNameMaster__c();
            if(i == 1){
                name = '平成';
            }
            if(i == 2){
                name = '昭和';
                startDate = Date.newInstance(1926, 12, 25);
            }
            if(i == 3){
                name = '大正';
                startDate = Date.newInstance(1912, 7, 30);
            }
            if(i == 4){
                name = '明治';
                startDate = Date.newInstance(1868, 1, 1);
            }
            japaneseEraNameMaster.Name = name;
            japaneseEraNameMaster.JapaneseCalendarStartDate__c = startDate;
            japaneseEraNameMasterList.add(japaneseEraNameMaster);
        }

        System.runAs (testUser) {
            insert japaneseEraNameMasterList;
        }
        return japaneseEraNameMasterList;
    }

    /*
     * Create Test User
     */
    public static User createTestUser() {
        //get Profile(プロファイル取得)
        Profile profile = [Select Id,Name from Profile where name IN ('System Administrator', 'システム管理者') limit 1];
        // ユーザ
        User user = new User();
        // 姓
        user.LastName = 'testuser';
        // 別名
        user.Alias = 'user';
        // メール
        user.Email = 'testuser@globalway.test';
        // ユーザ名
        user.UserName = 'testuser@globalway.test';
        // コミュニティのニックネーム
        user.CommunityNickname = 'testuser';
        // メールの文字コード
        user.EmailEncodingKey = 'ISO-2022-JP';
        // タイムゾーン
        user.TimeZoneSidKey = 'Asia/Tokyo';
        // 地域
        user.LocaleSidKey = 'ja_JP';
        // 言語
        user.LanguageLocaleKey = 'ja';
        // ユーザコード
        user.UserCode__c = '001';
        // プロファイル
        user.ProfileId = profile.Id;
        insert user;
        return user;
    }
}