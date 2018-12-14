public with sharing class JEOL_MaintenanceMultipleAnnai_ctrl extends JEOL_SearchBase_ctrl {
    
    public boolean fProblemStartDate{get; set;}
    public boolean fProblemEndDate{get; set;}
    public boolean fProblemAccount{get; set;}
    public boolean fWarningAccount{get; set;}
    public date dMemoStartDate{get; set;}
    public date dMemoEndDate{get; set;}
    public Account MemoAccount{get; set;}
    public String MemoAccountCode{get; set;}
    public decimal dAmount{get; set;}
    
    public MaintenanceMultipleAnnai__c MultipleAnnaiSummary{get; set;}
    
    private List<id> lsId = new List<id>();

    public static final String PARAM_ID = 'id';
        
    List<rowWrapper> rows = new List<rowWrapper>();

    //For RenewalListOptions
    public List<MaintenanceAnnaiOptions__c> lsOptions {get; set;}
    public Integer indiceOption {get; set;}

    public boolean getIsPrintForbidden() {
        return fProblemAccount || fProblemStartDate || fProblemEndDate;
    }
    

    // 画面起動時検索フラグ（'true'の場合に検索する）
    private String initSearchFlg = '';

    // エラーフラグ
    private Boolean errFlg = false;

    public JEOL_MaintenanceMultipleAnnai_ctrl() {
    
        String targetId = ApexPages.currentPage().getParameters().get('id');
        lsId = targetId.split(',');
        
        orderBy= 'name';
        currentOrder = 'name';
        orderDesc = false;

        MultipleAnnaiSummary = new MaintenanceMultipleAnnai__c();
        MultipleAnnaiSummary.ListIdLong__c = ApexPages.currentPage().getParameters().get('id');
        MultipleAnnaiSummary.ListId__c = MultipleAnnaiSummary.ListIdLong__c.left(255);

        id idCurrentYear = null;
        id idPreviousYear = null;
        
        // Check if the data exists for the current year
        List<MaintenanceMultipleAnnai__c> lsCurYear = [
            SELECT
                id, ListIdLong__c
            FROM
                MaintenanceMultipleAnnai__c
            WHERE
                ListId__c =: targetId.left(255)
            ORDER BY 
                CreatedDate desc
        ];
        
        for (MaintenanceMultipleAnnai__c rec : lsCurYear) {
            if (rec.ListIdLong__c == targetId) {
                idCurrentYear = rec.id;
                break;        
            }
        }
        
        
                
        
        
        
        
        List<MaintenanceContractManagement__c> lsResult = [SELECT NewOdrSalesAccount__c, NewOdrSalesAccount__r.Name, NewOdrSalesAccount__r.Code__c, NewOdrShipmentAccount__c, NewOdrShipmentAccount__r.Code__c, 
                                                                  NewContractStartDate__c, NewContractEndDate__c, NewContractAmount__c, PreviousYearOrder__c, PreviousYearOrder__r.Name, PreviousYearPipeline__c , PreviousYearPipeline__r.id,
                                                                  PreviousYearOrder__r.ItemName__c, PreviousYearOrder__r.UnitBody__c, PreviousYearOrder__r.MaintenancePeriodText__c, PreviousYearOrder__r.ConsumptionTax__c,
                                                                  PreviousYearOrder__r.ShipmentAccountCode__c, PreviousYearOrder__r.ShipmentAccount__c, PreviousYearOrder__r.SalesAccountCode__c, PreviousYearOrder__r.SalesAccount__c,
                                                                  PreviousYearOrder__r.MaintenanceStartDateFormula__c, PreviousYearOrder__r.MaintenanceEndDateFormula__c,
                                                                  JeolPipelineResponsible__c,JeolPipelineResponsible__r.Name,JeolPipelineResponsible2__c, JeolPipelineResponsible2__r.Name, AnnaiType__c, RenewalPrintDate__c,
                                                                  RenewalAddress__c, RenewalAddress2__c,JEOLRegionName__c,JEOLContactPosition__c,JEOLReplyRegionName__c,JEOLReplyContactPosition__c, RenewalTantoshya__c, RenewalContactPosition__c,
                                                                  RenewalPostalCode__c, RenewalTopSectionText__c, RenewalListOptions__c, RenewalCustomerNameReply__c, RenewalOptionCustomerNameLabel__c,
                                                                  RenewalOptionHideChangeInfo__c,RenewalFooterComment__c, RenewalOptionDateFormat__c, RenewalCompanyName__c, RenewalUndergraduate__c,
                                                                  RenewalDeliveryLocation__c, RenewalItemsName__c, UnitBody__c, UnitBody__r.UnitBody__c, JEOLContactTel__c, JEOLReplyContactFax__c, RenewalQuotation__c, RenewalQuotation__r.QuoteNo__c, RenewalQuotation__r.BranchNo__c
                                                           FROM MaintenanceContractManagement__c
                                                           WHERE id in :lsId
                                                          ];
        
        if (idCurrentYear == null) {
            List<id> lsIdPrevYear = new List<id>();
            boolean fContinue = true;
            
            // Check if some data exists for the previous year
            for (MaintenanceContractManagement__c row : lsResult) {
                if (row.PreviousYearPipeline__c != null && row.PreviousYearPipeline__r.id != null) {
                    lsIdPrevYear.add(row.PreviousYearPipeline__r.id);
                }
            }
                        
            if (lsIdPrevYear.size() == lsId.size()) {
                // if not, some data have no previous Year pipeline -> The data for the previous year can not exists

                lsIdPrevYear.sort();

                String targetIdPrevYear = String.join(lsIdPrevYear, ',');
        
                
                List<MaintenanceMultipleAnnai__c> lsPrevYear = [
                    SELECT
                        id, ListIdLong__c
                    FROM
                        MaintenanceMultipleAnnai__c
                    WHERE
                        ListId__c =: targetIdPrevYear.left(255)
                    ORDER BY 
                        CreatedDate desc
                ];
                
                for (MaintenanceMultipleAnnai__c rec : lsPrevYear) {
                    if (rec.ListIdLong__c == targetIdPrevYear) {
                        idPreviousYear = rec.id;
                        break;        
                    }
                }
            }
        }
        
        
        if (idCurrentYear != null || idPreviousYear != null) {

            id idToCopy = (idCurrentYear != null ? idCurrentYear : idPreviousYear);
            
            // Get the data
            MaintenanceMultipleAnnai__c dataToCopy = [SELECT id, Account__c,ItemName__c,ItemNamePrint__c,UnitBody__c,UnitBodyPrint__c,ContractNo__c,ContractNoPrint__c,RenewalOptionDateFormat__c,MaintenancePeriod__c,MaintenancePeriodPrint__c,
                                                             RenewalDeliveryLocationPrint__c,RenewalAddressPostalCodePrint__c,RenewalAddressLine1Print__c,RenewalAddressLine2Print__c,JEOLContactPositionPrint__c,JEOLReplyContactPositionPrint__c,
                                                             JEOLRegionNamePrint__c,JOELReplyRegionNamePrint__c,RenewalContactFaxPrint__c,RenewalContactTelPrint__c,RenewalTantoshyaPrint__c,RenewalContactPositionPrint__c,RenewalCompanyNamePrint__c,
                                                             RenewalUndergraduatePrint__c,RenewalTopSectionText__c,RenewalListOptions__c,RenewalCustomerNameReply__c,RenewalOptionCustomerNameLabel__c,RenewalOptionHideChangeInfo__c,
                                                             RenewalFooterComment__c,JEOLPipelineResponsiblePrint__c,JEOLPipelineResponsible2Print__c,AnnaiType__c,RenewalQuotationNumber__c, RenewalPrintDate__c
                                                      FROM   MaintenanceMultipleAnnai__c
                                                      WHERE  id = :idToCopy
                                                     ];
                                                     
            if (idCurrentYear != null) {
                MultipleAnnaiSummary.id = dataToCopy.id;
            }

            MultipleAnnaiSummary.Account__c = dataToCopy.Account__c;
            MultipleAnnaiSummary.ItemName__c = dataToCopy.ItemName__c;
            MultipleAnnaiSummary.ItemNamePrint__c = dataToCopy.ItemNamePrint__c;
            MultipleAnnaiSummary.UnitBody__c = dataToCopy.UnitBody__c;
            MultipleAnnaiSummary.UnitBodyPrint__c = dataToCopy.UnitBodyPrint__c;
            if (idCurrentYear != null) {
                MultipleAnnaiSummary.ContractNo__c = dataToCopy.ContractNo__c;
                MultipleAnnaiSummary.ContractNoPrint__c = dataToCopy.ContractNoPrint__c;
            }
            MultipleAnnaiSummary.RenewalOptionDateFormat__c = dataToCopy.RenewalOptionDateFormat__c;
            if (idCurrentYear != null) {
                MultipleAnnaiSummary.MaintenancePeriod__c = dataToCopy.MaintenancePeriod__c;
                MultipleAnnaiSummary.MaintenancePeriodPrint__c = dataToCopy.MaintenancePeriodPrint__c;
            }
            MultipleAnnaiSummary.RenewalDeliveryLocationPrint__c = dataToCopy.RenewalDeliveryLocationPrint__c;
            MultipleAnnaiSummary.RenewalAddressPostalCodePrint__c = dataToCopy.RenewalAddressPostalCodePrint__c;
            MultipleAnnaiSummary.RenewalAddressLine1Print__c = dataToCopy.RenewalAddressLine1Print__c;
            MultipleAnnaiSummary.RenewalAddressLine2Print__c = dataToCopy.RenewalAddressLine2Print__c;
            MultipleAnnaiSummary.JEOLContactPositionPrint__c = dataToCopy.JEOLContactPositionPrint__c;
            MultipleAnnaiSummary.JEOLReplyContactPositionPrint__c = dataToCopy.JEOLReplyContactPositionPrint__c;
            MultipleAnnaiSummary.JEOLRegionNamePrint__c = dataToCopy.JEOLRegionNamePrint__c;
            MultipleAnnaiSummary.JOELReplyRegionNamePrint__c = dataToCopy.JOELReplyRegionNamePrint__c;
            MultipleAnnaiSummary.RenewalContactFaxPrint__c = dataToCopy.RenewalContactFaxPrint__c;
            MultipleAnnaiSummary.RenewalContactTelPrint__c = dataToCopy.RenewalContactTelPrint__c;
            MultipleAnnaiSummary.RenewalTantoshyaPrint__c = dataToCopy.RenewalTantoshyaPrint__c;
            MultipleAnnaiSummary.RenewalContactPositionPrint__c = dataToCopy.RenewalContactPositionPrint__c;
            MultipleAnnaiSummary.RenewalCompanyNamePrint__c = dataToCopy.RenewalCompanyNamePrint__c;
            MultipleAnnaiSummary.RenewalUndergraduatePrint__c = dataToCopy.RenewalUndergraduatePrint__c;
            MultipleAnnaiSummary.RenewalTopSectionText__c = dataToCopy.RenewalTopSectionText__c;
            MultipleAnnaiSummary.RenewalListOptions__c = dataToCopy.RenewalListOptions__c;
            MultipleAnnaiSummary.RenewalCustomerNameReply__c = dataToCopy.RenewalCustomerNameReply__c;
            MultipleAnnaiSummary.RenewalOptionCustomerNameLabel__c = dataToCopy.RenewalOptionCustomerNameLabel__c;
            MultipleAnnaiSummary.RenewalOptionHideChangeInfo__c = dataToCopy.RenewalOptionHideChangeInfo__c;
            MultipleAnnaiSummary.RenewalFooterComment__c = dataToCopy.RenewalFooterComment__c;
            MultipleAnnaiSummary.JEOLPipelineResponsiblePrint__c = dataToCopy.JEOLPipelineResponsiblePrint__c;
            MultipleAnnaiSummary.JEOLPipelineResponsible2Print__c = dataToCopy.JEOLPipelineResponsible2Print__c;
            MultipleAnnaiSummary.AnnaiType__c = dataToCopy.AnnaiType__c;
            if (idCurrentYear != null) {
                MultipleAnnaiSummary.RenewalQuotationNumber__c = dataToCopy.RenewalQuotationNumber__c;
                MultipleAnnaiSummary.RenewalPrintDate__c = dataToCopy.RenewalPrintDate__c;
            }        
        }
        
        
        
        
        
        boolean fFirstData = true;
        fProblemStartDate = false;
        fProblemEndDate = false;
        fProblemAccount = false;
        fWarningAccount = false;
        dMemoStartDate = null;
        dMemoEndDate = null;
        MemoAccount = null;
        MemoAccountCode = '';
        dAmount = 0;
        decimal dPreviousAmount = 0;

        List<String> lsItemName = new List<String>();
        //List<String> lsItemNameWithUnitBody = new List<String>();
        List<String> lsRenewalDeliveryLocation = new List<String>();
        List<String> lsMaintenancePeriod = new List<String>();
        List<String> lsUnitBody = new List<String>();
        List<String> lsContractNo = new List<String>();
        List<String> lsQuotation = new List<String>();

        String renewalPostalCode; String renewalAddressLine1; String renewalAddressLine2;

        String sContactPosition; String sReplyContactPosition;
        String sRegionName; String sReplyRegionName;

        String renewalTantoshya; String renewalContactPosition;
        String renewalUndergraduate; String renewalCompanyName;
        String renewalContactTel; String renewalContactFax;

        User aPipelineResponsible1; User aPipelineResponsible2;

        String renewalTopSectionText; 
        //String renewalListOptions;
        lsOptions = new List<MaintenanceAnnaiOptions__c>();
        String renewalCustomerNameReply; String renewalOptionCustomerNameLabel;
        Boolean renewalOptionHideChangeInfo;
        String renewalAnnaiType;
        Date renewalPrintDate;
        String renewalFooterComment; String renewalOptionDateFormat;
        //String renewalQuotationNumber;
        
        for (MaintenanceContractManagement__c row : lsResult) {
            if (fFirstData) {
                dMemoStartDate = row.NewContractStartDate__c;
                dMemoEndDate = row.NewContractEndDate__c;
                MemoAccount = row.NewOdrSalesAccount__r;
                MemoAccountCode = (row.NewOdrSalesAccount__r != NULL && row.NewOdrSalesAccount__r.Code__c != NULL) ? row.NewOdrSalesAccount__r.Code__c : '';
                if (MemoAccountCode.length() > 5) MemoAccountCode = MemoAccountCode.left(5);
            }
            
            if (row.PreviousYearOrder__r.ConsumptionTax__c != null) {
                dPreviousAmount += row.PreviousYearOrder__r.ConsumptionTax__c;
            }        
            if (row.NewContractAmount__c != null) {
                dAmount += row.NewContractAmount__c;
            }        
            if (dMemoStartDate != row.NewContractStartDate__c) {
                fProblemStartDate = true;
            }
            if (dMemoEndDate != row.NewContractEndDate__c) {
                fProblemEndDate = true;
            }

            String MemoAccountCodeCurrent = (row.NewOdrSalesAccount__r != NULL && row.NewOdrSalesAccount__r.Code__c != NULL) ? row.NewOdrSalesAccount__r.Code__c : '';
            if (MemoAccountCodeCurrent.length() > 5) MemoAccountCodeCurrent = MemoAccountCodeCurrent.left(5);

            if (MemoAccountCode != MemoAccountCodeCurrent) {
                fProblemAccount = true;
                MemoAccount = null;
            }

            if (MemoAccount != row.NewOdrSalesAccount__r) {
                fWarningAccount = true;
            }



            if (fFirstData) {

                aPipelineResponsible1 = row.JeolPipelineResponsible__r;
                aPipelineResponsible2 = row.JeolPipelineResponsible2__r;
                sRegionName = row.JEOLRegionName__c;
                sReplyRegionName = row.JEOLReplyRegionName__c;
                sContactPosition = row.JEOLContactPosition__c;
                sReplyContactPosition = row.JEOLReplyContactPosition__c;
                renewalContactTel = row.JEOLContactTel__c;
                renewalContactFax = row.JEOLReplyContactFax__c;
                renewalCompanyName = row.RenewalCompanyName__c;
                renewalPostalCode = row.RenewalPostalCode__c;
                renewalUndergraduate = row.RenewalUndergraduate__c;
                renewalAddressLine1 = row.RenewalAddress__c;
                renewalContactPosition = row.RenewalContactPosition__c;
                renewalAddressLine2 = row.RenewalAddress2__c;
                renewalTantoshya = row.RenewalTantoshya__c;
                renewalOptionCustomerNameLabel = row.RenewalOptionCustomerNameLabel__c;
                renewalTopSectionText = row.RenewalTopSectionText__c;
                renewalFooterComment = row.RenewalFooterComment__c;
                renewalOptionDateFormat = row.RenewalOptionDateFormat__c;
                renewalOptionHideChangeInfo = row.RenewalOptionHideChangeInfo__c;
                addToRenewalListOption(row.RenewalListOptions__c); //check for RenewalListOptions__c=null is done afterwards
                renewalAnnaiType = row.AnnaiType__c;
                renewalPrintDate = row.RenewalPrintDate__c;
            }

            // Only for this field is not only the 1st data shown (UAT #127)
            if(row.RenewalCustomerNameReply__c != null && String.isEmpty(renewalCustomerNameReply)) {
                renewalCustomerNameReply = row.RenewalCustomerNameReply__c;
            }






            if(row.PreviousYearOrder__c != null) {
                addUniqueValueToTheList(row.PreviousYearOrder__r.Name, lsContractNo);
            }
            if(row.UnitBody__c != null) {
                addUniqueValueToTheList(row.UnitBody__r.UnitBody__c, lsUnitBody);
            }


            //Formats the date to Western-style (MM/dd/YY) if renewalOptionDateFormat = 2, else keeps them in Jp-style
            if (row.PreviousYearOrder__c != null && row.PreviousYearOrder__r.MaintenanceEndDateFormula__c != null &&
                row.PreviousYearOrder__r.MaintenanceStartDateFormula__c != null) {
                String periodValue = (renewalOptionDateFormat == '2') 
                                    ? 
                                    (getDateFormat(row.PreviousYearOrder__r.MaintenanceStartDateFormula__c, false, false)
                                        + ' ~ ' + 
                                    getDateFormat(row.PreviousYearOrder__r.MaintenanceEndDateFormula__c, false, false))
                                    : 
                                    (getDateFormat(row.PreviousYearOrder__r.MaintenanceStartDateFormula__c, true, false)
                                        + ' より ' +
                                    getDateFormat(row.PreviousYearOrder__r.MaintenanceEndDateFormula__c, true, false)
                                        + ' まで');
                addUniqueValueToTheList(periodValue, lsMaintenancePeriod);
            }

            // For the quotation, only the 1st row (UAT #127)
            if (fFirstData && row.RenewalQuotation__c != null && !String.isEmpty(row.RenewalQuotation__r.QuoteNo__c) && !String.isEmpty(row.RenewalQuotation__r.BranchNo__c)) {
                addUniqueValueToTheList(row.RenewalQuotation__r.QuoteNo__c + ' - ' + row.RenewalQuotation__r.BranchNo__c, lsQuotation);
            }

            addUniqueValueToTheList(row.RenewalDeliveryLocation__c, lsRenewalDeliveryLocation);

            addUniqueValueToTheList(row.RenewalItemsName__c,lsItemName);

            fFirstData = false;
        }
        
        // Add the other possibilities for the list of options
        addToRenewalListOptionOther();

        if (fProblemAccount) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintMultGuid_Message_DifferentAccountError));
        } else if (fWarningAccount) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, Label.JEOL_MaintMultGuid_Message_DifferentAccount));
        }
        if (fProblemStartDate) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintMultGuid_Message_DifferentStartDate));
        }
        if (fProblemEndDate) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintMultGuid_Message_DifferentEndDate));
        }
        
        
        if (!fProblemAccount && MemoAccount != null) {
            MultipleAnnaiSummary.Account__c = MemoAccount.Name;
        } else {
            MultipleAnnaiSummary.Account__c = '';                    
        }
        if (!fProblemStartDate) {
            MultipleAnnaiSummary.StartDate__c = dMemoStartDate;
        } else {
            MultipleAnnaiSummary.StartDate__c = null;
        }
        if (!fProblemEndDate) {
            MultipleAnnaiSummary.EndDate__c = dMemoEndDate;
        } else {
            MultipleAnnaiSummary.EndDate__c = null;                    
        }
        MultipleAnnaiSummary.Amount__c = dAmount;
        MultipleAnnaiSummary.PreviousAmount__c = dPreviousAmount;

        
        
        if (idCurrentYear == null && idPreviousYear == null) {
        

            MultipleAnnaiSummary.ContractNo__c = String.join(lsContractNo, '\r\n');
            MultipleAnnaiSummary.ContractNoPrint__c = MultipleAnnaiSummary.ContractNo__c;

            MultipleAnnaiSummary.UnitBody__c = String.join(lsUnitBody, '\r\n');
            MultipleAnnaiSummary.UnitBodyPrint__c = MultipleAnnaiSummary.UnitBody__c;

            if (aPipelineResponsible1 != null) {
                MultipleAnnaiSummary.JEOLPipelineResponsiblePrint__c = aPipelineResponsible1.Id;
            }
            if (aPipelineResponsible2 != null) {
                MultipleAnnaiSummary.JEOLPipelineResponsible2Print__c = aPipelineResponsible2.Id;
            }

            MultipleAnnaiSummary.JEOLRegionNamePrint__c = sRegionName;
            MultipleAnnaiSummary.JOELReplyRegionNamePrint__c = sReplyRegionName;
            MultipleAnnaiSummary.JEOLContactPositionPrint__c = sContactPosition;
            MultipleAnnaiSummary.JEOLReplyContactPositionPrint__c = sReplyContactPosition;
            MultipleAnnaiSummary.RenewalContactTelPrint__c = renewalContactTel;
            MultipleAnnaiSummary.RenewalContactFaxPrint__c = renewalContactFax;

            MultipleAnnaiSummary.MaintenancePeriod__c = String.join(lsMaintenancePeriod, '\r\n');
            MultipleAnnaiSummary.MaintenancePeriodPrint__c = MultipleAnnaiSummary.MaintenancePeriod__c;

            MultipleAnnaiSummary.RenewalQuotationNumber__c = String.join(lsQuotation, '\r\n');

            MultipleAnnaiSummary.RenewalCompanyNamePrint__c = renewalCompanyName;
            MultipleAnnaiSummary.RenewalAddressPostalCodePrint__c = renewalPostalCode;
            MultipleAnnaiSummary.RenewalUndergraduatePrint__c = renewalUndergraduate;
            MultipleAnnaiSummary.RenewalAddressLine1Print__c = renewalAddressLine1;
            MultipleAnnaiSummary.RenewalContactPositionPrint__c = renewalContactPosition;
            MultipleAnnaiSummary.RenewalAddressLine2Print__c = renewalAddressLine2;
            MultipleAnnaiSummary.RenewalTantoshyaPrint__c = renewalTantoshya;

            MultipleAnnaiSummary.RenewalDeliveryLocationPrint__c = String.join(lsRenewalDeliveryLocation, '\r\n');

            MultipleAnnaiSummary.ItemName__c = String.join(lsItemName, '\r\n');
            MultipleAnnaiSummary.ItemNamePrint__c = MultipleAnnaiSummary.ItemName__c;

            MultipleAnnaiSummary.RenewalOptionCustomerNameLabel__c  = renewalOptionCustomerNameLabel;
            MultipleAnnaiSummary.RenewalCustomerNameReply__c = renewalCustomerNameReply;
            MultipleAnnaiSummary.RenewalTopSectionText__c = renewalTopSectionText;
            MultipleAnnaiSummary.RenewalFooterComment__c = renewalFooterComment;
            MultipleAnnaiSummary.RenewalOptionDateFormat__c = renewalOptionDateFormat;
            MultipleAnnaiSummary.RenewalOptionHideChangeInfo__c = renewalOptionHideChangeInfo;
            MultipleAnnaiSummary.AnnaiType__c = renewalAnnaiType;
            MultipleAnnaiSummary.RenewalPrintDate__c = renewalPrintDate;            
    
            saveRenewalListOptions();

        } else {
            // Deal with the renewal optons
            lsOptions = new List<MaintenanceAnnaiOptions__c>();
            addToRenewalListOption(MultipleAnnaiSummary.RenewalListOptions__c);
            addToRenewalListOptionOther();
            
            if (idCurrentYear == null) {
                // Some fields have to be updated for previous year PL
                MultipleAnnaiSummary.ContractNo__c = String.join(lsContractNo, '\r\n');
                MultipleAnnaiSummary.ContractNoPrint__c = MultipleAnnaiSummary.ContractNo__c;
        
                //Formats the date to Western-style (MM/dd/YY) if MultipleAnnaiSummary.RenewalOptionDateFormat__c = 2, else keeps them in Jp-style
                for (MaintenanceContractManagement__c row : lsResult) {
                    if (row.PreviousYearOrder__c != null && row.PreviousYearOrder__r.MaintenanceEndDateFormula__c != null &&
                        row.PreviousYearOrder__r.MaintenanceStartDateFormula__c != null) {
                        String periodValue = (MultipleAnnaiSummary.RenewalOptionDateFormat__c == '2') 
                                            ? 
                                            (getDateFormat(row.PreviousYearOrder__r.MaintenanceStartDateFormula__c, false, false)
                                                + ' ~ ' + 
                                            getDateFormat(row.PreviousYearOrder__r.MaintenanceEndDateFormula__c, false, false))
                                            : 
                                            (getDateFormat(row.PreviousYearOrder__r.MaintenanceStartDateFormula__c, true, false)
                                                + ' より ' +
                                            getDateFormat(row.PreviousYearOrder__r.MaintenanceEndDateFormula__c, true, false)
                                                + ' まで');
                        addUniqueValueToTheList(periodValue, lsMaintenancePeriod);
                    }
                }
                MultipleAnnaiSummary.MaintenancePeriod__c = String.join(lsMaintenancePeriod, '\r\n');
                MultipleAnnaiSummary.MaintenancePeriodPrint__c = MultipleAnnaiSummary.MaintenancePeriod__c;

                MultipleAnnaiSummary.RenewalQuotationNumber__c = String.join(lsQuotation, '\r\n');
                MultipleAnnaiSummary.RenewalPrintDate__c = renewalPrintDate;                            
                    
            }
        }
        
        setStandardSetController();
    }

    //adds the String value to the list, if the value is not empty or not already present in the list
    private void addUniqueValueToTheList(String value, List<String> ls){
        if (!String.isEmpty(value)) {
                boolean fExist = false;
                if (ls != null && ls.size() > 0) {
                    for (String ss : ls) {
                        if (ss == value) {
                            fExist = true;
                            break;
                        }
                    }                    
                }
                if (!fExist) {
                    ls.add(value);
                }
            }
    }

   protected override void setStandardSetController() {
        
        String soql = ' SELECT ' +
                      ' id, Name, NewOdrSalesAccount__c, NewOdrSalesAccount__r.name, NewOdrSalesAccount__r.Code__c, NewOdrShipmentAccount__c, NewOdrShipmentAccount__r.Code__c, NewContractStartDate__c, NewContractEndDate__c, NewContractAmount__c, ' +
                      ' PreviousYearOrder__c, PreviousYearOrder__r.ShipmentAccountCode__c, PreviousYearOrder__r.ShipmentAccount__c, PreviousYearOrder__r.SalesAccountCode__c, ' +
                      ' PreviousYearOrder__r.SalesAccount__c ' +
                      ' FROM MaintenanceContractManagement__c ' +
                      ' WHERE id in :lsId';

        soql += ' ORDER BY ' + this.orderBy;
        if (this.orderDesc) {
            soql += ' DESC NULLS LAST';
        }
        
        soql += ' LIMIT 10000 ';
        ssc = new ApexPages.StandardSetController(Database.getQueryLocator(soql));

        if (this.errFlg) {
            ssc = null;
        } else if (ssc.getResultSize() >= 10000 ) {
            ssc = null;
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, '検索結果が１万件を超えました。検索条件を増やし、再度検索してください。'));
        } else {
            ssc.setPageSize(pageSize);
            ssc.setPageNumber(pageNo);
        }
           
    }
    
        
    
    /*  検索結果の設定　*/
    public class rowWrapper{
        public MaintenanceContractManagement__c rec {get; set;}
        public Integer rowNumber {get; set;}
        
        public rowWrapper(MaintenanceContractManagement__c rec, Integer rowNumber) {
            this.rec = rec;
            this.rowNumber = rowNumber;
        }
    }

    /*  検索結果の取得   */
    public List<rowWrapper> getSalesPipelines() {
        rows = new List<rowWrapper>();
        Integer currentCount = 0;
        
        if(ssc != null) {
            for (MaintenanceContractManagement__c row: (List<MaintenanceContractManagement__c>)ssc.getRecords()) {
                rowWrapper orderPlan = new rowWrapper(row, currentCount);
                rows.add(orderPlan);
                currentCount++;
            }
        }
        
        return rows;
    }

    public void PrintSogoAnnai1() {
        System.debug('Entering PrintSogoAnnai1: ');

/*        // FIRSTLY, DELETE THE OLD DATA OF THIS TEMPORARY TABLE
        List< MaintenanceMultipleAnnai__c > recsToDelete = [
            SELECT
                id
            FROM
                MaintenanceMultipleAnnai__c
            WHERE
                CreatedDate < LAST_N_DAYS:7
        ]; 
*/
        try{       
//            delete recsToDelete;
            saveRenewalListOptions(); //saves the current RenewalListOptions__c before upserting
            upsert MultipleAnnaiSummary;
        }
        catch(DmlException e){
            System.debug('e: ' + e);
        }
    }
    
    public void PrintSogoAnnai2() {

        Pagereference ref = this.getPrintUrl();
        Blob pdfData;
        if (!Test.IsRunningTest()) {
            pdfData = ref.getContent();
        } else {
            pdfData = Blob.valueOf('UNIT.TEST');
        }        
        
        List<Attachment> lsAttach = new List<Attachment>();

        For (id idid : lsId) {
        
            Attachment attachRec = new Attachment();
            attachRec.parentId = idid;
            attachRec.name = Label.JEOL_MaintMultGuid_Label_MultipleAnnaiPDFName + '.pdf';
            attachRec.body = pdfData;
            lsAttach.add(attachRec);
        }
        
        upsert lsAttach;
    }

    public Pagereference getPrintUrl() {

        Pagereference ret;
        
        if (MultipleAnnaiSummary.AnnaiType__c != null && MultipleAnnaiSummary.AnnaiType__c.length() > 0) {
            String annaiTypeValue = MultipleAnnaiSummary.AnnaiType__c.replace(' ', '_');
            If(annaiTypeValue == '2Pages') annaiTypeValue = '1Page'; //As URL for 1Page and 2Pages is same
            ret = new PageReference('/apex/JEOL_MaintenanceAnnaiPrintPage_MP_' + annaiTypeValue);
        } else {
            String defaultVal = '';
            for (Schema.PicklistEntry pv: MaintenanceMultipleAnnai__c.AnnaiType__c.getDescribe().getPicklistValues()) {
                if (pv.isDefaultValue()) {
                    defaultVal = pv.getValue();
                }    
            }
            ret = new PageReference('/apex/JEOL_MaintenanceAnnaiPrintPage_MP_' + defaultVal.replace(' ', '_'));                    
        }

        Map<String, String> params = ret.getParameters();
        params.put(PARAM_ID, MultipleAnnaiSummary.ListIdLong__c);
        params.put('test', MultipleAnnaiSummary.AnnaiType__c);
        params.put('print', 'true');
        return ret;
    }
    
    public boolean getHidePicklistAnnai() {
        return (MaintenanceMultipleAnnai__c.AnnaiType__c.getDescribe().getPicklistValues().size() <= 1);
    }
    
    public PageReference changeOrder2() {
    
        changeOrder();

        if (fProblemAccount) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintMultGuid_Message_DifferentAccountError));
        } else if (fWarningAccount) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, Label.JEOL_MaintMultGuid_Message_DifferentAccount));
        }
        if (fProblemStartDate) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintMultGuid_Message_DifferentStartDate));
        }
        if (fProblemEndDate) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.JEOL_MaintMultGuid_Message_DifferentEndDate));
        }
        
        return null;
    
    }

    //for Renewal List Options
    private void addToRenewalListOption(String renewalListOptions){
        // Get the options possible
        //lsOptions = new List<MaintenanceAnnaiOptions__c>();
        List<String> parts = new List<String>() ;
        if (renewalListOptions != null && renewalListOptions.length() > 0) {
            parts = renewalListOptions.split('\n');
        }
        if (parts != null && parts.size() > 0) {
            for (String partrow : parts) {
            
                boolean fAlreadyExists = false;
                
                if (lsOptions != null && lsOptions.size() > 0) {
                    for (MaintenanceAnnaiOptions__c opt : lsOptions) {
                        if (opt.Label__c == partrow) {
                            fAlreadyExists = true;
                            break;
                        }
                    }
                }
                
                if (!fAlreadyExists) {            
                    MaintenanceAnnaiOptions__c newopt = new MaintenanceAnnaiOptions__c();
                    newopt.Label__c = partrow;
                    newopt.TechnicalAlwaysFalse__c = true;
                    lsOptions.add(newopt);
                }
            }
        }

    }


    //for Renewal List Options
    private void addToRenewalListOptionOther(){

        //Add more options from the table
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
    }


    private void saveRenewalListOptions(){
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
        MultipleAnnaiSummary.RenewalListOptions__c = sListOptions;
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
    //

    private String getDateFormat(Date value, boolean isJapaneseEraOutput, boolean addSpace) {

        String year = '　　';
        String month = '　　';
        String day = '　　';

        if (value != NULL) {
            if (isJapaneseEraOutput) {
                Map<String, String> eraData = JEOLUtil.getJapaneseEraData(value);
                if (eraData.containsKey('name') && eraData.containsKey('year')) {
                    year = eraData.get('name') + (addSpace ? '　' : ' ') + eraData.get('year');
                } else {
                    year = String.valueOf(value.year());
                }
            } else {
                year = String.valueOf(value.year());
            }
            month = String.valueOf(value.month());
            if (month.length() < 2) {
                month = ' ' + month;
            }
            day = String.valueOf(value.day());
            if (day.length() < 2) {
                day = ' ' + day;
            }
        }

        if (UserInfo.getLanguage() != 'ja') {
            return year + (addSpace ? ' ' : '') + '/' + (addSpace ? ' ' : '') + month + (addSpace ? ' ' : '') + '/' + (addSpace ? ' ' : '') + day;
        } else {
            return year + '年' + (addSpace ? '　' : '') + month + '月' + (addSpace ? '　' : '') + day + '日';
        }
    }

}