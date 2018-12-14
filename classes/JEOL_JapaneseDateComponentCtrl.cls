/*
Created by: Vaibhav Kumar on Dec. 11th, 2015
Depends on: JEOLUtil.cls
*/
public with sharing class JEOL_JapaneseDateComponentCtrl {

	public Date inputDate;
	public String yearName;
	public String yearNumberString;
	public String dayNumberString;
	public String monthNumberString;

	private Map<String,String> japaneseDate;
	private String nameKey = 'name';
	private String yearKey = 'year';

	public JEOL_JapaneseDateComponentCtrl() {	
	}

	//Getter methods for controller properties
	public Date getInputDate(){
		return inputDate;
	}

	public String getYearName(){
		return yearName;
	}

	public String getYearNumberString(){
		return yearNumberString;
	}

	public String getDayNumberString(){
		return dayNumberString;
	}

	public String getMonthNumberString(){
		return monthNumberString;
	}

	//Setter methods for controller properties

	//Sets controller properties based on passed input date
	public void setInputDate(Date value){
		inputDate = value;
		if(inputDate != null){
			japaneseDate = JEOLUtil.getJapaneseEraData(inputDate); //converts Date into Map with Japanese Date Strings
			//System.debug('japaneseDate: ' + japaneseDate);

			setYearName();
			setYearNumberString();
			setDayNumberString();
			setMonthNumberString();
		}
	}

	//Set the Japanese year name string in japaneseDate Map
	private void setYearName(){
		if((japaneseDate != null) && (japaneseDate.containsKey(nameKey)))
			yearName = japaneseDate.get(nameKey);
	}

	//Sets the Japanese year's number string in japaneseDate Map
	private void setYearNumberString(){
		if((japaneseDate != null) && (japaneseDate.containsKey(yearKey)))
			yearNumberString = japaneseDate.get(yearKey);
	}

	//Sets Day-numeral of the inputDate
	private void setDayNumberString(){
		if(inputDate != null)
			dayNumberString = String.valueOf(inputDate.day());
	}

	//Sets Month-numeral of the inputDate
	private void setMonthNumberString(){
		if(inputDate != null)
			monthNumberString = String.valueOf(inputDate.month());
	}
}