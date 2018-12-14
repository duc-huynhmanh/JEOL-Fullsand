@isTest
private class JEOL_MaintenanceListToRenew_ctrlTest {
    // Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListToRenew_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceListToRenew_ctrl_Test01() {
        System.runAs (testUser) {
            // Preparation
            // Set Cookie
            List<Cookie> cookieList = setCurrentCookie();
            // SelectListManage(選択リスト管理)
            List<SelectListManage__c> selectListManageList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', '東京支店', 'QuotationAreaCode', '東京支店', 6);
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceListToRenew;
            Test.setCurrentPage(testPage);
            ApexPages.currentPage().setCookies(cookieList);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListToRenew_ctrl ctrl = new JEOL_MaintenanceListToRenew_ctrl();
            ctrl.getCCategoryOptions();
            ctrl.getRegionOptions();
            ctrl.getListAccountTypeName();
            ctrl.getListAccountTypeCode();
            ctrl.getListNetMaintenance();
            ctrl.seriesSelectCancel();
            for(JEOL_MaintenanceListToRenew_ctrl.OptionDetail od :ctrl.SeriesOptions){
                od.isSelected = true;
            }
            ctrl.seriesSelectApply();
            ctrl.seriesSelectAllSelect();
            ctrl.seriesSelectAllDeselect();
            for(JEOL_MaintenanceListToRenew_ctrl.OptionDetail od :ctrl.SeriesOptions){
                od.isSelected = true;
            }
            ctrl.getSelectedSeries();
            for(JEOL_MaintenanceListToRenew_ctrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
            ctrl.regionsSelectCancel();
            for(JEOL_MaintenanceListToRenew_ctrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
            ctrl.RegionsSelectApply();
            ctrl.regionsSelectAllSelect();
            ctrl.regionsSelectAllDeselect();
            for(JEOL_MaintenanceListToRenew_ctrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
            ctrl.getSelectedRegions();
            ctrl.getRedirectExportCsvURL();
            ctrl.doFormClear();
            ctrl.getMaintenanceContractManagements();
            ctrl.doSearch();
            ctrl.nextAndSaveCurrentPageNumber();
            ctrl.previousAndSaveCurrentPageNumber();
            ctrl.firstAndSaveCurrentPageNumber();
            ctrl.lastAndSaveCurrentPageNumber();
            ctrl.setJumpSaveCurrentPageSize();
            ctrl.setSizeSaveCurrentPageSize();
            ctrl.saveFlags();
            ctrl.redirectMultiAnnai();
            ctrl.redirectExportCsv();

            ctrl.setJumpSaveCurrentPageSize();
            //Test Stop
            Test.stopTest();
        }
    }

    /*
     * Description:Create CurrentCookie
     * MethodName :setCurrentCookie
     * @ return Cookie List
     */
    private static List<Cookie> setCurrentCookie(){
        List<Cookie> cookieList = new List<Cookie>();
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_RenewalMonth', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_LastYearSalesOrder', '2015',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_CustomerCode', '000000001',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_CustomerName', 'TestAccountName',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_CustCodeType', '1',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_CustNameType', '1',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_JeolPipelineResponsible', '担当者',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_NetMaintenance', 'No',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_ShipmentAddress', '住所',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_UnitBody', '本体号機',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_TargetSeries', 'CA',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_TargetRegions', '東京',null,-1,false));
        cookieList.add(new Cookie('PageNumber', '1',null,-1,false));
        cookieList.add(new Cookie('PageSize', '3',null,-1,false));
        cookieList.add(new Cookie('initSearchFlg', 'true',null,-1,false));
        return cookieList;
    }
}