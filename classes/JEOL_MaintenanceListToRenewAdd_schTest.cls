@isTest
private class JEOL_MaintenanceListToRenewAdd_schTest {
    //User(ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    /*
     * Description: Test Apex scheduleClass
     * MethodName : JEOL_MaintenanceListToRenewAdd_schTest_Test01
     */
    private static testMethod void JEOL_MaintenanceListToRenewAdd_schTest_Test01() {
        // Preparation
        String cronExpression = '0 0 * * * ?';
        System.runAs (testUser) {
            //Test Start
            Test.startTest();
            // Apexをスケジュールに登録
            System.schedule('TestScheduledApex', cronExpression, new JEOL_MaintenanceListToRenewAdd_schedule());
            //Test Stop
            Test.stopTest();
        }
    }
}