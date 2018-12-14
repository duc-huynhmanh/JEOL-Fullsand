@IsTest
private class JEOLUtilTest {
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    private static testMethod void test01() {
        System.runAs (testUser) {
            NumberingMaster__c nm = new NumberingMaster__c();
            nm.Name = 'dummy';
            nm.Prefix__c = 'dummy';
            nm.Suffix__c = 'dummy';
            nm.Type__c = 'dummy';
            nm.Digit__c = 2;
            nm.CurrentNumber__c = 1;
            insert nm;

            String ret1 = JEOLUtil.appendBeforeLikeText('dummy', 'dummy');
            List<String> lsstr = new List<String>();
            lsstr.add('dummy');
            String ret2 = JEOLUtil.appendInText('dummy', lsstr, true);
            String ret3 = JEOLUtil.joinWhereConditions(new List<String>());
            Decimal ret4 = JEOLUtil.getTaxationValue();
            NumberingMaster__c ret5 = JEOLUtil.getTargetMaster('dummy', 'dummy', 'dummy');
            String ret6 = JEOLUtil.nextNumberingValue(ret5);
            JEOLUtil.numberingUpdate(ret5);
            JEOLUtil.paddingLeftPadding(2, 2);
            // 2016.05.20 weijian add start
            String fieldname = 'TestFieldname__c';
            String value = 'TestFieldnameValue';
            JEOLUtil.appendLikeText(fieldname, value);
            JEOLUtil.appendAfterLikeText(fieldname, value);
            JEOLUtil.appendEqualText(fieldname, value);
            JEOLUtil.appendNotEqualText(fieldname, value);
            JEOLUtil.appendLessThanEqualText(fieldname, value);
            JEOLUtil.appendLessThanEqualText(fieldname, value, true);
            JEOLUtil.appendGreaterThanEqualText(fieldname, value);
            JEOLUtil.appendInText(fieldname, new List<String> {value});
            List<Category__c> categoryList = new List<Category__c>();
            for(Integer i = 1; i < 3; i++){
                Category__c category = new Category__c();
                category.Name = '取引先カテゴリ' + String.valueOf(i);
                category.Code__c = 'コード' + String.valueOf(i);
                categoryList.add(category);
            }
            insert categoryList;
            List<Account> accountList = JEOL_TestDataFactory.createAccountTestObject_Bulk('取引先', 2, 'コード');
            JEOLUtil.getCategoryNameOptions();

            JEOLUtil.getCategoryJunctionAccountIds(categoryList[0].Id);
            List<SelectListManage__c> selectListManageList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', '東京支店', 'QuotationAreaCode', '東京支店', 6);
            JEOLUtil.getSelectList(JEOLUtil.REFERENCE_NAME_QUOTATION_AREA_CODE);
            Date testDate = date.newInstance(2015,5,1);
            JEOLUtil.getFormattedDateValue(testDate, 'yyyymmdd');
            // JapaneseEraNameMaster(和暦マスタ)
            List<JapaneseEraNameMaster__c> japaneseEraNameMasterList = JEOL_TestDataFactory.createJapaneseEraNameMaster();
            JEOLUtil.getDateInJapaneseEraFormat(testDate);

            String byteTestData = 'abcd';
            JEOLUtil.getBytes(byteTestData);
            System.AssertEquals(JEOLUtil.getBytes(byteTestData), 4);
            // pattern1
            JEOLUtil.truncateToNBytesBaaN(byteTestData, 4);
            System.AssertEquals(JEOLUtil.truncateToNBytesBaaN(byteTestData, 4), byteTestData);
            // pattern2
            JEOLUtil.truncateToNBytesBaaN(byteTestData, -1);
            System.AssertEquals(JEOLUtil.truncateToNBytesBaaN(byteTestData, -1), '');
            // pattern3
            JEOLUtil.truncateToNBytesBaaN('byteTestData', 6);
            System.AssertEquals(JEOLUtil.truncateToNBytesBaaN('byteTestData', 6), 'byteTe');

            String text = 'text1\ntext2\ntext3\ntext4\n';
            JEOLUtil.createTextLines(text, 6);

            JEOLUtil.removeCarriageReturn(text);
            System.AssertEquals(JEOLUtil.removeCarriageReturn(text), 'text1 text2 text3 text4');
            // pattern1
            JEOLUtil.getFiscalYear(Date.newInstance(2016, 3, 1), false);
            System.AssertEquals(JEOLUtil.getFiscalYear(Date.newInstance(2016, 3, 1), false), 2015);
            // pattern2
            JEOLUtil.getFiscalYear(Date.newInstance(2016, 3, 1), true);
            System.AssertEquals(JEOLUtil.getFiscalYear(Date.newInstance(2016, 3, 1), true), 15);
            // 2016.05.20 weijian add end

            System.AssertEquals(JEOLUtil.nextNumberingPipelineValue(), '00000001');
            System.AssertEquals(JEOLUtil.nextNumberingPipelineValue(), '00000002');
        }

    }

    /*
     * Description: Test Method setSameRoleSharing
     * MethodName : setSameRoleSharing_Test
     */
    private static testMethod void setSameRoleSharing_Test() {
        System.runAs (testUser) {
            List<ServiceOrder__c> recs = createServiceOrder_TestData();
            Map<String, String> idAndSeriesMap = new Map<String, String>();
            List<ServiceOrder__c> shareUseRecs = [SELECT id, Customer__r.SeriesPI__c FROM ServiceOrder__c WHERE id IN: recs];
            for (ServiceOrder__c rec: shareUseRecs) {
                idAndSeriesMap.put(rec.id, rec.Customer__r.SeriesPI__c);
            }
            JEOLUtil.setSameRoleSharing(ServiceOrder__c.SObjectType.getDescribe().getName(), idAndSeriesMap);
        }
    }

    /*
     * Description: create ServiceOrder TestData
     * MethodName : createServiceOrder_TestData
     * @ return ServiceOrder
     */
    private static List<ServiceOrder__c> createServiceOrder_TestData(){
        Support__c sup = JEOL_TestDataFactory.createSupportTestObject('mySupport1','Agent CC','CA0000000', datetime.valueOf('2009-04-04 12:00:00 PM'));
        List<ServiceOrder__c> serviceOrderList = new List<ServiceOrder__c>();
        for(Integer i = 1; i < 3; i++){
            ServiceOrder__c salesOrder = new ServiceOrder__c();
            salesOrder.Name = 'TestSalesOrderName' + String.valueOf(i);
            salesOrder.Customer__c = sup.Id;
            serviceOrderList.add(salesOrder);
        }
        insert serviceOrderList;
        return serviceOrderList;
    }
}