public with sharing class clsChooseIcon{
    static final String ICON_FOLDER = 'MenuIcons';
    static final String FOLDER_TYPE = 'Document';

    String targetItem = '';
    public String IconId { get; set; }

    public clsChooseIcon(){
        targetItem = ApexPages.currentPage().getParameters().get('item');
        IconId = '';
    }

    public PageReference setIcon() {
        if(IconId.length()==0 || targetItem.length()==0){
            return null;
        }
        
        // added below 4 lines (2014/7/18)
        if(!MenuInfo__c.IconID__c.getDescribe().isUpdateable())
        {
            return null;
        }
        
        try {
            MenuInfo__c menu = [Select
                           m.Id, m.IconID__c
                      from MenuInfo__c m
                 where m.Id = :targetItem
            ];
            menu.IconID__c = IconId;

            update menu;
        } catch(Exception e) {
            System.debug(e);
        }
        return null;
    }

    public LIST<Document> getIcons(){
        Folder folder = new Folder();
        LIST<Document> docs = new LIST<Document>();

        // added below 11 lines (2014/7/18)
        //// object level
        if(!Document.SObjectType.getDescribe().isAccessible())
        {
            return docs;
        }
        //// field level
        if (!Document.Name.getDescribe().isAccessible() 
             || !Document.Id.getDescribe().isAccessible()  
             || !Document.Type.getDescribe().isAccessible()  ){
          return docs;
        }
        
        try{
            folder = [
                select Id, Name, Type
                  from Folder
                 where Name = :ICON_FOLDER
                   and Type = :FOLDER_TYPE
                 limit 1
            ];
        
            docs = [
                select Id, Name, Type
                  from Document
                 where FolderId = :folder.Id
                 order by Name
            ];
        } catch(Exception e) {
            System.debug(e);
        }
        
        return docs;
    }

    static testMethod void testClsChooseIcon() {
        clsChooseIcon ctrl = new clsChooseIcon();        

        ctrl.getIcons();
        ctrl.setIcon();

        MenuInfo__c testMenuItem = new MenuInfo__c();
        insert testMenuItem;
        
        ctrl.targetItem = testMenuItem.id;
        ctrl.IconId = 'xxxxxx';

        ctrl.setIcon();

    }


}