public with sharing class clsMenuControl{

    static final String ITEM_RECORD_TYPE_NAME = 'アイテム';
    static final String DEFAULT_MENU_STYLE = 'vfMenuTileCss';

    String tabName = '';
    String itemRecordTypeId = '';

    public class MenuInfo {
        public String ItemTitle { get; private set; }
        public String IconID { get; private set; }
        public String Link { get; private set; }
        public String Target { get; private set; }
        public String NumberOfCols { get; private set; }
        public String FontSize { get; private set; }
        
        public MenuInfo(){
        }
        
        public MenuInfo(String pItemTitle, String pIconID, String pLink, String pTarget, String pNumberOfCols, String pFontSize){
            this.ItemTitle = pItemTitle;
            this.IconID = pIconID;
            this.Link = pLink;
            this.Target = pTarget;
            this.NumberOfCols = pNumberOfCols;
            this.FontSize = pFontSize;
        }
    }

    public MAP<String, LIST<MenuInfo>> MenuLists { get; private set; }
    public LIST<String> MenuKeys { get; private set; }
    public Boolean ShowSideBar { get; private set; }
    public Boolean ShowHeader { get; private set; }
    public String MenuStyle { get; private set; }
    public Boolean ShowChatter { private set; }
    private Map<String,Schema.RecordTypeInfo> rtMapByName;

    public clsMenuControl(){
        tabName = ApexPages.currentPage().getParameters().get('sfdc.tabName');

        Schema.DescribeSObjectResult d = Schema.SObjectType.MenuInfo__c; 
        rtMapByName = d.getRecordTypeInfosByName();

        itemRecordTypeId = rtMapByName.get(ITEM_RECORD_TYPE_NAME).getRecordTypeId();
        
        MenuLists = new MAP<String, LIST<MenuInfo>>();
        MenuKeys = new LIST<String>();
        
        ShowSideBar = true;
        ShowHeader = true;
        MenuStyle = DEFAULT_MENU_STYLE;
        
        setMenuList();
    }
    
    public Boolean getShowChatter(){
        List<MenuInfo__c> menuInfoList = [Select showChatter__c  From MenuInfo__c  Where TabId__c = :tabName AND RecordTypeId = :rtMapByName.get('メニュー').getRecordTypeId() Limit 1];
        if(menuInfoList.size()==0) return false;
        else return menuInfoList[0].showChatter__c;
    }
    
    private void setMenuList(){
        String key = '';
        LIST<MenuInfo> vals = new LIST<MenuInfo>();

        // added below 4 lines (2014/7/18)
        if(!isAccessibleForMenuInfoFields())
        {
            return;
        }
        
        try {
            LIST<MenuInfo__c> items = [
                Select
                       m.Id, m.ItemOrder__c, m.ItemTitle__c, m.Name, m.RecordTypeId, m.SectionMenuTabId__c
                     , m.SectionRef__c, m.SectionRefMenu__c, m.SectionRefMenuTitle__c
                     , m.SectionRefOrder__c, m.SectionRefTitle__c, m.IconID__c, m.Link__c
                     , m.ItemSideBar__c, m.ItemShowHeader__c, m.ItemMenuStyle__c, m.TargetWindowName__c
                     , m.SectionNumberOfCols__c, m.SectionFontSize__c 
                  from MenuInfo__c m
                 where m.RecordTypeId = :itemRecordTypeId
                   and m.SectionMenuTabId__c = :tabName 
                 order by m.Guide__c
            ];
            
            for(MenuInfo__c it: items){
                if(it.ItemMenuStyle__c != MenuStyle){
                    MenuStyle = it.ItemMenuStyle__c;
                }
                ShowHeader= (it.ItemShowHeader__c == 'true');
                ShowSideBar = (it.ItemSideBar__c == 'true');

                if(key == it.SectionRefTitle__c){
                    vals.add(new MenuInfo(it.ItemTitle__c, it.IconID__c, it.Link__c, it.TargetWindowName__c, it.SectionNumberOfCols__c, it.SectionFontSize__c));
                } else {
                    if(!vals.isEmpty() && key != ''){
                        MenuLists.put(key, vals);
                        MenuKeys.add(key);
                        vals = new LIST<MenuInfo>();
                    }
                    key = it.SectionRefTitle__c;
                    vals.add(new MenuInfo(it.ItemTitle__c, it.IconID__c, it.Link__c, it.TargetWindowName__c, it.SectionNumberOfCols__c, it.SectionFontSize__c));
                }
            }
            if(!vals.isEmpty() && key != ''){
                MenuLists.put(key, vals);
                MenuKeys.add(key);
            }
        } catch (Exception e) {
            System.Debug(e);
        }
    }

     // added below 28 lines (2014/7/18)
    private Boolean isAccessibleForMenuInfoFields() {
        Set<String> fields = new Set<String>{
            'Id','ItemOrder__c','ItemTitle__c','Name','RecordTypeId','SectionMenuTabId__c'
            ,'SectionRef__c','SectionRefMenu__c','SectionRefMenuTitle__c'
            ,'SectionRefOrder__c','SectionRefOrder__c','IconID__c','Link__c'
            ,'ItemSideBar__c','ItemShowHeader__c','ItemMenuStyle__c','TargetWindowName__c','SectionNumberOfCols__c', 'SectionFontSize__c' };

        Schema.DescribeSObjectResult descResult = MenuInfo__c.SObjectType.getDescribe();
        Map<String,Schema.SObjectField> fieldMap = descResult.fields.getMap();
        Set<String> checkTargetKeys = new Set<String>();
        for(String fieldName : fields) {
            for(String key : fieldMap.keySet()) {
                if(fieldName.equalsIgnoreCase(key)) {
                    checkTargetKeys.add(key);
                }
            }
        }

        for(String key : checkTargetKeys) {
            Schema.SObjectField field = fieldMap.get(key);
            Schema.DescribeFieldResult descFieldResult = field.getDescribe();
            if(!descFieldResult.isAccessible()) {
                return false;
            }
        }
        
        return true;
    }
    
    @isTest(SeeAllData=true)
    static void testClsMenuControl() {
        clsMenuControl ctrl = new clsMenuControl();        

        ctrl.setMenuList();

        MenuInfo__c testMenu1 = new MenuInfo__c(RecordTypeId=ctrl.itemRecordTypeId);
        insert testMenu1;

        ctrl.setMenuList();

        MenuInfo__c testMenu2 = new MenuInfo__c(RecordTypeId=ctrl.itemRecordTypeId);
        insert testMenu2;

        ctrl.setMenuList();
    }
}