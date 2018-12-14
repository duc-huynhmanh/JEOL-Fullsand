@isTest
private class JEOL_MaintenancePurcahseSearchList_Test {
	// Test User (ユーザ)
    private static User testUser = JEOL_TestDataFactory.createTestUser();

    private static Boolean isParam = false;
	private static Id mpmId;

	/*
     * Description: Test Method
     * MethodName : JEOL_MaintenancePurchaseSearchListCtrlMethod_Test
     */
    private static testMethod void JEOL_MaintenancePurchaseSearchListCtrlMethod_Test() {
		System.runAs (testUser) {
            // Preparation
    		// Set Cookie (検索条件をクッキーにより設定を行う)
            List<Cookie> cookieList = setCurrentCookie();
            // Set Page
            PageReference testPage = Page.JEOL_MaintenancePurchaseSearchListPage;
            Test.setCurrentPage(testPage);
            ApexPages.currentPage().setCookies(cookieList);
    		isParam = true;
    		MaintenancePurchaseManagement__c mpm = getMaintenancePurchaseManagement(isParam);
    		// Update
    		mpm.NSNRInspectionPlannedDate__c = Date.today().addDays(+1);
    		update mpm;
    		// SelectListManage(選択リスト管理)
            List<SelectListManage__c> selectListManageList = JEOL_TestDataFactory.createSelectListManageData('サービスエリア', '東京支店', 'QuotationAreaCode', '東京支店', 6);
    		Test.startTest();
    		JEOL_MaintenancePurchaseSearchListCtrl ctrl = new JEOL_MaintenancePurchaseSearchListCtrl();
    		ctrl.getIsAcceptanceSettledOptions();
    		ctrl.regionsSelectCancel();
    		for(JEOL_MaintenancePurchaseSearchListCtrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
    		ctrl.RegionsSelectApply();
    		ctrl.regionsSelectAllSelect();
    		for(JEOL_MaintenancePurchaseSearchListCtrl.OptionDetail od :ctrl.RegionsOptions){
                od.isSelected = true;
            }
    		ctrl.getSelectedRegions();
    		ctrl.regionsSelectAllDeselect();
    		ctrl.setSizeSaveCurrentPageSize();
            ctrl.nextAndSaveCurrentPageNumber();
            ctrl.previousAndSaveCurrentPageNumber();
            ctrl.firstAndSaveCurrentPageNumber();
            ctrl.lastAndSaveCurrentPageNumber();
            ctrl.setJumpSaveCurrentPageSize();

            Test.stopTest();
        }
    }

	//Tests the affirmative case for doSearch() on a single test-object
	@isTest static void doSearchTest_one() {
        System.runAs (testUser) {
    		//Assign
    		// 2016.5.26 weijian mod start
    		// Set Cookie (検索条件をクッキーにより設定を行う)
            List<Cookie> cookieList = setCurrentCookie();
            // Set Page
            PageReference testPage = Page.JEOL_MaintenancePurchaseSearchListPage;
            Test.setCurrentPage(testPage);
            ApexPages.currentPage().setCookies(cookieList);
    		isParam = true;
    		MaintenancePurchaseManagement__c mpm = getMaintenancePurchaseManagement(isParam);
    		// Update
    		mpm.NSNRInspectionPlannedDate__c = Date.today().addDays(+1);
    		update mpm;
    		//MaintenancePurchaseManagement__c mpm = JEOL_TestDataFactory.createMaintenancePurchaseManagementTestObject('123456',
    		//	'shippingCustomerName', '123456789', 'unitBodyNumber', JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM,
    		//	date.today().addDays(-1) ,'regionName', date.today().addDays(-1), date.today());
    		// 2016.5.26 weijian mod end
    		JEOL_MaintenancePurchaseSearchListCtrl ctrl = new JEOL_MaintenancePurchaseSearchListCtrl();
    		// 2016.5.26 weijian del start
    		//ctrl.paymentType = JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM;
    		//ctrl.regionName = 'regionName';
    		//ctrl.shippingCustomerName = 'shippingCustomerName';
    		//ctrl.supplierCustomerCode = '12';
    		//ctrl.unitBodyNumber = 'unitBodyNumber';
    		//ctrl.contractPeriodFrom = date.today();
    		//ctrl.contractPeriodTo = date.today();
    		//ctrl.purchasingOffice = '12';
    		// 2016.5.26 weijian del end

    		//Arrange
    		ctrl.doSearch();

    		//Assert
    		system.assertEquals(0, ctrl.getSearchedRecords().size());
        }
	}

	//Tests the negative case for doSearch() on a single test-object
	@isTest static void doSearchTest_two() {
        System.runAs (testUser) {
    		//Assign
    		// 2016.5.26 weijian mod start
    		isParam = true;
    		MaintenancePurchaseManagement__c mpm = getMaintenancePurchaseManagement(isParam);
    		//MaintenancePurchaseManagement__c mpm = JEOL_TestDataFactory.createMaintenancePurchaseManagementTestObject('123456',
    		//	'shippingCustomerName', '123456789', 'unitBodyNumber', JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM,
    		//	date.today().addDays(-1) ,'regionName', date.today().addDays(-2), date.today()-1);
    		// 2016.5.26 weijian mod end
    		JEOL_MaintenancePurchaseSearchListCtrl ctrl = new JEOL_MaintenancePurchaseSearchListCtrl();
    		ctrl.paymentType = JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM;
    		//ctrl.regionName = 'regionName';
    		ctrl.shippingCustomerName = 'shippingCustomerName';
    		ctrl.supplierCustomerCode = '12';
    		ctrl.unitBodyNumber = 'unitBodyNumber';
            ctrl.contractStartDateFrom = date.today();
            ctrl.contractStartDateTo = date.today();
            ctrl.contractEndDateFrom = date.today();
            ctrl.contractEndDateTo = date.today();
    		ctrl.purchasingOffice = '12';

    		//Arrange
    		ctrl.doSearch();

    		//Assert
    		system.assertEquals(0, ctrl.getSearchedRecords().size());
        }
	}

	//Tests doClear() for a single test-object
	@isTest static void doClearTest_one() {
        System.runAs (testUser) {
    		//Assign
    		// 2016.5.26 weijian mod start
    		isParam = false;
    		MaintenancePurchaseManagement__c mpm = getMaintenancePurchaseManagement(isParam);
    		//MaintenancePurchaseManagement__c mpm = JEOL_TestDataFactory.createMaintenancePurchaseManagementTestObject_NoParams();
    		// 2016.5.26 weijian mod end
    		JEOL_MaintenancePurchaseSearchListCtrl ctrl = new JEOL_MaintenancePurchaseSearchListCtrl();
    		ctrl.paymentType = JEOL_MaintenancePurchaseSearchList_Utils.paymentTypeHELIUM;
    		//ctrl.regionName = 'regionName';
    		ctrl.shippingCustomerName = 'shippingCustomerName';
    		ctrl.supplierCustomerCode = '12';
    		ctrl.unitBodyNumber = 'unitBodyNumber';
            ctrl.contractStartDateFrom = date.today();
            ctrl.contractStartDateTo = date.today();
            ctrl.contractEndDateFrom = date.today();
            ctrl.contractEndDateTo = date.today();
    		ctrl.purchasingOffice = '12';

    		ctrl.doSearch();
    		system.assertNotEquals(ctrl.ssc, null);

    		ctrl.doClear();
    		system.assertEquals(ctrl.ssc, null);
        }
	}


	//TODO: Check the cache methods

	/*
     * Description:get MaintenancePurchaseManagement Test Data
     * MethodName :getMaintenancePurchaseManagement
     * @ Boolean isParams (true: params, false: No Params)
     * @ return MaintenancePurchaseManagement
     */
    private static MaintenancePurchaseManagement__c getMaintenancePurchaseManagement(Boolean isParams){
		MaintenancePurchaseManagement__c mpm = new MaintenancePurchaseManagement__c();
		if(isParams){
			mpm = JEOL_TestDataFactory.createMaintenancePurchaseManagementTestObject('33',
			'01', '03', '01', 'NS',
			date.today().addDays(-1) ,'TK', date.today().addDays(-1), date.today());
		}else{
			mpm = JEOL_TestDataFactory.createMaintenancePurchaseManagementTestObject_NoParams();
		}
		mpmId = mpm.Id;
		system.debug('ID===' + mpmId);
		String query = 'SELECT Id, ';
		query += 'Name, ';
		query += 'PurchasingOffice__c, ';
		query += 'ShipmentCustomerAccount__c, ';
		query += 'SupplierCustomerCode__c, ';
		query += 'PaymentType__c, ';
		query += 'UnitBodyNumber__c, ';
		query += 'RegionName__c, ';
		query += 'MaintenanceContractPeriod__c, ';
		query += 'PurchasingOrder__c, ';
		query += 'WarehousePlanningDate__c, ';
		query += 'HeliumFillingImplementationDate__c, ';
		query += 'NSNRInspectionImplementationDate__c, ';
		query += 'NSNRInspectionPlannedDate__c, ';
		query += 'NSRegularInspectionImplementationDate__c, ';
		query += 'ProductNumber__c, ';
		query += 'isAcceptanceSettled__c ';
		query += 'FROM MaintenancePurchaseManagement__c ';
		query += 'WHERE Id =:mpmId ';
		MaintenancePurchaseManagement__c resultRec = Database.query(query);
		return resultRec;
    }

    /*
     * Description:Create CurrentCookie
     * MethodName :setCurrentCookie
     * @ return Cookie List
     */
    private static List<Cookie> setCurrentCookie(){
        List<Cookie> cookieList = new List<Cookie>();
        cookieList.add(new Cookie('PurchasingOfficeVal', '33',null,-1,false));
        cookieList.add(new Cookie('ShipToCustomerVal', '01',null,-1,false));
        cookieList.add(new Cookie('SupplierCustomerCodeVal', '01',null,-1,false));
        cookieList.add(new Cookie('ShipToCustomerVal', '01',null,-1,false));
        cookieList.add(new Cookie('PaymentTypeVal', 'NS',null,-1,false));
        cookieList.add(new Cookie('UnitBodyNumberVal', '01',null,-1,false));
        cookieList.add(new Cookie('MaintenanceContractStartDateFromVal', '2016/05/01',null,-1,false));
        cookieList.add(new Cookie('MaintenanceContractStartDateToVal', '2016/05/30',null,-1,false));
        cookieList.add(new Cookie('MaintenanceContractEndDateFromVal', '2016/05/01',null,-1,false));
        cookieList.add(new Cookie('MaintenanceContractEndDateToVal', '2016/05/30',null,-1,false));
        cookieList.add(new Cookie('ScheduledDeliveryDateVal', '2016/05/27',null,-1,false));
        cookieList.add(new Cookie('IsAcceptanceSettled', 'true',null,-1,false));
        cookieList.add(new Cookie('JEOL_MaintenanceInspectionList_TargetRegions', 'TK',null,-1,false));
        cookieList.add(new Cookie('PageNumber', '1',null,-1,false));
        cookieList.add(new Cookie('PageSize', '50',null,-1,false));
        cookieList.add(new Cookie('initSearchFlg', 'true',null,-1,false));
        return cookieList;
    }
}