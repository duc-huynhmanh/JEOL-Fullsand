public with sharing class JEOL_MaintenanceAccountBookCtrl {

    public static final String LABEL_ITEM_DEFAULT_TYPE1 = '本体保守売上';
    public static final String LABEL_ITEM_DEFAULT_TYPE2 = '本体保守売上';
    public static final String LABEL_ITEM_DEFAULT_TYPE3 = 'ATT保守売上';
    public static final String LABEL_ITEM_DEFAULT_TYPE4 = 'ヘリウム充填保守売上';

    public static final String ACCOUNTBOOK_HONTAI_INSPEC = '1';
    public static final String ACCOUNTBOOK_HONTAI_NO_INSPEC = '2';
    public static final String ACCOUNTBOOK_HONTAI_ATTACH = '3';
    public static final String ACCOUNTBOOK_HONTAI_HELIUM = '4';

    public String sType{get; set;}
    private String TaxCodeDefaultValue = null;
    
    public Decimal dAmountOtherAccountBook{get; set;}
    public Decimal dAmountCurrentAccountBookSalesReturn{get; set;}

    public MaintenanceContractManagement__c so{get; set;}

    public List<MaintenanceAccountBook__c> lsAccountBookRow {get; set;}
    
    public String firstMonth {get; set;}
 
    public JEOL_MaintenanceAccountBookCtrl(ApexPages.StandardController ctrl) {

        for (Schema.PicklistEntry pv : MaintenanceAccountBook__c.TaxCode__c.getDescribe().getPicklistValues()) {
            if (pv.isDefaultValue()) {
                TaxCodeDefaultValue = pv.getValue();
            }    
        }
        
        sType = Apexpages.currentPage().getParameters().get('type');
        if (sType != ACCOUNTBOOK_HONTAI_INSPEC && sType != ACCOUNTBOOK_HONTAI_NO_INSPEC && sType != ACCOUNTBOOK_HONTAI_ATTACH && sType != ACCOUNTBOOK_HONTAI_HELIUM) {
            sType = ACCOUNTBOOK_HONTAI_INSPEC;
        }
        List<String> fields = new List<String>();
        fields.add('NewOdrMaintenanceStartDate__c');
        fields.add('NewOdrMaintenanceEndDate__c');
        fields.add('PreviousYearPipeline__c');
        fields.add('BillingMethodHontai__c');
        fields.add('BillingMethodHelium__c');
        fields.add('SubAmountHontaiNoInspec__c');
        fields.add('SubAmountHelium__c');
        fields.add('NewOdrContractAmountt__c');

        if (!Test.isRunningTest()) { 
            ctrl.addFields(fields);
        }
        
        this.so = (MaintenanceContractManagement__c) ctrl.getRecord();
        lsAccountBookRow = [select id, SalesReturn__c, AlreadyBilled__c, Name, Inspection__c, InspectionDone__c, MaintenanceContractManagement__c, Month__c, BillingDone__c, BillingAmountEstimate__c, SalesAmountEstimate__c, SalesAmountReal__c, SalesAuto__c, InvoiceNumber__c, InvoiceNumberAuto__c, TaxCode__c, ItemName__c from MaintenanceAccountBook__c where MaintenanceContractManagement__c = :so.Id and Type__c = :sType order by Month__c asc, SalesReturn__c asc];

        dAmountCurrentAccountBookSalesReturn = 0;
        for (MaintenanceAccountBook__c ab : lsAccountBookRow) {
            dAmountCurrentAccountBookSalesReturn += (ab.SalesReturn__c ? (ab.SalesAmountReal__c != null ? ab.SalesAmountReal__c : 0) : 0);
        }            

        // Get the amount of other account books
        dAmountOtherAccountBook = 0;
        List<MaintenanceAccountBook__c> lsAB = [SELECT id, SalesReturn__c, SalesAmountEstimate__c, SalesAmountReal__c from MaintenanceAccountBook__c where MaintenanceContractManagement__c = :so.Id and Type__c != :sType];
        for (MaintenanceAccountBook__c ab : lsAB) {
            dAmountOtherAccountBook += (ab.SalesReturn__c ? (ab.SalesAmountReal__c != null ? ab.SalesAmountReal__c : 0) : (ab.SalesAmountEstimate__c != null ? ab.SalesAmountEstimate__c : 0));
        }            

        // Check if there is some data entered
        boolean fExistData = false;
        for (MaintenanceAccountBook__c row : lsAccountBookRow) {
            if (row.BillingDone__c || row.BillingAmountEstimate__c != null || row.SalesAmountEstimate__c != null || row.SalesAmountReal__c != null || row.Inspection__c || row.InspectionDone__c
                 || (row.SalesAuto__c && sType != ACCOUNTBOOK_HONTAI_NO_INSPEC && sType != ACCOUNTBOOK_HONTAI_HELIUM) || (!row.SalesAuto__c && (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC || sType == ACCOUNTBOOK_HONTAI_HELIUM))
                 || row.InvoiceNumber__c != null
                 || row.InvoiceNumberAuto__c != null
                 || row.TaxCode__c != TaxCodeDefaultValue
                 || (row.ItemName__c != (LABEL_ITEM_DEFAULT_TYPE1  + '（' + row.Name + '）') && sType == ACCOUNTBOOK_HONTAI_INSPEC) || (row.ItemName__c != (LABEL_ITEM_DEFAULT_TYPE2  + '（' + row.Name + '）') && sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) || (row.ItemName__c != (LABEL_ITEM_DEFAULT_TYPE3  + '（' + row.Name + '）') && sType == ACCOUNTBOOK_HONTAI_ATTACH) || (row.ItemName__c != (LABEL_ITEM_DEFAULT_TYPE4  + '（' + row.Name + '）') && sType == ACCOUNTBOOK_HONTAI_HELIUM) 
               ) {
                fExistData = true;
                break;
            }
        }

        if (!fExistData) {
            lsAccountBookRow = new List<MaintenanceAccountBook__c>();
        }

        // In case of the first call, create the rows from StartDate to EndDate
        if (lsAccountBookRow.size() == 0) {
        
            String sStartMonth;
            String sEndMonth;
            
            if (so.NewOdrMaintenanceStartDate__c != null && so.NewOdrMaintenanceEndDate__c != null) {
                if (so.NewOdrMaintenanceEndDate__c >= so.NewOdrMaintenanceStartDate__c) {
                    sStartMonth = datetime.newInstance(so.NewOdrMaintenanceStartDate__c, Time.newInstance(0,0,0,0)).format('yyyyMM');
                    sEndMonth = datetime.newInstance(so.NewOdrMaintenanceEndDate__c, Time.newInstance(0,0,0,0)).format('yyyyMM');
                } else {
                    sEndMonth = datetime.newInstance(so.NewOdrMaintenanceStartDate__c, Time.newInstance(0,0,0,0)).format('yyyyMM');
                    sStartMonth = datetime.newInstance(so.NewOdrMaintenanceEndDate__c, Time.newInstance(0,0,0,0)).format('yyyyMM');
                }
            } else if (so.NewOdrMaintenanceStartDate__c != null) {
                sStartMonth = datetime.newInstance(so.NewOdrMaintenanceStartDate__c, Time.newInstance(0,0,0,0)).format('yyyyMM');
                sEndMonth = sStartMonth;
            } else if (so.NewOdrMaintenanceEndDate__c != null) {
                sStartMonth = datetime.newInstance(so.NewOdrMaintenanceEndDate__c, Time.newInstance(0,0,0,0)).format('yyyyMM');
                sEndMonth = sStartMonth;
            } else {
                sStartMonth = datetime.newInstance(date.today(), Time.newInstance(0,0,0,0)).format('yyyyMM');
                sEndMonth = sStartMonth;
            }
            
            integer iStartYear = Integer.valueOf(sStartMonth.substring(0, 4));
            integer iStartMonth = Integer.valueOf(sStartMonth.substring(4));
            integer iEndYear = Integer.valueOf(sEndMonth.substring(0, 4));
            integer iEndMonth = Integer.valueOf(sEndMonth.substring(4));
            
            if (iEndYear > iStartYear + 10) {
                iEndYear = iStartYear;
                iEndMonth = iStartMonth;
            }

            firstMonth = sStartMonth;
            
            while ((iStartYear < iEndYear) || (iStartYear == iEndYear && iStartMonth <= iEndMonth)) {
                
                // Create a row
                MaintenanceAccountBook__c maintRow = new MaintenanceAccountBook__c();
                maintRow.Type__c = sType;
                maintRow.MaintenanceContractManagement__c = so.id;
                maintRow.Month__c = ('0000' + string.valueof(iStartYear)).substring(string.valueof(iStartYear).length()) + ('00' + string.valueof(iStartMonth)).substring(string.valueof(iStartMonth).length());
                maintRow.Name = maintRow.Month__c.Substring(0, 4) + '/' + maintRow.Month__c.Substring(4);
                if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
                    maintRow.MaintenanceContractManagement4__c = maintRow.MaintenanceContractManagement__c;
                    maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE4 + '（' + maintRow.Name + '）';
                } else if (sType == ACCOUNTBOOK_HONTAI_ATTACH) {
                    maintRow.MaintenanceContractManagement3__c = maintRow.MaintenanceContractManagement__c;
                    maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE3 + '（' + maintRow.Name + '）';
                } else if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
                    maintRow.MaintenanceContractManagement2__c = maintRow.MaintenanceContractManagement__c;
                    maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE2 + '（' + maintRow.Name + '）';
                } else {
                    maintRow.MaintenanceContractManagement1__c = maintRow.MaintenanceContractManagement__c;
                    maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE1 + '（' + maintRow.Name + '）';
                }

                if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC || sType == ACCOUNTBOOK_HONTAI_HELIUM) {
                    maintRow.SalesAuto__c = true;
                }
                
                lsAccountBookRow.add(maintRow);
                
                // Get the next month
                iStartMonth += 1;
                if (iStartMonth > 12) {
                    iStartYear += 1;
                    iStartMonth = 1;
                }
            }
        
        }

    }

    public PageReference save(){

        try {

            // Check if the amount is correct (case proportionnal)
    
            if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC || sType == ACCOUNTBOOK_HONTAI_HELIUM) {

                decimal dTotalAmount = 0;
                if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
                    if (so.SubAmountHontaiNoInspec__c != null) {
                        dTotalAmount = so.SubAmountHontaiNoInspec__c;
                    }
                } else if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
                    if (so.SubAmountHelium__c != null) {
                        dTotalAmount = so.SubAmountHelium__c;
                    }
                } 
        
                decimal dTotalAmountRows = 0;
                for (MaintenanceAccountBook__c row : lsAccountBookRow) {
                    if (row.SalesReturn__c) {
                        if (row.SalesAmountReal__c != null) {
                            dTotalAmountRows += row.SalesAmountReal__c;
                        }
                    } else {          
                        if (row.SalesAmountEstimate__c != null) {
                            dTotalAmountRows += row.SalesAmountEstimate__c;
                        }
                    }                                
                }
                
                if (dTotalAmountRows != dTotalAmount) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '台帳の金額と行の金額は違ってます。按分ボタンを押してください。'));                                
                    return null;                        
                }

            } 


            // Delete the data that has been deleted
            List<id> lsIDKept = new List<id>();
            for (MaintenanceAccountBook__c row : lsAccountBookRow) {
                row.Name = row.Month__c.Substring(0, 4) + '/' + row.Month__c.Substring(4);
                if (row.id != null) {
                    lsIDKept.add(row.id);
                }
            }
            
            List<MaintenanceAccountBook__c> lsOldRows;
            if (lsIDKept != null && lsIDKept.size() > 0) {
                // delete the rows not kept
                lsOldRows = [select id from MaintenanceAccountBook__c where MaintenanceContractManagement__c = :so.Id and Type__c = :sType and id not in :lsIDKept];                
            } else {
                // delete all
                lsOldRows = [select id from MaintenanceAccountBook__c where MaintenanceContractManagement__c = :so.Id and Type__c = :sType];        
            }
            if (lsOldRows != null && lsOldRows.size() > 0) {
                delete lsOldRows;
            }
                
            upsert lsAccountBookRow;
            upsert so;
            
            PageReference pr = new PageReference('/apex/JEOL_MaintenanceDetailView');
            pr.getParameters().put('id', so.id);
            pr.setRedirect(true);
            return pr;
        } catch (Exception ex) {
            // The message is already returned by the trigger
            // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, ' エラーが発生しました：' + ex.getMessage()));                                        
            return null;
        }
    }

    private integer getIndiceFirstRowNotReturn() {

        integer iReturn = -1;
        
        integer iIdx = 0;
        if (lsAccountBookRow != null && lsAccountBookRow.size() > 0) {
            for (MaintenanceAccountBook__c row : lsAccountBookRow) {
                if (!row.SalesReturn__c) {
                    iReturn = iIdx;
                    break;
                }
                iIdx++;
            }
        }

        return iReturn;    
    }

    private integer getIndiceLastRowNotReturn() {

        integer iReturn = -1;
        
        integer iIdx = 0;
        if (lsAccountBookRow != null && lsAccountBookRow.size() > 0) {
            for (MaintenanceAccountBook__c row : lsAccountBookRow) {
                if (!row.SalesReturn__c) {
                    iReturn = iIdx;
                }
                iIdx++;
            }
        }

        return iReturn;    
    }


    private integer getIndiceInsertion(String month) {

        integer iReturn = -1;
        
        integer iIdx = 0;
        if (lsAccountBookRow != null && lsAccountBookRow.size() > 0) {
            for (MaintenanceAccountBook__c row : lsAccountBookRow) {
                if (row.month__c >= month) {
                    iReturn = iIdx;
                    break;
                }
                iIdx++;
            }
        }

        return iReturn;    
    }

    public PageReference addFirstRow(){

        integer iYear = 0;
        integer iMonth = 0;
        integer iIdxFirstRow = getIndiceFirstRowNotReturn();
        if (iIdxFirstRow >= 0) {
            // Return the month before the 1st one
            String sMonth = lsAccountBookRow.get(iIdxFirstRow).month__c;
            iYear = Integer.valueOf(sMonth.substring(0, 4));
            iMonth = Integer.valueOf(sMonth.substring(4));
    
            iMonth -= 1;
            if (iMonth < 1) {
                iYear -= 1;
                iMonth = 12;
            }
        } else {
            // Return the current month
            String sMonth = datetime.newInstance(date.today(), Time.newInstance(0,0,0,0)).format('yyyyMM');
            iYear = Integer.valueOf(sMonth.substring(0, 4));
            iMonth = Integer.valueOf(sMonth.substring(4));
        }
            
        // Create a row
        MaintenanceAccountBook__c maintRow = new MaintenanceAccountBook__c();
        maintRow.Type__c = sType;
        maintRow.MaintenanceContractManagement__c = so.id;
        maintRow.Month__c = ('0000' + string.valueof(iYear)).substring(string.valueof(iYear).length()) + ('00' + string.valueof(iMonth)).substring(string.valueof(iMonth).length());
        maintRow.Name = maintRow.Month__c.Substring(0, 4) + '/' + maintRow.Month__c.Substring(4);
        if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            maintRow.MaintenanceContractManagement4__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE4 + '（' + maintRow.Name + '）';
        } else  if (sType == ACCOUNTBOOK_HONTAI_ATTACH) {
            maintRow.MaintenanceContractManagement3__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE3 + '（' + maintRow.Name + '）';
        } else  if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
            maintRow.MaintenanceContractManagement2__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE2 + '（' + maintRow.Name + '）';
        } else {
            maintRow.MaintenanceContractManagement1__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE1 + '（' + maintRow.Name + '）';
        }

        if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC || sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            maintRow.SalesAuto__c = true;
        }

        maintRow.TaxCode__c = TaxCodeDefaultValue;
        
        integer iIdx = getIndiceInsertion(maintRow.Month__c);
        if (iIdx >= 0) {
            lsAccountBookRow.add(iIdx, maintRow);
        } else {
            lsAccountBookRow.add(maintRow);
        }
        
system.debug('bbb:' + sType);
        return null;

    }
     
    public PageReference addLastRow(){

        integer iYear = 0;
        integer iMonth = 0;
        integer iIdxLastRow = getIndiceLastRowNotReturn();

        if (iIdxLastRow >= 0) {
            // Return the month before the 1st one
            String sMonth = lsAccountBookRow.get(iIdxLastRow).month__c;
            iYear = Integer.valueOf(sMonth.substring(0, 4));
            iMonth = Integer.valueOf(sMonth.substring(4));
    
            iMonth += 1;
            if (iMonth > 12) {
                iYear += 1;
                iMonth = 1;
            }
        } else {
            // Return the current month
            String sMonth = datetime.newInstance(date.today(), Time.newInstance(0,0,0,0)).format('yyyyMM');
            iYear = Integer.valueOf(sMonth.substring(0, 4));
            iMonth = Integer.valueOf(sMonth.substring(4));
        }
            
        // Create a row
        MaintenanceAccountBook__c maintRow = new MaintenanceAccountBook__c();
        maintRow.Type__c = sType;
        maintRow.MaintenanceContractManagement__c = so.id;
        maintRow.Month__c = ('0000' + string.valueof(iYear)).substring(string.valueof(iYear).length()) + ('00' + string.valueof(iMonth)).substring(string.valueof(iMonth).length());
        maintRow.Name = maintRow.Month__c.Substring(0, 4) + '/' + maintRow.Month__c.Substring(4);
        if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            maintRow.MaintenanceContractManagement4__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE4 + '（' + maintRow.Name + '）';
        } else if (sType == ACCOUNTBOOK_HONTAI_ATTACH) {
            maintRow.MaintenanceContractManagement3__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE3 + '（' + maintRow.Name + '）';
        } else if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
            maintRow.MaintenanceContractManagement2__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE2 + '（' + maintRow.Name + '）';
        } else {
            maintRow.MaintenanceContractManagement1__c = maintRow.MaintenanceContractManagement__c;
            maintRow.ItemName__c = LABEL_ITEM_DEFAULT_TYPE1 + '（' + maintRow.Name + '）';
        }

        if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC || sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            maintRow.SalesAuto__c = true;
        }
        
        maintRow.TaxCode__c = TaxCodeDefaultValue;

        integer iIdx = getIndiceInsertion(maintRow.Month__c);
        if (iIdx >= 0) {
            lsAccountBookRow.add(iIdx, maintRow);
        } else {
            lsAccountBookRow.add(maintRow);
        }

        return null;

    }

    public PageReference removeFirstRow(){

        removeRow(getIndiceFirstRowNotReturn());
        return null;

    }

    public PageReference removeLastRow(){

        removeRow(getIndiceLastRowNotReturn());
        return null;

    }

    private void removeRow(integer idxRow){

        if (idxRow >= 0) {
            if (lsAccountBookRow[idxRow].AlreadyBilled__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '売上済の行のため、削除できません。'));                                        
                return;
            }
            if (lsAccountBookRow[idxRow].SalesAmountReal__c != null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '売上（実績）のため、削除できません。'));                                        
                return;
            }
            if (lsAccountBookRow[idxRow].SalesReturn__c) {
                // Should not happen, this indice should not be returned
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '売上戻しの行のため、削除できません。'));                                        
                return;
            }
            lsAccountBookRow.remove(idxRow);
        }

    }
    
    public PageReference importPreviousYearData(){

        if (so.PreviousYearPipeline__c == null) {
            // Should not happen, the button is not enabled
            return null;
        }
        
        // Check if there is no row not editable (売上戻し, AlreadyBilled, SalesAmountReal__c not null, ...)
        for (MaintenanceAccountBook__c row : lsAccountBookRow) {
            if (row.SalesReturn__c || row.AlreadyBilled__c || row.SalesAmountReal__c != null) {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '変更できない行があるため、コピーできません。'));                        
                return null;
            }
        }
        
        List<MaintenanceAccountBook__c> lsPast = [select id, Name, Inspection__c, InspectionDone__c, MaintenanceContractManagement__c, Month__c, 
                                                  BillingDone__c, BillingAmountEstimate__c, SalesAmountEstimate__c, SalesAmountReal__c, SalesAuto__c,
                                                  TaxCode__c, ItemName__c, MaintenanceContractManagement__r.SubAmountHontaiNoInspec__c, MaintenanceContractManagement__r.SubAmountHelium__c,
                                                  MaintenanceContractManagement__r.BillingMethodHontai__c, MaintenanceContractManagement__r.BillingMethodHelium__c
                                                  from MaintenanceAccountBook__c
                                                  where MaintenanceContractManagement__c = :so.PreviousYearPipeline__c
                                                  and Type__c = :sType order by Month__c asc
                                                 ];

        if (lsPast == null || lsPast.size() == 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '前年の台帳情報がありません。'));                        
            return null;
        }

        // Clear the data already present
        for (MaintenanceAccountBook__c row : lsAccountBookRow) {            
            row.Inspection__c = false;            
            row.BillingAmountEstimate__c = null;
            row.SalesAmountEstimate__c = null;
            row.SalesAuto__c = (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC || sType == ACCOUNTBOOK_HONTAI_HELIUM);
            row.TaxCode__c = TaxCodeDefaultValue;
            if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
                row.ItemName__c = LABEL_ITEM_DEFAULT_TYPE4 + '（' + row.Name + '）';
            } else if (sType == ACCOUNTBOOK_HONTAI_ATTACH) {
                row.ItemName__c = LABEL_ITEM_DEFAULT_TYPE3 + '（' + row.Name + '）';
            } else if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
                row.ItemName__c = LABEL_ITEM_DEFAULT_TYPE2 + '（' + row.Name + '）';
            } else {
                row.ItemName__c = LABEL_ITEM_DEFAULT_TYPE1 + '（' + row.Name + '）';
            }            
        }

        if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
            so.SubAmountHontaiNoInspec__c = lsPast.get(0).MaintenanceContractManagement__r.SubAmountHontaiNoInspec__c;
        } else if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            so.SubAmountHelium__c = lsPast.get(0).MaintenanceContractManagement__r.SubAmountHelium__c;
        }

        if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            so.BillingMethodHelium__c = lsPast.get(0).MaintenanceContractManagement__r.BillingMethodHelium__c;
        } else {
            so.BillingMethodHontai__c = lsPast.get(0).MaintenanceContractManagement__r.BillingMethodHontai__c;
        }

        for (integer idx = 0; idx < lsPast.size(); idx++) {

            if (lsAccountBookRow.size() <= idx) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '今回の期間は前年より短かったので、ある部分をコピーできませんでした。'));                        
                return null;
            }

            lsAccountBookRow[idx].Inspection__c = lsPast[idx].Inspection__c;
            lsAccountBookRow[idx].BillingAmountEstimate__c = lsPast[idx].BillingAmountEstimate__c;
            lsAccountBookRow[idx].TaxCode__c = lsPast[idx].TaxCode__c;

            if (sType == ACCOUNTBOOK_HONTAI_INSPEC || sType == ACCOUNTBOOK_HONTAI_ATTACH) {
                lsAccountBookRow[idx].SalesAmountEstimate__c = lsPast[idx].SalesAmountEstimate__c;
            }

            // UAT #121 lsAccountBookRow[idx].SalesAuto__c = lsPast[idx].SalesAuto__c;
            // UAT #121 lsAccountBookRow[idx].ItemName__c = lsPast[idx].ItemName__c;
        }
        
   
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, '前年の情報をコピーしました。'));                        
        return null;

    }

    public PageReference doProportionalAmount(){

        if (sType != ACCOUNTBOOK_HONTAI_NO_INSPEC && sType != ACCOUNTBOOK_HONTAI_HELIUM) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'この管理台帳で按分できません。'));                                
            return null;
        } 

        decimal dTotalAmount = 0;
        if (sType == ACCOUNTBOOK_HONTAI_NO_INSPEC) {
            if (so.SubAmountHontaiNoInspec__c != null) {
                dTotalAmount = so.SubAmountHontaiNoInspec__c;
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '台帳金額を入力してください。'));                                
                return null;
            }
        } else if (sType == ACCOUNTBOOK_HONTAI_HELIUM) {
            if (so.SubAmountHelium__c != null) {
                dTotalAmount = so.SubAmountHelium__c;
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, '台帳金額を入力してください。'));                                
                return null;
            }
        } 

        // Exclude the rows already billed and the sales return
        integer iNbRows = 0;
        for (MaintenanceAccountBook__c row : lsAccountBookRow) {
            
            if (row.SalesReturn__c) {
                if (row.SalesAmountReal__c != null) {
                    dTotalAmount -= row.SalesAmountReal__c;
                }
            }
            
            if (row.AlreadyBilled__c) {          
                if (row.SalesAmountEstimate__c != null) {
                    dTotalAmount -= row.SalesAmountEstimate__c;
                }
            }
            
            if (!row.SalesReturn__c && !row.AlreadyBilled__c) {
                iNbRows++;
            }
                        
        }

        if (iNbRows == 0 || dTotalAmount < 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'この金額の按分できません。'));                                
            return null;
        } 

        decimal dAmountPerRow = Math.floor(dTotalAmount / (100 * iNbRows)) * 100;
        
        integer iIndiceRow = 0;
        for (MaintenanceAccountBook__c row : lsAccountBookRow) {

            if (!row.SalesReturn__c && !row.AlreadyBilled__c) {
                iIndiceRow++;
                
                if (iIndiceRow == iNbRows) {
                    // Last row contains the difference
                    row.SalesAmountEstimate__c = dTotalAmount - (iNbRows - 1) * dAmountPerRow;
                } else {
                    row.SalesAmountEstimate__c = dAmountPerRow;
                }
                
                if (row.SalesAmountEstimate__c == 0) {
                    row.SalesAmountEstimate__c = null;
                }
            }                        
        }        
        
        return null;
    }

}