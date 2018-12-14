public without sharing class JEOL_MaintenanceBillingListCsv_ctrl extends JEOL_SearchBase_ctrl {

    public String month{get; set;}
    public String customerCode{get; set;}
    public String customerName{get; set;}
    public String unitBody{get; set;}
    public String type{get; set;}
    public String orderNo{get; set;}
    public String status{get; set;}
    public String netMaintenance{get; set;}
    public String invoiceNumber{get; set;}

    private List<String> targetSeries;
    private List<String> targetRegions;

    Public List<List<String>> lslsstrRowMCM{get;set;}

    Public String sTitle{get;set;}

    Public String getFileName() {
        return 'BillingList_' + date.today().format() + '.csv';
    }
    
    Public JEOL_MaintenanceBillingListCsv_ctrl() {

        // Forbid the launch is the user has not the adequate permission set and ia not an admin
        Profile p = [Select Name from Profile where Id =: userinfo.getProfileid()];
        if (p.Name != 'System Admin' && 
            p.Name != 'System Administrator' && 
            p.Name != 'システム管理者' 
           ) {

            List<PermissionSetAssignment> lsPerm = [SELECT PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId() AND PermissionSet.Name = 'Maintenance_PermSet_02'];
            if (lsPerm == NULL || lsPerm.size() == 0) {
                return;
            }
            
        }

        initFieldFromCookie();
        String soql = ' SELECT ' +
                            ' Id, Name, Month__c, BillingDone__c, MaintenanceContractManagement__r.NewOdrSeries__c, MaintenanceContractManagement__r.NewOdrRegion__c, ' +
                            ' MaintenanceContractManagement__r.ProductNumber__c, MaintenanceContractManagement__r.PreviousYearOrder__r.FlagshipProduct__c, ' +
                            ' MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Name, MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Undergraduate__c, MaintenanceContractManagement__r.NewOdrContractAmountt__c, MaintenanceContractManagement__r.NewOdrSalesOrder__c, MaintenanceContractManagement__r.NewOdrSalesOrder__r.Name, ' +
                            ' MaintenanceContractManagement__r.UnitBody__c, Type__c, SalesAmountEstimate__c, MaintenanceContractManagement__r.UnitBody__r.Model__c, MaintenanceContractManagement__r.NewOdrFlagshipProduct__c, ' +
                            ' MaintenanceContractManagement__c, MaintenanceContractManagement__r.Name, MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Code__c, ' +
                            ' MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Address__c, MaintenanceContractManagement__r.UnitBody__r.Name, MaintenanceContractManagement__r.NewOdrMaintenancePeriodText__c, ' +
                            ' MaintenanceContractManagement__r.NewOdrNetMaintenance__c, BillingAmountEstimate__c, CurrencyIsoCode, InvoiceNumberFormula__c, BillingMethod__c, ' +
                            ' MaintenanceContractManagement__r.NewOdrSalesAccount__r.Code__c, MaintenanceContractManagement__r.NewOdrSalesAccount__r.Name, ' +
                            ' MaintenanceContractManagement__r.NewOdrDepartment__r.Name ' +
                      ' FROM ' +
                            ' MaintenanceAccountBook__c ';                    

        List<String> whereStrElems = getWhereStrList();
        if (whereStrElems.size() > 0) {
            soql += JEOLUtil.joinWhereConditions(whereStrElems);
        }
            
        lslsstrRowMCM = new List<List<String>>();
        
        sTitle = '';
        sTitle = ConcatenateField(sTitle, '保守契約管理: 保守契約管理番号', true);
        sTitle = ConcatenateField(sTitle, '販売オーダ', false);
        sTitle = ConcatenateField(sTitle, '系列', false);
        sTitle = ConcatenateField(sTitle, '販売オフィス', false);
        sTitle = ConcatenateField(sTitle, 'NET保守区分', false);
        sTitle = ConcatenateField(sTitle, '保守管理台帳: 月', false);
        sTitle = ConcatenateField(sTitle, '請求済', false);
        sTitle = ConcatenateField(sTitle, '請求（予定）', false);
        sTitle = ConcatenateField(sTitle, '請求（予定） 通貨', false);
        sTitle = ConcatenateField(sTitle, '請求番号', false);
        sTitle = ConcatenateField(sTitle, '請求方法', false);
        sTitle = ConcatenateField(sTitle, '保守契約期間', false);
        sTitle = ConcatenateField(sTitle, '販売先取引先コード', false);
        sTitle = ConcatenateField(sTitle, '販売先取引先', false);
        sTitle = ConcatenateField(sTitle, '出荷先取引先コード', false);
        sTitle = ConcatenateField(sTitle, '出荷先取引先', false);
        sTitle = ConcatenateField(sTitle, '出荷先取引住所', false);
        sTitle = ConcatenateField(sTitle, '本体号機', false);
        sTitle = ConcatenateField(sTitle, '商品名', false);
        sTitle = ConcatenateField(sTitle, '製番', false);

        List<String> lsstrRowMCM = new List<String>();
        integer iSize = 0;

system.debug('Query for csv: ' + soql);
        for (MaintenanceAccountBook__c mcm : Database.Query(soql + ' ORDER BY NAME LIMIT 10000 ')) {
                
            if (iSize == 1000) {
                lslsstrRowMCM.add(lsstrRowMCM);
                lsstrRowMCM = new List<String>();
                iSize = 0;
            }
            
            String sRow = '';
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.Name, true);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrSalesOrder__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrSeries__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrDepartment__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrNetMaintenance__c, false);
            sRow = ConcatenateField(sRow, mcm.Name, false);
            sRow = ConcatenateField(sRow, mcm.BillingDone__c ? 1 : 0, false);
            sRow = ConcatenateField(sRow, mcm.BillingAmountEstimate__c, false);
            sRow = ConcatenateField(sRow, mcm.CurrencyIsoCode, false);
            sRow = ConcatenateField(sRow, mcm.InvoiceNumberFormula__c, false);
            sRow = ConcatenateField(sRow, mcm.BillingMethod__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrMaintenancePeriodText__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrSalesAccount__r.Code__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrSalesAccount__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Code__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Address__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.UnitBody__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.NewOdrFlagshipProduct__c, false);
            sRow = ConcatenateField(sRow, mcm.MaintenanceContractManagement__r.ProductNumber__c, false);
                        
            lsstrRowMCM.add(sRow);
            
            iSize += 1;
        }
        lslsstrRowMCM.add(lsstrRowMCM);
    }
    
    private String ConcatenateField(String strConcat, object field, boolean fFirstField) {    
        String sReturn = strConcat;
        if (!fFirstField) {
            sReturn += ',';
        }
        if (field != null) {
            if (field instanceOf boolean ||
                field instanceOf Decimal ||
                field instanceOf Date) {
                sReturn += field;
            } else {
                String sField = (String)field;
                sField = sField.replaceAll('[\n\r]', ' ');
                sReturn += '"' + sField.replace('"', '""') + '"';
            }
        }
        return sReturn;
    }


    private List<String> getWhereStrList() {

        List<String> strList = new List<String>();

        strList.add('BillingAmountEstimate__c > 0');
        
        if (String.isNotBlank(this.month)) {
            strList.add(JEOLUtil.appendAfterLikeText('month__c', this.month));
        }

        // 系列
        if (this.targetSeries != null && this.targetSeries.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('MaintenanceContractManagement__r.NewOdrSeries__c', this.targetSeries) + ')');
        }
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('MaintenanceContractManagement__r.NewOdrRegion__c', this.targetRegions) + ')');
        }
        if (String.isNotBlank(this.customerCode)) {
            strList.add('((' + JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.RenewalAccount__r.Code__c', this.customerCode) + ') OR ' +
                         '(' + JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Code__c', this.customerCode) + ') OR ' +
                         '(' + JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrSalesAccount__r.Code__c', this.customerCode) + '))');
        }
        if (String.isNotBlank(this.customerName)) {
            strList.add('((' + JEOLUtil.appendLikeText('MaintenanceContractManagement__r.RenewalAccount__r.Name', this.customerName) + ') OR ' +
                         '(' + JEOLUtil.appendLikeText('MaintenanceContractManagement__r.NewOdrShipmentAccount__r.Name', this.customerName) + ') OR ' +
                         '(' + JEOLUtil.appendLikeText('MaintenanceContractManagement__r.NewOdrSalesAccount__r.Name', this.customerName) + '))');
        }
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.UnitBody__r.Name', this.unitBody));
        }
        if (String.isNotBlank(this.type)) {
            strList.add(JEOLUtil.appendEqualText('type__c', this.type));
        }

        if (String.isNotBlank(this.orderNo)) {
            strList.add(JEOLUtil.appendAfterLikeText('MaintenanceContractManagement__r.NewOdrSalesOrder__r.Name', this.orderNo));
        }
        if (String.isNotBlank(this.status)) {        
            if (this.status == '1') {
                strList.add('BillingDone__c = true');
            } else if (this.status == '2') {
                strList.add('BillingDone__c = false');
            }
        }        
        if (String.isNotBlank(this.netMaintenance)) {
            strList.add(JEOLUtil.appendEqualText('MaintenanceContractManagement__r.NewOdrNetMaintenance__c', this.netMaintenance));
        }
        if (String.isNotBlank(this.invoiceNumber)) {
            strList.add('((' + JEOLUtil.appendAfterLikeText('InvoiceNumber__c', this.invoiceNumber) + ') OR ' +
                         '(' + JEOLUtil.appendAfterLikeText('InvoiceNumberAuto__c', this.invoiceNumber) + '))');
        }
        
        return strList;
    }
    
    
    private void initFieldFromCookie() {

        final String PARAM_MONTH = 'MONTH';
        final String PARAM_CUSTOMERCODE = 'CUSTOMERCODE';
        final String PARAM_CUSTOMERNAME = 'CUSTOMERNAME';
        final String PARAM_UNITBODY = 'UNITBODY';
        final String PARAM_TYPE = 'TYPE';
        final String PARAM_ORDERNO = 'ORDERNO';
        final String PARAM_STATUS = 'STATUS';
        final String PARAM_NETMAINTENANCE = 'NETMAINTENANCE';
        final String PARAM_INVOICENUMBER = 'INVOICENUMBER';
        final String PARAM_SERIES = 'SERIES';
        final String PARAM_REGIONS = 'REGIONS';

            
        if (apexpages.currentpage().getparameters().containsKey(PARAM_MONTH)) {
            this.month = apexpages.currentpage().getparameters().get(PARAM_MONTH);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_CUSTOMERCODE)) {
            this.customerCode = apexpages.currentpage().getparameters().get(PARAM_CUSTOMERCODE);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_CUSTOMERNAME)) {
            this.customerName = apexpages.currentpage().getparameters().get(PARAM_CUSTOMERNAME);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_UNITBODY)) {
            this.UnitBody = apexpages.currentpage().getparameters().get(PARAM_UNITBODY);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_ORDERNO)) {
            this.orderNo = apexpages.currentpage().getparameters().get(PARAM_ORDERNO);
        }
    
        if (apexpages.currentpage().getparameters().containsKey(PARAM_STATUS)) {
            this.status = apexpages.currentpage().getparameters().get(PARAM_STATUS);
        }
        
        if (apexpages.currentpage().getparameters().containsKey(PARAM_NETMAINTENANCE)) {
            this.netMaintenance = apexpages.currentpage().getparameters().get(PARAM_NETMAINTENANCE);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_INVOICENUMBER)) {
            this.invoiceNumber = apexpages.currentpage().getparameters().get(PARAM_INVOICENUMBER);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_TYPE)) {
            this.type = apexpages.currentpage().getparameters().get(PARAM_TYPE);
        }

        if (apexpages.currentpage().getparameters().containsKey(PARAM_SERIES)) {
            String targetSeriesText = apexpages.currentpage().getparameters().get(PARAM_SERIES);
            if (String.isNotBlank(targetSeriesText)) {
                this.targetSeries = targetSeriesText.split('_');
            }
        }    

        if (apexpages.currentpage().getparameters().containsKey(PARAM_REGIONS)) {
            String targetRegionsText = apexpages.currentpage().getparameters().get(PARAM_REGIONS);
            if (String.isNotBlank(targetRegionsText)) {
                this.targetRegions = targetRegionsText.split('_');
            }
        }    

    }
                
}