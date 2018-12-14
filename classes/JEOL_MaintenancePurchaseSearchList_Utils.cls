public with sharing class JEOL_MaintenancePurchaseSearchList_Utils {

	/*PAYMENT TYPES RELATED*/
	//Payment types
    public static String paymentTypeBLANK {
    	get{return 'BLANK';}
    }
    public static String paymentTypeNR {
    	get{return 'NR';}
    }
    public static String paymentTypeNS {
    	get{return 'NS';}
    }
    public static String paymentTypeHELIUM {
    	get{return 'HELIUM';}
    }
    
    //Returns related fields if paymentType matches, otherwise returns ''
    public static String getMPMFieldNameForPaymentType(String paymentType) {
    	String fieldName = '';
    	if(paymentType == paymentTypeHELIUM)
    		fieldName = ' HeliumFillingCompletionDate__c ';
		else if((paymentType == paymentTypeNS) || (paymentType == paymentTypeNR))
    		fieldName = ' NSNRInspectionPlannedDate__c ';

    	return fieldName;
    }

    //Returns label for KazeHikazei field's value
    public static String getLabelForKazeiHikazeiValue(String value){
        if(value == '1')
            return '課税';
        else if(value == '2')
                return '非課税';
        else return '';
    }

    //Constructor
	public JEOL_MaintenancePurchaseSearchList_Utils() {		
	}
}