@isTest
private class JEOL_MaintenancePurchaseSearchL_UtilTest {
    private static String paymentType = '';
    private static String value = '';
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    /*
     * Description: Test Method
     * MethodName : JEOL_MaintenancePurchaseSearchList_Utils_Test01
     */
    private static testMethod void JEOL_MaintenancePurchaseSearchList_Utils_Test01() {
        System.runAs (testUser) {
            //preparation
            JEOL_MaintenancePurchaseSearchList_Utils ctrl = new JEOL_MaintenancePurchaseSearchList_Utils();
            //Test Start
            Test.startTest();
            // RaymentType = NR
            paymentType = 'NR';
            JEOL_MaintenancePurchaseSearchList_Utils.getMPMFieldNameForPaymentType(paymentType);
            //JEOL_MaintenancePurchaseSearchList_Utils.getItemNumberForPaymentType(paymentType);
            // RaymentType = NS
            paymentType = 'NS';
            JEOL_MaintenancePurchaseSearchList_Utils.getMPMFieldNameForPaymentType(paymentType);
            //JEOL_MaintenancePurchaseSearchList_Utils.getItemNumberForPaymentType(paymentType);
            // RaymentType = HELIUM
            paymentType = 'HELIUM';
            JEOL_MaintenancePurchaseSearchList_Utils.getMPMFieldNameForPaymentType(paymentType);
            //JEOL_MaintenancePurchaseSearchList_Utils.getItemNumberForPaymentType(paymentType);
            // RaymentType = BLANK
            paymentType = 'BLANK';
            JEOL_MaintenancePurchaseSearchList_Utils.getMPMFieldNameForPaymentType(paymentType);
            //JEOL_MaintenancePurchaseSearchList_Utils.getItemNumberForPaymentType(paymentType);
            // Taxation(課税)
            value = '1';
            JEOL_MaintenancePurchaseSearchList_Utils.getLabelForKazeiHikazeiValue(value);
            // Not Taxation(非課税)
            value = '2';
            JEOL_MaintenancePurchaseSearchList_Utils.getLabelForKazeiHikazeiValue(value);
            // other (課税でも非課税でもない)
            value = '3';
            JEOL_MaintenancePurchaseSearchList_Utils.getLabelForKazeiHikazeiValue(value);
            //Test Stop
            Test.stopTest();
        }
    }
}