public with sharing class JEOL_MaintenanceListNewAdd_ctrl {
    
    private static boolean addContractMaintenanceList(List<id> lsId, boolean isBatch, List<Integer> nbRowsInserted, List<String> messageError) {

        if (nbRowsInserted != NULL && nbRowsInserted.size() > 0) {
            nbRowsInserted[0] = 0;
        }
        if (messageError != NULL && messageError.size() > 0) {
            messageError[0] = '';
        }

        try {

            List<MaintenanceContractManagement__c> lsToBeAded = new List<MaintenanceContractManagement__c>();
            
            List<UnitBody__c> lsUB = [SELECT Id, Series__c, Name, ShippingDateFormula__c, SalesAccount__c, SalesAccount__r.phone, SalesAccount__r.fax, SalesAccount__r.Address__c, DeliveryAccount__c, DeliveryAccount__r.phone, DeliveryAccount__r.fax, DeliveryAccount__r.Area__c
                                      FROM UnitBody__c
                                      WHERE id IN :lsId
                                      AND Id NOT IN (SELECT UnitBody__c FROM MaintenanceContractManagement__c)
                                     ];



            List<String> lsArea = new List<String>();
            
            for (UnitBody__c so : lsUB) {
                if (so.DeliveryAccount__r.Area__c != null && so.DeliveryAccount__r.Area__c.length() > 0) {
                    lsArea.add(so.DeliveryAccount__r.Area__c);
                }
            }
            
            // Get the list of Area Code
            List<SelectListManage__c> lsAreaCode = [SELECT Value__c, Label__c
                                                    FROM SelectListManage__c
                                                    WHERE ReferenceName__c =: JEOLUtil.REFERENCE_NAME_MAINTENANCE_AREA
                                                    AND Label__c IN :lsArea
                                                    ORDER BY SortNo__c desc, Value__c desc
                                                   ];
                                                   
            Map<String, String> mpAreaCode = new Map<String, String>();
            if (lsAreaCode != null && lsAreaCode.size() > 0) {
                for (SelectListManage__c slm : lsAreaCode) {
                    mpAreaCode.put(slm.Label__c, slm.Value__c);
                }
            }

            for (UnitBody__c so : lsUB) {
            
                MaintenanceContractManagement__c row = new MaintenanceContractManagement__c();

                row.NewOdrSeries__c = so.Series__c;
                row.UnitBody__c = so.id;
                
                
                if (so.ShippingDateFormula__c != null) {
                    row.NewContractStartDate__c = so.ShippingDateFormula__c.addYears(1);
                    row.NewContractEndDate__c = row.NewContractStartDate__c.addYears(1).addDays(-1);      
                }

                row.RenewalAccount__c = so.SalesAccount__c;
                row.RenewalAddress__c = so.SalesAccount__r.Address__c;
                // row.RenewalContactPosition__c = null;
                // row.RenewalTantoshya__c = null;
                row.RenewalContactTel__c = so.SalesAccount__r.phone;
                row.RenewalContactFax__c = so.SalesAccount__r.fax;


                // row.NewOdrName__c = null;
                //row.NewOdrNetMaintenance__c = so.NetMaintenance__c;
                row.NewOdrSalesAccount__c = so.SalesAccount__c;
                //row.NewOdrSalesContactPosition__c = so.SalesContactPosition__c;
                //row.NewOdrSalesTantoshya__c = so.SalesTantoshya__c;
                row.NewOdrSalesContactTel__c = so.SalesAccount__r.phone;
                row.NewOdrSalesContactFax__c = so.SalesAccount__r.fax;
                row.NewOdrShipmentAccount__c = so.DeliveryAccount__c;
                //row.NewOdrShipmentContactPosition__c = so.ShipmentContactPosition__c;
                //row.NewOdrShipmentTantosha__c = so.ShipmentTantosha__c;
                row.NewOdrShipmentContact_Tel__c = so.DeliveryAccount__r.phone;
                row.NewOdrShipmentContact_Fax__c = so.DeliveryAccount__r.fax;

                //row.NewOdrOrdersMemp__c = so.OrdersMemp__c;
                //row.NewOdrSalesStaffCode__c = so.SalesStaffCode__c;
                //row.NewOdrSalesStaff__c = so.SalesStaff__c;
                //row.NewOdrAssistantCode__c = so.AssistantCode__c;
                //row.NewOdrAssistant__c = so.Assistant__c;

                //row.NewOdrFlagshipProduct__c = so.FlagshipProduct__c;

                if (mpAreaCode != null && mpAreaCode.containsKey(so.DeliveryAccount__r.Area__c)) {
                    row.NewOdrRegion__c =  mpAreaCode.get(so.DeliveryAccount__r.Area__c); 
                }

                row.NewOdrMaintenanceStartDate__c = row.NewContractStartDate__c;
                row.NewOdrMaintenanceEndDate__c = row.NewContractEndDate__c;      
                row.NewOdrContractAmountt__c = row.NewContractAmount__c;     

                // row.PreviousYearOrder__c = null;
                // row.RegionName__c =  null;
                // row.NewContractAmount__c = null;

                // row.PreviousYearPipeline__c =  null; 
                // row.AnnaiType__c = null; 
                // row.JeolPipelineResponsible__c = null;


                // row.QuotationCreated__c = false;
                // row.ContractSentDate__c = null;
                // row.QuotationSentDate__c = null;
                // row.RenewalNoticeSentDate__c = null;
                // row.RenewalNoticeCreated__c = false;
                // row.RenewalApproved__c = false;
                // row.PipelineStopped__c = false;
                // row.PipelineStoppedReason__c = null;

                // row.Memo__c = null;
                // row.NextYearNotes__c = null;          
                // row.LinkageStatus__c = default value;          
                // row.ProductNumber__c = later in the pipeline;
                
                lsToBeAded.add(row);
            }
            
            if (lsToBeAded != null && lsToBeAded.size() > 0) {
                insert lsToBeAded;

                if (nbRowsInserted != NULL && nbRowsInserted.size() > 0) {
                    nbRowsInserted[0] = lsToBeAded.size();
                }

                if (!isBatch) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Label.JEOL_MaintRenewalAdd_Message_DataAdded));
                }
            }

            return true;

        } catch(Exception e) {

            if (messageError != NULL && messageError.size() > 0) {
                messageError[0] = 'JEOL_MaintenanceListNewAdd_ctrl.addContractMaintenanceList でエラーが発生しました。' + e.getMessage();
            }
            return false;

        }
                          
    }       

    /**
     * Add the contract maintenance from the UnitBody table. 
     *
     * @param   nbRowsInserted Number of rows inserted
     * @param   messageError   Error messagethe location of the image, relative to the url argument
     * @return                 Indicates if the execution of the method has been a success
     */
     public static boolean addContractMaintenanceBatch(Integer nbRowsMax, List<Integer> nbRowsInserted, List<String> messageError) {

        try {

            date dTodayFirstDay = Date.newInstance(date.today().year(), date.today().month(), 1);
            
            List<UnitBody__c> lsUB;

            if (nbRowsMax != NULL) {
                lsUB = [SELECT Id
                        FROM UnitBody__c
                        WHERE UnitBody__c != null
                        AND (ShippingDateFormula__c >= 2016-04-01 AND ShippingDateFormula__c < :dTodayFirstDay)
                        AND Id NOT IN (SELECT UnitBody__c from MaintenanceContractManagement__c WHERE IsHeliumOnly__c = false)
                        AND Id NOT IN (SELECT UnitBodyLink__c from SalesOrder__c where RecordType.DeveloperName = 'HosyuKeiyaku' and (MaintenanceContractManagement__c = null OR MaintenanceContractManagement__r.IsHeliumOnly__c = false))
                        AND (NOT DeliveryAccount__r.Code__c  LIKE '0%')
                        LIMIT :nbRowsMax
                       ]; 
            } else {
                lsUB = [SELECT Id
                        FROM UnitBody__c
                        WHERE UnitBody__c != null
                        AND (ShippingDateFormula__c >= 2016-04-01 AND ShippingDateFormula__c < :dTodayFirstDay)
                        AND Id NOT IN (SELECT UnitBody__c from MaintenanceContractManagement__c WHERE IsHeliumOnly__c = false)
                        AND Id NOT IN (SELECT UnitBodyLink__c from SalesOrder__c where RecordType.DeveloperName = 'HosyuKeiyaku' and (MaintenanceContractManagement__c = null OR MaintenanceContractManagement__r.IsHeliumOnly__c = false))
                        AND (NOT DeliveryAccount__r.Code__c  LIKE '0%')
                       ];                 
            }

            List<id> lsId = new List<id>();
            for (UnitBody__c ub : lsUB) {
                lsId.add(ub.id);
            }
            return addContractMaintenanceList(lsId, true, nbRowsInserted, messageError);

        } catch (Exception e) {

            if (messageError != NULL && messageError.size() > 0) {
                messageError[0] = 'JEOL_MaintenanceListNewAdd_ctrl.addContractMaintenanceBatch でエラーが発生しました。' + e.getMessage();
            }
            return false;

        }

    }

}