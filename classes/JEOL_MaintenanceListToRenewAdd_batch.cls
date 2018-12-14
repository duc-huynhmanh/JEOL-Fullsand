global class JEOL_MaintenanceListToRenewAdd_batch implements Database.batchable<sObject>, Database.Stateful {

    global Integer nbDataMax = NULL;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM Account LIMIT 1';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> scope) {


        boolean fExecutionOK = false;
        String errorMessage = '';
    
        Integer nbRows1 = 0;
        Integer nbRows2 = 0;

        List<Integer> nbRowsInserted1 = New List<Integer>{0};
        List<String> messageError1 = New List<String>{''};
        List<Integer> nbRowsInserted2 = New List<Integer>{0};
        List<String> messageError2 = New List<String>{''};

        try {

    
            nbDataMax = Integer.valueOf(BaaNSettings__c.getValues('Default').BatchMaxData__c);

            fExecutionOK = JEOL_MaintenanceListToRenewAdd_ctrl.addContractMaintenanceBatch(nbDataMax, nbRowsInserted1, messageError1);
            nbRows1 = nbRowsInserted1[0];
            errorMessage = messageError1[0];

            if (nbDataMax != NULL) nbDataMax -= nbRows1;

            if (fExecutionOK) {
                fExecutionOK = JEOL_MaintenanceListNewAdd_ctrl.addContractMaintenanceBatch(nbDataMax, nbRowsInserted2, messageError2);
                nbRows2 = nbRowsInserted2[0];
                errorMessage = messageError2[0];
            }

            if (nbDataMax != NULL) nbDataMax -= nbRows2;

        } catch (Exception e) {

            fExecutionOK = false;
            errorMessage = 'JEOL_MaintenanceListToRenewAdd_batch.execute でエラーが発生しました。' + e.getMessage();

        }
      
        sendLogEmail(fExecutionOK, errorMessage, nbRows1, nbRows2, nbDataMax);

    }  

    global void finish(Database.BatchableContext BC) {
        if (nbDataMax != NULL && nbDataMax == 0) {
            // start again in 2 mins
            Datetime sysTime = System.now().addSeconds(120);
            System.scheduleBatch(new JEOL_MaintenanceListToRenewAdd_batch(), 'MaintenanceJobBatch' + sysTime, 2);
        }  
    }


   private void sendLogEmail(boolean fExecutionOK, String errorMessage, Integer nbRowsInserted1, Integer nbRowsInserted2, Integer nbRowsMaxRemaining) {

        List<User> lsUsr = [SELECT id, name, email from User where id in (SELECT UserOrGroupId FROM GroupMember where group.DeveloperName = 'MaintenanceBatchLog') and email != null];

        if (lsUsr == null || lsUsr.size() == 0) {
            return;
        }

        // Step 0: Create a master list to hold the emails we'll send
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        for (User usr : lsUsr) {
            sendTo.add(usr.email);          
        }
        mail.setToAddresses(sendTo);

        // Step 3: Set who the email is sent from
        //  mail.setReplyTo('sirdavid@bankofnigeria.com');
        mail.setSenderDisplayName('保守契約管理・バッチの結果');


        // Step 4. Set email contents - you can use variables!
        mail.setSubject('【SFDC】保守契約管理・バッチの結果');


        String body = '';

        if (fExecutionOK) {
            body = 'バッチは正常に終わりました。<br/><br/>';
            body += '販売オーダから作成されたデータ：' + nbRowsInserted1 + '件' + '<br/>';
            body += '本体号機から作成されたデータ：' + nbRowsInserted2 + '件';

            if (nbRowsMaxRemaining != NULL && nbRowsMaxRemaining == 0) {
                body += '<br/><br/>' + '（注意：バッチの最大の数を対応しましたので、データが残る可能性があります。）';
            }
        } else {
            body = 'バッチ処理で、エラーが発生しました。<br/><br/>' + errorMessage;
        }
        
        mail.setHtmlBody(body);

        // Step 5. Add your email to the master list
        mails.add(mail);

        // Step 6: Send all emails in the master list
        Messaging.sendEmail(mails);

    }
}