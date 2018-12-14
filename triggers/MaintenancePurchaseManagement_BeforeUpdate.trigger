trigger MaintenancePurchaseManagement_BeforeUpdate on MaintenancePurchaseManagement__c (Before update) {
    
    for (MaintenancePurchaseManagement__c mcm : Trigger.New){
        
        if (!mcm.BypassTriggerCheck__c) {
        
            if (trigger.oldMap.get(mcm.id).LinkageStatus__c == '連携済') {
                
                if (mcm.LinkageStatus__c == '未連携' || mcm.LinkageStatus__c == '連携不要') {
                    mcm.LinkageStatus__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).PaymentType__c != mcm.PaymentType__c) {
                    mcm.PaymentType__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }

                if (trigger.oldMap.get(mcm.id).CallCenterReceptionNumber__c != mcm.CallCenterReceptionNumber__c) {
                    mcm.CallCenterReceptionNumber__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }

                if (trigger.oldMap.get(mcm.id).SupplierCustomerCode__c != mcm.SupplierCustomerCode__c) {
                    mcm.SupplierCustomerCode__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }

                if (trigger.oldMap.get(mcm.id).PurchasingManager__c != mcm.PurchasingManager__c) {
                    mcm.PurchasingManager__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }

                if (trigger.oldMap.get(mcm.id).XPayment__c != mcm.XPayment__c) {
                    mcm.XPayment__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }

                if (trigger.oldMap.get(mcm.id).WarehousePlanningDate__c != mcm.WarehousePlanningDate__c) {
                    mcm.WarehousePlanningDate__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).OrderDate__c != mcm.OrderDate__c) {
                    mcm.OrderDate__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).Remark__c != mcm.Remark__c) {
                    mcm.Remark__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).PurchaseOrderType__c != mcm.PurchaseOrderType__c) {
                    mcm.PurchaseOrderType__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).PurchasingOrder__c != mcm.PurchasingOrder__c) {
                    mcm.PurchasingOrder__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).PurchasingOffice__c != mcm.PurchasingOffice__c) {
                    mcm.PurchasingOffice__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).OriginalPurchaseCustomerOrder__c != mcm.OriginalPurchaseCustomerOrder__c) {
                    mcm.OriginalPurchaseCustomerOrder__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).IsAcceptanceSettled__c != mcm.IsAcceptanceSettled__c) {
                    mcm.IsAcceptanceSettled__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
                
                if (trigger.oldMap.get(mcm.id).KazeiHiKazei__c != mcm.KazeiHiKazei__c) {
                    mcm.KazeiHiKazei__c.adderror('連携済ですので、この変更は禁止です。');   
                    mcm.adderror('連携済ですので、この変更は禁止です。');                   
                }
            }

            // Check the required fields

            // 購買先取引先
            if (mcm.SupplierCustomerCode__c == null) {
                mcm.SupplierCustomerCode__c.adderror('「購買先取引先」の項目は必須です。');   
                mcm.adderror('「購買先取引先」の項目は必須です。');                   
            }

            // 購買担当
            if (mcm.PurchasingManager__c == null) {
                mcm.PurchasingManager__c.adderror('「購買担当」の項目は必須です。');   
                mcm.adderror('「購買担当」の項目は必須です。');                   
            }

            // 購買オーダタイプ
            if (mcm.PurchaseOrderType__c == null) {
                mcm.PurchaseOrderType__c.adderror('「購買オーダタイプ」の項目は必須です。');   
                mcm.adderror('「購買オーダタイプ」の項目は必須です。');                   
            }

            // 購買オフィス
            if (mcm.PurchasingOffice__c == null) {
                mcm.PurchasingOffice__c.adderror('「購買オフィス」の項目は必須です。');   
                mcm.adderror('「購買オフィス」の項目は必須です。');                   
            }

            //  支払金額
            if (mcm.LinkageStatus__c == '未連携' && mcm.XPayment__c == null) {
                mcm.XPayment__c.adderror('「支払金額」の項目は必須です。');   
                mcm.adderror('「支払金額」の項目は必須です。');                   
            }

            //  オーダ日付
            if (mcm.LinkageStatus__c == '未連携' && mcm.OrderDate__c == null) {
                mcm.OrderDate__c.adderror('「オーダ日付」の項目は必須です。');   
                mcm.adderror('「オーダ日付」の項目は必須です。');                   
            }

            //  製番
            if (mcm.LinkageStatus__c == '未連携' && mcm.ProductNumber__c == null) {
                mcm.ProductNumber__c.adderror('「製番」の項目は必須です。');   
                mcm.adderror('「製番」の項目は必須です。');                   
            }            

        }
        
        mcm.BypassTriggerCheck__c = false;

    }
    







}