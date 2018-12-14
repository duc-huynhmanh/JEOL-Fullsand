@isTest
private class JEOL_MaintenanceInspectionList_ctrlTest {
	// Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceInspectionList_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceInspectionList_ctrl_Test01() {
        System.runAs (testUser) {
            //Test Start
            Test.startTest();
            JEOL_MaintenanceInspectionList_ctrl ctrl = new JEOL_MaintenanceInspectionList_ctrl();
            ctrl.getCCategoryOptions();
            ctrl.getRegionOptions();
            ctrl.getStatusOptions();
            ctrl.getTypeOptions();
            ctrl.seriesSelectCancel();
            ctrl.seriesSelectApply();
            ctrl.seriesSelectAllSelect();
            ctrl.seriesSelectAllDeselect();
            ctrl.getSelectedSeries();
            ctrl.regionsSelectCancel();
            ctrl.RegionsSelectApply();
            ctrl.regionsSelectAllSelect();
            ctrl.regionsSelectAllDeselect();
            ctrl.getSelectedRegions();
            ctrl.doFormClear();
            ctrl.getSalesPipelines();
            ctrl.doSearch();
            ctrl.nextAndSaveCurrentPageNumber();
            ctrl.previousAndSaveCurrentPageNumber();
            ctrl.firstAndSaveCurrentPageNumber();
            ctrl.lastAndSaveCurrentPageNumber();
            ctrl.setJumpSaveCurrentPageSize();
            ctrl.setSizeSaveCurrentPageSize();
            ctrl.saveFlags();
            ctrl.setJumpSaveCurrentPageSize();
            //Test Stop
            Test.stopTest();
        }
    }
}