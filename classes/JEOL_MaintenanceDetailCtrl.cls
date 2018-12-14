public with sharing class JEOL_MaintenanceDetailCtrl {

    public String DepartmentCode {get; set;}
    
    public static final String PARAM_ID = 'id';
    public static final String URL_PARAM_NAME_ISCOPY = 'isCopy';
    
    public MaintenanceContractManagement__c so {get; set;}
    private String StatusMemo = null;
    private boolean KeiyakuOKMemo = false;
    private boolean KeiyakuStoppedMemo = false;
    private boolean isUnitBodyNull = false;
    public String LinkStatus {get; set;}
    public String LinkStatusMsg {get; set;}
    public integer LinkStatusCode {get; set;}
    public boolean IsCheckBaaNOK {get; set;}
    public List<MaintenanceAnnaiOptions__c> lsOptions {get; set;}
 
    public List<MaintenanceContractManagement__c> lsOtherPipelines {get; set;}

    public integer indiceOption {get; set;}
    
    public boolean getExistOtherPipeline() {
        return (lsOtherPipelines != null && lsOtherPipelines.size() > 0);
    }
 
    public boolean getAreAllFieldsEditable() {
        return (LinkStatusCode != 1 && LinkStatusCode != 2 && LinkStatusCode != 3 && LinkStatusCode != 4 && LinkStatusCode != 6);
    }

    public boolean getIsUnitBodyNull() {
        return isUnitBodyNull;
    }

    public String getIdSmarepo() {
        return BaaNSettings__c.getValues('Default').SmarepoID__c;
    }

    public List<SelectOption> getRegionOptions() {
        return JEOLUtil.getSelectList(JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA);
    }

    public String getCurrentNewOdrArea() {
        return getLabelPicklist(JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA, so.NewOdrRegion__c);
    }

    public List<SelectOption> getDepartments() {
        List<SelectOption> options = new List<SelectOption>();
        List<Department__c> masterRecs = [SELECT Id, Name, DepartmentCode__c FROM Department__c ORDER BY SortNo__c];
        options.add(new SelectOption('', ''));
        for (Department__c rec: masterRecs) {
            options.add(new SelectOption(rec.DepartmentCode__c, rec.Name));
        }
        return options;
    }
        
    private String getLabelPicklist(String ReferenceName, String Value) {
        String sReturn = '';
        
        For(SelectListManage__c listopt : [SELECT Label__c FROM SelectListManage__c WHERE ReferenceName__c = :ReferenceName AND Value__c = :Value]) {
            sReturn = listopt.Label__c;
        }
        
        return sReturn;
    }
            
    public JEOL_MaintenanceDetailCtrl(ApexPages.StandardController ctrl) {

        try {

            List<String> fields = new List<String>();
            fields.add('Name');
            fields.add('LastModifiedBy');
            fields.add('LastModifiedBy.Name');
            fields.add('LastModifiedDate');
            fields.add('UnitBody__c');
            fields.add('UnitBody__r.Model__c');
            fields.add('UnitBody__r.Name');
            fields.add('UnitBody__r.UnitBody__c');
            fields.add('RenewalAccount__c');
            fields.add('RenewalContactPosition__c');
            fields.add('RenewalTantoshya__c');
            fields.add('RenewalAddress__c');
            fields.add('RenewalContactTel__c');
            fields.add('RenewalContactFax__c');
            fields.add('QuotationCreated__c');
            fields.add('QuotationSentDate__c');
            fields.add('RenewalNoticeCreated__c');
            fields.add('RenewalNoticeSentDate__c');            
            fields.add('RenewalCompanyName__c');
            fields.add('RenewalUndergraduate__c');
            fields.add('RenewalDeliveryLocation__c');
            fields.add('RenewalItemsName__c');
            fields.add('RenewalListOptions__c');
            fields.add('RenewalPrintDate__c');
            fields.add('RenewalCustomerNameReply__c');
            fields.add('RenewalTopSectionText__c');
            fields.add('RenewalFooterComment__c');
            fields.add('RenewalOptionDateFormat__c');
            fields.add('RenewalOptionCustomerNameLabel__c');
            fields.add('RenewalOptionHideChangeInfo__c');
            fields.add('NextYearNotes__c');
            fields.add('ContractSentDate__c');
            fields.add('Memo__c');
            fields.add('PreviousYearOrder__r');
            fields.add('PreviousYearOrder__r.ShipmentAccount__c');
            fields.add('PreviousYearOrder__r.ShipmentAccountCode__c');
            fields.add('PreviousYearOrder__r.OrderDateFormula__c');
            fields.add('PreviousYearOrder__r.ConsumptionTax__c');
            fields.add('PreviousYearOrder__r.Name');
            fields.add('PreviousYearOrder__r.NetMaintenance__c');
            fields.add('PreviousYearOrder__r.ProductNumber__c');
            fields.add('PreviousYearOrder__r.MaintenanceType__c');
            fields.add('PreviousYearOrder__r.Area__c');
            fields.add('PreviousYearOrder__r.MaintenancePeriodText__c');
            fields.add('PreviousYearOrder__r.SalesAccount__c');
            fields.add('PreviousYearOrder__r.SalesAccountCode__c');
            fields.add('PreviousYearOrder__r.SalesContactPosition__c');
            fields.add('PreviousYearOrder__r.SalesTantoshya__c');
            fields.add('PreviousYearOrder__r.SalesAddress__c');
            fields.add('PreviousYearOrder__r.SalesContactTel__c');
            fields.add('PreviousYearOrder__r.SalesContactFax__c');
            fields.add('PreviousYearOrder__r.ShipmentAccount__c');
            fields.add('PreviousYearOrder__r.ShipmentAccountCode__c');
            fields.add('PreviousYearOrder__r.ShipmentContactPosition__c');
            fields.add('PreviousYearOrder__r.ShipmentTantosha__c');
            fields.add('PreviousYearOrder__r.ShipmentAddress__c');
            fields.add('PreviousYearOrder__r.ShipmentContact_Tel__c');
            fields.add('PreviousYearOrder__r.ShipmentContact_Fax__c');
            fields.add('PreviousYearOrder__r.UnitBodyLink__c');
            fields.add('PreviousYearOrder__r.UnitBodyLink__r.Model__c');
            fields.add('NewContractStartDate__c');
            fields.add('NewContractEndDate__c');
            fields.add('NewContractAmount__c');
            fields.add('AnnaiType__c');
            fields.add('PreviousYearOrder__r.MaintenanceStartDateFormula__c');
            fields.add('PreviousYearOrder__r.MaintenanceEndDateFormula__c');
            fields.add('RenewalApproved__c');
            fields.add('ProductNumber__c');
            fields.add('PipelineStopped__c');
            fields.add('PipelineStoppedDate__c');
            fields.add('PipelineStoppedReason__c');
            fields.add('SubmittedToAccounting__c');
            fields.add('NewOdrNewUpdated__c');
            fields.add('NewOdrSalesNoOfTimes__c');
            fields.add('Status__c');
            fields.add('PreviousYearPipeline__c');
            fields.add('PreviousYearPipeline__r.NextYearNotes__c');
            fields.add('PreviousYearPipeline__r.Memo__c');
            fields.add('PreviousYearPipeline__r.Status__c');
            fields.add('PreviousYearOrder__r.QuotationInformation__c');
            fields.add('NewOdrSalesAccount__c');
            fields.add('NewOdrSalesAccount__r.Code__c');
            fields.add('NewOdrSalesAccount__r.Undergraduate__c');
            fields.add('NewOdrSalesContactPosition__c');
            fields.add('NewOdrSalesContactPost__c');
            fields.add('NewOdrSalesTantoshya__c');
            fields.add('NewOdrSalesAccount__r.Address__C');
            fields.add('NewOdrSalesContactTel__c');
            fields.add('NewOdrSalesContactFax__c');
            fields.add('NewOdrShipmentAccount__c');
            fields.add('NewOdrShipmentAccount__r.Code__c');
            fields.add('NewOdrShipmentAccount__r.Undergraduate__c');
            fields.add('NewOdrShipmentContactPosition__c');
            fields.add('NewOdrShipmentContactPost__c');
            fields.add('NewOdrShipmentTantosha__c');
            fields.add('NewOdrShipmentAccount__r.Address__C');
            fields.add('NewOdrShipmentContact_Tel__c');
            fields.add('NewOdrShipmentContact_Fax__c');
            fields.add('JeolPipelineResponsible__c');
            fields.add('PreviousYearOrder__r.QuotationInformation__r.QuoteNo__c');
            fields.add('PreviousYearOrder__r.QuotationInformation__r.BranchNo__c');
            fields.add('NewOdrNetMaintenance__c');
            fields.add('NewOdrOrderDate__c');
            fields.add('NewOdrFiscalYear__c');
            fields.add('NewOdrQuotation__c');
            fields.add('NewOdrQuotation__r.QuoteNo__c');
            fields.add('NewOdrQuotation__r.BranchNo__c');
            fields.add('NewOdrReferenceOrder__c');
            fields.add('NewOdrReferenceOrder__r.Name');
            fields.add('NewOdrSalesPipeline__c');
            fields.add('NewOdrSalesPipeline__r.Name');
            fields.add('NewOdrSalesPipeline__r.ShodanNo_sync__c');
            fields.add('NewOdrOrdersMemp__c');
            fields.add('NewOdrSalesStaff__c');
            fields.add('NewOdrSalesStaff__r.UserCode__c');
            fields.add('NewOdrAssistant__c');
            fields.add('NewOdrAssistant__r.UserCode__c');
            fields.add('NewOdrTradingCompanyInvolved__c');
            fields.add('NewOdrShareOrderAmount__c');
            fields.add('NewOdrCommissionOrderAmount__c');
            fields.add('NewOdrCommissionPayment__c');
            fields.add('NewOdrCommissionPayment__r.Code__c');
            fields.add('NewOdrMaintenanceType__c');
            fields.add('BillingMethodHontai__c');
            fields.add('BillingMethodHelium__c');
            fields.add('BillingMethod__c');
            fields.add('NewOdrSeries__c');
            fields.add('NewOdrRegion__c');
            fields.add('NewOdrContractDivision__c');
            fields.add('NewOdrDepartment__c');
            fields.add('NewOdrDepartment__r.DepartmentCode__c');
            fields.add('NewOdrFlagshipProduct__c');
            fields.add('NewOdrMaintenanceStartDate__c');
            fields.add('NewOdrMaintenanceEndDate__c');
            fields.add('NewOdrMaintenancePeriodText__c');
            fields.add('NewOdrContractAmountt__c');
            fields.add('NewOdrRoutineCheck__c');
            fields.add('NewOdrTroubleshooting__c');
            fields.add('NewOdrNotices1__c');
            fields.add('NewOdrNotices2__c');
            fields.add('NewOdrRepairParts__c');
            fields.add('NewOdrAtt__c');
            fields.add('NewOdrOther1__c');
            fields.add('NewOdrOther2__c');
            fields.add('InquiryRepayment__c');
            fields.add('InquiryMaintenancePossibity__c');
            fields.add('InquiryPriceList__c');
            fields.add('InquiryQuotation__c');
        
            fields.add('RenewalPostalCode__c');
            fields.add('RenewalAddress2__c');
            fields.add('RenewalQuotation__c');
            fields.add('RenewalQuotation__r.QuoteNo__c');
            fields.add('RenewalQuotation__r.BranchNo__c');                                    
            fields.add('JEOLRegionName__c');
            fields.add('JEOLContactPosition__c');
            fields.add('JEOLReplyRegionName__c');
            fields.add('JEOLReplyContactPosition__c');
            fields.add('JEOLPipelineResponsible2__c');
            fields.add('VersionNumber__c');
            fields.add('LastLinkBaaN__r.VersionSent__c');
            fields.add('ContractAmountLine__c');
            fields.add('BillingTogether__c');
            fields.add('NewOdrSalesOrder__c');
            fields.add('HidePipeline__c');
            fields.add('ContractImpossible__c');
            fields.add('SubAmountHontaiInspec__c');
            fields.add('SubAmountHontaiNoInspec__c');
            fields.add('SubAmountAttach__c');
            fields.add('SubAmountHelium__c');
            fields.add('JEOLContactTel__c');
            fields.add('JEOLReplyContactFax__c');
            fields.add('ContractImpossibleReason__c');
            
            if (!Test.isRunningTest()) {
                ctrl.addFields(fields);
            }
            
            this.so = (MaintenanceContractManagement__c) ctrl.getRecord();

            IsCheckBaaNOK = false;
            
            if (so.NewOdrDepartment__r != NULL && so.NewOdrDepartment__r.DepartmentCode__c != NULL) {
                DepartmentCode = so.NewOdrDepartment__r.DepartmentCode__c;
            }
            
            StatusMemo = so.Status__c;
            KeiyakuOKMemo = so.RenewalApproved__c;
            KeiyakuStoppedMemo = so.PipelineStopped__c;
            isUnitBodyNull = (so.UnitBody__c == null);

            // Get the other PL
            if (so.UnitBody__c != null && so.UnitBody__r.UnitBody__c.length() > 0) {
                lsOtherPipelines = [select id, Name, NewOdrSalesOrder__c, NewOdrMaintenanceType__c, Status__c, NewOdrMaintenanceStartDate__c, NewOdrMaintenanceEndDate__c, NewOdrContractAmountt__c, NewOdrSalesStaff__c
                                    from MaintenanceContractManagement__c
                                    where id <> :so.Id
                                    and UnitBody__r.UnitBody__c = :so.UnitBody__r.UnitBody__c
                                    and NewOdrMaintenanceEndDate__c >= TODAY
                                    ORDER BY NewOdrMaintenanceEndDate__c DESC NULLS LAST, NewOdrMaintenanceStartDate__c DESC NULLS LAST, NewOdrMaintenanceType__c
                                    LIMIT 10];
            }

            // Get the options possible
            lsOptions = new List<MaintenanceAnnaiOptions__c>();
            
            List<String> parts = new List<String>() ;
            if (so.RenewalListOptions__c != null && so.RenewalListOptions__c.length() > 0) {
                parts = so.RenewalListOptions__c.split('\n');
            }
            if (parts != null && parts.size() > 0) {
                for (String partrow : parts) {
                    MaintenanceAnnaiOptions__c newopt = new MaintenanceAnnaiOptions__c();
                    newopt.Label__c = partrow;
                    newopt.TechnicalAlwaysFalse__c = true;
                    lsOptions.add(newopt);
                }
            }

            List<MaintenanceAnnaiOptions__c> lsOptionsTbl = [SELECT id, Label__c, TechnicalAlwaysFalse__c, SortNo__c FROM MaintenanceAnnaiOptions__c WHERE Obsolete__c = false ORDER BY SortNo__c];
            if (lsOptionsTbl != null && lsOptionsTbl.size() > 0) {
                for (MaintenanceAnnaiOptions__c newopt : lsOptionsTbl) {
                    boolean fAlreadyExists = false;
                    
                    if (lsOptions != null && lsOptions.size() > 0) {
                        for (MaintenanceAnnaiOptions__c opt : lsOptions) {
                            if (opt.Label__c == newopt.Label__c) {
                                fAlreadyExists = true;
                                break;
                            }
                        }
                    }
                    
                    if (!fAlreadyExists) {
                        lsOptions.add(newopt);
                    }
                }
            }
            integer idx = 0;
            for (MaintenanceAnnaiOptions__c opt : lsOptions) {
                opt.SortNo__c = idx;
                idx++;
            }
            
            // Check if the product number is already used
            checkExistenceProductNumber(so.ProductNumber__c);
            checkExistenceQuotation(so.NewOdrQuotation__c);

            // Get the link status
            RefreshLinkStatus();
            
            if (this.so == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Address not correct.'));
            }

        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Address not correct.'));
            this.so = null;
        }

    }

    public void RefreshLinkStatus() {

        List<MaintenanceLinkOrder__c> lsLinkRow = [SELECT Id, Name, ifst__c, clyn__c, mess__c, CreatedDate FROM MaintenanceLinkOrder__c WHERE MaintenanceContractManagement__c = :so.id ORDER BY CreatedDate desc LIMIT 1];
        if (lsLinkRow == null || lsLinkRow.size() == 0) {
            LinkStatus = '未連携';
            LinkStatusCode = 0;
            LinkStatusMsg = '';            
        } else {
            for (MaintenanceLinkOrder__c lkRow: lsLinkRow) {
                String sDate = ' (' + lkRow.CreatedDate.format('yyyy/MM/dd HH:mm:ss') + ')';
                boolean fGetMessageonChild = false;
                id idLastRow = null;
                if (lkRow.clyn__c != null && lkRow.clyn__c == '1') {
                    // DELETION
                    if (lkRow.ifst__c != null && lkRow.ifst__c == '2') {
                        LinkStatus = '取消済';
                        LinkStatusCode = 5;
                        so.NewOdrOrderDate__c = null; // Show null if it has been deleted (it will be reinitialize in the sent to BaaN)
                        LinkStatusMsg = '';
                    } else if (lkRow.ifst__c != null && lkRow.ifst__c == '5') {
                        LinkStatus = '取消済（警告あり）';
                        LinkStatusCode = 5;
                        so.NewOdrOrderDate__c = null; // Show null if it has been deleted (it will be reinitialize in the sent to BaaN)
                        LinkStatusMsg = lkRow.mess__c;
                    } else if (lkRow.ifst__c != null && (lkRow.ifst__c == '3' || lkRow.ifst__c == '4')) {
                        LinkStatus = '取消失敗';
                        LinkStatusCode = 6;
                        if (lkRow.ifst__c == '3') {
                            LinkStatusMsg = lkRow.mess__c;
                        } else {
                            fGetMessageonChild = true;
                            idLastRow = lkRow.id;
                        }
                    } else {
                        LinkStatus = '取消中';
                        LinkStatusCode = 4;
                        LinkStatusMsg = '';
                    }
                } else {
                    // ROW NORMAL
                    if (lkRow.ifst__c != null && lkRow.ifst__c == '2') {
                        LinkStatus = '連携済';
                        LinkStatusCode = 2;
                        LinkStatusMsg = '';
                    } else if (lkRow.ifst__c != null && lkRow.ifst__c == '5') {
                        LinkStatus = '連携済（警告あり）';
                        LinkStatusCode = 2;
                        LinkStatusMsg = lkRow.mess__c;
                    } else if (lkRow.ifst__c != null && (lkRow.ifst__c == '3' || lkRow.ifst__c == '4')) {
                        LinkStatus = '連携失敗';
                        LinkStatusCode = 3;
                        if (lkRow.ifst__c == '3') {
                            LinkStatusMsg = lkRow.mess__c;
                        } else {
                            fGetMessageonChild = true;
                            idLastRow = lkRow.id;
                        }
                    } else {
                        LinkStatus = '連携中';
                        LinkStatusCode = 1;
                        LinkStatusMsg = '';
                    }                    
                }
                LinkStatus = LinkStatus + sDate;
                
                if (fGetMessageonChild) {
                    List <MaintenanceLinkOrderLine__c> lsLines = [SELECT id, mess__c, pono__c FROM MaintenanceLinkOrderLine__c WHERE MaintenanceLinkOrder__c = :idLastRow AND ifst__c = '3' LIMIT 1];
                    if (lsLines != null && lsLines.size() > 0) {
                        LinkStatusMsg = lsLines[0].mess__c;
                        LinkStatusMsg += '（管理台帳・タイプ：';
                        String sType = getLineNoLinkReverseType(lsLines[0].pono__c);
                        if (sType == '1') {
                            LinkStatusMsg += '本体、点検有り';
                        } else if (sType == '2') {
                            LinkStatusMsg += '本体、点検無し';
                        } else if (sType == '3') {
                            LinkStatusMsg += 'アタッチ';
                        } else if (sType == '4') {
                            LinkStatusMsg += 'ヘリウム';
                        }
                        LinkStatusMsg += '、月：';
                        LinkStatusMsg += getLineNoLinkReverseMonth(lsLines[0].pono__c);
                        LinkStatusMsg += '）';
                        
                    } else {
                        List <MaintenanceLinkOrderForm__c> lsForms = [SELECT id, mess__c, sqno__c FROM MaintenanceLinkOrderForm__c WHERE MaintenanceLinkOrder__c = :idLastRow AND ifst__c = '3' LIMIT 1];
                        if (lsForms != null && lsForms.size() > 0) {
                            LinkStatusMsg = lsForms[0].mess__c;
                            LinkStatusMsg += '（注文書・連番：';
                            LinkStatusMsg += lsForms[0].sqno__c;
                            LinkStatusMsg += '）';
                        }                    
                    }
                }
            }
        }
            
    }
    
    public PageReference redirectList(){

        PageReference pr;
        if (so.PreviousYearOrder__c != null) {
            pr = new PageReference('/apex/JEOL_MaintenanceListToRenew');
        } else {
            pr = new PageReference('/apex/JEOL_MaintenanceListNew');
        }
        
        pr.setRedirect(true);
        return pr;

    }

    public PageReference redirectAccountBook(){

        PageReference pr = new PageReference('/apex/JEOL_MaintenanceAccountBook');
        pr.getParameters().put('id', so.id);
        pr.setRedirect(true);
        return pr;

    }

    public PageReference redirectSupportList(){


        PageReference pr = new PageReference('/apex/JEOL_SupportListViewPage');
        if (so.UnitBody__c != null && so.UnitBody__r.UnitBody__c != null && so.UnitBody__r.UnitBody__c.length() > 0) {
            pr.getParameters().put('UnitBody', so.UnitBody__r.UnitBody__c);
        }

system.debug(so.PreviousYearOrder__r.MaintenanceStartDateFormula__c);
        if (so.PreviousYearOrder__r != null && so.PreviousYearOrder__r.MaintenanceStartDateFormula__c != null) {
            
            pr.getParameters().put('StartDate', ('0000' + so.PreviousYearOrder__r.MaintenanceStartDateFormula__c.year()).Substring(('0000' + so.PreviousYearOrder__r.MaintenanceStartDateFormula__c.year()).length() - 4) + 
                                                '-' + 
                                                ('00' + so.PreviousYearOrder__r.MaintenanceStartDateFormula__c.month()).Substring(('00' + so.PreviousYearOrder__r.MaintenanceStartDateFormula__c.month()).length() - 2) + 
                                                '-' + 
                                                ('00' + so.PreviousYearOrder__r.MaintenanceStartDateFormula__c.day()).Substring(('00' + so.PreviousYearOrder__r.MaintenanceStartDateFormula__c.day()).length() - 2) 
                                  );

        }

        if (so.PreviousYearOrder__r != null && so.PreviousYearOrder__r.MaintenanceEndDateFormula__c != null) {

            pr.getParameters().put('EndDate', ('0000' + so.PreviousYearOrder__r.MaintenanceEndDateFormula__c.year()).Substring(('0000' + so.PreviousYearOrder__r.MaintenanceEndDateFormula__c.year()).length() - 4) + 
                                              '-' + 
                                              ('00' + so.PreviousYearOrder__r.MaintenanceEndDateFormula__c.month()).Substring(('00' + so.PreviousYearOrder__r.MaintenanceEndDateFormula__c.month()).length() - 2) + 
                                              '-' + 
                                              ('00' + so.PreviousYearOrder__r.MaintenanceEndDateFormula__c.day()).Substring(('00' + so.PreviousYearOrder__r.MaintenanceEndDateFormula__c.day()).length() - 2) 
                                  );

        }

        pr.setRedirect(true);
        return pr;
    }


    public PageReference redirectSurvey(){

        PageReference pr = new PageReference('/apex/JEOL_MaintenanceDetailSurvey');
        pr.getParameters().put('id', so.id);
        pr.setRedirect(true);
        return pr;

    }


    
    public void PrintAnnai1() {
    }
    
    public void PrintAnnai2() {

        Pagereference ref = this.getPrintUrl();
        Blob pdfData;
        if (!Test.IsRunningTest()) {
            pdfData = ref.getContent();
        } else {
            pdfData = Blob.valueOf('UNIT.TEST');
        }        
        Attachment attachRec = new Attachment();
        attachRec.parentId = so.id;
        attachRec.name = Label.JEOL_MaintDetail_Label_AnnaiPDFName  + '.pdf';
        attachRec.body = pdfData;
        insert attachRec;
    }
    
    public Pagereference getPrintUrl() {

        IF (so.AnnaiType__c == NULL) {
            return null;
        }

        Pagereference ret;
        String annaiTypeValue = so.AnnaiType__c.replace(' ', '_');
        If(annaiTypeValue == '2pages') annaiTypeValue = '1Page'; //As URL for 1Page and 2pages is same
        ret = new PageReference('/apex/JEOL_MaintenanceAnnaiPrintPage_' + annaiTypeValue);
        //ret = new PageReference('/apex/JEOL_MaintenanceAnnaiPrintPage_' + so.AnnaiType__c.replace(' ', '_'));                      
    
        /*    
        if (so.AnnaiType__c == 'FU') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_FU;
        } else if (so.AnnaiType__c == 'NA') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_NA;
        } else if (so.AnnaiType__c == 'OS') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_OS;
        } else if (so.AnnaiType__c == 'SA') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_SA;
        } else if (so.AnnaiType__c == 'SE') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_SE;
        } else if (so.AnnaiType__c == 'SE v2') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_SE_v2;
        } else if (so.AnnaiType__c == 'TA') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_TA;
        } else if (so.AnnaiType__c == 'TA_ME') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_TA_ME;
        } else if (so.AnnaiType__c == 'TA_MP') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_TA_MP;
        } else if (so.AnnaiType__c == 'TO') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_TO;
        } else if (so.AnnaiType__c == 'TU') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_TU;
        } else if (so.AnnaiType__c == 'YO') {
            ret = Page.JEOL_MaintenanceAnnaiPrintPage_YO;
        }
        */

        Map<String, String> params = ret.getParameters();
        params.put(PARAM_ID, so.id);
        params.put('print', 'true');
        return ret;
    }

    public Pagereference save() {
    
        boolean fProblem = false;

        if (so.NewOdrSeries__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintDetail_Message_SeriesMissing));
            fProblem = true;
        }
        if (so.NewOdrRegion__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Label.JEOL_MaintDetail_Message_AreaMissing));
            fProblem = true;
        }

        if (so.PreviousYearOrder__c != null) {
            // renewal
        } else {
            // new
            if (so.NewOdrSalesAccount__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '販売先取引先: 値を入力してください'));
                fProblem = true;
            }
            if (so.NewOdrShipmentAccount__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '出荷先取引先: 値を入力してください'));
                fProblem = true;
            }
            if (so.NewOdrSalesStaff__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '営業担当: 値を入力してください'));
                fProblem = true;
            }
            if (so.PipelineStopped__c && !so.RenewalApproved__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '契約中止フラグは受注確定のときしか使えません。'));
                fProblem = true;            
            }
            if (so.RenewalApproved__c && so.ContractImpossible__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '契約不可フラグは受注確定のとき使えません。'));
                fProblem = true;            
            }
            if (so.HidePipeline__c && so.ContractImpossible__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '未表示フラグは契約不可のとき使えません。'));
                fProblem = true;            
            }
        } 
        if (fProblem) {
            return null;
        }
        
        boolean fStatusUpdated = false;
        try {
        
            // Put ProductNumber__c in capital letters
            if (so.ProductNumber__c != null) {
                so.ProductNumber__c = convertHalfwidth(so.ProductNumber__c.toUpperCase());
            }

            so.NewOdrDepartment__c = NULL;
            if (DepartmentCode != NULL) {
                List<Department__c> lsDep = [SELECT Id, Name, DepartmentCode__c FROM Department__c where DepartmentCode__c = :DepartmentCode ORDER BY SortNo__c];
                for (Department__c dep: lsDep) {
                    so.NewOdrDepartment__c = dep.id;
                }
            }
            
            // Automatic update of the status
            if (so.PreviousYearOrder__c == null) {
                // The previous year order does not exists, it is a new negociation
                
                if (StatusMemo == so.Status__c) {
                    // Any change will happen only if the user has not changed the status manually

                    if (StatusMemo == null || StatusMemo == '1' || StatusMemo == '2' || StatusMemo == '6' || StatusMemo == '8' || StatusMemo == '9') {
                
                        if (so.RenewalApproved__c && !so.PipelineStopped__c) {
                        
                            // The negociation has been approved
                            if (so.Status__c != '2') {
                                fStatusUpdated = true;
                                so.Status__c = '2';
                            }
                        
                        } else if (so.RenewalApproved__c && so.PipelineStopped__c) {
                        
                            // The negociation has been approved and rejected
                            if (so.Status__c != '6') {
                                fStatusUpdated = true;
                                so.Status__c = '6';
                            }
                            
                        } else if (so.ContractImpossible__c) {
                        
                            // Contract impossible
                            if (so.Status__c != '8') {
                                fStatusUpdated = true;
                                so.Status__c = '8';
                            }
                            
                        } else if (so.HidePipeline__c) {
                        
                            // Hide pipeline
                            if (so.Status__c != '9') {
                                fStatusUpdated = true;
                                so.Status__c = '9';
                            }
                            
                        } else {
                        
                            // No check
                            if (so.Status__c != '1') {
                                fStatusUpdated = true;
                                so.Status__c = '1';
                            }
                            
                        } 
                
                    }

                }
            
            } else {
                // The previous year order does not exists, it is a renewal
            
                // Change on the current year status
                if (StatusMemo == so.Status__c) {
                    // Any change will happen only if the user has not changed the status manually

                    if (StatusMemo == null || StatusMemo == '1' || StatusMemo == '2' || StatusMemo == '6' || StatusMemo == '7') {
                
                        if (so.RenewalApproved__c && !so.PipelineStopped__c) {
                        
                            // The negociation has been approved
                            if (so.Status__c != '2') {
                                fStatusUpdated = true;
                                so.Status__c = '2';
                            }
                        
                        } else if (so.RenewalApproved__c && so.PipelineStopped__c) {
                        
                            // The negociation has been approved and rejected
                            if (so.Status__c != '6') {
                                fStatusUpdated = true;
                                so.Status__c = '6';
                            }
                            
                        } else if (!so.RenewalApproved__c && so.PipelineStopped__c) {
                        
                            // The negociation has been rejected
                            if (so.Status__c != '7') {
                                fStatusUpdated = true;
                                so.Status__c = '7';
                            }
                            
                        } else {
                        
                            // Not approved, not rejected
                            if (so.Status__c != '1') {
                                fStatusUpdated = true;
                                so.Status__c = '1';
                            }
                            
                        } 
                
                    }
                }



                // Change the Status of the previous Year (only for Status 2, 3, 4 and 5)
                List<MaintenanceContractManagement__c> lsPrevYear = [SELECT id, Name, Status__c
                                                                     FROM MaintenanceContractManagement__c
                                                                     WHERE id = :so.PreviousYearPipeline__c
                                                                     AND Status__c in ('2', '3', '4', '5')];                
                if (lsPrevYear != null && lsPrevYear.size() > 0) {
                    boolean fUpdatePreviousYear = false;
                    for (MaintenanceContractManagement__c prevYear : lsPrevYear) {


                        if (so.RenewalApproved__c) {
                        
                            // The renewal has been approved
                            if (prevYear.Status__c != '4') {
                                fUpdatePreviousYear = true;
                                prevYear.Status__c = '4';
                            }
                            
                        } else if (so.PipelineStopped__c) {
                        
                            // The renewal has been rejected
                            if (prevYear.Status__c != '5') {
                                fUpdatePreviousYear = true;
                                prevYear.Status__c = '5';
                            }
                            
                        } else {
                        
                            // The renewal is ongoing
                            if (prevYear.Status__c != '3') {
                                fUpdatePreviousYear = true;
                                prevYear.Status__c = '3';
                            }
                            
                        } 
                        
                    }
                    if (fUpdatePreviousYear) {
                        update lsPrevYear;
                    }
                }                    
            
            }
                        
            // Save the options
            String sListOptions = '';
            if (lsOptions != null && lsOptions.size() > 0) {
                for (MaintenanceAnnaiOptions__c opt : lsOptions) {
                    if (opt.TechnicalAlwaysFalse__c) {
                        if (sListOptions.length() > 0) {
                            sListOptions += '\n';
                        }
                        sListOptions += opt.Label__c;
                    }
                }
            }
            so.RenewalListOptions__c = sListOptions;
            
            upsert so;

        } catch (exception ex) {
            // Put again the status that was set
            if (fStatusUpdated) {
                so.Status__c = StatusMemo;
            }
            
            return null;
        }
        
        Pagereference ret = Page.JEOL_MaintenanceDetailView;
        ret.setRedirect(true);
        Map<String, String> params = ret.getParameters();
        params.put(PARAM_ID, so.id);
        return ret;
    }




    public Pagereference saveSurvey() {

        try {
            upsert so;
        } catch (exception ex) {            
            return null;
        }
        
        Pagereference ret = Page.JEOL_MaintenanceDetailView;
        ret.setRedirect(true);
        Map<String, String> params = ret.getParameters();
        params.put(PARAM_ID, so.id);
        return ret;

    }






    public PageReference redirectNewQuotation(){

        Pagereference ref = Page.JEOL_QuotationEditorPage;
        ref.setRedirect(true);
        
        if (so.PreviousYearOrder__c != null && so.PreviousYearOrder__r.QuotationInformation__c != null) {
            Map<String, String> params = ref.getParameters();
            params.put(PARAM_ID, so.PreviousYearOrder__r.QuotationInformation__c);
            params.put(URL_PARAM_NAME_ISCOPY, 'true');
        }

        return ref;

    }

    private boolean LinkageCheckData(MaintenanceContractManagement__c mcm, boolean isDeletion) {
    
        if (!isDeletion) {
            
            date dOrderDate = mcm.NewOdrOrderDate__c;
            if (dOrderDate == null) {
                dOrderDate = system.today();     
            }
    
            // Check if the ProductNumber is already used
            checkExistenceProductNumber(mcm.ProductNumber__c);
            checkExistenceQuotation(mcm.NewOdrQuotation__c);
            
            checkDeliveryAccount(mcm.NewOdrSalesAccount__r, mcm.NewOdrShipmentAccount__r);
        
            if (mcm.NewOdrMaintenanceEndDate__c != null) {
                integer iNbDays = (integer)BaaNSettings__c.getValues('Default').NbDaysSendOK__c;
                if (mcm.NewOdrMaintenanceEndDate__c.AddDays(iNbDays) <=  system.today()) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintDetail_Message_DataTooOld));
                    return false;                
                }
            }
            
        
            // Check the length of the fields
            if (!CheckDataLength(mcm.Name,                                  true,  false,  14, '保守契約管理番号')) return false;
            if (!CheckDataLength(mcm.NewOdrSeries__c,                       true,  false,   2, '系列')) return false;
            if (!CheckDataLength(mcm.NewOdrFiscalYear__c,                   true,  false,   2, '年度')) return false;
    
            if (mcm.NewOdrNetMaintenance__c == null || (mcm.NewOdrNetMaintenance__c.trim().toUpperCase() != 'YES' && mcm.NewOdrNetMaintenance__c.trim().toUpperCase() != 'NO')) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「NET保守区分」の項目は必須です。'));
                return false;
            }
                    
            if (!CheckDataLength(mcm.NewOdrSalesAccount__r.Code__c,         true,  false,   9, '販売先取引先')) return false;
            String sSalesAccount5Chars = (mcm.NewOdrSalesAccount__r.Code__c.length() > 5 ? mcm.NewOdrSalesAccount__r.Code__c.substring(0, 5) : mcm.NewOdrSalesAccount__r.Code__c);
            
            if (!mcm.NewOdrSalesAccount__r.SalesAccountFlag__c || mcm.NewOdrSalesAccount__r.SalesAccountSituation__c == '無効') {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した販売先取引先は無効です。'));
                return false;                    
            } else if ((mcm.NewOdrSalesAccount__r.SalesAccountStartDateFormula__c != NULL && mcm.NewOdrSalesAccount__r.SalesAccountStartDateFormula__c > dOrderDate) ||
                       (mcm.NewOdrSalesAccount__r.SalesAccountEndDateFormula__c != NULL && mcm.NewOdrSalesAccount__r.SalesAccountEndDateFormula__c < dOrderDate)) {
                // Check the date are OK
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した「販売先取引先」はこの日に使えません。'));
                return false;                                
            }
            
            if (!CheckDataLength(mcm.NewOdrSalesContactPosition__c,         false, true,   -1, '販売先担当者所属')) return false;
            if (!CheckDataLength(mcm.NewOdrSalesContactPost__c,             false, true,   -1, '販売先担当者役職')) return false;
            if (!CheckDataLength(mcm.NewOdrSalesTantoshya__c,               false, true,   -1, '販売先担当者名')) return false;
            if (!CheckDataLength(mcm.NewOdrSalesContactTel__c,              false, false,  -1, '販売先TEL')) return false;
            if (!CheckDataLength(mcm.NewOdrSalesContactFax__c,              false, false,  -1, '販売先FAX')) return false;
            if (!CheckDataLength(mcm.NewOdrShipmentAccount__r.Code__c,      true,  false,   9, '出荷先取引先')) return false;
    
            if (!mcm.NewOdrShipmentAccount__r.ShipmentAccountFlag__c || mcm.NewOdrShipmentAccount__r.ShipmentAccountSituation__c == '無効') {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した出荷先取引先は無効です。'));
                return false;                    
            } else if ((mcm.NewOdrShipmentAccount__r.ShipmentAccountStartDateFormula__c != NULL && mcm.NewOdrShipmentAccount__r.ShipmentAccountStartDateFormula__c > dOrderDate) ||
                       (mcm.NewOdrShipmentAccount__r.ShipmentAccountEndDateFormula__c != NULL && mcm.NewOdrShipmentAccount__r.ShipmentAccountEndDateFormula__c < dOrderDate)) {
                // Check the date are OK
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した「出荷先取引先」はこの日に使えません。'));
                return false;                                
            }
            
            if (!CheckDataLength(mcm.NewOdrShipmentContactPosition__c,      false, true,   -1, '納入先担当者所属')) return false;
            if (!CheckDataLength(mcm.NewOdrShipmentContactPost__c,          false, true,   -1, '納入先担当者役職')) return false;
            if (!CheckDataLength(mcm.NewOdrShipmentTantosha__c,             false, true,   -1, '納入先担当者名')) return false;
            if (!CheckDataLength(mcm.NewOdrShipmentContact_Tel__c,          false, false,  -1, '納入先TEL')) return false;
            if (!CheckDataLength(mcm.NewOdrShipmentContact_Fax__c,          false, false,  -1, '納入先FAX')) return false;
            if (!CheckDataLength(mcm.NewOdrFlagshipProduct__c,              true,  true,   -1, '受注代表商品名')) return false;
            if (!CheckDataLength(mcm.NewOdrSalesStaff__r.UserCode__c,       true,  false,   9, '営業担当者')) return false;
            if (mcm.NewOdrSalesStaff__r.RetiredFlag__c && (mcm.NewOdrSalesStaff__r.RetiredDate__c == null || mcm.NewOdrSalesStaff__r.RetiredDate__c < dOrderDate)) {
                // The user has retired
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した「営業担当者」は退職しました。'));
                return false;                                
            }
    
            if (!CheckDataLength(mcm.NewOdrOrdersMemp__c,                   false, true,   -1, '受注メモ')) return false;
            if (!CheckDataLength(mcm.ProductNumber__c,                      true,  false,  15, '製番')) return false;
            if (!CheckDataLength(mcm.NewOdrDepartment__r.DepartmentCode__c, true,  false,  15, '販売オフィス')) return false;
            if (!CheckDataLength(mcm.NewOdrRegion__c,                       true,  false,   3, '地域')) return false;
            if (!CheckDataLength(mcm.NewOdrContractDivision__c,             true,  false,   1, '契約区分')) return false;
            if (!CheckDataLength(mcm.NewOdrQuotation__r.QuoteNo__c,         true,  false,  13, '見積番号')) return false;
            if (!CheckDataLength(mcm.NewOdrQuotation__r.BranchNo__c,        true,  false,   2, '見積番号(枝番)')) return false;
    
            String sQuotationAccount5Chars = '';
            if (mcm.NewOdrQuotation__r.ContractAccount__c != null && mcm.NewOdrQuotation__r.ContractAccount__r.Code__c != null) {
                sQuotationAccount5Chars = (mcm.NewOdrQuotation__r.ContractAccount__r.Code__c.length() > 5 ? mcm.NewOdrQuotation__r.ContractAccount__r.Code__c.substring(0, 5) : mcm.NewOdrQuotation__r.ContractAccount__r.Code__c);
            }
            if (sQuotationAccount5Chars != sSalesAccount5Chars) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「見積書の契約先」（' + sQuotationAccount5Chars + '）は「販売先取引先」（' + sSalesAccount5Chars + '）と違ってます。'));
                return false;                            
            }        
    
            // Check if the quotation is not already used in a SalesOrder
            // Done in checkExistenceQuotation()
                    
            // Check if the quotation has already been sent to BaaN
            if (mcm.NewOdrQuotation__r.RecordType.Name == 'SFDC' && mcm.NewOdrQuotation__r.LinkageStatus__c != '連携済') {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '見積書はまだBaaNに送ってないです。'));
                return false;                    
            }
    
            if (!CheckDataLength(mcm.NewOdrReferenceOrder__r.Name,          false, false,   9, '関連オーダ番号')) return false;
            if (mcm.NewOdrSalesOrder__c != null && mcm.NewOdrReferenceOrder__c != null && mcm.NewOdrSalesOrder__c == mcm.NewOdrReferenceOrder__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「関連オーダ」は販売オーダと違わないといけない。'));
                return false;
            }
    
            if (!CheckDataLength(mcm.NewOdrSalesPipeline__r.ShodanNo_sync__c, false, false,   9, '受注予定番号')) return false;
            if (mcm.NewOdrSalesPipeline__c != null) {
                // Check the series and the region
                if (mcm.NewOdrSalesPipeline__r.Series__c != mcm.NewOdrSeries__c) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した営業パイプラインは違う系列のパイプラインです。'));
                    return false;            
                }
                if (mcm.NewOdrSalesPipeline__r.RegionName__c != mcm.NewOdrRegion__c) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した営業パイプラインは違う地域のパイプラインです。'));
                    return false;            
                }

                // Check if the pipeline is not already used in a SalesOrder
                List <SalesOrder__c> lsSO2 = [SELECT id, Name FROM SalesOrder__c WHERE SalesPipelineLink__c = :mcm.NewOdrSalesPipeline__c AND MaintenanceContractManagement__c != :so.id];
                if (lsSO2 != null && lsSO2.size() > 0) {
                    string listSO = '';
                    for (SalesOrder__c sOdr : lsSO2) {                
                        listSO += ' <a href="/' + sOdr.id + '">' + sOdr.Name + '</a>';
                    }
                
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '次の販売オーダは同じ営業パイプラインを使ってます：' + listSO));
                    return false;            
                }
            }
            if (!CheckDataLength(mcm.NewOdrAssistant__r.UserCode__c,        false, false,   9, 'アシスタント')) return false;
            if (mcm.NewOdrAssistant__r.UserCode__c != null) {
                if (mcm.NewOdrSalesStaff__r.RetiredFlag__c && (mcm.NewOdrSalesStaff__r.RetiredDate__c == null || mcm.NewOdrSalesStaff__r.RetiredDate__c < dOrderDate)) {
                    // The user has retired
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した「アシスタント」は退職しました。'));
                    return false;                                
                }
            }
            
            if (!CheckDataLength(mcm.NewOdrTradingCompanyInvolved__c,       false, false,   1, '商社関与区分')) return false;
    
            if (mcm.NewOdrCommissionPayment__c != NULL) {
                if (!CheckDataLength(mcm.NewOdrCommissionPayment__r.Code__c,        false, false,   9, '口銭支払先コード')) return false;
                if (!mcm.NewOdrCommissionPayment__r.SalesAccountFlag__c || mcm.NewOdrCommissionPayment__r.SalesAccountSituation__c == '無効') {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した口銭支払先は無効です。'));
                    return false;                    
                } else if ((mcm.NewOdrCommissionPayment__r.SalesAccountStartDateFormula__c != NULL && mcm.NewOdrCommissionPayment__r.SalesAccountStartDateFormula__c > dOrderDate) ||
                           (mcm.NewOdrCommissionPayment__r.SalesAccountEndDateFormula__c != NULL && mcm.NewOdrCommissionPayment__r.SalesAccountEndDateFormula__c < dOrderDate)) {
                    // Check the date are OK
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '選択した「口銭支払先」はこの日に使えません。'));
                    return false;                                
                }
            }
            
            if (!CheckDataLength(mcm.UnitBody__r.Name,                      false, false,  15, '本体号機')) return false;
            boolean flg1 = (mcm.UnitBody__r.Name != null && mcm.UnitBody__r.Name.length() > 0); // Mandatory if 保守契約オーダかつ本体号機あり
            if (!CheckDataLength(getMaintenanceType(mcm.NewOdrMaintenanceType__c), flg1,  false,   2, '保守種類')) return false;
            if (mcm.NewOdrRoutineCheck__c != null && (mcm.NewOdrRoutineCheck__c < 0 || mcm.NewOdrRoutineCheck__c > 99)) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「定期点検」の項目の長さは2以内してください。'));
                return false;
            }
            if (!CheckDataLength(mcm.NewOdrTroubleshooting__c,              false, true,   -1, '故障修理')) return false;
            if (!CheckDataLength(mcm.NewOdrNotices1__c,                     false, true,   -1, '特記事項１')) return false;
            if (!CheckDataLength(mcm.NewOdrNotices2__c,                     false, true,   -1, '特記事項２')) return false;
            if (!CheckDataLength(mcm.NewOdrRepairParts__c,                  false, true,   -1, '修理部品')) return false;
            if (!CheckDataLength(mcm.NewOdrAtt__c,                          false, true,   -1, 'ATT')) return false;
            if (!CheckDataLength(mcm.NewOdrOther1__c,                       false, true,   -1, 'その他１')) return false;
            if (!CheckDataLength(mcm.NewOdrOther2__c,                       false, true,   -1, 'その他２')) return false;
            if (!CheckDataLength(mcm.NewOdrSalesNoOfTimes__c,               false, true,   -1, '売上回数')) return false;
    
            if (!mcm.RenewalApproved__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「受注確定済」がチェックされていませんので、BaaNに送ることができません。'));
                return false;            
            }
    
            if (mcm.Status__c == null || mcm.Status__c == '5' || (flg1 && mcm.Status__c != '2' && mcm.Status__c != '3' && mcm.Status__c != '4' && mcm.Status__c != '5' && mcm.Status__c != '6' && mcm.Status__c != '7')) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'このステータスはBaanに送ることができません。'));
                return false;
            }

            if (mcm.PipelineStopped__c && mcm.NewOdrSalesOrder__c == NULL) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '販売オーダがない契約中止の保守契約管理はBaanに送ることができません。'));
                return false;                
            }

            if ((flg1 || mcm.NewOdrMaintenanceStartDate__c != null) && mcm.NewOdrMaintenanceEndDate__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「保守契約終了日」の項目は必須です。'));
                return false;        
            }
            if (mcm.NewOdrMaintenanceStartDate__c != null && mcm.NewOdrMaintenanceEndDate__c != null && mcm.NewOdrMaintenanceEndDate__c < mcm.NewOdrMaintenanceStartDate__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「保守契約終了日」の項目は「保守契約開始日」の項目より過去は不可です。'));
                return false;        
            }
    
            if (flg1 && mcm.NewOdrNewUpdated__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「新規／更新」の項目は必須です。'));
                return false;        
            }
            
            boolean flg2 = (mcm.Status__c != null && (mcm.Status__c == '6' || mcm.Status__c == '7')); // BaaN status is 契約中止
            if (flg2 && mcm.PipelineStoppedReason__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「契約中止理由」の項目は必須です。'));
                return false;        
            }
            if (flg2 && mcm.PipelineStoppedDate__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「契約中止日」の項目は必須です。'));
                return false;        
            }
        }
        
        if (!CheckDataNumeric(mcm.NewOdrContractAmountt__c,       false, 11, 2, '契約金額')) return false;
        if (!CheckDataNumeric(mcm.NewOdrShareOrderAmount__c,      false, 11, 2, '商社取分金額')) return false;
        if (!CheckDataNumeric(mcm.NewOdrCommissionOrderAmount__c, false, 11, 2, '支払口銭金額')) return false;
        
        if (!isDeletion) {
            if ((mcm.NewOdrContractAmountt__c != null && mcm.NewOdrContractAmountt__c != mcm.ContractAmountLine__c) || (mcm.NewOdrContractAmountt__c == null && mcm.ContractAmountLine__c != 0)) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「契約金額」は「管理台帳総合金額」と同じではありません。'));
                return false;                    
            }
    
            // Check the format of ProductNumber
            //     XM9391501014039
            //     XM              系列 (check only done if series is different from CA/LC/EQ/ER/NM/AP/XP)
            //       939           Fixed for Maintenance
            //          15         Fiscal Year of the new contract
            //            010      地域
            //               14039 Code determined the 1st year (the 14 is the fiscal year of the 1st time)        
            if (mcm.ProductNumber__c.length() != 15 || 
                (mcm.ProductNumber__c.substring(0, 2) != mcm.NewOdrSeries__c && mcm.NewOdrSeries__c != 'CA' && mcm.NewOdrSeries__c != 'LC' && mcm.NewOdrSeries__c != 'EQ' && mcm.NewOdrSeries__c != 'ER' && mcm.NewOdrSeries__c != 'NM' && mcm.NewOdrSeries__c != 'AP' && mcm.NewOdrSeries__c != 'XP') || 
                mcm.ProductNumber__c.substring(2, 5) != '939' || 
                mcm.ProductNumber__c.substring(5, 7) != mcm.NewOdrFiscalYear__c || 
                mcm.ProductNumber__c.substring(7, 10) != mcm.NewOdrRegion__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「採番」の形を確認してください。' + ' (' + (mcm.NewOdrSeries__c != 'CA' && mcm.NewOdrSeries__c != 'LC' && mcm.NewOdrSeries__c != 'EQ' && mcm.NewOdrSeries__c != 'ER' && mcm.NewOdrSeries__c != 'NM' && mcm.NewOdrSeries__c != 'AP' && mcm.NewOdrSeries__c != 'XP' ? mcm.NewOdrSeries__c : 'xx') + '939' + mcm.NewOdrFiscalYear__c + mcm.NewOdrRegion__c + 'xxxxx)'));
                return false;                            
            }
        }

        return true;
    }

    private boolean LinkageCheckDataLine(MaintenanceAccountBook__c mcmline, MaintenanceContractManagement__c mcm, boolean isDeletion) {

        if (!isDeletion) {
            
            // Check the length of the fields
            if (mcmline.Type__c == null || (mcmline.Type__c != '1' && mcmline.Type__c != '2' && mcmline.Type__c != '3' && mcmline.Type__c != '4')) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「品目」の項目は必須です。'));
                return false;
            }
    
            if (!CheckDataLength(mcmline.ItemName__c,                       true,  true,   -1, '管理台帳の商品名')) return false;
    
            if (mcmline.Month__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「月」の項目は必須です。'));
                return false;
            }
    
            if (!CheckDataLength(mcmline.TaxCode__c,                        true,  false,   9, '税金コード')) return false;
    
            if (mcmline.SalesAmountEstimate__c != null && mcmline.SalesAmountEstimate__c < 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '台帳の「金額」は正数じゃないといけない。'));
                return false;
            }
        }
        
        if (!CheckDataNumeric(mcmline.SalesAmountEstimate__c, false, 10, 2, '台帳の金額')) return false;
        
        /* This check is no more needed (confirmed by phone by OKI on 2016/02/23)
        if (!isDeletion) {
            date ddate = mcm.NewOdrOrderDate__c;
            if (ddate == null) {
                ddate = system.today();     
            }
            if (getLastDayMonth(mcmline.Month__c) < ddate) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '台帳の月はオーダ日付より過去は不可です。'));
                return false;        
            }
        }
        */

        return true;

    }


    private boolean LinkageCheckDataOrderDoc(MaintenanceOrderDocument__c mcmline, boolean isDeletion) {

        if (!isDeletion) {
        
            if (!CheckDataLength(mcmline.OrderNumber__c,                   true,  true,   -1, '注文書の注文番号')) return false;
    
            if (mcmline.PaymentTerms__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の支払条件」の項目は必須です。'));
                return false;
            }

        }
            
        if (!CheckDataNumeric(mcmline.Price__c, true, 11, 2, '注文書の金額')) return false;

        if (!isDeletion) {

            if (mcmline.ContractDate__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の契約年月日」の項目は必須です。'));
                return false;
            }
    
            if (mcmline.PenaltyFlg__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書のペナルティ有無」の項目は必須です。'));
                return false;
            }
    
            boolean flg1 = (mcmline.PenaltyFlg__c == '1'); // Mandatory if and only if ペナルティ有無 = 有(1)
            if (!CheckDataLength(mcmline.PenaltyRatio__c,                   flg1,  true,   -1, '注文書のペナルティ率')) return false;
            if (mcmline.PenaltyRatio__c != null && !flg1) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '注文書のペナルティ無の場合、「ペナルティ率」の項目は入力不可です。'));
                return false;        
            }
    
    
            if (mcmline.PaymentFrequency__c == null || mcmline.PaymentFrequency__c <= 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の支払回数」の項目は必須です。'));
                return false;
            }
    
            if (mcmline.CashPromissoryDivision__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の現金手形区分」の項目は必須です。'));
                return false;
            }
    
            boolean flg2 = (mcmline.CashPromissoryDivision__c == '2'); // Mandatory if 現金手形区分 = 手形(2)
            if ((flg2 && mcmline.SightDays__c == null) || (mcmline.SightDays__c != null && mcmline.SightDays__c < 0)) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '注文書の手形の場合、「サイト/DAYS」の項目は必須です。'));
                return false;
            }
    
            if (mcmline.PaymentTogetherDivision__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の支払一括区分」の項目は必須です。'));
                return false;
            }
    
            if (mcmline.PaymentDayDivision__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の支払日区分」の項目は必須です。'));
                return false;
            }
    
            if (mcmline.InspectionDeadlineDivision__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書の検収締切区分」の項目は必須です。'));
                return false;
            }
    
            boolean flg3 = mcmline.PaymentDayDivision__c != '1' || mcmline.InspectionDeadlineDivision__c != '1'; // Mandatory if 支払日区分 = 末日(1) or 検収締切区分 = 末日(1)
            if (!CheckDataLength(mcmline.PaymentDatePeriod__c,               flg3,  false,   -1, '注文書の支払日定時')) return false;
            if (!CheckDataLength(mcmline.AcceptanceDeadline__c,              flg3,  false,   -1, '注文書の検収締日')) return false;
    
            if (mcmline.Factoring__c == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書のファクタリング有無」の項目は必須です。'));
                return false;
            }
        }
        
        return true;
        
    }


    
    // Return value : true: OK, false: problem
    private boolean CheckDataLength(String data, boolean isRequired, boolean isMultyBytesOK, integer lengthMax, String itemNameForErrorMessage) {
    
        boolean fReturn = true;
        
        // Check if a field required is entered
        if (isRequired) {
            if (data == null || data.length() == 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「' + itemNameForErrorMessage + '」の項目は必須です。'));
                fReturn = false;
            }            
        }

        
        // Check if there is some multi-bytes character
        if (!isMultyBytesOK) {
            if (data != null && JEOLUtil.getSizeInBytes(data) != data.length()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「' + itemNameForErrorMessage + '」の項目はマルチバイトの文字を含めることができません。'));
                fReturn = false;                
            }
        }
        

        // Check the length of the fields
        if (data != null && lengthMax != -1 && JEOLUtil.getSizeInBytes(data) > lengthMax) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「' + itemNameForErrorMessage + '」の項目の長さは' + lengthMax + 'バイト以内してください。'));
            fReturn = false;
        }            
        
    
        return fReturn;
    }
        
    // Return value : true: OK, false: problem
    private boolean CheckDataNumeric(Decimal data, boolean isRequired, integer lengthMax, integer decimalMax, String itemNameForErrorMessage) {
    
        boolean fReturn = true;
        
        // Check if a field required is entered
        if (isRequired && data == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「' + itemNameForErrorMessage + '」の項目は必須です。'));
            fReturn = false;
        }


        // Check the length of the fields
        if (data != null && data != 0) {
            if (data.stripTrailingZeros().scale() > decimalMax) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「' + itemNameForErrorMessage + '」の項目は小数点第' + decimalMax + '位にしてください。'));
                fReturn = false;            
            }
        
            if (('' + data.round(System.RoundingMode.DOWN)).length() > lengthMax) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「' + itemNameForErrorMessage + '」の項目の長さは' + lengthMax + '以内してください。'));
                fReturn = false;            
            }
            
        }            
        
    
        return fReturn;
    }
        
                
    public PageReference LinkageSendToBaan(){

        LinkageToBaan(false, false);
        return null;

    }

    public PageReference LinkageDeleteFromBaan(){

        List<MaintenanceAccountBook__c> lsPb = [SELECT id FROM MaintenanceAccountBook__c WHERE MaintenanceContractManagement__c = :so.id AND (AlreadyBilled__c = true OR SalesAmountReal__c != null OR SalesReturn__c = true) LIMIT 1];

        if (lsPb != NULL && lsPb.size() > 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '売上済の台帳データがあるため、取消できません。'));
            return null;            
        }
        
        if (so.PipelineStoppedReason__c != 'H99_TORIKESHI') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '取消するためには保守中止理由の「取消」を選択下さい。'));
            return null;
        }

        LinkageToBaan(true, false);
        return null;

    }
    
    public PageReference checkBaaN(){

        LinkageToBaan(false, true);
        return null;

    }
                

    private void LinkageToBaan(boolean IsDeletion, boolean isOnlyCheck){

        Datetime dDateLinkage = System.Now();
        boolean fUpdateMCM = false;

        IsCheckBaaNOK = false;
                
        MaintenanceContractManagement__c soUpd = [SELECT id, NewOdrSeries__c, NewOdrFiscalYear__c, NewOdrSalesAccount__r.Code__c, NewOdrSalesContactPosition__c, NewOdrSalesContactPost__c, NewOdrSalesTantoshya__c, RenewalApproved__c,
                                                             NewOdrSalesContactTel__c, NewOdrSalesContactFax__c, NewOdrShipmentAccount__r.Code__c, NewOdrShipmentContactPosition__c, NewOdrShipmentContactPost__c,
                                                             NewOdrShipmentTantosha__c, NewOdrShipmentContact_Tel__c, NewOdrShipmentContact_Fax__c, NewOdrFlagshipProduct__c, NewOdrSalesStaff__r.UserCode__c,
                                                             NewOdrOrdersMemp__c, ProductNumber__c, NewOdrDepartment__r.DepartmentCode__c, NewOdrRegion__c, NewOdrContractDivision__c, NewOdrOrderDate__c,
                                                             NewOdrQuotation__r.QuoteNo__c, NewOdrQuotation__r.BranchNo__c, NewOdrSalesOrder__c, NewOdrReferenceOrder__c, NewOdrReferenceOrder__r.Name, NewOdrSalesPipeline__r.Name, NewOdrSalesPipeline__r.ShodanNo_sync__c, NewOdrAssistant__r.UserCode__c,
                                                             NewOdrContractAmountt__c, NewOdrTradingCompanyInvolved__c, NewOdrShareOrderAmount__c, NewOdrCommissionOrderAmount__c, NewOdrCommissionPayment__c, NewOdrCommissionPayment__r.Code__c,
                                                             UnitBody__r.Name, NewOdrMaintenanceType__c, NewOdrNetMaintenance__c, NewOdrRoutineCheck__c, NewOdrTroubleshooting__c, NewOdrNotices1__c, NewOdrNotices2__c,
                                                             NewOdrRepairParts__c, NewOdrAtt__c, NewOdrOther1__c, NewOdrOther2__c, NewOdrMaintenanceStartDate__c, NewOdrMaintenanceEndDate__c, Status__c, PipelineStoppedReason__c, PipelineStopped__c,
                                                             PipelineStoppedDate__c, NewOdrNewUpdated__c, NewOdrSalesNoOfTimes__c, BillingMethod__c, VersionNumber__c, ContractAmountLine__c, Name,
                                                             NewOdrQuotation__r.ContractAccount__c, NewOdrQuotation__r.ContractAccount__r.Code__c, NewOdrSalesPipeline__r.Series__c, NewOdrSalesPipeline__r.RegionName__c,
                                                             NewOdrSalesAccount__r.SalesAccountFlag__c, NewOdrSalesAccount__r.SalesAccountSituation__c, NewOdrSalesAccount__r.SalesAccountStartDateFormula__c, NewOdrSalesAccount__r.SalesAccountEndDateFormula__c,
                                                             NewOdrShipmentAccount__r.ShipmentAccountFlag__c, NewOdrShipmentAccount__r.ShipmentAccountSituation__c, NewOdrShipmentAccount__r.ShipmentAccountStartDateFormula__c, NewOdrShipmentAccount__r.ShipmentAccountEndDateFormula__c,
                                                             NewOdrCommissionPayment__r.SalesAccountFlag__c, NewOdrCommissionPayment__r.SalesAccountSituation__c, NewOdrCommissionPayment__r.SalesAccountStartDateFormula__c, NewOdrCommissionPayment__r.SalesAccountEndDateFormula__c,
                                                             NewOdrSalesStaff__r.RetiredFlag__c, NewOdrSalesStaff__r.RetiredDate__c, NewOdrAssistant__r.RetiredFlag__c, NewOdrAssistant__r.RetiredDate__c, NewOdrQuotation__r.RecordType.Name, NewOdrQuotation__r.LinkageStatus__c
                                                  FROM   MaintenanceContractManagement__c
                                                  WHERE  id = :so.id
                                                  FOR UPDATE];

        // Refresh the link status and check that the operation is still authorized
        RefreshLinkStatus();
        if (IsDeletion && (LinkStatusCode == 0 || LinkStatusCode == 4 || LinkStatusCode == 5)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '現在の連携ステータスのため、このオペレーションは禁止です。'));
            return;
        }

        if (!LinkageCheckData(soUpd, IsDeletion)) {
            return;
        }
               
        MaintenanceLinkOrder__c lkOrder = new MaintenanceLinkOrder__c();
        lkOrder.MaintenanceContractManagement__c = soUpd.id;
        
        lkOrder.ifdt__c = dDateLinkage;
        lkOrder.sfno__c = soUpd.id;
        lkOrder.orno__c = soUpd.NewOdrSeries__c + soUpd.NewOdrFiscalYear__c;
        lkOrder.clyn__c = IsDeletion ? '1' : '2';
        lkOrder.cpcl__c = soUpd.NewOdrSeries__c;
        lkOrder.odkd__c = '1';
        lkOrder.ofbp__c = soUpd.NewOdrSalesAccount__r.Code__c;
        lkOrder.blng__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrSalesContactPosition__c, 40);
        lkOrder.post__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrSalesContactPost__c, 20);
        lkOrder.ctps__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrSalesTantoshya__c, 30);
        lkOrder.telp__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrSalesContactTel__c, 15);
        lkOrder.falp__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrSalesContactFax__c, 15);
        lkOrder.stbp__c = soUpd.NewOdrShipmentAccount__r.Code__c;
        lkOrder.dlbl__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrShipmentContactPosition__c, 40);
        lkOrder.dlps__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrShipmentContactPost__c, 20);
        lkOrder.dlpr__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrShipmentTantosha__c, 30);
        lkOrder.dltl__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrShipmentContact_Tel__c, 15);
        lkOrder.dlfx__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrShipmentContact_Fax__c, 15);
        lkOrder.sdsc__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrFlagshipProduct__c, 40);
        lkOrder.crep__c = soUpd.NewOdrSalesStaff__r.UserCode__c;
        lkOrder.memo__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrOrdersMemp__c, 80);
        lkOrder.sotp__c = '4A1';
        lkOrder.cprj__c = convertHalfwidth(soUpd.ProductNumber__c.toUpperCase());
        lkOrder.cofc__c = soUpd.NewOdrDepartment__r.DepartmentCode__c;
        lkOrder.creg__c = soUpd.NewOdrRegion__c;
        lkOrder.cntr__c = soUpd.NewOdrContractDivision__c;

        if (!IsDeletion && !IsOnlyCheck && (soUpd.NewOdrOrderDate__c == null || LinkStatusCode == 5)) {
system.debug('call 0');
            soUpd.NewOdrOrderDate__c = system.today();
            fUpdateMCM = true;
        }

        lkOrder.odat__c = (soUpd.NewOdrOrderDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.NewOdrOrderDate__c)).addhours(-9));        
        lkOrder.scdt__c = (soUpd.NewOdrOrderDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.NewOdrOrderDate__c)).addhours(-9));   
        lkOrder.prdt__c = (soUpd.NewOdrOrderDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.NewOdrOrderDate__c)).addhours(-9));   
        lkOrder.ddat__c = (soUpd.NewOdrOrderDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.NewOdrOrderDate__c)).addhours(-9));   
        lkOrder.ccur__c = 'JPY';
        lkOrder.mtmr__c = soUpd.NewOdrQuotation__r.QuoteNo__c;
        lkOrder.mtno__c = soUpd.NewOdrQuotation__r.BranchNo__c;
        lkOrder.rlsn__c = soUpd.NewOdrReferenceOrder__r.Name;
        lkOrder.bsno__c = soUpd.NewOdrSalesPipeline__r.ShodanNo_sync__c;
        lkOrder.osrp__c = soUpd.NewOdrAssistant__r.UserCode__c;
        lkOrder.stax__c = soUpd.NewOdrContractAmountt__c;
        lkOrder.svcm__c = soUpd.NewOdrContractAmountt__c;
        lkOrder.prtc__c = soUpd.NewOdrTradingCompanyInvolved__c;
        lkOrder.prkg__c = soUpd.NewOdrShareOrderAmount__c;
        lkOrder.pkcm__c = soUpd.NewOdrCommissionOrderAmount__c;
        lkOrder.cmcd__c = (soUpd.NewOdrCommissionPayment__c == NULL ? null : soUpd.NewOdrCommissionPayment__r.Code__c);
        lkOrder.main__c = soUpd.UnitBody__r.Name;
        lkOrder.hsyu__c = getMaintenanceType(soUpd.NewOdrMaintenanceType__c);

        if (soUpd.NewOdrNetMaintenance__c != null && soUpd.NewOdrNetMaintenance__c.trim().length() > 0) {
            if (soUpd.NewOdrNetMaintenance__c.trim().toUpperCase() == 'YES') {
                lkOrder.ntkn__c = '1';
            } else if (soUpd.NewOdrNetMaintenance__c.trim().toUpperCase() == 'NO') {
                lkOrder.ntkn__c = '2';
            }                            
        }

        lkOrder.tete__c = soUpd.NewOdrRoutineCheck__c;
        lkOrder.kosy__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrTroubleshooting__c), 100);
        lkOrder.tok1__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrNotices1__c), 160);
        lkOrder.tok2__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrNotices2__c), 160);
        lkOrder.sybu__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrRepairParts__c), 160);
        lkOrder.atta__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrAtt__c), 160);
        lkOrder.oth1__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrOther1__c), 160);
        lkOrder.oth2__c = JEOLUtil.truncateToNBytesBaaN(JEOLUtil.removeCarriageReturn(soUpd.NewOdrOther2__c), 160);
        lkOrder.hoss__c = (soUpd.NewOdrMaintenanceStartDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.NewOdrMaintenanceStartDate__c)).addhours(-9));
        lkOrder.hose__c = (soUpd.NewOdrMaintenanceEndDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.NewOdrMaintenanceEndDate__c)).addhours(-9));

        lkOrder.kkzy__c = null;
        if (soUpd.Status__c != null && soUpd.Status__c.trim().length() > 0) {
            if (soUpd.Status__c == '2') {
                lkOrder.kkzy__c = '1';
            } else if (soUpd.Status__c == '3') {
                lkOrder.kkzy__c = '2';
            } else if (soUpd.Status__c == '4') {
                lkOrder.kkzy__c = '3';
            } else if (soUpd.Status__c == '5') {
                lkOrder.kkzy__c = '2';
            } else if (soUpd.Status__c == '6') {
                lkOrder.kkzy__c = '4';
            } else if (soUpd.Status__c == '7') {
                lkOrder.kkzy__c = '4';
            }                            
        }

        lkOrder.cdis__c = (soUpd.PipelineStoppedReason__c != null && soUpd.PipelineStoppedReason__c.length() > 3 ? soUpd.PipelineStoppedReason__c.substring(0, 3) : soUpd.PipelineStoppedReason__c);
        lkOrder.tydt__c = (soUpd.PipelineStoppedDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(soUpd.PipelineStoppedDate__c)).addhours(-9));
        lkOrder.siko__c = soUpd.NewOdrNewUpdated__c;
        lkOrder.keki__c = soUpd.NewOdrContractAmountt__c;
        lkOrder.ukai__c = JEOLUtil.truncateToNBytesBaaN(soUpd.NewOdrSalesNoOfTimes__c, 30);
        lkOrder.stuk__c = JEOLUtil.truncateToNBytesBaaN(soUpd.BillingMethod__c, 50);
        lkOrder.ifst__c = '1';
        lkOrder.gndt__c = Date.newInstance(1970, 1, 1);
        lkOrder.mess__c = '';
//      lkOrder.rcid__c = 
        lkOrder.mnno__c = soUpd.Name;


        // Insert the rows
        List<MaintenanceLinkOrderLine__c> lsLinkLines = new List<MaintenanceLinkOrderLine__c>();
        
        List<MaintenanceAccountBook__c> lsAccountBook = [SELECT id, Name, MaintenanceContractManagement__c, Type__c, Month__c, SalesAmountEstimate__c, SalesAuto__c, ItemName__c, TaxCode__c
                                                         FROM   MaintenanceAccountBook__c
                                                         WHERE  MaintenanceContractManagement__c = :so.id
                                                         AND    (SalesAmountEstimate__c != null AND SalesAmountEstimate__c != 0)
                                                         AND    AlreadyBilled__c = false
                                                         ORDER BY Type__c, Month__c
                                                        ];
        
        for (MaintenanceAccountBook__c rowAcc : lsAccountBook) {

            if (!LinkageCheckDataLine(rowAcc, soUpd, isDeletion)) {
                return;
            }
    
            MaintenanceLinkOrderLine__c lkOrderLine = new MaintenanceLinkOrderLine__c();
            //lkOrderLine.MaintenanceLinkOrder__c = lkOrder.id;

            lkOrderLine.ifdt__c = dDateLinkage;
            lkOrderLine.sfno__c = so.id;
            lkOrderLine.pono__c = Decimal.valueOf(getLineNoLink(rowAcc.Type__c, rowAcc.Month__c) + '00');

            //　ATT管理台帳に　金額が記載のあるライン　⇒　CZZH012　ATT保守売上
            //　HE管理台帳に　　金額が記載のあるライン　⇒　CZZH008　ヘリウム充填保守売上
            //　本体管理台帳に　金額が記載のあるライン ⇒　CZZH007  本体保守売上
            //　本体管理台帳（自動）に　金額が記載のあるライン ⇒　CZZH016  本体保守売上            
            if (rowAcc.Type__c != null && rowAcc.Type__c.trim().length() > 0) {
                if (rowAcc.Type__c == '1') {
                    lkOrderLine.item__c = 'CZZH007';
                } else if (rowAcc.Type__c == '2') {
                    lkOrderLine.item__c = 'CZZH016';
                } else if (rowAcc.Type__c == '3') {
                    lkOrderLine.item__c = 'CZZH012';
                } else if (rowAcc.Type__c == '4') {
                    lkOrderLine.item__c = 'CZZH008';
                }                            
            }
    
            lkOrderLine.bfnm__c = JEOLUtil.truncateToNBytesBaaN(rowAcc.ItemName__c, 60);
            lkOrderLine.qoor__c = 1;
            lkOrderLine.pric__c = rowAcc.SalesAmountEstimate__c;
            lkOrderLine.ddta__c = (getLastDayMonth(rowAcc.Month__c) == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(getLastDayMonth(rowAcc.Month__c))).addhours(-9));
            lkOrderLine.prdt__c = lkOrderLine.ddta__c;
            lkOrderLine.cvat__c = rowAcc.TaxCode__c;
            if (rowAcc.SalesAuto__c != null) {
                lkOrderLine.auto__c = rowAcc.SalesAuto__c ? '1' : '2';
            }
            lkOrderLine.ifst__c = '1';
            lkOrderLine.gndt__c = Date.newInstance(1970, 1, 1);
            lkOrderLine.mess__c = '';
//          lkOrderLine.rcid__c = 
            
            lsLinkLines.add(lkOrderLine);    
        }




        // Insert the Order Form
        List<MaintenanceLinkOrderForm__c> lsLinkForms = new List<MaintenanceLinkOrderForm__c>();
        
        List<MaintenanceOrderDocument__c> lsOrderDoc = [SELECT id, Name, MaintenanceContractManagement__c, SerialNumber__c, OrderNumber__c, ContractDate__c, OnSpotInspection__c, PenaltyFlg__c, Price__c, PaymentTogetherDivision__c,
                                                               InstallationDay__c, PaymentDayDivision__c, InspectionDeadlineDivision__c, Factoring__c, ContractFlg__c, BudgetFiscalYear__c, PenaltyRatio__c, PaymentTerms__c,
                                                               PaymentFrequency__c, CashPromissoryDivision__c, SightDays__c, PaymentDatePeriod__c, AcceptanceDeadline__c
                                                        FROM   MaintenanceOrderDocument__c
                                                        WHERE  MaintenanceContractManagement__c = :so.id
                                                        ORDER BY SerialNumber__c, Name
                                                       ];
        
        if (!isDeletion && (lsOrderDoc == null || lsOrderDoc.size() == 0) && soUpd.NewOdrContractDivision__c != '2') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '「注文書」は必須です。'));
            return;
        }
        
        for (MaintenanceOrderDocument__c rowOdrDoc : lsOrderDoc) {

            if (!LinkageCheckDataOrderDoc(rowOdrDoc, isDeletion)) {
                return;
            }

            MaintenanceLinkOrderForm__c lkOrderForm = new MaintenanceLinkOrderForm__c();
            //lkOrderForm.MaintenanceLinkOrder__c = lkOrder.id;

            lkOrderForm.ifdt__c = dDateLinkage;
            lkOrderForm.sfno__c = so.id;

            lkOrderForm.sqno__c = rowOdrDoc.SerialNumber__c;
            lkOrderForm.ornb__c = JEOLUtil.truncateToNBytesBaaN(rowOdrDoc.OrderNumber__c, 20);
            lkOrderForm.pymt__c = rowOdrDoc.PaymentTerms__c;
            lkOrderForm.pric__c = rowOdrDoc.Price__c;
            lkOrderForm.ctdt__c = (rowOdrDoc.ContractDate__c == NULL ? Date.newInstance(1970, 1, 1) : ((Datetime)(rowOdrDoc.ContractDate__c)).addhours(-9));
            lkOrderForm.prts__c = rowOdrDoc.OnSpotInspection__c ? '1' : '2';
            lkOrderForm.bgyr__c = rowOdrDoc.BudgetFiscalYear__c;
            lkOrderForm.ptkb__c = rowOdrDoc.PenaltyFlg__c;
            lkOrderForm.ptrt__c = JEOLUtil.truncateToNBytesBaaN(rowOdrDoc.PenaltyRatio__c, 20);
            lkOrderForm.pytm__c = rowOdrDoc.PaymentFrequency__c;
            lkOrderForm.pykb__c = rowOdrDoc.CashPromissoryDivision__c;
            lkOrderForm.site__c = rowOdrDoc.SightDays__c;
            lkOrderForm.pytp__c = rowOdrDoc.PaymentTogetherDivision__c;
            lkOrderForm.pydt__c = rowOdrDoc.PaymentDayDivision__c;
            lkOrderForm.fpdt__c = JEOLUtil.truncateToNBytesBaaN(rowOdrDoc.PaymentDatePeriod__c, 8);
            lkOrderForm.tdkb__c = rowOdrDoc.InspectionDeadlineDivision__c;
            lkOrderForm.tddt__c = JEOLUtil.truncateToNBytesBaaN(rowOdrDoc.AcceptanceDeadline__c, 8);
            lkOrderForm.dtnm__c = rowOdrDoc.InstallationDay__c;
            lkOrderForm.kflg__c = rowOdrDoc.ContractFlg__c ? '1' : '2';
            lkOrderForm.ftys__c = rowOdrDoc.Factoring__c;
   
            lkOrderForm.ifst__c = '1';
            lkOrderForm.gndt__c = Date.newInstance(1970, 1, 1);
            lkOrderForm.mess__c = '';
//          lkOrderForm.rcid__c = 
            
            lsLinkForms.add(lkOrderForm);    
        }


        if (fUpdateMCM) {
system.debug('call 1 start:' + soUpd.VersionNumber__c);
            soUpd.IncrementVersionNumber__c = true;
            decimal iCurrentVersionNumber = soUpd.VersionNumber__c;
            update soUpd;
            soUpd.VersionNumber__c = (iCurrentVersionNumber == null) ? 1 : (iCurrentVersionNumber + 1);
            so.VersionNumber__c = (iCurrentVersionNumber == null) ? 1 : (iCurrentVersionNumber + 1);
            // I prefer to make this than to directly take the last value at this time to avoid the case of 2 simultaneous updates (extremely rare case)
            // In this case, at worst, it will appear as "last version not sent" even if it has been sent
            // Which is better than appearing as sent when it has not been
system.debug('call 1 end' + so.VersionNumber__c);
        }
            
        lkOrder.VersionSent__c = so.VersionNumber__c;
        if (!IsOnlyCheck) {
            insert lkOrder;
        }
        
        if (!IsOnlyCheck && lsLinkLines != null && lsLinkLines.size() > 0) {
            for (MaintenanceLinkOrderLine__c lkOrderLine : lsLinkLines) {
                lkOrderLine.MaintenanceLinkOrder__c = lkOrder.id;
            }
            insert lsLinkLines;
        }

        if (!IsOnlyCheck && lsLinkForms != null && lsLinkForms.size() > 0) {
            for (MaintenanceLinkOrderForm__c lkOrderForm : lsLinkForms) {
                lkOrderForm.MaintenanceLinkOrder__c = lkOrder.id;
            }
            insert lsLinkForms;
        }
        
        if (!IsOnlyCheck) {
            soUpd.LastLinkBaaN__c = lkOrder.id;
            soUpd.BypassTriggerCheck__c = true;
            soUpd.IncrementVersionNumber__c = false;
    system.debug('call 2 start:' + so.VersionNumber__c);
    system.debug('call 2');
            update soUpd;
    system.debug('call 2 end:' + so.VersionNumber__c);
        }
        
        if (IsOnlyCheck) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'BaaNに送るチェックの問題がありません。'));
        }
        IsCheckBaaNOK = IsOnlyCheck;
        
    }


    private String getLineNoLink(String sType, String sMonth) {
        
        String sReturn = '';

        try {
                    
            if (sType.trim().length() != 1 || sMonth.trim().length() != 6) {
                return '';        
            }
            
            sReturn = sType.trim();
            
            integer iYear = integer.valueof(sMonth.trim().substring(2, 4));
            integer iMonth = integer.valueof(sMonth.trim().substring(4));
            
            sReturn += ((12 * iYear) + iMonth);

        } catch (Exception ex) {
            sReturn = '';
        }
        
        return sReturn;
    }
    
    private String getLineNoLinkReverseType(decimal pono) {
        
        String sReturn = '';
        String sPono = '' + pono;
        try {
                    
            if (sPono.trim().length() != 6) {
                return '';        
            }
            
            sReturn = sPono.trim().substring(0, 1);

        } catch (Exception ex) {
            sReturn = '';
        }
        
        return sReturn;
    }
    
    private String getLineNoLinkReverseMonth(decimal pono) {
        
        String sReturn = '';
        String sPono = '' + pono;

        try {
                    
            if (sPono.trim().length() != 6) {
                return '';        
            }
            
            integer ipono = integer.valueof(sPono.trim().substring(1, 4));
            integer iMonth = math.mod(ipono, 12);
            integer iYear = 2000 + (ipono - 12) / 12;
            if (iMonth == 0) {
                iMonth = 12;
                iYear -= 1;
            }
            
            if (iMonth < 10) {
                 sReturn = '' + iYear + '/' + '0' + iMonth;
             } else {
                 sReturn = '' + iYear + '/' + iMonth;
            }             

        } catch (Exception ex) {
            sReturn = '';
        }
        
        return sReturn;
    }
    
        

    private Datetime getLastDayMonth(String sMonth) {
        
        Datetime dReturn = null;

        try {
                    
            if (sMonth.trim().length() != 6) {
                return null;
            }
                        
            integer iYear = integer.valueof(sMonth.trim().substring(0, 4));
            integer iMonth = integer.valueof(sMonth.trim().substring(4));
            
            dReturn = Date.newInstance(iYear, iMonth, 1).addMonths(1).addDays(-1);

        } catch (Exception ex) {
            dReturn = null;
        }
        
        return dReturn;
    }



    public PageReference ImportDataFromSalesAccount(){

        List<Account> lsAcc = [SELECT Id, phone, fax
                               FROM Account
                               WHERE id = :so.NewOdrSalesAccount__c
                              ];

        so.NewOdrSalesContactPosition__c = null;
        so.NewOdrSalesContactPost__c = null;
        so.NewOdrSalesTantoshya__c = null;
        so.NewOdrSalesContactTel__c = null;
        so.NewOdrSalesContactFax__c = null;

        for (Account rowAcc : lsAcc) {        
            so.NewOdrSalesContactTel__c = rowAcc.phone;
            so.NewOdrSalesContactFax__c = rowAcc.fax;
        }
            
        return null;
    }

    public PageReference ImportDataFromShipmentAccount(){

        List<Account> lsAcc = [SELECT Id, phone, fax
                               FROM Account
                               WHERE id = :so.NewOdrShipmentAccount__c
                              ];

        so.NewOdrShipmentContactPosition__c = null;
        so.NewOdrShipmentContactPost__c = null;
        so.NewOdrShipmentTantosha__c = null;
        so.NewOdrShipmentContact_Tel__c = null;
        so.NewOdrShipmentContact_Fax__c = null;

        for (Account rowAcc : lsAcc) {        
            so.NewOdrShipmentContact_Tel__c = rowAcc.phone;
            so.NewOdrShipmentContact_Fax__c = rowAcc.fax;
        }
            
        return null;
    }


    public PageReference ImportDataFromUnitBody(){

        // Do not import if it has already been sent to BaaN or if a quotation has been selected
        if (so.LastLinkBaaN__c != null || so.NewOdrQuotation__c != null) {
            return null;
        }

        List<UnitBody__c> lsUB = [SELECT Id, Series__c, ShippingDateFormula__c, SalesAccount__c, SalesAccount__r.phone, SalesAccount__r.fax, DeliveryAccount__c, DeliveryAccount__r.phone, DeliveryAccount__r.fax
                                  FROM UnitBody__c
                                  WHERE id = :so.UnitBody__c
                                 ];

        for (UnitBody__c rowUB : lsUB) {
        
            so.NewOdrSeries__c = rowUB.Series__c;
                        
            if (rowUB.ShippingDateFormula__c != null) {
                so.NewOdrMaintenanceStartDate__c = rowUB.ShippingDateFormula__c.addYears(1);
                so.NewOdrMaintenanceEndDate__c = so.NewOdrMaintenanceStartDate__c.addYears(1).addDays(-1);  
            } else {
                so.NewOdrMaintenanceStartDate__c = null;
                so.NewOdrMaintenanceEndDate__c = null;              
            }

            so.NewOdrSalesAccount__c = rowUB.SalesAccount__c;
            so.NewOdrSalesContactPosition__c = null;
            so.NewOdrSalesContactPost__c = null;
            so.NewOdrSalesTantoshya__c = null;
            so.NewOdrSalesContactTel__c = rowUB.SalesAccount__r.phone;
            so.NewOdrSalesContactFax__c = rowUB.SalesAccount__r.fax;

            so.NewOdrShipmentAccount__c = rowUB.DeliveryAccount__c;
            so.NewOdrShipmentContactPosition__c = null;
            so.NewOdrShipmentContactPost__c = null;
            so.NewOdrShipmentTantosha__c = null;
            so.NewOdrShipmentContact_Tel__c = rowUB.DeliveryAccount__r.phone;
            so.NewOdrShipmentContact_Fax__c = rowUB.DeliveryAccount__r.fax;
            
        }
            
        return null;
    }
          
    public PageReference ImportDataFromQuotation(){

        // Do not import if it has already been sent to BaaN
        if (so.LastLinkBaaN__c != null) {
            return null;
        }
        
        List<QuotationInformation__c> lsQuot = [SELECT Id, Name, Series__c, SalesAreaCode__c, DepartmentCode__c, KeiyakuStartDate__c, KeiyakuEndDate__c, HoshuShurui__c, SalesPerson__c, SalesAssistant__c, TotalAmount__c,
                                                       ContractAccount__c, ContractBelong__c, ContractPost__c, ContractPersonInCharge__c, ContractPhone__c, ContractFax__c,
                                                       ShipmentAccount__c, ShipmentBelong__c, ShipmentPost__c, ShipmentPersonInCharge__c, ShipmentPhone__c, ShipmentFax__c, UnitBody__c
                                                FROM QuotationInformation__c
                                                WHERE id = :so.NewOdrQuotation__c
                                               ];

        for (QuotationInformation__c rowQuot : lsQuot) {
        
            // Check that the Series is amongst the values authorised
            so.NewOdrSeries__c = null;
            for( Schema.PicklistEntry f : MaintenanceContractManagement__c.NewOdrSeries__c.getDescribe().getPicklistValues()) {
                if (f.getValue() == rowQuot.Series__c) {
                    so.NewOdrSeries__c = rowQuot.Series__c;
                }
            }       
            
            // Check that the region is allowed
            so.NewOdrRegion__c = null;
            List<SelectListManage__c> lsVal = [SELECT id FROM SelectListManage__c WHERE ReferenceName__c = 'MaintenanceAreaCode' AND Value__c = :rowQuot.SalesAreaCode__c AND Disabled__c = false AND Hidden__c = false];
            if (lsVal != null && lsVal.size() > 0) {
                so.NewOdrRegion__c = rowQuot.SalesAreaCode__c;
            }
                    
            so.NewOdrDepartment__c = null;
            List<Department__c> ldDept = [SELECT Id FROM Department__c WHERE DepartmentCode__c = :rowQuot.DepartmentCode__c];
            for (Department__c rowDept : ldDept) {
                so.NewOdrDepartment__c = rowDept.id;                
            }
            DepartmentCode = rowQuot.DepartmentCode__c;
            
            so.NewOdrMaintenanceStartDate__c = rowQuot.KeiyakuStartDate__c;
            so.NewOdrMaintenanceEndDate__c = rowQuot.KeiyakuEndDate__c;
            so.NewOdrMaintenanceType__c = rowQuot.HoshuShurui__c;
            so.NewOdrSalesStaff__c = rowQuot.SalesPerson__c;
            so.NewOdrAssistant__c = rowQuot.SalesAssistant__c;
            so.NewOdrContractAmountt__c = rowQuot.TotalAmount__c;
            so.NewOdrSalesAccount__c = rowQuot.ContractAccount__c;
            so.NewOdrSalesContactPosition__c = rowQuot.ContractBelong__c;
            so.NewOdrSalesContactPost__c = rowQuot.ContractPost__c;
            so.NewOdrSalesTantoshya__c = rowQuot.ContractPersonInCharge__c;
            so.NewOdrSalesContactTel__c = rowQuot.ContractPhone__c;
            so.NewOdrSalesContactFax__c = rowQuot.ContractFax__c;
            so.NewOdrShipmentAccount__c = rowQuot.ShipmentAccount__c;
            so.NewOdrShipmentContactPosition__c = rowQuot.ShipmentBelong__c;
            so.NewOdrShipmentContactPost__c = rowQuot.ShipmentPost__c;
            so.NewOdrShipmentTantosha__c = rowQuot.ShipmentPersonInCharge__c;
            so.NewOdrShipmentContact_Tel__c = rowQuot.ShipmentPhone__c;
            so.NewOdrShipmentContact_Fax__c = rowQuot.ShipmentFax__c;
            so.NewOdrFlagshipProduct__c = rowQuot.Name;

            // Import the Unit Body if not already set
            if (so.UnitBody__c == null) {
                List<UnitBody__c> lsUnitBody = new List<UnitBody__c>();
                if (rowQuot.UnitBody__c != null) {
                    lsUnitBody = [SELECT Id
                                  FROM UnitBody__c
                                  WHERE UnitBody__c = :rowQuot.UnitBody__c
                                 ];
                }

                if (lsUnitBody != null && lsUnitBody.size() > 0) {
                    so.UnitBody__c = lsUnitBody[0].id;
                }                
            }
        }
            
        return null;
    }
    
    private void checkExistenceProductNumber(string ProductNumber) {
    
        if (ProductNumber == null || ProductNumber.length() == 0) {
            return;
        }
        
        List<MaintenanceContractManagement__c> lsWarnings = [SELECT id, Name FROM MaintenanceContractManagement__c WHERE ProductNumber__c = :ProductNumber AND id != :so.id];
    
        if (lsWarnings != null && lsWarnings.size() > 0) {
        
            string listPLM = '';
            for (MaintenanceContractManagement__c mcm : lsWarnings) {
                listPLM += ' <a href="./JEOL_MaintenanceDetailView?id=' + mcm.id + '">' + mcm.Name + '</a>';
            }
        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '次の保守契約管理は同じ製番をもってます：' + listPLM));
        }
    }

    private void checkExistenceQuotation(string quotation) {
    
        if (quotation == null || quotation.length() == 0) {
            return;
        }

        List <MaintenanceContractManagement__c> lsWarnings = [SELECT id, Name FROM MaintenanceContractManagement__c WHERE NewOdrQuotation__c = :quotation AND id != :so.id];
        if (lsWarnings != null && lsWarnings.size() > 0) {
            string listPLM = '';
            for (MaintenanceContractManagement__c mcm : lsWarnings) {
                listPLM += ' <a href="./JEOL_MaintenanceDetailView?id=' + mcm.id + '">' + mcm.Name + '</a>';
            }
        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '次の保守契約管理は同じ見積書を使ってます：' + listPLM));
        }
    }
    
    private void checkDeliveryAccount(Account SalesAccount, Account ShipmentAccount) {
    
        if (SalesAccount == null || SalesAccount.Code__c == null || SalesAccount.Code__c.length() == 0 ||
            ShipmentAccount == null || ShipmentAccount.Code__c == null || ShipmentAccount.Code__c.length() == 0) {
            return;
        }

        String sSalesAccount5Chars = (SalesAccount.Code__c.length() > 5 ? SalesAccount.Code__c.substring(0, 5) : SalesAccount.Code__c);
        String sShipmentAccount5Chars = (ShipmentAccount.Code__c.length() > 5 ? ShipmentAccount.Code__c.substring(0, 5) : ShipmentAccount.Code__c);

        if (sShipmentAccount5Chars != sSalesAccount5Chars) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '「出荷先取引先」（' + sShipmentAccount5Chars + '）は「販売先取引先」（' + sSalesAccount5Chars + '）と違ってます。'));
        }        

    }
    
        
    public integer getNbOption() {
       return lsOptions.size();
    }
    
    public void optionMoveUp() {

        MaintenanceAnnaiOptions__c optTmp = lsOptions.get(indiceOption);
        lsOptions.set(indiceOption, lsOptions.get(indiceOption - 1));
        lsOptions.set(indiceOption - 1, optTmp);

        integer idx = 0;
        for (MaintenanceAnnaiOptions__c opt : lsOptions) {
            opt.SortNo__c = idx;
            idx++;
        }

    }

    public void optionMoveDown() {

        MaintenanceAnnaiOptions__c optTmp = lsOptions.get(indiceOption);
        lsOptions.set(indiceOption, lsOptions.get(indiceOption + 1));
        lsOptions.set(indiceOption + 1, optTmp);

        integer idx = 0;
        for (MaintenanceAnnaiOptions__c opt : lsOptions) {
            opt.SortNo__c = idx;
            idx++;
        }

    }

    private String convertHalfwidth(String stringToConvert) {

        if (stringToConvert == null) {
            return null;
        }

        String sReturn = stringToConvert;
        sReturn = sReturn.replaceAll('[Ａ]', 'A').replaceAll('[ａ]', 'a').replaceAll('[Ｂ]', 'B').replaceAll('[ｂ]', 'b').replaceAll('[Ｃ]', 'C').replaceAll('[ｃ]', 'c').replaceAll('[Ｄ]', 'D').replaceAll('[ｄ]', 'd').replaceAll('[Ｅ]', 'E').replaceAll('[ｅ]', 'e');
        sReturn = sReturn.replaceAll('[Ｆ]', 'F').replaceAll('[ｆ]', 'f').replaceAll('[Ｇ]', 'G').replaceAll('[ｇ]', 'g').replaceAll('[Ｈ]', 'H').replaceAll('[ｈ]', 'h').replaceAll('[Ｉ]', 'I').replaceAll('[ｉ]', 'i').replaceAll('[Ｊ]', 'J').replaceAll('[ｊ]', 'j');
        sReturn = sReturn.replaceAll('[Ｋ]', 'K').replaceAll('[ｋ]', 'k').replaceAll('[Ｌ]', 'L').replaceAll('[ｌ]', 'l').replaceAll('[Ｍ]', 'M').replaceAll('[ｍ]', 'm').replaceAll('[Ｎ]', 'N').replaceAll('[ｎ]', 'n').replaceAll('[Ｏ]', 'O').replaceAll('[ｏ]', 'o');
        sReturn = sReturn.replaceAll('[Ｐ]', 'P').replaceAll('[ｐ]', 'p').replaceAll('[Ｑ]', 'Q').replaceAll('[ｑ]', 'q').replaceAll('[Ｒ]', 'R').replaceAll('[ｒ]', 'r').replaceAll('[Ｓ]', 'S').replaceAll('[ｓ]', 's').replaceAll('[Ｔ]', 'T').replaceAll('[ｔ]', 't');
        sReturn = sReturn.replaceAll('[Ｕ]', 'U').replaceAll('[ｕ]', 'u').replaceAll('[Ｖ]', 'V').replaceAll('[ｖ]', 'v').replaceAll('[Ｗ]', 'W').replaceAll('[ｗ]', 'w').replaceAll('[Ｘ]', 'X').replaceAll('[ｘ]', 'x').replaceAll('[Ｙ]', 'Y').replaceAll('[ｙ]', 'y');
        sReturn = sReturn.replaceAll('[Ｚ]', 'Z').replaceAll('[ｚ]', 'z');
        sReturn = sReturn.replaceAll('[０]', '0').replaceAll('[１]', '1').replaceAll('[２]', '2').replaceAll('[３]', '3').replaceAll('[４]', '4').replaceAll('[５]', '5').replaceAll('[６]', '6').replaceAll('[７]', '7').replaceAll('[８]', '8').replaceAll('[９]', '9');

        Return sReturn;
    }

    private static String getMaintenanceType(String sMaintenanceType) {
        
        if (sMaintenanceType == null) {
            return null;
        }

        String sReturn = sMaintenanceType;
        Integer iIdx = sMaintenanceType.indexOf('_');
        if (iIdx > 0) {
            sReturn = sMaintenanceType.left(iIdx);
        } else if (iIdx == 0) {
            sReturn = NULL;
        }
        
        return sReturn;
    }


}