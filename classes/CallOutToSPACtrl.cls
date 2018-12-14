public with sharing class CallOutToSPACtrl {
	private String recordId;
	private User currentUser;
	public String errorMessage{get;set;}
	public Integer calloutStatus{get;set;}
	
	//TODO: get Endpoint from custom setting
	public String getEndPoint(){
		return 'https://globalwaydemo.spa-cloud.com/';
	}
	//TODO: get username from custom setting
	public String getUsername(){
		return 'admin';
	}
	//TODO: get password from custom setting
	public String getPassword(){
		return 'duchm123';
	}
	public String getPath(){
		return '/Demo';
	}
	public String getFileName(){
		return currentUser.Name + String.valueOf(Datetime.now().getTime()) + '.pdf';
	}

	public CallOutToSPACtrl() {
		recordId = Apexpages.currentPage().getParameters().get('Id');
	}

	Blob generatePDF(){
		if(String.isBlank(recordId)){
			return null;
		}
		pageReference pdf = Page.ContractGenerator;
        //pass the Account Id parameter to the class.
        pdf.getParameters().put('id', recordId);
        Blob body;
        if(!test.isRunningTest()) {
            body = pdf.getContent();
        } else{
            body = blob.valueOf('TestString');
        }
        return body;
	}

	public List<String> doLogin(){
		List<String> result = new List<String>();
		Http h = new Http();
		String url = getEndPoint() + 'spa/service/auth/login';
    	HttpRequest req = new HttpRequest();
    	req.setTimeout(120000);
    	req.setEndpoint(url);
    	req.setMethod('POST');
		req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		String body = String.format('user={0}&password={1}', new String[] {getUsername(), getPassword()});
		req.setBody(body);

    	// Send the request, and return a response
    	HttpResponse res = h.send(req);
		String[] resHeader = res.getHeaderKeys();
		for(String key : resHeader){
			if(key == null) continue;
			if(key == 'Set-Cookie') {
				String value = res.getHeader(key);
				//cookie
				result.add(value); 
				Integer startInd = value.indexOf('XSRF-TOKEN');
				value = value.substring(startInd + 11);
				Integer endInd = value.indexOf(';');
				result.add(value.substring(0, endInd));
			}
		}
		return result;
	}

	public void sendToSpa(){
		calloutStatus = 0;
		currentUser = [SELECT Name FROM User WHERE Id = :UserInfo.getUserId()];
		String fileName = getFileName();
		String url = getEndPoint() + 'spa/service/archives';

        //  Compose the form
        string form64 = '';
        form64 += RequestFormHelper.WriteBoundary();
        form64 += RequestFormHelper.WriteBodyParameter('path', getPath());
        form64 += RequestFormHelper.WriteBoundary();
        form64 += RequestFormHelper.WriteBodyParameter('name', fileName);
        form64 += RequestFormHelper.WriteBoundary();

        Blob bodyData = generatePDF();
        RequestFormHelper.WriteFileResult result = RequestFormHelper.WriteFile('file', fileName, 'application/pdf', bodyData);

        form64 += result.Content;
        form64 += RequestFormHelper.WriteBoundary(result.EndingType);

        blob formBlob = EncodingUtil.base64Decode(form64);
        string contentLength = string.valueOf(formBlob.size());

        HttpRequest req = new HttpRequest();

    	req.setEndpoint(url);
    	req.setMethod('POST');
    	// XSRF Tokenをセット
    	List<String> loginResult = doLogin();
    	String cookie = loginResult.size() >= 1 ? loginResult[0] : '';
    	String xsrf = loginResult.size() >= 2 ? loginResult[1] : '';
    	req.setHeader('x-xsrf-token', xsrf);
    	req.setHeader('Cookie', cookie);
        // マルチパートメッセージの作成
        req.setHeader('Content-Type', RequestFormHelper.GetContentType());
        req.setHeader('x-requested-with', 'XMLHttpRequest');
		req.setHeader('Connection', 'keep-alive');
        req.setHeader('Content-Length', contentLength);
      	req.setTimeout(120000);
      	req.setBodyAsBlob(formBlob);
      	Http http = new Http();
      	
      	HTTPResponse res = http.send(req);
      	calloutStatus = res.getStatusCode();
      	//system.debug('res: ' + res.getBody());
      	if(calloutStatus == 200){
      		Map<String, String> resBody = (Map<String, String>) JSON.deserialize(res.getBody(), Map<String, String>.class);
      		String docId = resBody.get('id');
      		SVC_Doc_URL__c sendResult = new SVC_Doc_URL__c();
      		sendResult.SVC__c = recordId;
      		sendResult.Sender__c = currentUser.Id;
      		sendResult.Doc_URL__c = getEndPoint() + 'spa/preview.jsp?docId=' + docId;
      		insert sendResult;
      	} else {
      		errorMessage = res.getStatus();
      	}

      	/*String[] resHeader = res.getHeaderKeys();
		for(String key : resHeader){
			if(key == null) continue;
			system.debug('key: ' + key + ' - value: ' + res.getHeader(key));
		}*/
    }
}