/*
 * Created : 2015/10/06 by Polus (Voxer)
 */
public with sharing class JEOL_MaintenanceAnnaiPrintPageCtrl {
    
    public List<PageBlock> pdfPages{get; set;}
    public String outputType{get; set;}
    public String renderTarget{get; set;}
    //
    public MaintenanceContractManagement__c rec {get;set;}
    public SalesOrder__c prevSalesOrder {get; set;}
    public Account renewalAccount {get; set;}

    public String blankDate {get;set;}
    //
    
    public static final Integer MAX_LINE_SIZE_FIRST = 22;
    public static final Integer MAX_LINE_SIZE = 42;
    public static final Integer BASE_TEXT_LENGTH = 17;

    public JEOL_MaintenanceAnnaiPrintPageCtrl() {
        Map<String, String> params = Apexpages.currentPage().getParameters();
        String recId = params.get('id');
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
        rec = getTargetRecord(recId);
        prevSalesOrder = getPrevYearSalesOrder(rec);
        renewalAccount = getRenewalAccountForRec(rec);
        this.pdfPages = createPdfPages(rec);
        blankDate = '平成 　年 　月　　日';
    }

    private Account getRenewalAccountForRec(MaintenanceContractManagement__c targetRec){
        List<Account> ras = [
                SELECT
                        Id, Name, PostalCode__c, Undergraduate__c
                        FROM
                                Account
                        WHERE
                                Id =: targetRec.RenewalAccount__c
                ];

                if(ras.size() == 1){
                        system.debug('ras[0]: ' + ras[0]);
                        return ras[0];
                }
                else
                        return null;
    }

      private SalesOrder__c getPrevYearSalesOrder(MaintenanceContractManagement__c targetRec){
                List<SalesOrder__c> sos = [
                        SELECT 
                                Id, Name, ItemName__c, MaintenanceStartDateFormula__c, MaintenanceEndDateFormula__c, 
                                MaintenancePeriod__c,ConsumptionTax__c, UnitBody__c
                        FROM 
                                SalesOrder__c 
                        WHERE 
                                Id =: targetRec.PreviousYearOrder__c
                ];

        if(sos.size() == 1)
            return sos[0];
        else return null;
    }
    
    private List<PageBlock> createPdfPages(MaintenanceContractManagement__c targetRec) {
    
        integer iCurrentPageNo = 1;
        List<PageBlock> pdfPages = new List<PageBlock>();

        PageBlock headerPage = new PageBlock();
        headerPage.isFirst = true;
        QuotationHeader head = new QuotationHeader(targetRec);
        headerPage.setHead(head);

        Integer totalLineSize = 0;
        PageBlock page = headerPage;
        totalLineSize += page.getQuotatinNameLinesSize();
        pdfPages.add(page);
        
        // Section with line items
        Integer lineBodySize = BASE_TEXT_LENGTH;
        Integer countLineSize = 0;
                
        System.debug('pdfPages: ' + pdfPages);
        return pdfPages;
    }
    
    private MaintenanceContractManagement__c getTargetRecord(String targetId) {
        MaintenanceContractManagement__c targetaRecord = null;
        List< MaintenanceContractManagement__c > recs = [
            SELECT
                id, name, CurrencyIsoCode, LastModifiedDate, CreatedDate, PreviousYearOrder__c, RenewalAccount__c, UnitBody__c, RenewalPrintDate__c,
                NewContractStartDate__c, NewContractEndDate__c, NewContractAmount__c, RenewalTantoshya__c, JEOLContactTel__c, 
                JEOLReplyContactFax__c, NewOdrRegion__c,NewOdrSalesTantoshya__c,NewOdrSalesContactPosition__c,NewOdrSalesContactTel__c,
                NewOdrSalesContactFax__c, UnitBody__r.UnitBody__c,
                JeolPipelineResponsible__c,JeolPipelineResponsible__r.Name, JeolPipelineResponsible__r.Phone, JeolPipelineResponsible__r.Fax,JeolPipelineResponsible__r.Email,
                JeolPipelineResponsible2__c, JeolPipelineResponsible2__r.Name, JeolPipelineResponsible2__r.Phone, JeolPipelineResponsible2__r.Fax, JeolPipelineResponsible2__r.Email,
                RenewalAddress__c, RenewalAddress2__c,RenewalPostalCode__c,
                JEOLRegionName__c,JEOLContactPosition__c,JEOLReplyRegionName__c,JEOLReplyContactPosition__c, RenewalContactPosition__c, RenewalQuotation__r.QuoteNo__c, RenewalQuotation__r.BranchNo__c,
                RenewalOptionDateFormat__c, RenewalCompanyName__c, RenewalUndergraduate__c,RenewalTopSectionText__c,RenewalDeliveryLocation__c,
                RenewalItemsName__c, JeolPipelineResponsible__r.LastName, JeolPipelineResponsible2__r.LastName, RenewalOptionCustomerNameLabel__c,
                RenewalCustomerNameReply__c,RenewalFooterComment__c,RenewalListOptions__c,RenewalOptionHideChangeInfo__c,AnnaiType__c
            FROM
                MaintenanceContractManagement__c
            WHERE
                Id =: targetId
        ];
        if (recs != null && recs.size() > 0) {
            targetaRecord = recs.get(0);
            
        } else {
            throw new JEOLException('不正な操作が行われました。');
        }
        return targetaRecord;
    }


    public class PageBlock {
        public Boolean isFirst{get; set;}
        public Boolean isLast{get; set;}
        public Boolean isShowTotal{get; set;}
        public Boolean isAccompanyingPaper{get; set;}
        public Boolean isShowNote{get; set;}
        public Boolean isShowNoteLabel{get; set;}
        public QuotationHeader head{get; set;}
        public List<String> quotatinNameLines{get; set;}
        public List<String> noteTextLines{get; set;}
        public Integer pageNo{get; set;}
        
        public PageBlock() {
            this.isFirst = false;
            this.isLast = false;
            this.isShowTotal = false;
            this.isAccompanyingPaper = false;
            this.isShowNote = false;
            this.isShowNoteLabel = false;
            this.head = null;
            this.pageNo = 1;
        }
        public void setHead(QuotationHeader head) {
            this.head = head;
            this.noteTextLines = head.noteTextLines;
            this.quotatinNameLines = head.quotatinNameLines;
        }
        public Integer getNoteTextLineSize() {
            return this.noteTextLines.size();
        }
        public Integer getQuotatinNameLinesSize() {
            return this.quotatinNameLines.size();
        }
        public Boolean getHasNoteText() {
            return (this.noteTextLines != NULL && this.noteTextLines.size() > 0);
        }

    }
    public class QuotationHeader {
        Public String CompanyAddress{get; set;}
        public MaintenanceContractManagement__c rec{get; set;}
        public List<String> quotatinNameLines{get; set;}
        public List<String> noteTextLines{get; set;}
        public List<String> otherTextLines{get; set;}
        
        public QuotationHeader(MaintenanceContractManagement__c quotation) {
            this.rec = quotation;
            
                // Just create a data with 1 line and a dummy data
                this.quotatinNameLines =  new List<String>();
                this.quotatinNameLines.add('DUMMY');
            
            this.CompanyAddress = '';   
        }
    }


    public Integer getPageSize() {
        Integer pageSize = 0;
        if (this.pdfPages != null) {
            pageSize = this.pdfPages.size();
        }
        return pageSize;
    }

    public String getPrintDate() {
        String returnDate = '';
        returnDate = this.getDateFormat(rec.RenewalPrintDate__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        return returnDate;
    }

    public String getNewContractStartDate() {
        String returnDate = '';
        if (rec.NewContractStartDate__c != null) {
            returnDate = this.getDateFormat(rec.NewContractStartDate__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        }
        return returnDate;
    }

    public String getNewContractEndDate() {
        String returnDate = '';
        if (rec.NewContractEndDate__c != null) {
            returnDate = this.getDateFormat(rec.NewContractEndDate__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        }
        return returnDate;
    }

    public String getMaintenanceStartDateFormula() {
        String returnDate = '';
        if (prevSalesOrder.MaintenanceStartDateFormula__c != null) {
            returnDate = this.getDateFormat(prevSalesOrder.MaintenanceStartDateFormula__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
        }
        return returnDate;
    }

    public String getMaintenanceEndDateFormula() {
        String returnDate = '';
        if (prevSalesOrder.MaintenanceEndDateFormula__c != null) {
            returnDate = this.getDateFormat(prevSalesOrder.MaintenanceEndDateFormula__c, rec.RenewalOptionDateFormat__c == null || rec.RenewalOptionDateFormat__c != '2', false);
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