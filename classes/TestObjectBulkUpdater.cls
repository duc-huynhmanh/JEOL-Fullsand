@isTest
private class TestObjectBulkUpdater {

    /**
     * @method
     * 初期画面構築時(init)テスト
     * コントローラ初期化時点で必要なデータがクラスプロパティに格納されている事
     */
    static testMethod void test01 () {
        objectBulkUpdateController c = getController();
        //System.assertEquals(71, c.objects.size());
    }

    /**
     * @method
     * オブジェクト選択完了後テスト
     * 指定オブジェクトのフィールド一覧を取得し、クラスプロパティに格納できている事
     */
    static testMethod void test02 () {
        setCurrentPage();

        objectBulkUpdateController c = getController();
        c.init();
        c.dto.objKey = 'testobject1__c';

        c.objects = new List<SelectOption>();
        c.fieldSerchOpeList = new Map<String,List<SelectOption>>();
        c.dataTypes1 = new List<String>();
        c.resultListChecked = new List<SObject>();
        c.sortOrders = new List<SelectOption>();
        c.sortFields = new List<SelectOption>();

        System.assertEquals(c.objects.isEmpty(), true);

        c.doSelectObject();
        System.assertEquals(true, c.dto.isObjectSelected);
        List<SelectOption> expect = new List<SelectOption> {
            new SelectOption('Name', 'テストオブジェクト1名'),
            new SelectOption('date__c', 'カスタム日付'),
            new SelectOption('OwnerId', '所有者 ID')
        };
        //System.assertEquals(expect, c.fields);

        c.doExport();
        c.next();
        c.previous();
    }

    /**
     * @method
     * 検索フォーム表示時テスト
     * 指定オブジェクトのフィールド一覧表示用プロパティの値が正常である事
     */
    static testMethod void test03 () {
        setCurrentPage();

        objectBulkUpdateController c = getController();
        c.init();

        c.dto.objKey = 'testobject1__c';
        c.dto.selectFields = new List<String>{'Name', 'date__c', 'OwnerId', 'MultiPicklist__c'};
        c.dto.fields = new List<String>{'Name', 'date__c', 'OwnerId', 'MultiPicklist__c'};
        c.selectedHidden = 'Name,date__c,OwnerId,MultiPicklist__c';
        c.doGenerateSearchCriteriaForm();
        System.assertEquals(true, c.dto.isFieldSelected);
        System.assertEquals(c.objects.isEmpty(), false);
        System.assertEquals(c.fieldSerchOpeList.isEmpty(), false);
        System.assertEquals(c.sortOrders.isEmpty(), false);
        System.assertEquals(c.sortFields.isEmpty(), false);
        Map<String, String> expect = new Map<String, String> {
            'Name' => 'テストオブジェクト1名',
            'date__c' => 'カスタム日付',
            'OwnerId' => '所有者 ID',
            'MultiPicklist__c' => 'list1'
        };
        //System.assertEquals(expect, c.dto.fieldNames);
    }

    /**
     * @method
     * 検索実行時テスト
     * 事前に挿入したデータを正常に取得し、クラスプロパティに格納できている事
     */
    static testMethod void test04 () {
        setCurrentPage();

        objectBulkUpdateController c = getController();
        c.init();

        c.dto.objKey = 'testobject1__c';
        c.dto.selectFields = new String[] {'Name', 'date__c', 'OwnerId'};
        c.selectedHidden = 'Name,date__c,OwnerId';
        c.doGenerateSearchCriteriaForm();
        c.dto.sortField = 'Id';
        c.dto.sortOrder = 'asc';
        c.selectedHiddenOpe = 'false,false,false';

        insertTestData();
        c.doSearch();
        System.assertEquals(true, c.dto.isSearched);
        testObject1__c expect = [SELECT Id, Name, date__c, OwnerId FROM testobject1__c];
        System.assertEquals(1, c.resultList.size());
        System.assertEquals(expect, c.resultList[0].result);

        c.doCancel();
        c.doDelete();
    }

    /**
     * @method
     * GETパラメータ付きURLでアクセスした場合のテスト
     * パラメータを読み取って適切にクラスプロパティにデータが格納されている事
     */
    static testMethod void test05 () {
        insertTestData();

        PageReference pr = Page.objectBulkUpdater;
        Map<String, String> params = pr.getParameters();
        params.put('objKey', 'testObject1__c');
        params.put('selectFields', 'Name,date__c');
        params.put('sortField', 'Id');
        params.put('fieldSerchOpe', 'false,false');
        params.put('sortField', 'Id');
        params.put('sortOrder', 'asc');
        params.put('currentPage', '1');
        Test.setCurrentPage(pr);

        objectBulkUpdateController c = getController();
        c.init();
        //System.assertEquals(true, c.dto.isSearched);
        System.assertEquals(1, c.resultList.size());
        testObject1__c expect = [SELECT Id, Name, date__c FROM testobject1__c];
        System.assertEquals(expect, c.resultList[0].result);
    }

    /**
     * @method
     * レコード更新テスト
     * doUpdate メソッドでレコードが更新されている事
     */
    static testMethod void test06 () {
        insertTestData();

        PageReference pr = Page.objectBulkUpdater;
        Map<String, String> params = pr.getParameters();
        params.put('objKey', 'testObject1__c');
        params.put('selectFields', 'Name,date__c');
        params.put('sortField', 'Id');
        params.put('fieldSerchOpe', 'false,false');
        params.put('sortOrder', 'asc');
        params.put('currentPage', '1');
        Test.setCurrentPage(pr);

        objectBulkUpdateController c = getController();
        c.init();

        c.resultList[0].checked = true;
        c.resultList[0].result.put('Name', 'updated');
        c.doUpdate();

        testObject1__c expect = [SELECT Id, Name, date__c FROM testobject1__c];
        System.assertEquals('updated', c.resultList[0].result.get('Name'));
    }

    /**
     * @method
     * テスト
     * 
     */
    static testMethod void test07 () {
    	objectBulkUpdateController c = getController();
        c.init();

        c.dto.objKey = 'testobject1__c';
        c.dto.selectFields = new String[] {'Name', 'date__c', 'OwnerId'};
        c.selectedHidden = 'Name,date__c,OwnerId';
        c.doGenerateSearchCriteriaForm();
        c.dto.sortField = 'Id';
        c.dto.sortOrder = 'asc';
        c.selectedHiddenOpe = '=,false,false';

        insertTestData();
        c.doSearchOnlyResult();
        c.nextOnlyResult ();
        c.previousOnlyResult ();
    }

    /**
     * @method
     * カレントをイニシャルページに設定
     */
    private static void setCurrentPage () {
        PageReference pr = Page.objectBulkUpdater;
        Test.setCurrentPage(pr);
    }

    /**
     * cobjBulkUpdateController インスタンスを取得
     * @return [Object] cobjBulkUpdateController
     */
    private static objectBulkUpdateController getController () {
        return new objectBulkUpdateController();
    }

    private static void insertTestData () {
        testObject1__c record = new testObject1__c(
            Name = 'test1',
            date__c = date.today()
        );
        insert record;
    }
}