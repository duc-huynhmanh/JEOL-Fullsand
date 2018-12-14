public without sharing class JEOL_MaintenanceListToRenewCsv_ctrl extends JEOL_SearchBase_ctrl {

    public String renewalMonth{get; set;}
    public String lastYearSalesOrder{get; set;}
    public String customerCode{get; set;}
    public String customerName{get; set;}
    public String custCodeType{get; set;}
    public String custNameType{get; set;}
    public String jeolPipelineResponsible{get; set;}
    public String netMaintenance{get; set;}
    public String shipmentAddress{get; set;}
    public String unitBody{get; set;}
    private List<String> targetSeries;
    private List<String> targetRegions;

    Public List<List<String>> lslsstrRowMCM{get;set;}

    Public String sTitle{get;set;}

    Public String getFileName() {
        return 'RenewalList_' + date.today().format() + '.csv';
    }
    
    Public JEOL_MaintenanceListToRenewCsv_ctrl() {

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
                            ' id, Name, NewOdrSeries__c, PreviousYearOrder__r.ShipmentAccount__r.Name, PreviousYearOrder__r.ShipmentFacultyOffice__c, PreviousYearOrder__r.ShipmentTantosha__c, RenewalNoticeCreated__c, ' +
                            ' RenewalNoticeSentDate__c, QuotationCreated__c, QuotationSentDate__c, ContractSentDate__c, ' +
                            ' PreviousYearPipeline__c, PreviousYearOrder__r.Name, PreviousYearOrder__r.NetMaintenance__c, PreviousYearOrder__r.ModelPI__c, PreviousYearOrder__r.MaintenanceStartDateFormula__c, ' +
                            ' PreviousYearOrder__r.MaintenanceEndDateFormula__c, PreviousYearOrder__r.MaintenanceType__c, PreviousYearOrder__r.QuotationInformation__r.QuoteNo__c, PreviousYearOrder__r.ShipmentAccount__r.Code__c, ' +
                            ' PreviousYearOrder__r.ShipmentAccount__r.Address__c, Memo__c, NewOdrSalesAccount__r.Code__c, NewOdrSalesAccount__r.Name, NewOdrSalesAccount__r.Undergraduate__c, UnitBody__r.UnitBody__c, ' +
                            ' PreviousYearOrder__r.ProductNumber__c, PreviousYearPipeline__r.NextYearNotes__c, PreviousYearPipeline__r.Memo__c, NewOdrOrdersMemp__c, NewOdrFlagshipProduct__c, ' +
                            ' NewOdrContractAmountt__c, NewOdrRoutineCheck__c, NewOdrTroubleshooting__c, NewOdrNotices1__c, NewOdrAtt__c, NewOdrOther1__c, NewOdrSalesStaff__r.Name, NewOdrAssistant__r.Name, ' +
                            ' (SELECT id, Name, Type__c, Inspection__c, InspectionDone__c, BillingAmountEstimate__c, BillingDone__c from MaintenanceAccountBook__r ORDER BY Name, Type__c) ' +         
                      ' FROM ' +
                          ' MaintenanceContractManagement__c ';

        List<String> whereStrElems = getWhereStrList();
        if (whereStrElems.size() > 0) {
            soql += JEOLUtil.joinWhereConditions(whereStrElems);
        }
            
        lslsstrRowMCM = new List<List<String>>();
        
        sTitle = '';
        sTitle = ConcatenateField(sTitle, '保守契約管理番号', true);
        sTitle = ConcatenateField(sTitle, '系列', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 見積番号', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 出荷先コード', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 出荷先取引先: 取引先名', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 出荷先学部・事業所', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 出荷先担当者名', false);
        sTitle = ConcatenateField(sTitle, '出荷先住所', false);
        sTitle = ConcatenateField(sTitle, '送付案内作成', false);
        sTitle = ConcatenateField(sTitle, '更新案内送付日', false);
        sTitle = ConcatenateField(sTitle, '見積書作成', false);
        sTitle = ConcatenateField(sTitle, '見積書送付日', false);
        sTitle = ConcatenateField(sTitle, '契約書送付日', false);
        sTitle = ConcatenateField(sTitle, '今年度備考', false);
        sTitle = ConcatenateField(sTitle, '販売先コード', false);
        sTitle = ConcatenateField(sTitle, '販売先名', false);
        sTitle = ConcatenateField(sTitle, '販売先学部事業所', false);
        sTitle = ConcatenateField(sTitle, '前年保守契約管理: 保守契約管理番号', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 販売オーダNo', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: NET保守区分', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 機種', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 保守契約開始日', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 保守契約終了日', false);
        sTitle = ConcatenateField(sTitle, '前年オーダ: 保守種類', false);
        sTitle = ConcatenateField(sTitle, '本体号機', false);
        sTitle = ConcatenateField(sTitle, '前年度製番', false);
        sTitle = ConcatenateField(sTitle, '前年度保守契約管理情報　来年度へ', false);
        sTitle = ConcatenateField(sTitle, '前年度保守契約管理情報　備考', false);
        sTitle = ConcatenateField(sTitle, '受注メモ', false);
        sTitle = ConcatenateField(sTitle, '代表商品名', false);
        sTitle = ConcatenateField(sTitle, '営業担当者名', false);
        sTitle = ConcatenateField(sTitle, 'アシスタント', false);
        sTitle = ConcatenateField(sTitle, '契約金額', false);
        sTitle = ConcatenateField(sTitle, '定期点検', false);
        sTitle = ConcatenateField(sTitle, '故障修理', false);
        sTitle = ConcatenateField(sTitle, '特記事項', false);
        sTitle = ConcatenateField(sTitle, 'ＡＴＴ', false);
        sTitle = ConcatenateField(sTitle, 'その他', false);
        sTitle = ConcatenateField(sTitle, '点検予定', false);
        sTitle = ConcatenateField(sTitle, '請求予定', false);
        sTitle = ConcatenateField(sTitle, '点検予定（HE）', false);
        sTitle = ConcatenateField(sTitle, '請求予定（HE）', false);
        sTitle = ConcatenateField(sTitle, '点検予定（ATT）', false);
        sTitle = ConcatenateField(sTitle, '請求予定（ATT）', false);
        sTitle = ConcatenateField(sTitle, '点検実績', false);
        sTitle = ConcatenateField(sTitle, '請求実績', false);
        sTitle = ConcatenateField(sTitle, '点検実績（HE）', false);
        sTitle = ConcatenateField(sTitle, '請求実績（HE）', false);
        sTitle = ConcatenateField(sTitle, '点検実績（ATT）', false);
        sTitle = ConcatenateField(sTitle, '請求実績（ATT）', false);

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
            sRow = ConcatenateField(sRow, mcm.NewOdrSeries__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.QuotationInformation__r.QuoteNo__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ShipmentAccount__r.Code__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ShipmentAccount__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ShipmentFacultyOffice__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ShipmentTantosha__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ShipmentAccount__r.Address__c, false);
            sRow = ConcatenateField(sRow, mcm.RenewalNoticeCreated__c, false);
            sRow = ConcatenateField(sRow, mcm.RenewalNoticeSentDate__c, false);
            sRow = ConcatenateField(sRow, mcm.QuotationCreated__c, false);
            sRow = ConcatenateField(sRow, mcm.QuotationSentDate__c, false);
            sRow = ConcatenateField(sRow, mcm.ContractSentDate__c, false);
            sRow = ConcatenateField(sRow, mcm.Memo__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesAccount__r.Code__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesAccount__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesAccount__r.Undergraduate__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearPipeline__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.NetMaintenance__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ModelPI__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.MaintenanceStartDateFormula__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.MaintenanceEndDateFormula__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.MaintenanceType__c, false);
            sRow = ConcatenateField(sRow, mcm.UnitBody__r.UnitBody__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearOrder__r.ProductNumber__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearPipeline__r.NextYearNotes__c, false);
            sRow = ConcatenateField(sRow, mcm.PreviousYearPipeline__r.Memo__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrOrdersMemp__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrFlagshipProduct__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrSalesStaff__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrAssistant__r.Name, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrContractAmountt__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrRoutineCheck__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrTroubleshooting__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrNotices1__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrAtt__c, false);
            sRow = ConcatenateField(sRow, mcm.NewOdrOther1__c, false);
            
            List<String> sListEstInspect = new List<String>();
            List<String> sListEstBilling = new List<String>();
            List<String> sListEstInspectHE = new List<String>();
            List<String> sListEstBillingHE = new List<String>();
            List<String> sListEstInspectATT = new List<String>();
            List<String> sListEstBillingATT = new List<String>();
            List<String> sListRealInspect = new List<String>();
            List<String> sListRealBilling = new List<String>();
            List<String> sListRealInspectHE = new List<String>();
            List<String> sListRealBillingHE = new List<String>();
            List<String> sListRealInspectATT = new List<String>();
            List<String> sListRealBillingATT = new List<String>();
            
            for (MaintenanceAccountBook__c row : mcm.MaintenanceAccountBook__r) {
            
                if (row.Inspection__c) {
                    if (row.Type__c == '1' || row.Type__c == '2') {
                        sListEstInspect.add(row.Name);
                    } else if (row.Type__c == '3') {
                        sListEstInspectATT.add(row.Name);
                    } else if (row.Type__c == '4') {
                        sListEstInspectHE.add(row.Name);
                    }
                }

                if (row.BillingAmountEstimate__c != null && row.BillingAmountEstimate__c != 0) {
                    if (row.Type__c == '1' || row.Type__c == '2') {
                        sListEstBilling.add(row.Name);
                    } else if (row.Type__c == '3') {
                        sListEstBillingATT.add(row.Name);
                    } else if (row.Type__c == '4') {
                        sListEstBillingHE.add(row.Name);
                    }
                }

                if (row.InspectionDone__c) {
                    if (row.Type__c == '1' || row.Type__c == '2') {
                        sListRealInspect.add(row.Name);
                    } else if (row.Type__c == '3') {
                        sListRealInspectATT.add(row.Name);
                    } else if (row.Type__c == '4') {
                        sListRealInspectHE.add(row.Name);
                    }
                }

                if (row.BillingDone__c) {
                    if (row.Type__c == '1' || row.Type__c == '2') {
                        sListRealBilling.add(row.Name);
                    } else if (row.Type__c == '3') {
                        sListRealBillingATT.add(row.Name);
                    } else if (row.Type__c == '4') {
                        sListRealBillingHE.add(row.Name);
                    }
                }
            }

            sRow = ConcatenateField(sRow, String.join(sListEstInspect, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListEstBilling, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListEstInspectHE, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListEstBillingHE, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListEstInspectATT, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListEstBillingATT, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListRealInspect, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListRealBilling, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListRealInspectHE, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListRealBillingHE, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListRealInspectATT, ', '), false);
            sRow = ConcatenateField(sRow, String.join(sListRealBillingATT, ', '), false);
            
                        
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




        strList.add('(RenewalApproved__c = false or LastLinkBaaN__c = null)');
        strList.add('PipelineStopped__c = false');
        strList.add('PreviousYearOrder__c != null');

        // 更新月
        if (String.isNotBlank(this.renewalMonth)) {
            strList.add('RenewalMonthFormula__c <= \'' + (String.escapeSingleQuotes(renewalMonth) + '999999').substring(0, 6) + '\'');
            //strList.add(JEOLUtil.appendAfterLikeText('RenewalMonthFormula__c', this.renewalMonth));
        }

        // 前年オーダ番号 
        if (String.isNotBlank(this.lastYearSalesOrder)) {
            strList.add(JEOLUtil.appendLikeText('PreviousYearOrder__r.Name', this.lastYearSalesOrder));
        }

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
        
        // 住所               
        if (String.isNotBlank(this.shipmentAddress)) {
            strList.add(JEOLUtil.appendLikeText('NewOdrShipmentAccount__r.Address__c', this.shipmentAddress));
        }

        // 本体号機
        if (String.isNotBlank(this.unitBody)) {
            strList.add(JEOLUtil.appendAfterLikeText('UnitBody__r.Name', this.unitBody));
        }

       // 更新担当者
        if (String.isNotBlank(this.jeolPipelineResponsible)) {
            strList.add('((' +
                        JEOLUtil.appendAfterLikeText('NewOdrSalesStaff__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrSalesStaff__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('NewOdrAssistant__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('NewOdrAssistant__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('JeolPipelineResponsible__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('JeolPipelineResponsible__r.Name', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendAfterLikeText('JeolPipelineResponsible2__r.UserCode__c', this.jeolPipelineResponsible) +
                        ') OR (' +
                        JEOLUtil.appendLikeText('JeolPipelineResponsible2__r.Name', this.jeolPipelineResponsible) +
                        '))' );
        }        
        
        // NET区分
        if (String.isNotBlank(this.netMaintenance)) {
            strList.add(JEOLUtil.appendEqualText('NewOdrNetMaintenance__c', this.netMaintenance));
        }

        return strList;
    }
    
    
    private void initFieldFromCookie() {

        final String PARAM_RENEWALMONTH = 'MONTH';
        final String PARAM_LASTYEARSO = 'LASTYEARSO';
        final String PARAM_SERIES = 'SERIES';
        final String PARAM_REGIONS = 'REGIONS';
        final String PARAM_CUSTOMERCODE = 'CUSTOMERCODE';
        final String PARAM_CUSTOMERNAME = 'CUSTOMERNAME';
        final String PARAM_CUSTCODETYPE = 'CUSTCODETYPE';
        final String PARAM_CUSTNAMETYPE = 'CUSTNAMETYPE';
        final String PARAM_JEOLPIPELINERESPONSIBLE = 'JEOLPIPELINERESPONSIBLE';
        final String PARAM_NETMAINTENANCE = 'NETMAINTENANCE';
        final String PARAM_SHIPMENTADDRESS = 'SHIPMENTADDRESS';
        final String PARAM_UNITBODY = 'UNITBODY';
            
        if (apexpages.currentpage().getparameters().containsKey(PARAM_RENEWALMONTH)) {
            this.renewalMonth = apexpages.currentpage().getparameters().get(PARAM_RENEWALMONTH);
        }
    
        if (apexpages.currentpage().getparameters().containsKey(PARAM_LASTYEARSO)) {
            this.lastYearSalesOrder = apexpages.currentpage().getparameters().get(PARAM_LASTYEARSO);
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
        if (apexpages.currentpage().getparameters().containsKey(PARAM_CUSTOMERCODE)) {
            this.customerCode = apexpages.currentpage().getparameters().get(PARAM_CUSTOMERCODE);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_CUSTOMERNAME)) {
            this.customerName = apexpages.currentpage().getparameters().get(PARAM_CUSTOMERNAME);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_CUSTCODETYPE)) {
            this.custCodeType = apexpages.currentpage().getparameters().get(PARAM_CUSTCODETYPE);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_CUSTNAMETYPE)) {
            this.custNameType = apexpages.currentpage().getparameters().get(PARAM_CUSTNAMETYPE);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_JEOLPIPELINERESPONSIBLE)) {
            this.jeolPipelineResponsible = apexpages.currentpage().getparameters().get(PARAM_JEOLPIPELINERESPONSIBLE);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_NETMAINTENANCE)) {
            this.netMaintenance = apexpages.currentpage().getparameters().get(PARAM_NETMAINTENANCE);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_SHIPMENTADDRESS)) {
            this.shipmentAddress = apexpages.currentpage().getparameters().get(PARAM_SHIPMENTADDRESS);
        }
        if (apexpages.currentpage().getparameters().containsKey(PARAM_UNITBODY)) {
            this.UnitBody = apexpages.currentpage().getparameters().get(PARAM_UNITBODY);
        }
    }
    
                
}