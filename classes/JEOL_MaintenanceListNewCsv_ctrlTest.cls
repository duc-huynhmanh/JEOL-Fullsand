@isTest
private class JEOL_MaintenanceListNewCsv_ctrlTest {
    private static Date startDate = Date.newInstance(2015, 5, 1);
    private static Date endDate = Date.newInstance(2015, 5, 30);
    //User(ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    //Account(取引先)
    private static Account testAccount = JEOL_TestDataFactory.createAccountTestObject('TestAccountName01', '000000001', false, '有効', false, '有効');
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListNewCsv_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceListNewCsv_ctrl_Test01() {
        System.runAs (testUser) {
            // Preparation
            String pattern = '1';
            // Set Cookie
            List<Cookie> cookieList = setCurrentCookie(pattern);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceListNewCsv;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('SERIES', 'CA');
            testPage.getParameters().put('REGIONS', 'TK');
            testPage.getParameters().put('CUSTOMERCODE', 'C001');
            testPage.getParameters().put('CUSTOMERNAME', 'N001');
            testPage.getParameters().put('CUSTCODETYPE', pattern);
            testPage.getParameters().put('CUSTNAMETYPE', pattern);
            testPage.getParameters().put('SALESRESPONSIBLE', 'SALESRESPONSIBLE');
            testPage.getParameters().put('SHIPMENTADDRESS', '住所');
            testPage.getParameters().put('UNITBODY', 'UNITBODY');

            testPage.getParameters().put('INQUIRYREPAYMENT', pattern);
            testPage.getParameters().put('SHIPPINGDATEYEARFROM', '2015/05/01');
            testPage.getParameters().put('SHIPPINGDATEYEARTO', '2015/05/30');
            testPage.getParameters().put('INQUIRYMAINTENANCEPOSSIBILITY', pattern);

            testPage.getParameters().put('ACCEPTANCEDATEYEARFROM', '2015/05/01');
            testPage.getParameters().put('ACCEPTANCEDATEYEARTO', '2015/05/30');
            testPage.getParameters().put('INQUIRYQUOTATION', pattern);
            testPage.getParameters().put('EXISTLASTACTIVITYDATE', pattern);

            testPage.getParameters().put('LASTACTIVITYDATEFROM', '2015/05/01');
            testPage.getParameters().put('LASTACTIVITYDATETO', '2015/05/30');
            testPage.getParameters().put('QUOTATIONSENTDATEFROM', String.valueOf(startDate));
            testPage.getParameters().put('QUOTATIONSENTDATETO', String.valueOf(endDate));

            testPage.getParameters().put('PERIODFROM', String.valueOf(startDate));
            testPage.getParameters().put('PERIODTO', String.valueOf(endDate));
            testPage.getParameters().put('ORDERPROBABILITYFROM', '30');
            testPage.getParameters().put('ORDERPROBABILITYTO', '60');
            ApexPages.currentPage().setCookies(cookieList);
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListNewCsv_ctrl ctrl = new JEOL_MaintenanceListNewCsv_ctrl();

            ctrl.getFileName();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListNewCsv_ctrl_Test02
     */
    private static testMethod void JEOL_MaintenanceListNewCsv_ctrl_Test02() {
        System.runAs (testUser) {
            // Preparation
            String pattern = '2';
            // Set Cookie
            List<Cookie> cookieList = setCurrentCookie(pattern);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceListNewCsv;
            Test.setCurrentPage(testPage);
            testPage.getParameters().put('SERIES', 'CA');
            testPage.getParameters().put('REGIONS', 'TK');
            testPage.getParameters().put('CUSTOMERCODE', 'C001');
            testPage.getParameters().put('CUSTOMERNAME', 'N001');
            testPage.getParameters().put('CUSTCODETYPE', pattern);
            testPage.getParameters().put('CUSTNAMETYPE', pattern);
            testPage.getParameters().put('SALESRESPONSIBLE', 'SALESRESPONSIBLE');
            testPage.getParameters().put('SHIPMENTADDRESS', '住所');
            testPage.getParameters().put('UNITBODY', 'UNITBODY');

            testPage.getParameters().put('INQUIRYREPAYMENT', pattern);
            testPage.getParameters().put('SHIPPINGDATEYEARFROM', '2015/05/01');
            testPage.getParameters().put('SHIPPINGDATEYEARTO', '2015/05/30');
            testPage.getParameters().put('INQUIRYMAINTENANCEPOSSIBILITY', pattern);

            testPage.getParameters().put('ACCEPTANCEDATEYEARFROM', '2015/05/01');
            testPage.getParameters().put('ACCEPTANCEDATEYEARTO', '2015/05/30');
            testPage.getParameters().put('INQUIRYQUOTATION', pattern);
            testPage.getParameters().put('EXISTLASTACTIVITYDATE', pattern);

            testPage.getParameters().put('LASTACTIVITYDATEFROM', '2015/05/01');
            testPage.getParameters().put('LASTACTIVITYDATETO', '2015/05/30');
            testPage.getParameters().put('QUOTATIONSENTDATEFROM', String.valueOf(startDate));
            testPage.getParameters().put('QUOTATIONSENTDATETO', String.valueOf(endDate));

            testPage.getParameters().put('PERIODFROM', String.valueOf(startDate));
            testPage.getParameters().put('PERIODTO', String.valueOf(endDate));
            testPage.getParameters().put('ORDERPROBABILITYFROM', '30');
            testPage.getParameters().put('ORDERPROBABILITYTO', '60');
            ApexPages.currentPage().setCookies(cookieList);
            // MaintenanceContractManagement(保守契約管理)
            MaintenanceContractManagement__c testMcm = createTestData01(startDate, endDate);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListNewCsv_ctrl ctrl = new JEOL_MaintenanceListNewCsv_ctrl();

            ctrl.getFileName();
            //Test Stop
            Test.stopTest();
        }
    }


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
     * Description:Create UnitBody TestData(本体号機テストデータ作成)
     * MethodName :createUnitBodyTestData
     * @ return 本体号機
     */
    private static UnitBody__c createUnitBodyTestData(){
        // ProductItem(品目)
        ProductItem__c productItme = createProductItemTestData();
        // UnitBody(本体号機)
        UnitBody__c unitBody = new UnitBody__c();
        unitBody.Name = 'N000-1';
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
        insert mcm;
        return mcm;
    }

    /*
     * Description:Create CurrentCookie
     * MethodName :setCurrentCookie
     * @ return Cookie List
     */
    private static List<Cookie> setCurrentCookie(String pattern){
        List<Cookie> cookieList = new List<Cookie>();
        cookieList.add(new Cookie('SERIES', 'CA',null,-1,false));
        cookieList.add(new Cookie('REGIONS', 'TK',null,-1,false));
        cookieList.add(new Cookie('CUSTOMERCODE', 'C001',null,-1,false));
        cookieList.add(new Cookie('CUSTOMERNAME', 'N001',null,-1,false));
        cookieList.add(new Cookie('CUSTCODETYPE', pattern,null,-1,false));
        cookieList.add(new Cookie('CUSTNAMETYPE', pattern,null,-1,false));
        cookieList.add(new Cookie('SALESRESPONSIBLE', 'SALESRESPONSIBLE',null,-1,false));
        cookieList.add(new Cookie('SHIPMENTADDRESS', '住所',null,-1,false));
        cookieList.add(new Cookie('UNITBODY', 'UNITBODY',null,-1,false));
        cookieList.add(new Cookie('INQUIRYREPAYMENT', pattern,null,-1,false));
        cookieList.add(new Cookie('SHIPPINGDATEYEARFROM', '2015/05/01',null,-1,false));
        cookieList.add(new Cookie('SHIPPINGDATEYEARTO', '2015/05/30',null,-1,false));
        cookieList.add(new Cookie('INQUIRYMAINTENANCEPOSSIBILITY', pattern,null,-1,false));
        cookieList.add(new Cookie('ACCEPTANCEDATEYEARFROM', '2015/05/01',null,-1,false));
        cookieList.add(new Cookie('ACCEPTANCEDATEYEARTO', '2015/05/30',null,-1,false));
        cookieList.add(new Cookie('INQUIRYQUOTATION', pattern,null,-1,false));
        cookieList.add(new Cookie('EXISTLASTACTIVITYDATE', pattern,null,-1,false));
        cookieList.add(new Cookie('LASTACTIVITYDATEFROM', '2015/05/01',null,-1,false));
        cookieList.add(new Cookie('LASTACTIVITYDATETO', '2015/05/30',null,-1,false));
        cookieList.add(new Cookie('QUOTATIONSENTDATEFROM', String.valueOf(startDate),null,-1,false));
        cookieList.add(new Cookie('QUOTATIONSENTDATETO', String.valueOf(endDate),null,-1,false));
        cookieList.add(new Cookie('PERIODFROM', String.valueOf(startDate),null,-1,false));
        cookieList.add(new Cookie('PERIODTO', String.valueOf(endDate),null,-1,false));
        cookieList.add(new Cookie('ORDERPROBABILITYFROM', '30',null,-1,false));
        cookieList.add(new Cookie('ORDERPROBABILITYTO', '60',null,-1,false));
        return cookieList;
    }
}