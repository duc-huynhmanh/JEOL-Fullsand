/*
 * Created : 2015/10/06 by Polus (Voxer)
 */
public with sharing class JEOL_MaintenanceSogoAnnaiPrintPageCtrl {

    public String sDate{get; set;}
    public Date sDateEndPreviousContract{get; set;}
    //public String sJeolCompanyName{get; set;}
    
    public List<String> lsAccount{get; set;}
    public List<String> lsItemName{get; set;}
    //public List<String> lsRenewalAccountName{get; set;}
    public List<String> lsUnitBody{get; set;}
    public List<String> lsContractNo{get; set;}
    public List<String> lsMaintenancePeriod{get; set;}
    public List<String> lsItemNameWithUnitBody{get; set;}
    public List<String> lsRenewalDeliveryLocation {get; set;}
    public List<String> lsQuotation{get; set;}

    public String outputType{get; set;}
    public String renderTarget{get; set;}

    public MaintenanceMultipleAnnai__c rec{get; set;}
    
    public static final Integer MAX_LINE_SIZE_FIRST = 22;
    public static final Integer MAX_LINE_SIZE = 42;
    public static final Integer BASE_TEXT_LENGTH = 17;

    public JEOL_MaintenanceSogoAnnaiPrintPageCtrl() {
    
        sDate = '平成　　年　　月　　日';
        //sDateEndPreviousContract = '平成27年3月31日';
        //sJeolCompanyName = '日本電子株式会社';
        
        Map<String, String> params = Apexpages.currentPage().getParameters();
        String recId = params.get('id');

        rec = getTargetRecord(recId);
        if(rec.EndDate__c != null)
            sDateEndPreviousContract = rec.EndDate__c.addDays(-1);
        //System.debug('rec.EndDate__c: ' + rec.EndDate__c);
            
        outputType = 'print';
        if (params.containsKey('preview') && String.isNotBlank(params.get('preview'))) {
            outputType = 'preview';
        }
        if (params.containsKey('print') && String.isNotBlank(params.get('print'))) {
            outputType = 'print';
        }
        if (outputType == 'print') {
            renderTarget = 'pdf';
        }
        createDetail(recId);
    }
    
    private void createDetail(String targetId) {
    
        integer iCurrentPageNo = 1;

        MaintenanceMultipleAnnai__c targetRec = getTargetRecord(targetId);
        
        lsAccount = new List<String>();
        if (targetRec.AccountPrint__c != null) {
            lsAccount = targetRec.AccountPrint__c.split('\n');
        } else {
            lsAccount.add('');
        }

        lsItemName = new List<String>();
        if (targetRec.ItemNamePrint__c != null) {
            lsItemName = targetRec.ItemNamePrint__c.split('\n');
        } else {
            lsItemName.add('');
        }

        lsUnitBody = new List<String>();
        if (targetRec.UnitBodyPrint__c != null) {
            lsUnitBody = targetRec.UnitBodyPrint__c.split('\n');
        } else {
            lsUnitBody.add('');
        }

        lsContractNo = new List<String>();
        if (targetRec.ContractNoPrint__c != null) {
            lsContractNo = targetRec.ContractNoPrint__c.split('\n');
        } else {
            lsContractNo.add('');
        }

        lsMaintenancePeriod = new List<String>();
        if (targetRec.MaintenancePeriodPrint__c != null) {
            lsMaintenancePeriod = targetRec.MaintenancePeriodPrint__c.split('\n');
        } else {
            lsMaintenancePeriod.add('');
        }

        lsItemNameWithUnitBody = new List<String>();
        if (targetRec.RenewalItemsNameUnitBodyPrint__c != null) {
            lsItemNameWithUnitBody = targetRec.RenewalItemsNameUnitBodyPrint__c.split('\n');
        } else {
            lsItemNameWithUnitBody.add('');
        }

        lsRenewalDeliveryLocation = new List<String>();
        if (targetRec.RenewalDeliveryLocationPrint__c != null) {
            lsRenewalDeliveryLocation = targetRec.RenewalDeliveryLocationPrint__c.split('\n');
        } else {
            lsRenewalDeliveryLocation.add('');
        }

        lsQuotation = new List<String>();
        if (targetRec.RenewalQuotationNumber__c != null) {
            lsQuotation = targetRec.RenewalQuotationNumber__c.split('\n');
        }
    }
    
    
    private MaintenanceMultipleAnnai__c getTargetRecord(String targetId) {
    
        MaintenanceMultipleAnnai__c targetaRecord = null;
        List< MaintenanceMultipleAnnai__c > recs = [
            SELECT
                id, name, UnitBody__c, RenewalPrintDate__c, MaintenancePeriodPrint__c, AccountPrint__c, ItemNamePrint__c, CurrencyIsoCode, 
                UnitBodyPrint__c , ContractNoPrint__c , LastModifiedDate, CreatedDate, Account__c, ListIdLong__c, 
                PreviousAmount__c, Amount__c, EndDate__c, RenewalAddressLine1Print__c,RenewalAddressLine2Print__c,
                RenewalAddressPostalCodePrint__c,JEOLRegionNamePrint__c, JEOLContactPositionPrint__c, JOELReplyRegionNamePrint__c,
                JEOLPipelineResponsiblePrint__r.LastName, JEOLPipelineResponsible2Print__r.LastName,
                JEOLReplyContactPositionPrint__c, RenewalAccountNamePrint__c, RenewalTantoshyaPrint__c, UndergraduatePrint__c,
                RenewalContactPositionPrint__c, RenewalTopSectionText__c, RenewalListOptions__c, RenewalCustomerNameReply__c, 
                RenewalOptionCustomerNameLabel__c, RenewalOptionHideChangeInfo__c,RenewalFooterComment__c, RenewalOptionDateFormat__c,
                RenewalUndergraduatePrint__c, RenewalContactTelPrint__c, RenewalContactFaxPrint__c,RenewalItemsNameUnitBodyPrint__c,
                RenewalDeliveryLocationPrint__c,RenewalCompanyNamePrint__c, AnnaiType__c, StartDate__c, RenewalQuotationNumber__c
            FROM
                MaintenanceMultipleAnnai__c
            WHERE
                ListId__c =: targetId.left(255)
            ORDER BY 
                CreatedDate desc
        ];
        
        boolean fFound = false;
        for (MaintenanceMultipleAnnai__c rec : recs) {
            if (rec.ListIdLong__c == targetId) {
                targetaRecord = rec;
                fFound = true;
                break;        
            }
        }
        
        if (!fFound) {
            throw new JEOLException('不正な操作が行われました。');
        }
        return targetaRecord;
    }

    public String getTodayDate() {
        String returnDate = '';
        returnDate = this.getDateFormat(System.today(), rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        return returnDate;
    }

    public String getPrintDate() {
        String returnDate = '';
        returnDate = this.getDateFormat(rec.RenewalPrintDate__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        return returnDate;
    }

    public String getStartDate() {
        String returnDate = '';
        if (rec.StartDate__c != null) {
            returnDate = this.getDateFormat(rec.StartDate__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        }
        return returnDate;
    }

    public String getEndDate() {
        String returnDate = '';
        if (rec.EndDate__c != null) {
            returnDate = this.getDateFormat(rec.EndDate__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        }
        return returnDate;
    }

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