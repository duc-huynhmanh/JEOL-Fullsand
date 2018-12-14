trigger JEOL_SalesPipeline_BeforeUpsertTrigger on SalesPipeline__c (Before Insert, Before Update) {

    Id sfdcRecordTypeId = Schema.SObjectType.SalesPipeline__c.getRecordTypeInfosByName().get('Asia').getRecordTypeId();


    for (SalesPipeline__c salesPL : Trigger.new) {

        if (salesPL.JuchuYoteiTsuki__c == '0') {
            salesPL.JuchuYoteiTsuki__c = null;
        }
        if (salesPL.UriageYoteiTsuki__c == '0') {
            salesPL.UriageYoteiTsuki__c = null;
        }
        if (salesPL.ReceiveMonthHonbu__c == '0') {
            salesPL.ReceiveMonthHonbu__c = null;
        }
        if (salesPL.ReceiveMonthGroupTop__c == '0') {
            salesPL.ReceiveMonthGroupTop__c = null;
        }
        if (salesPL.ShukkaYokyuTsuki__c == '0') {
            salesPL.ShukkaYokyuTsuki__c = null;
        }


 //       if (salesPL.UpdateMethod__c == null || salesPL.UpdateMethod__c == 0) {
   if ( salesPL.UpdateMethod__c == 0) {
    //        if (Trigger.isInsert) {
                // We make the record type to JEOL for new PL not created by the WM
            //    salesPL.RecordTypeId = sfdcRecordTypeId;
  //          }
            salesPL.LinkageStatus__c = '未連携';

            if (Trigger.isUpdate &&
                salesPL.PipelineType__c != trigger.oldMap.get(salesPL.id).PipelineType__c) {

                salesPL.PipelineType__c.adderror('パイプライン種類の変更は禁止です。（前の値：' + trigger.oldMap.get(salesPL.id).PipelineType__c + '）');   

            }        
        } 

        if (salesPL.RecordTypeId == sfdcRecordTypeId)
        {
                if (salesPL.RegionNamePicklist__c  == '131')
                  {
                    salesPL.Field14__c = 'AU'; 
                  }
                else 
                  { 
                    salesPL.Field14__c = 'JEOL(Asia)LTD';
                  }
                 
                 if    (salesPL.Field48__c == 'A')
                  {
                        salesPL.Field26_del__c = True;
                 }
                 else
                  {
                        salesPL.Field26_del__c = False;
                 }
                
                }

        if (salesPL.UpdateMethod__c == 1) {
            // Updated by the WM
            salesPL.KigyoTaniPicklist__c = salesPL.KigyoTani__c;
            salesPL.CountryNamePicklist__c = salesPL.CountryName__c;
            salesPL.RegionNamePicklist__c = salesPL.RegionName__c;
            salesPL.SeriesPicklist__c = salesPL.Series__c;
        } else if (salesPL.UpdateMethod__c == NULL || salesPL.UpdateMethod__c == 0) {
            // Updated by the user interface
            salesPL.KigyoTani__c = salesPL.KigyoTaniPicklist__c;
            salesPL.CountryName__c = salesPL.CountryNamePicklist__c;
            salesPL.RegionName__c = salesPL.RegionNamePicklist__c;
            salesPL.Series__c = salesPL.SeriesPicklist__c;
        } 

        salesPL.UpdateMethod__c = 0;

    }
    
}