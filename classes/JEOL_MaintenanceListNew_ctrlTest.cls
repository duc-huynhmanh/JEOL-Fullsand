@isTest
private class JEOL_MaintenanceListNew_ctrlTest {
    //User(ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListNew_ctrl_Test01
     */
    private static testMethod void JEOL_MaintenanceListNew_ctrl_Test01() {
        System.runAs (testUser) {
            //preparation
            List<Cookie> cookieList = setCurrentCookie();
            // Set Page
            PageReference testPage = Page.JEOL_MaintenanceListNew;
            Test.setCurrentPage(testPage);
            ApexPages.currentPage().setCookies(cookieList);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListNew_ctrl ctrl = new JEOL_MaintenanceListNew_ctrl();
            ctrl.getCCategoryOptions();
            ctrl.getRegionOptions();
            ctrl.getListAccountTypeName();
            ctrl.getListAccountTypeCode();
            ctrl.getListInquiryRepayment();
            ctrl.getListInquiryMaintenancePossibility();
            ctrl.getListInquiryQuotation();
            ctrl.getListExistLastActivityDate();
            ctrl.seriesSelectCancel();
            for(JEOL_MaintenanceListNew_ctrl.OptionDetail od :ctrl.SeriesOptions){
                od.isSelected = true;
            }
            ctrl.seriesSelectApply();
            ctrl.seriesSelectAllSelect();
            ctrl.seriesSelectAllDeselect();
            for(JEOL_MaintenanceListNew_ctrl.OptionDetail od :ctrl.SeriesOptions){
                od.isSelected = true;
            }
            ctrl.getSelectedSeries();
            ctrl.regionsSelectCancel();
            for(JEOL_MaintenanceListNew_ctrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
            ctrl.getSelectedRegions();
            //Test Stop
            Test.stopTest();
        }
    }
    /*
     * Description: Test Constructor(コンストラクターテスト)
     * MethodName : JEOL_MaintenanceListNew_ctrl_Test02
     */
    private static testMethod void JEOL_MaintenanceListNew_ctrl_Test02() {
        System.runAs (testUser) {
            //preparation
            //List<SelectListManage__c> selectListManageList = createTestData();
            List<SelectListManage__c> selectListManageList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', '東京支店', 'QuotationAreaCode', '東京支店', 6);
            //Test Start
            Test.startTest();
            JEOL_MaintenanceListNew_ctrl ctrl = new JEOL_MaintenanceListNew_ctrl();
            Integer i = 1;
            for(JEOL_MaintenanceListNew_ctrl.OptionDetail od :ctrl.SeriesOptions){
                if(i < 3){
                    od.isSelected = true;
                }
                i ++;
            }
            i = 1;
            for(JEOL_MaintenanceListNew_ctrl.OptionDetail od :ctrl.RegionsOptions){
                if(i < 3){
                    od.isSelected = true;
                }
                i ++;
            }
            ctrl.RegionsSelectApply();
            ctrl.getSelectedSeries();
            ctrl.regionsSelectCancel();
            ctrl.regionsSelectAllSelect();
            ctrl.regionsSelectAllDeselect();
            i = 1;
            for(JEOL_MaintenanceListNew_ctrl.OptionDetail od :ctrl.RegionsOptions){
                if(i < 3){
                    od.isSelected = true;
                }
                i ++;
            }
            ctrl.getSelectedRegions();
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
            ctrl.getRedirectExportCsvURL();
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
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_CustomerCode', '１２３４５６７８９',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_CustomerName', 'TestAccountName',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_CustCodeType', '1',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_CustNameType', 'nameType',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_SalesResponsible', 'SalesResponsible',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_ShipmentAddress', 'ShipmentAddress',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_UnitBody', 'UnitBody',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_InquiryRepayment', 'InquiryRepayment',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_ShippingDateYearFrom', '2015',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_ShippingDateYearTo', '2016',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_InquiryMaintenancePossibility', 'InquiryMaintenancePossibility',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_AcceptanceDateYearFrom', '2015',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_AcceptanceDateYearTo', '2016',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_InquiryQuotation', 'InquiryQuotation',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_ExistLastActivityDate', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_LastActivityDateFrom', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_LastActivityDateTo', '201605',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_QuotationSentDateFrom', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_QuotationSentDateTo', '201605',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_PeriodFrom', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_PeriodTo', '201605',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_OrderProbabilityFrom', '201505',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_OrderProbabilityTo', '201605',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListNew_TargetSeries', 'CA',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceListToRenew_TargetRegions', '東京',null,-1,false));
        cookieList.add(new Cookie('PageNumber', '1',null,-1,false));
        cookieList.add(new Cookie('PageSize', '3',null,-1,false));
        cookieList.add(new Cookie('initSearchFlg', 'true',null,-1,false));
        return cookieList;
    }
}