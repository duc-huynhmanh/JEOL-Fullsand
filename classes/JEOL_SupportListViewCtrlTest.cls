@isTest
private class JEOL_SupportListViewCtrlTest {

  //Tests the positive search result case for passed params for 1 test object
    @isTest static void doSearch_withParams_test_one() {
        PageReference testPage = Page.JEOL_SupportListViewPage;
        Map<String, String> params = testPage.getParameters();
        params.put('UnitBody', 'CA');
        params.put('StartDate', '2009-01-01');
        params.put('EndDate', '2010-01-01');
        Test.setCurrentPage(testPage);

        String recId = getTestData();

        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        ctrl.doSearch();
                List<OperationHistory__c> results = ctrl.getSupportContracts();
                System.assertNotEquals(null,ctrl.ssc);
                System.assertEquals(1,results.size());
                System.assertEquals(true,ctrl.isUnitBodyFieldDisable);
    }

    //Tests the Negative search result case for passed params for 1 test object
    @isTest static void doSearch_withParams_test_two() {
        PageReference testPage = Page.JEOL_SupportListViewPage;
                Map<String, String> params = testPage.getParameters();
                params.put('UnitBody', 'CA');
                params.put('StartDate', '2010-01-01'); //our test object's start date is in 2009
                params.put('EndDate', '2010-01-01');
                Test.setCurrentPage(testPage);

                String recId = getTestData();

                JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
                ctrl.doSearch();
                List<OperationHistory__c> results = ctrl.getSupportContracts();
                System.assertNotEquals(null,ctrl.ssc);
                System.assertEquals(0,results.size());
                System.assertEquals(true,ctrl.isUnitBodyFieldDisable);
    }

    //Tests the Negative search result case for passed params for 1 test object
    @isTest static void doSearch_withParams_test_three() {
        PageReference testPage = Page.JEOL_SupportListViewPage;
                Map<String, String> params = testPage.getParameters();
                params.put('UnitBody', 'CA');
                params.put('StartDate', '2010-01-01');//start date of the test object is 2009
                params.put('EndDate', '2010-01-01');
                Test.setCurrentPage(testPage);

                String recId = getTestData();

                JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
                ctrl.doSearch();
                List<OperationHistory__c> results = ctrl.getSupportContracts();
                System.assertNotEquals(null,ctrl.ssc);
                System.assertEquals(0,results.size());
                System.assertEquals(true,ctrl.isUnitBodyFieldDisable);
    }

    //Tests the positive search result in case of no-params for 1 test object
    @isTest static void doSearch_noParams_test_one() {
        String recId = getTestData();

        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();

        ctrl.doSearch();
        List<OperationHistory__c> results = ctrl.getSupportContracts();
        System.assertNotEquals(null,ctrl.ssc);
        System.assertEquals(1,results.size());
        System.assertEquals(false,ctrl.isUnitBodyFieldDisable);
    }

    //Tests the Negative search result in case of no-params for 0 test object
    @isTest static void doSearch_noParams_test_two() {
        //String recId = getTestData();

        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();

        ctrl.doSearch();
        List<OperationHistory__c> results = ctrl.getSupportContracts();
        System.assertEquals(0,results.size());
        System.assertEquals(false,ctrl.isUnitBodyFieldDisable);
    }

    //Tests the positive search result in case of no-params for 1 test object with additional filter values
    @isTest static void doSearch_noParams_test_three() {
        String recId = getTestData();

        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        ctrl.unitBodyName = 'CA';
        ctrl.secondSupportPerson = 'Agent RB';
        ctrl.customerContactPerson = 'Agent CC';
        ctrl.startDateTimeFrom = Date.valueOf('2009-01-01');
        ctrl.startDateTimeTo = Date.valueOf('2010-01-01');
        ctrl.endDateTimeFrom = Date.valueOf('2009-01-01');
        ctrl.endDateTimeTo = Date.valueOf('2010-01-01');

        ctrl.doSearch();
        List<OperationHistory__c> results = ctrl.getSupportContracts();

        System.assertNotEquals(null,ctrl.ssc);
        System.assertEquals(1,results.size());
        System.assertEquals(false,ctrl.isUnitBodyFieldDisable);
    }

    @isTest static void doSearch_noParams_bulkData_test_one(){
        Integer bulkSize = 50; //SOQL Query limit is 101 so can not generate more than 50 OH records (as 50 Support objects are also crated)
        List<OperationHistory__c> bulkData = getTestData_Bulk(bulkSize);

        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();

        ctrl.doSearch();
        List<OperationHistory__c> results = ctrl.getSupportContracts();

        System.assertNotEquals(null,ctrl.ssc);
        System.assertEquals(bulkSize,results.size());
        System.assertEquals(false,ctrl.isUnitBodyFieldDisable);
    }

    //Tests whether the clear method clears all the data or not
    @isTest static void doClear_one(){
        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        ctrl.doClear();
        System.assertEquals(0,ctrl.getSupportContracts().size());
        System.assertEquals(null,ctrl.unitBodyName);
        System.assertEquals(null,ctrl.startDateTimeFrom);
        System.assertEquals(null,ctrl.startDateTimeTo);
        System.assertEquals(null,ctrl.secondSupportPerson);
        System.assertEquals(null,ctrl.customerContactPerson);
        System.assertEquals(null,ctrl.endDateTimeTo);
        System.assertEquals(null,ctrl.endDateTimeFrom);
        System.assertEquals(null,ctrl.ssc);
        System.assertEquals(false,ctrl.isUnitBodyFieldDisable);
    }

    //Tests the initially initiallized results in case of no-params for bulk objects
    @isTest static void cookieHandlingAndPagingMethods_test_one() {
        Integer bulkSize = 50; //SOQL Query limit is 101 so can not generate more than 50 OH records (as 50 Support objects are also crated)
        List<OperationHistory__c> bulkData = getTestData_Bulk(bulkSize);
        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        ctrl.doSearch();

        System.assertEquals(1,ctrl.ssc.getPageNumber());
        System.assertEquals(50,ctrl.ssc.getPageSize());
    }

    //Tests the paging and cookie logic when page size is changed to 10
    @isTest static void cookieHandlingAndPagingMethods_test_two() {
        Integer bulkSize = 50; //SOQL Query limit is 101 so can not generate more than 50 OH records (as 50 Support objects are also crated)
        List<OperationHistory__c> bulkData = getTestData_Bulk(bulkSize);
        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        // 2016.5.23 weijian mod start
        ctrl.doSearch();
        ctrl.ssc.setPageSize(10);
        ctrl.setJumpSaveCurrentPageSize();
        System.assertEquals(1,ctrl.ssc.getPageNumber());
        System.assertEquals(10,ctrl.ssc.getPageSize());

        ctrl.nextAndSaveCurrentPageNumber();
        System.assertEquals(2,ctrl.ssc.getPageNumber());


        ctrl.previousAndSaveCurrentPageNumber();
        System.assertEquals(1,ctrl.ssc.getPageNumber());

        ctrl.lastAndSaveCurrentPageNumber();
        System.assertEquals(5,ctrl.ssc.getPageNumber());

        ctrl.firstAndSaveCurrentPageNumber();
        System.assertEquals(1,ctrl.ssc.getPageNumber());
        //ctrl.setPageSize(10);
        //ctrl.setJumpSaveCurrentPageSize();
        //ctrl.doSearch();
        //System.assertEquals(1,ctrl.ssc.getPageNumber());
        //System.assertEquals(10,ctrl.ssc.getPageSize());

        //ctrl.nextAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(2,ctrl.ssc.getPageNumber());


        //ctrl.previousAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(1,ctrl.ssc.getPageNumber());

        //ctrl.lastAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(5,ctrl.ssc.getPageNumber());

        //ctrl.firstAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(1,ctrl.ssc.getPageNumber());
        // 2016.5.23 weijian mod end
    }

    //Tests the paging and cookie logic when page size is changed to 20
    @isTest static void cookieHandlingAndPagingMethods_test_three() {
        Integer bulkSize = 50; //SOQL Query limit is 101 so can not generate more than 50 OH records (as 50 Support objects are also crated)
        List<OperationHistory__c> bulkData = getTestData_Bulk(bulkSize);
        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        ctrl.doSearch();

        //Page size is changed to 20
        // 2016.5.23 weijian mod start
        ctrl.ssc.setPageSize(20);
        ctrl.setJumpSaveCurrentPageSize();
        System.assertEquals(20,ctrl.ssc.getPageSize());
        System.assertEquals(1,ctrl.ssc.getPageNumber());

        ctrl.nextAndSaveCurrentPageNumber();
        System.assertEquals(2,ctrl.ssc.getPageNumber());

        ctrl.previousAndSaveCurrentPageNumber();
        System.assertEquals(1,ctrl.ssc.getPageNumber());

        ctrl.lastAndSaveCurrentPageNumber();
        System.assertEquals(3,ctrl.ssc.getPageNumber());

        ctrl.firstAndSaveCurrentPageNumber();
        System.assertEquals(1,ctrl.ssc.getPageNumber());
        //ctrl.setPageSize(20);
        //ctrl.setSizeSaveCurrentPageSize();
        //System.assertEquals(20,ctrl.ssc.getPageSize());
        //System.assertEquals(1,ctrl.ssc.getPageNumber());

        //ctrl.nextAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(2,ctrl.ssc.getPageNumber());

        //ctrl.previousAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(1,ctrl.ssc.getPageNumber());

        //ctrl.lastAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(3,ctrl.ssc.getPageNumber());

        //ctrl.firstAndSaveCurrentPageNumber();
        //ctrl.doSearch();
        //System.assertEquals(1,ctrl.ssc.getPageNumber());
        // 2016.5.23 weijian mod end
    }

    //Tests the doRunReport methods, if it returns a non null Page-reference
    @isTest static void doRunReport_test_one(){
        JEOL_SupportListViewCtrl ctrl = new JEOL_SupportListViewCtrl();
        //Blob pageBlob = ctrl.doRunReport().getContent();
        //System.assertNotEquals(0,pageBlob.size());
        // 2016.5.23 weijian mod start
        System.assertEquals(null,ctrl.doRunReport1());
        System.assertEquals(null,ctrl.doRunReport2());
        System.assertEquals(null,ctrl.doRunReport3());

        //System.assertNotEquals(null,ctrl.doRunReport1());
        //System.assertNotEquals(null,ctrl.doRunReport2());
        //System.assertNotEquals(null,ctrl.doRunReport3());
        // 2016.5.23 weijian mod end
    }

    //Instantiates single OperationHistory__c object
    private static String getTestData(){
        Support__c sup = JEOL_TestDataFactory.createSupportTestObject('mySupport1','Agent CC','CA0000000',
            datetime.valueOf('2009-04-04 12:00:00 PM'));
        OperationHistory__c rec = JEOL_TestDataFactory.createOperationHistoryTestObject('二次',datetime.valueOf('2009-02-02 12:00:00 PM'),
            datetime.valueOf('2009-03-03 12:00:00 PM'),'Agent RB','blah blah beh...', sup);
        return rec.Id;
    }

    //Instantiates and returns bulk OperationHistory__c object
    private static List<OperationHistory__c> getTestData_Bulk(Integer bulkSize){
        List<Support__c> supportBulk = JEOL_TestDataFactory.createSupportTestObject_Bulk(bulkSize,'mySupport', 'CC', 'CA000000',
            datetime.valueOf('2009-04-04 12:00:00 PM'));
        List<OperationHistory__c> ohBulk = JEOL_TestDataFactory.createOperationHistoryTestObject_Bulk(bulkSize, '二次',
            datetime.valueOf('2009-02-02 12:00:00 PM'),datetime.valueOf('2009-03-03 12:00:00 PM'),'Agent RB','blah blah beh...',
            supportBulk);
        return ohBulk;
    }
}