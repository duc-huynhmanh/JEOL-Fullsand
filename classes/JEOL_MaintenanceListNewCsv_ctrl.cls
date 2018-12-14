public without sharing class JEOL_MaintenanceListNewCsv_ctrl extends JEOL_SearchBase_ctrl {

    public String customerCode{get; set;}
    public String customerName{get; set;}
    public String custCodeType{get; set;}
    public String custNameType{get; set;}
    public String salesResponsible{get; set;}
    public String shipmentAddress{get; set;}
    public String unitBody{get; set;}
    public String inquiryRepayment{get; set;}
    public String shippingDateYearFrom{get; set;}
    public String shippingDateYearTo{get; set;}
    public String inquiryMaintenancePossibility{get; set;}
    public String acceptanceDateYearFrom{get; set;}
    public String acceptanceDateYearTo{get; set;}
    public String inquiryQuotation{get; set;}
    public String existLastActivityDate{get; set;}
    public Date lastActivityDateFrom{get; set;}
    public Date lastActivityDateTo{get; set;}
    public Date quotationSentDateFrom{get; set;}
    public Date quotationSentDateTo{get; set;}
    public Date periodFrom{get; set;}
    public Date periodTo{get; set;}
    public String orderProbabilityFrom{get; set;}
    public String orderProbabilityTo{get; set;}
    private List<String> targetSeries;
    private List<String> targetRegions;

    Public List<List<String>> lslsstrRowMCM{get;set;}

    Public String sTitle{get;set;}

    Public String getFileName() {
        return 'NewList_' + date.today().format() + '.csv';
    }
    
    Public JEOL_MaintenanceListNewCsv_ctrl() {

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
                            ' Id, Name, PreviousYearOrder__c, ' +
                            ' ContractSentDate__c, QuotationSentDate__c, RenewalNoticeSentDate__c, LastActivityDate, QuotationCreated__c, ' +
                            ' RenewalContactPosition__c, RenewalTantoshya__c, TechnicalAlwaysFalse__c, UnitBody__r.Name, NewOdrContractAmountt__c, ' +
                            ' NewOdrSalesAccount__r.Name, NewOdrSalesAccount__r.Code__c, NewOdrShipmentAccount__r.Name, NewOdrShipmentAccount__r.Code__c, UnitBody__r.Model__c, UnitBody__r.SerialNo__c, UnitBodyShippingDateFormula__c, UnitBodyAcceptanceDateFormula__c, UnitBodyEFEndDateFormula__c,' +
                            ' toLabel(InquiryRepayment__c), toLabel(InquiryMaintenancePossibity__c), toLabel(InquiryPriceList__c), toLabel(InquiryQuotation__c), JuchuKakudoValue__c, NewOdrSalesPipeline__r.Name, HighlightEFEndDate__c' +
                      ' FROM ' +
                          ' MaintenanceContractManagement__c ';

        List<String> whereStrElems = getWhereStrList();
        if (whereStrElems.size() > 0) {
            soql += JEOLUtil.joinWhereConditions(whereStrElems);
        }
            
        lslsstrRowMCM = new List<List<String>>();
        
        sTitle = '';

        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.Name.getDescribe().getLabel(), true);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.NewOdrSalesPipeline__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.UnitBody__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.UnitBody__c.fields.Model__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, '製造依頼番号', false);
        sTitle = ConcatenateField(sTitle, '販売先取引先コード', false);
        sTitle = ConcatenateField(sTitle, '販売先取引先名', false);
        sTitle = ConcatenateField(sTitle, '出荷先取引先コード', false);
        sTitle = ConcatenateField(sTitle, '出荷先取引先名', false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.UnitBodyShippingDateFormula__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.UnitBodyAcceptanceDateFormula__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.UnitBodyEFEndDateFormula__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, '対応日', false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.QuotationSentDate__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.NewOdrContractAmountt__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.JuchuKakudoValue__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.InquiryRepayment__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.InquiryMaintenancePossibity__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.InquiryPriceList__c.getDescribe().getLabel(), false);
        sTitle = ConcatenateField(sTitle, Schema.MaintenanceContractManagement__c.fields.InquiryQuotation__c.getDescribe().getLabel(), false);

        List<String> lsstrRowMCM = new List<String>();
        integer iSize = 0;

system.debug('Query for csv: ' + soql);
        for (MaintenanceContractManagement__c mcm : Database.Query(soql + ' ORDER BY NAME LIMIT 10000 ')) {
                
            if (iSize == 1000) {
                lslsstrRowMCM.add(lsstrRowMCM);
                lsstrRowMCM = new List<String>();
                iSize = 0;
            }
            
            String sRow = '';

            sRow = ConcatenateField(sRow, mcm.Name, true);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesPipeline__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.UnitBody__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.UnitBody__r.Model__c, false);
            sRow = ConcatenateField(sRow, mcm.UnitBody__r.SerialNo__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesAccount__r.Code__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesAccount__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrShipmentAccount__r.Code__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrShipmentAccount__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.UnitBodyShippingDateFormula__c, false);
            sRow = ConcatenateField(sRow, mcm.UnitBodyAcceptanceDateFormula__c, false);
            sRow = ConcatenateField(sRow, mcm.UnitBodyEFEndDateFormula__c, false);
            sRow = ConcatenateField(sRow, mcm.LastActivityDate, false);
            sRow = ConcatenateField(sRow, mcm.QuotationSentDate__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrContractAmountt__c, false);
            sRow = ConcatenateField(sRow, mcm.JuchuKakudoValue__c, false);
            sRow = ConcatenateField(sRow, mcm.InquiryRepayment__c, false);
            sRow = ConcatenateField(sRow, mcm.InquiryMaintenancePossibity__c, false);
            sRow = ConcatenateField(sRow, mcm.InquiryPriceList__c, false);
            sRow = ConcatenateField(sRow, mcm.InquiryQuotation__c, false);
                        
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
        
        strList.add('HidePipeline__c = false');
        strList.add('ContractImpossible__c = false');
        strList.add('PreviousYearOrder__c = null');
        strList.add('LastLinkBaaN__c = null');
        
        // 系列
        if (this.targetSeries != null && this.targetSeries.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('NewOdrSeries__c', this.targetSeries) + ')');
        }
                
        // 地域
        if (this.targetRegions != null && this.targetRegions.size() > 0) {
            strList.add('(' + JEOLUtil.appendInText('NewOdrRegion__c', this.targetRegions) + ')');
        }

        // 販売先・出荷先コード
        if (String.isNotBlank(this.customerCode)) {
            if (custCodeType == '2') {
                // 出荷先
                strList.add(JEOLUtil.appendAfterLikeText('NewOdrShipmentAccount__r.Code__c', this.customerCode));
            } else {
                // 販売先            
                strList.add(JEOLUtil.appendAfterLikeText('NewOdrSalesAccount__r.Code__c', this.customerCode));
            }
        }
        
        // 販売先・出荷先名称
        if (String.isNotBlank(this.customerName)) {
            if (custNameType == '2') {
                // 出荷先
                strList.add(JEOLUtil.appendLikeText('NewOdrShipmentAccount__r.Name', this.customerName));
            } else {
                // 販売先            
                strList.add(JEOLUtil.appendLikeText('NewOdrSalesAccount__r.Name', this.customerName));
            }
        }
        
        // 更新担当者
        if (String.isNotBlank(this.salesResponsible)) {
            strList.add('((' +
                        JEOLUtil.appendAfterLikeText('NewOdrSalesStaff__r.UserCode__c', this.salesResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrSalesStaff__r.Name', this.salesResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('NewOdrAssistant__r.UserCode__c', this.salesResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrAssistant__r.Name', this.salesResponsible) +
                        '))' );
        }        

        // 住所               
        if (String.isNotBlank(this.shipmentAddress)) {
            strList.add(JEOLUtil.appendLikeText('NewOdrShipmentAccount__r.Address__c', this.shipmentAddress));
        }

        // 本体号機
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('UnitBody__r.Name', this.unitBody));
        }

        // 返却有無
        if (String.isNotBlank(this.inquiryRepayment)) {
            if (inquiryRepayment == '1') {
                strList.add(JEOLUtil.appendEqualText('InquiryRepayment__c', '1'));
            } else if (inquiryRepayment == '2') {
                strList.add(JEOLUtil.appendEqualText('InquiryRepayment__c', '2'));
            } else {
                strList.add('InquiryRepayment__c = null');
            }
        }
        
        // 出荷年度
        if (String.isNotBlank(this.shippingDateYearFrom)) {
            try {
                integer iYear = integer.valueof(this.shippingDateYearFrom);
                date dDateFrom = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.ShippingDateFormula__c >= ' +  String.valueOf(ddateFrom));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
        if (String.isNotBlank(this.shippingDateYearTo)) {
            try {
                integer iYear = integer.valueof(this.shippingDateYearTo) + 1;
                date dDateTo = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.ShippingDateFormula__c < ' +  String.valueOf(ddateTo));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
       
        // 保守可能性
        if (String.isNotBlank(this.inquiryMaintenancePossibility)) {
            if (inquiryMaintenancePossibility == '1') {
                strList.add(JEOLUtil.appendEqualText('InquiryMaintenancePossibity__c', '1'));
            } else if (inquiryMaintenancePossibility == '2') {
                strList.add(JEOLUtil.appendEqualText('InquiryMaintenancePossibity__c', '2'));
            } else {
                strList.add('InquiryMaintenancePossibity__c = null');
            }
        }

        // 検収年度
        if (String.isNotBlank(this.acceptanceDateYearFrom)) {
            try {
                integer iYear = integer.valueof(this.acceptanceDateYearFrom);
                date dDateFrom = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.AcceptanceDateFormula__c >= ' +  String.valueOf(ddateFrom));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
        if (String.isNotBlank(this.acceptanceDateYearTo)) {
            try {
                integer iYear = integer.valueof(this.acceptanceDateYearTo) + 1;
                date dDateTo = date.newinstance(iYear, 4, 1);
                strList.add('UnitBody__r.AcceptanceDateFormula__c < ' +  String.valueOf(ddateTo));                
            } catch (Exception ex) {
                strList.add('TechnicalAlways1__c = 2');
            }
        }
       
        // 見積書有無
        if (String.isNotBlank(this.inquiryQuotation)) {
            if (inquiryQuotation == '1') {
                strList.add(JEOLUtil.appendEqualText('InquiryQuotation__c', '1'));
            } else if (inquiryQuotation == '2') {
                strList.add(JEOLUtil.appendEqualText('InquiryQuotation__c', '2'));
            } else {
                strList.add('InquiryQuotation__c = null');
            }
        }

        // 対応日付
        if (this.lastActivityDateFrom != null) {
            strList.add('LastActivityDate >= ' + String.valueOf(this.lastActivityDateFrom));
        }
        if (this.lastActivityDateTo != null) {
            strList.add('LastActivityDate <= ' + String.valueOf(this.lastActivityDateTo));
        }

        // 見積書有無
        if (String.isNotBlank(this.existLastActivityDate)) {
            if (existLastActivityDate == '1') {
                strList.add('LastActivityDate != null');
            } else if (existLastActivityDate == '2') {
                strList.add('LastActivityDate = null');
            }
        }

        // 受注確度
        if (String.isNotBlank(this.orderProbabilityFrom)) {
            strList.add('NewOdrSalesPipeline__r.JuchuKakudoValue__c >= ' + orderProbabilityFrom);
        }
        if (String.isNotBlank(this.orderProbabilityTo)) {
            strList.add('NewOdrSalesPipeline__r.JuchuKakudoValue__c <= ' + orderProbabilityTo);
        }

        // 見積書送付日
        if (this.quotationSentDateFrom != null) {
            strList.add('QuotationSentDate__c >= ' + String.valueOf(this.quotationSentDateFrom));
        }
        if (this.quotationSentDateTo != null) {
            strList.add('QuotationSentDate__c <= ' + String.valueOf(this.quotationSentDateTo));
        }

        // 予定開始日
        if (this.periodFrom != null) {
            strList.add('NewOdrMaintenanceStartDate__c >= ' + String.valueOf(this.periodFrom));
        }
        if (this.periodTo != null) {
            strList.add('NewOdrMaintenanceStartDate__c <= ' + String.valueOf(this.periodTo));
        }     
        
        return strList;
    }
    
    
    private void initFieldFromCookie() {

        final String PARAM_SERIES = 'SERIES';
        final String PARAM_REGIONS = 'REGIONS';
        final String PARAM_CUSTOMERCODE = 'CUSTOMERCODE';
        final String PARAM_CUSTOMERNAME = 'CUSTOMERNAME';
        final String PARAM_CUSTCODETYPE = 'CUSTCODETYPE';
        final String PARAM_CUSTNAMETYPE = 'CUSTNAMETYPE';
        final String PARAM_SALESRESPONSIBLE = 'SALESRESPONSIBLE';
        final String PARAM_SHIPMENTADDRESS = 'SHIPMENTADDRESS';
        final String PARAM_UNITBODY = 'UNITBODY';
        final String PARAM_INQUIRYREPAYMENT = 'INQUIRYREPAYMENT';
        final String PARAM_SHIPPINGDATEYEARFROM = 'SHIPPINGDATEYEARFROM';
        final String PARAM_SHIPPINGDATEYEARTO = 'SHIPPINGDATEYEARTO';
        final String PARAM_INQUIRYMAINTENANCEPOSSIBILITY = 'INQUIRYMAINTENANCEPOSSIBILITY';
        final String PARAM_ACCEPTANCEDATEYEARFROM = 'ACCEPTANCEDATEYEARFROM';
        final String PARAM_ACCEPTANCEDATEYEARTO = 'ACCEPTANCEDATEYEARTO';
        final String PARAM_INQUIRYQUOTATION = 'INQUIRYQUOTATION';
        final String PARAM_EXISTLASTACTIVITYDATE = 'EXISTLASTACTIVITYDATE';
        final String PARAM_LASTACTIVITYDATEFROM = 'LASTACTIVITYDATEFROM';
        final String PARAM_LASTACTIVITYDATETO = 'LASTACTIVITYDATETO';
        final String PARAM_QUOTATIONSENTDATEFROM = 'QUOTATIONSENTDATEFROM';
        final String PARAM_QUOTATIONSENTDATETO = 'QUOTATIONSENTDATETO';
        final String PARAM_PERIODFROM = 'PERIODFROM';
        final String PARAM_PERIODTO = 'PERIODTO';
        final String PARAM_ORDERPROBABILITYFROM = 'ORDERPROBABILITYFROM';
        final String PARAM_ORDERPROBABILITYTO = 'ORDERPROBABILITYTO';


        if (Apexpages.currentpage().getparameters().containsKey(PARAM_CUSTOMERCODE)) {
            this.customerCode = Apexpages.currentpage().getparameters().get(PARAM_CUSTOMERCODE);
        }
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_CUSTOMERNAME)) {
            this.customerName = Apexpages.currentpage().getparameters().get(PARAM_CUSTOMERNAME);
        }

        if (Apexpages.currentpage().getparameters().containsKey(PARAM_CUSTCODETYPE)) {
            this.custCodeType = Apexpages.currentpage().getparameters().get(PARAM_CUSTCODETYPE);
        }
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_CUSTNAMETYPE)) {
            this.custNameType = Apexpages.currentpage().getparameters().get(PARAM_CUSTNAMETYPE);
        }
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_SALESRESPONSIBLE)) {
            this.salesResponsible = Apexpages.currentpage().getparameters().get(PARAM_SALESRESPONSIBLE);
        }
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_SHIPMENTADDRESS)) {
            this.shipmentAddress = Apexpages.currentpage().getparameters().get(PARAM_SHIPMENTADDRESS);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_UNITBODY)) {
            this.UnitBody = Apexpages.currentpage().getparameters().get(PARAM_UNITBODY);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_INQUIRYREPAYMENT)) {
            this.inquiryRepayment = Apexpages.currentpage().getparameters().get(PARAM_INQUIRYREPAYMENT);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_SHIPPINGDATEYEARFROM)) {
            this.shippingDateYearFrom = Apexpages.currentpage().getparameters().get(PARAM_SHIPPINGDATEYEARFROM);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_SHIPPINGDATEYEARTO)) {
            this.shippingDateYearTo = Apexpages.currentpage().getparameters().get(PARAM_SHIPPINGDATEYEARTO);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_INQUIRYMAINTENANCEPOSSIBILITY)) {
            this.inquiryMaintenancePossibility = Apexpages.currentpage().getparameters().get(PARAM_INQUIRYMAINTENANCEPOSSIBILITY);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_ACCEPTANCEDATEYEARFROM)) {
            this.acceptanceDateYearFrom = Apexpages.currentpage().getparameters().get(PARAM_ACCEPTANCEDATEYEARFROM);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_ACCEPTANCEDATEYEARTO)) {
            this.acceptanceDateYearTo = Apexpages.currentpage().getparameters().get(PARAM_ACCEPTANCEDATEYEARTO);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_INQUIRYQUOTATION)) {
            this.inquiryQuotation = Apexpages.currentpage().getparameters().get(PARAM_INQUIRYQUOTATION);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_EXISTLASTACTIVITYDATE)) {
            this.existLastActivityDate = Apexpages.currentpage().getparameters().get(PARAM_EXISTLASTACTIVITYDATE);
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_LASTACTIVITYDATEFROM)) {
            try{
                this.lastActivityDateFrom = Date.parse(Apexpages.currentpage().getparameters().get(PARAM_LASTACTIVITYDATEFROM));
            } catch(Exception ex){
            }
        }  
        if (Apexpages.currentpage().getparameters().containsKey(PARAM_LASTACTIVITYDATETO)) {
            try{
                this.lastActivityDateTo = Date.parse(Apexpages.currentpage().getparameters().get(PARAM_LASTACTIVITYDATETO));
            } catch(Exception ex){
            }
        }  
        if (apexpages.currentpage().getparameters().containsKey(PARAM_QUOTATIONSENTDATEFROM)) {
            try{
                this.quotationSentDateFrom = Date.parse(apexpages.currentpage().getparameters().get(PARAM_QUOTATIONSENTDATEFROM));
            } catch(Exception ex){
            }
        }  
        if (apexpages.currentpage().getparameters().containsKey(PARAM_QUOTATIONSENTDATETO)) {
            try{
                this.quotationSentDateTo = Date.parse(apexpages.currentpage().getparameters().get(PARAM_QUOTATIONSENTDATETO));
            } catch(Exception ex){
            }
        }  
        if (apexpages.currentpage().getparameters().containsKey(PARAM_PERIODFROM)) {
            try{
                this.periodFrom = Date.parse(apexpages.currentpage().getparameters().get(PARAM_PERIODFROM));
            } catch(Exception ex){
            }
        }  
        if (apexpages.currentpage().getparameters().containsKey(PARAM_PERIODTO)) {
            try{
                this.periodTo = Date.parse(apexpages.currentpage().getparameters().get(PARAM_PERIODTO));
            } catch(Exception ex){
            }
        }  
        if (apexpages.currentpage().getparameters().containsKey(PARAM_ORDERPROBABILITYFROM)) {
            this.orderProbabilityFrom = apexpages.currentpage().getparameters().get(PARAM_ORDERPROBABILITYFROM);
        }  
        if (apexpages.currentpage().getparameters().containsKey(PARAM_ORDERPROBABILITYTO)) {
            this.orderProbabilityTo = apexpages.currentpage().getparameters().get(PARAM_ORDERPROBABILITYTO);
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