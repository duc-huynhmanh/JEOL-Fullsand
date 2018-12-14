public with sharing class objectBulkUpdateController {
    /**
     * @class
     * VF <=> Apex データ受け渡し用DTO
     */
    public class DTO {
        public String objKey { get; set; }
        public SObject obj { get; set; }
        public List<String> selectFields { get; set; }
        public List<String> fields { get; set; }
        public List<String> fieldSerchOpe { get; set; }
        public Map<String, String> fieldNames { get; set; }
        public Map<String, String> fieldSerchKeys { get; set; }
        public Map<String, String> fieldTypes { get; set; }
        public Map<String, String> fieldUnEditValues { get; set; }
        public Map<String, Boolean> fieldEditFlgs { get; set; }
        public Map<String, Boolean> fieldPicklistFlgs { get; set; }
        public List<String> fieldKeys { get; set; }
        public List<String> fieldKeysEdit { get; set; }
        public List<String> fieldKeysNotEdit { get; set; }
        public String sortField { get; set; }
        public String sortOrder { get; set; }
        public Boolean isObjectSelected { get; set; }
        public Boolean isFieldSelected { get; set; }
        public Boolean isSearched { get; set; }
        public Integer currentPage { get; set; }
        public Boolean onlyResultFlg { get; set; }
        public Boolean isPersonAccountFlg { get; set; }
    }

    /** @property DTOインスタンス */
    public DTO dto { get; set; }

    /** @property オブジェクトプルダウンに表示する項目List */
    public List<SelectOption> objects {
        get {
            if (objects != null) return objects;
            objects = new List<SelectOption>();
            //objects.add(new SelectOption('false', '選択して下さい'));
            Map<String, Schema.SObjectType> all = Schema.getGlobalDescribe();
            for (String key: all.keySet()) {
                Schema.DescribeSObjectResult sr = all.get(key).getDescribe();
                if (sr.isAccessible() && sr.isUpdateable())
                    objects.add(new SelectOption(key, sr.getLabel().replaceAll(' ID$', '')));
            }
            return objects;
        }
        set;
    }

    /** @property 項目の検索条件List */
    public Map<String,List<SelectOption>> fieldSerchOpeList {
        get {
            fieldSerchOpeList = new Map<String,List<SelectOption>>();
            for (String fn: this.dto.fieldTypes.keySet()) {
                List<SelectOption> so = new List<SelectOption>();
                Boolean notEditFlg = true;
                /*for(String notEdit: this.dto.fieldKeysNotEdit){
                    if(fn.equals(notEdit)){
                        so.add(new SelectOption('false', '編集不可項目'));
                        //notEditFlg = false;
                        break;
                    }
                }*/
                if(notEditFlg){
                    so.add(new SelectOption('false', '条件指定なし'));
                    so.add(new SelectOption('=', '文字列と一致する'));
                    so.add(new SelectOption('!=', '文字列と一致しない'));
                    for(String dt1: dataTypes1){
                        if(!dt1.equals(this.dto.fieldTypes.get(fn))) continue;
                        so.add(new SelectOption('<', '<'));
                        so.add(new SelectOption('>', '>'));
                        so.add(new SelectOption('<=', '<='));
                        so.add(new SelectOption('>=', '>='));
                        break;
                    }
                    for(String dt2: dataTypes2){
                        if(!dt2.equals(this.dto.fieldTypes.get(fn))) continue;
                        so.add(new SelectOption('LIKE', '次の文字列を含む'));
                        so.add(new SelectOption('NOTLIKE', '次の文字列を含まない'));
                        so.add(new SelectOption('STARTLIKE', '次の文字列で始まる'));
                        break;
                    }
                    for(String dt3: dataTypes3){
                        if(!dt3.equals(this.dto.fieldTypes.get(fn))) continue;
                        so.add(new SelectOption('INCLUDES', '次の値を含む'));
                        so.add(new SelectOption('EXCLUDES', '次の値を含まない'));
                        break;
                    }
                }
                fieldSerchOpeList.put(fn,so);
            }
            return fieldSerchOpeList;
        }
        set;
    }
    /** @property データ型List1 */
    public List<String> dataTypes1 {
        get {
            dataTypes1= new List<String>();
            dataTypes1.add('CURRENCY');
            dataTypes1.add('DATE');
            dataTypes1.add('DATETIME');
            dataTypes1.add('DOUBLE');
            dataTypes1.add('EMAIL');
            dataTypes1.add('INTEGER');
            dataTypes1.add('PERCENT');
            dataTypes1.add('PHONE');
            dataTypes1.add('PICKLIST');
            dataTypes1.add('STRING');
            dataTypes1.add('TEXTAREA');
            dataTypes1.add('URL');
            dataTypes1.add('COMBOBOX');
            return dataTypes1;
        }
        set;
    }
    /** @property データ型List2 */
    public List<String> dataTypes2 {
        get {
            dataTypes2= new List<String>();
            dataTypes2.add('EMAIL');
            dataTypes2.add('PHONE');
            dataTypes2.add('PICKLIST');
            dataTypes2.add('STRING');
            dataTypes2.add('TEXTAREA');
            dataTypes2.add('URL');
            dataTypes2.add('COMBOBOX');
            return dataTypes2;
        }
        set;
    }
    /** @property データ型List3 */
    public List<String> dataTypes3 {
        get {
            dataTypes3= new List<String>();
            dataTypes3.add('MULTIPICKLIST');
            return dataTypes3;
        }
        set;
    }

    /**
     * @class
     * VF <=> Apex レコード検索結果&編集内容受け渡し用DTO
     */
    public class resultDTO {
        public Boolean checked { get; set; }
        public SObject result { get; set; }

        public resultDTO () {
            checked = false;
        }
    }
    /** @property 検索結果レコード */
    public List<resultDTO> resultList { get; set; }

    public Integer resultCount { get; set; }
    
    public List<SObject> resultListChecked { get; set; }

    /** @property ソート順 */
    public List<SelectOption> sortOrders {
        get {
            if (sortOrders != null) return sortOrders;
            sortOrders = new List<SelectOption>();
            sortOrders.add(new SelectOption('asc', '昇順'));
            sortOrders.add(new SelectOption('desc', '降順'));
            return sortOrders;
        }
        set;
    }

    /** @property ソートフィールド */
    public List<SelectOption> sortFields {
        get {
            if (this.dto.objKey == '') return sortFields;
            sortFields = new List<SelectOption>();
            Schema.SObjectType st = Schema.getGlobalDescribe().get(this.dto.objKey);
            Schema.DescribeSObjectResult sr = st.getDescribe();
            Map<String, Schema.SObjectField> fmap = sr.fields.getMap();
            for (Schema.SObjectField field: fmap.values()) {
                Schema.DescribeFieldResult fr = field.getDescribe();
                if (fr.isSortable()) sortFields.add(new SelectOption(fr.getName(), fr.getLabel().replaceAll(' ID$', '')));
            }
            return sortFields;
        }
        set;
    }

    /** @property 項目選択リストに表示する、選択されたオブジェクトのフィールド一覧List */
    public List<SelectOption> fields { get; set; }
    /** @property 選択済みフィールド名(VFのinput hiddenにバインド) */
    public String selectedHidden { get; set; }
    /** @property 選択済み検索条件演算子(VFのinput hiddenにバインド) */
    public String selectedHiddenOpe { get; set; }


    /**
     * @constructor
     */
    public objectBulkUpdateController () {}


    /**
     * @method
     * 初期画面構築
     */
    public void init () {
        this.dto = new DTO();
        this.resultList = new List<resultDTO>();
        this.dto.currentPage = 1;
        this.setPropertiesFromRequestParam();
        this.dto.onlyResultFlg = false;
    }


    /**
     * @method
     * カスタムオブジェクト選択済み、オブジェクトのフィールド一覧を取得
     */
    public PageReference doSelectObject () {
        if (this.dto.objKey == '' || this.dto.objKey == 'false') return null;
        this.fields = new List<SelectOption>();
        // 2017-02-add 個人取引先の場合の処理
        this.dto.isPersonAccountFlg = false;
        if ('account'.equals(this.dto.objKey)) {
            for (Schema.SObjectField field: this.getSObjectFields(this.dto.objKey)) {
                Schema.DescribeFieldResult fr = field.getDescribe();
                if ('IsPersonAccount'.equals(fr.getName())) this.dto.isPersonAccountFlg = true;
            }
            for (Schema.SObjectField field: this.getSObjectFields(this.dto.objKey)) {
                Schema.DescribeFieldResult fr = field.getDescribe();
                // 個人取引先のレコードタイプは表示も出来ない為除外
                if (this.dto.isPersonAccountFlg && 'RecordTypeId'.equals(fr.getName())) continue;
                // 個人取引先項目は強制的に選択させるので除外
                if (this.dto.isPersonAccountFlg && 'IsPersonAccount'.equals(fr.getName())) continue;
                if (!fr.isFilterable()) continue; // Whereの条件指定で使用不可
                if (!fr.isAccessible()) continue; // 参照不可
                if (fr.isExternalID()) continue;  // 外部ID
                if ('ADDRESS'.equals(String.valueOf(fr.getType()))) continue;
                this.fields.add(new SelectOption(fr.getName(), fr.getLabel().replaceAll(' ID$', '')));
            }
        }
        else{
            for (Schema.SObjectField field: this.getSObjectFields(this.dto.objKey)) {
                Schema.DescribeFieldResult fr = field.getDescribe();
                if (!fr.isFilterable()) continue; // Whereの条件指定で使用不可
                if (!fr.isAccessible()) continue; // 参照不可
                //if (!fr.isUpdateable()) continue; // 編集不可
                if (fr.isExternalID()) continue;  // 外部ID
                if ('ADDRESS'.equals(String.valueOf(fr.getType()))) continue;
                if ('EmailBouncedDate'.equals(fr.getName())) continue;
                if ('EmailBouncedReason'.equals(fr.getName())) continue;
                // @MEMO: Order.ActivatedDate Order.ActivatedById は自動入力項目であり、ユーザ入力が拒否される為除外
                // @MEMO: order.StatusCode も、ユーザ入力が拒否される為除外
                if ('order'.equals(this.dto.objKey)) {
                    if ('ActivatedDate'.equals(fr.getName())) continue;
                    if ('ActivatedById'.equals(fr.getName())) continue;
                    if ('StatusCode'.equals(fr.getName())) continue;
                }
                this.fields.add(new SelectOption(fr.getName(), fr.getLabel().replaceAll(' ID$', '')));
            }
        }
//        this.dto.currentPage = 1;
        this.dto.isObjectSelected = true;
        this.dto.isFieldSelected = false;
        this.dto.isSearched = false;

        return null;
    }

    /**
     * @method
     * 項目選択済み、検索フォームを生成する為に選択されたオブジェクトと項目を特定する
     */
    public PageReference doGenerateSearchCriteriaForm () {
        this.dto.fieldNames = new Map<String, String>();
        this.dto.fieldTypes = new Map<String, String>();
        this.dto.fieldUnEditValues = new Map<String, String>();
        this.dto.fieldEditFlgs = new Map<String, Boolean>();
        this.dto.fieldPicklistFlgs = new Map<String, Boolean>();
        this.dto.fieldKeys = new List<String>();
        this.dto.fieldKeysEdit = new List<String>();
        this.dto.fieldKeysNotEdit = new List<String>();
        this.dto.selectFields = this.selectedHidden.split(',', 0);
        this.dto.fieldSerchKeys = new Map<String,String>();
        for (String key: this.dto.selectFields) {
            for (Schema.SObjectField field: this.getSObjectFields(this.dto.objKey)) {
                Schema.DescribeFieldResult fr = field.getDescribe();
                if (!key.equals(fr.getName())) continue;
                this.dto.fieldNames.put(key, fr.getLabel().replaceAll(' ID$', ''));
                this.dto.fieldTypes.put(key, String.valueOf(fr.getType()));
                this.dto.fieldEditFlgs.put(key, fr.isUpdateable());
                if(fr.getType() == Schema.DisplayType.PICKLIST) this.dto.fieldPicklistFlgs.put(key, FALSE);
                else this.dto.fieldPicklistFlgs.put(key, TRUE);
                this.dto.fieldSerchKeys.put(key, 'false');
                this.dto.fieldKeys.add(key);
                this.dto.fieldUnEditValues.put(key, '');
                if (fr.isUpdateable() && fr.isAccessible()){
                    this.dto.fieldKeysEdit.add(key);
                } else {
                    this.dto.fieldKeysNotEdit.add(key);
                }
            }
        }
        this.dto.isFieldSelected = true;
        this.dto.isSearched = false;
        this.dto.obj = Schema.getGlobalDescribe().get(this.dto.objKey).newSObject();
        return null;
    }

    /**
     * @method
     * 検索を実行する
     */
    public PageReference doSearch () {
        this.dto.fieldSerchKeys = new Map<String, String>();
        this.dto.fieldSerchOpe = this.selectedHiddenOpe.split(',', 0);
        Integer i = 0;
        for (String key: this.dto.selectFields) {
            for (Schema.SObjectField field: this.getSObjectFields(this.dto.objKey)) {
                Schema.DescribeFieldResult fr = field.getDescribe();
                if (!key.equals(fr.getName())) continue;
                this.dto.fieldSerchKeys.put(key, this.dto.fieldSerchOpe[i]);
            i++;
            }
        }
        this.dto.fieldUnEditValues.put('test', 'test');
        //List<String> wheres = this.generateWhereClauseList(this.dto.objKey, this.dto.fieldNames.keySet(), this.dto.fieldSerchKeys);
        String wheres = this.generateWhereClauseList(this.dto.objKey, this.dto.fieldNames.keySet(), this.dto.fieldSerchKeys);
        //system.debug('wheres★'+wheres);
        String countQuery = 'SELECT COUNT() FROM ' + this.dto.objKey + ' ';
        String query = 'SELECT ' + String.join(this.dto.selectFields, ',') + ' FROM ' + this.dto.objKey + ' ';
        //if (wheres.size() > 0) {
        //    query += 'WHERE ' + String.join(wheres, ' AND ') + ' ';
        //    countQuery += 'WHERE ' + String.join(wheres, ' AND ') + ' ';
        //}
        if(wheres != null && wheres != ''){
            query += 'WHERE ' + wheres + ' ';
            countQuery += 'WHERE ' + wheres + ' ';
        }
        query += 'ORDER BY ' + this.dto.sortField + ' ' + this.dto.sortOrder + ' ';
        query += 'LIMIT 200';
        if (this.dto.currentPage > 1) {
            query += ' OFFSET ' + String.valueOf((this.dto.currentPage - 1) * 200);
        }
        try {
            //system.debug('query:'+query);
            this.resultCount = database.countQuery(countQuery);
            this.resultList = this.rehashSearchResult(database.query(query));
            this.dto.isSearched = true;
            return this.getAdditionalParamsPageRef();
        } catch (Exception ex) {
            ApexPages.addMessages(ex);
            return null;
        }
    }

    /**
     * @method
     * 検索を実行し、データ一括処理_検索結果画面を表示
     */
    public PageReference doSearchOnlyResult () {
        this.doSearch();
        this.dto.onlyResultFlg = true;
        return this.getAdditionalParamsPageRef();
    }
    
    /**
     * @method
     * 一括更新を実行
     */
    public PageReference doUpdate () {
        List<SObject> updates = new List<SObject>();
        for (resultDTO result: this.resultList) {
            if (!result.checked) continue;
            updates.add(result.result);
        }
        if (updates.size() > 0) update updates;
        return null;
    }

    /**
     * @method
     * 編集をキャンセルし、入力を全て元に戻す
     */
    public PageReference doCancel () {
        this.doSearch();
        return null;
    }

    /**
     * @method
     * 一括削除を実行
     */
    public PageReference doDelete () {
        List<SObject> deletes = new List<SObject>();
        for (resultDTO result: this.resultList) {
            if (!result.checked) continue;
            deletes.add(result.result);
        }
        if (deletes.size() > 0) delete deletes;
        this.doSearch();
        return null;
    }

    /**
     * @method
     * ファイル出力を実行する
     */
    public PageReference doExport () {
        PageReference pr = null;
        this.resultListChecked = new List<SObject>();
        for (resultDTO result: this.resultList) {
            if (!result.checked) continue;
            resultListChecked.add(result.result);
        }
        if (resultListChecked.size() > 0) pr = Page.objectBulkExportExcel;
        return pr;
    }

    /**
     * @method
     * 次のページを表示する
     */
    public PageReference next () {
        this.dto.currentPage++;
        return this.getAdditionalParamsPageRef();
    }

    /**
     * @method
     * 前のページを表示する
     */
    public PageReference previous () {
        this.dto.currentPage--;
        return this.getAdditionalParamsPageRef();
    }

    /**
     * @method
     * 次のページを表示する(データ一括処理_検索結果画面)
     */
    public PageReference nextOnlyResult () {
        this.dto.onlyResultFlg = true;
        return this.next();
    }

    /**
     * @method
     * 前のページを表示する(データ一括処理_検索結果画面)
     */
    public PageReference previousOnlyResult () {
        this.dto.onlyResultFlg = true;
        return this.previous();
    }

    /**
     * @method
     * 検索結果レコード配列をVFへ返すよう、DTOListに詰め替える
     */
    private List<resultDTO> rehashSearchResult (SObject[] searchResult) {
        List<resultDTO> ret = new List<resultDTO>();
        for (SObject result: searchResult) {
            resultDTO temp = new resultDTO();
            temp.result = result;
            ret.add(temp);
        }
        return ret;
    }

    /**
     * @method
     * 引数で指定されたオブジェクト名とフィールド名から、where句向けのListを生成する
     * @param objectName [String] 対象オブジェクトAPI名
     * @param fieldNames [Set<String>] 対象フィールドAPI名
     * @return [List<String>] where句向けList<String>
     * @example [field = 'value', field2 = 2014-01-01...]
     */
    //private List<String> generateWhereClauseList (String objectName, Set<String> fieldNames, Map<String, String> fieldSerchKey) {
    private String generateWhereClauseList (String objectName, Set<String> fieldNames, Map<String, String> fieldSerchKey) {
        //List<String> wheres = new List<String> ();
        List<String> whereList = new List<String> ();
        List<String> logicList = new List<String> ();
        List<String> fieldList = new List<String> ();
        Map<String, Schema.SObjectField> fmap =
            Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        try {
            for (String fn: fieldNames) {
                String values = String.valueOf(this.dto.obj.get(fn));
                if (values == null) values = String.valueOf(this.dto.fieldUnEditValues.get(fn));
                String[] valueAry = values.split(',', 0);
                //System.debug('valueAry★'+valueAry);
                String con = fieldSerchKey.get(fn);
                //if (String.isEmpty(value)) continue;
                if('false'.equals(con)) continue;
                Integer i = 1;
                for (String value: valueAry){
                    con = fieldSerchKey.get(fn);
                    // 検索条件
                    if('NOTLIKE'.equals(con)) {
                        value = '\'%' + value + '%\'';
                        con = ' LIKE ';
                        //wheres.add( ' (NOT ' + fn + con + value + ')');
                        whereList.add( ' (NOT ' + fn + con + value + ')');
                        logicList.add(' AND ');
                        fieldList.add(fn);
                        i++;
                        continue;
                    } else if('LIKE'.equals(con)) {
                        value = '\'%' + value + '%\'';
                        con = ' LIKE ';
                    } else if ('STARTLIKE'.equals(con)) {
                        value = '\'' + value + '%\'';
                        con = ' LIKE ';
                    } else if ('INCLUDES'.equals(con)){
                        value = '(\'' + value + '\')';
                        con = ' INCLUDES ';
                    } else if ('EXCLUDES'.equals(con)){
                        value = '(\'' + value + '\')';
                        con = ' EXCLUDES ';
                    }
                    // 項目の型 
                    else if (fmap.get(fn).getDescribe().getType() == Schema.DisplayType.CURRENCY || 
                       fmap.get(fn).getDescribe().getType() == Schema.DisplayType.DOUBLE ||
                       fmap.get(fn).getDescribe().getType() == Schema.DisplayType.INTEGER ||
                       fmap.get(fn).getDescribe().getType() == Schema.DisplayType.Boolean ||
                       fmap.get(fn).getDescribe().getType() == Schema.DisplayType.PERCENT ||
                       fmap.get(fn).getDescribe().getType() == Schema.DisplayType.Date ||
                       fmap.get(fn).getDescribe().getType() == Schema.DisplayType.Datetime
                       ) {
                        if (('<'.equals(con) || '>'.equals(con) || '<='.equals(con) || '>='.equals(con)) && (value == null || value == '')) {
                            continue;
                        } else if (fmap.get(fn).getDescribe().getType() == Schema.DisplayType.Date && (value != null || value == '')) {
                            String[] spl = value.split(' ', 0);
                            value = spl[0];
                        } else if (fmap.get(fn).getDescribe().getType() == Schema.DisplayType.Datetime && (value != null || value == '')) {
                            Datetime dt = Datetime.valueOf(value);
                            value = dt.format('yyyy-MM-dd\'T\'hh:mm:ss.SSS\'Z\'');
                        } else if (value == null || value == ''){
                            value = ' null ';
                        }
                    } 
                    // null対応
                    else if (value == null || value == ''){
                        value = '\'\'';
                    }
                    // 通常
                    else {
                        value = '\'' + value + '\'';
                    }
                    // ANDかORを付加
                    // 項目が参照型
                    if(fmap.get(fn).getDescribe().getType() == Schema.DisplayType.Reference && this.dto.fieldUnEditValues.get(fn) != '' ){
                        //wheres.add(fmap.get(fn).getDescribe().getRelationshipName() + '.Name' + con + value);
                        whereList.add(fmap.get(fn).getDescribe().getRelationshipName() + '.Name' + con + value);
                        logicList.add(' AND ');
                        fieldList.add(fn);
                    }
                    // 通常
                    else{
                        //wheres.add(fn + con + value);
                        whereList.add(fn + con + value);
                        //if(i != valueAry.size()) logicList.add(' OR ');
                        // 最後の「','で区切られた検索値」ではないとき
                        // 同じ項目でwhere条件リストを追加するとき
                        // 検索条件が'!='のときは同じ項目の検索値を' AND 'で結合する
                        if(i != valueAry.size()){
                            if('!='.equals(con)) logicList.add(' AND ');
                            else logicList.add(' OR ');
                        } 
                        else logicList.add(' AND ');
                        fieldList.add(fn);
                    }
                    i++;
                }
            }
        } catch (Exception ex) {
            ApexPages.addMessages(ex);
        }
        String whereStr2 = '';
        Integer inte = 0;
        Boolean flg = true;
        // where条件リストがある場合、はじめに'('を付ける
        if(whereList.size() > 0) whereStr2 += '(';
        for(String w : whereList){
            // where条件リストの値
            whereStr2 += w;
            // 最後のwhere条件リストではないとき
            // 次のfieldリストがあるとき
            if(whereList.size() != inte+1){
                // 次のfieldリストの値が同じとき
                // where条件リストの値 + ロジックリストの値
                if(fieldList[inte].equals(fieldList[inte+1])){
                    whereStr2 += logicList[inte];
                }
                // 次のfieldリストの値が同じではないとき
                // where条件リストの値 + ')' + ロジックリストの値 + '('
                else{
                    whereStr2 += ')';
                    whereStr2 += logicList[inte];
                    whereStr2 += '(';
                }
            }
            inte ++;
            /*if(flg == true && ' OR '.equals(logicList[inte])){
                whereStr2 += '(';
                flg = false;
            }
            whereStr2 += w;
            if(flg == false && inte >= 1 && ' OR '.equals(logicList[inte-1]) && ' AND '.equals(logicList[inte])){
                whereStr2 += ')';
                flg = true;
            }
            if(inte+1 != whereList.size()) whereStr2 += logicList[inte];*/
        }
        // where条件リストがある場合、終わりに'('を付ける
        if(whereList.size() > 0) whereStr2 += ')';
        //System.debug('whereStr2★'+whereStr2);

        //return wheres;
        return whereStr2;
    }

    /**
     * @method
     * GETパラメータ付きURLへ遷移させるPageReferenceを生成する
     * @return [PageReference] GETパラメータ+リダイレクト指定付与のPageReference
     */
    private PageReference getAdditionalParamsPageRef () {
        PageReference pr = Page.objectBulkUpdater;
        if(this.dto.onlyResultFlg == null) this.dto.onlyResultFlg = false;
        if(this.dto.onlyResultFlg){
            pr = Page.objectBulkUpdaterResult;
            this.dto.onlyResultFlg = false;
        } 
        //PageReference pr = new PageReference(System.currentPageReference().getUrl());
        if (!String.isEmpty(this.dto.objKey))
            pr.getParameters().put('objKey', this.dto.objKey);
        if (this.dto.selectFields != null && this.dto.selectFields.size() > 0)
            pr.getParameters().put('selectFields', String.join(this.dto.selectFields, ','));
        if (this.dto.fieldSerchOpe != null && this.dto.fieldSerchOpe.size() > 0){
            pr.getParameters().put('fieldSerchOpe', String.join(this.dto.fieldSerchOpe, ','));}
        if (!String.isEmpty(this.dto.sortOrder)) {
            pr.getParameters().put('sortOrder', this.dto.sortOrder);
            pr.getParameters().put('sortField', this.dto.sortField);
            pr.getParameters().put('currentPage', String.valueOf(this.dto.currentPage));
            for (String key: this.dto.fieldNames.keySet()) {
                Boolean editFlg = true;
                for (String notEdit: this.dto.fieldKeysNotEdit){
                    if (key.equals(notEdit)) {
                        pr.getParameters().put(key, String.valueOf(this.dto.fieldUnEditValues.get(key)));
                        editFlg = false;
                        break;
                    }
                }
                if (editFlg){
                    pr.getParameters().put(key, String.valueOf(this.dto.obj.get(key)));
                }
            }
        }
        pr.setRedirect(true);
        return pr;
    }
    
    /**
     * @method
     * リクエストパラメータ付きで起動された場合、リクエストパラメータをプロパティにセットする
     */
    private void setPropertiesFromRequestParam () {
        Map<String, String> params = System.currentPageReference().getParameters();
        List<String> keys = new List<String> {'objKey', 'selectFields', 'fieldSerchOpe', 'sortOrder'};
        for (String key: params.keySet()) {
            if (key == 'objKey') {
                this.dto.objKey = params.get(key);
                this.doSelectObject();
            }
            if (key == 'selectFields') {
                this.selectedHidden = params.get(key);
                this.dto.selectFields = params.get(key).split(',', 0);
                this.doGenerateSearchCriteriaForm();
            }
            if (key == 'fieldSerchOpe') {
                this.selectedHiddenOpe = params.get(key);
                this.dto.fieldSerchOpe = params.get(key).split(',', 0);
                //this.doGenerateSearchCriteriaForm();
                this.dto.fieldSerchKeys = new Map<String, String>();
                this.dto.fieldSerchOpe = this.selectedHiddenOpe.split(',', 0);
                Integer i = 0;
                for (String key2: this.dto.fieldSerchOpe) {
                    this.dto.fieldSerchKeys.put(key2, this.dto.fieldSerchOpe[i]);
                    i++;
                }
            }
            if (key == 'sortOrder') {
                this.dto.sortField = params.get('sortField');
                this.dto.sortOrder = params.get(key);
                this.dto.currentPage = Integer.valueOf(params.get('currentPage'));
                Map<String, Schema.SObjectField> fmap = 
                    Schema.getGlobalDescribe().get(this.dto.objKey).getDescribe().fields.getMap();
                for (String key2: params.get('selectFields').split(',', 0)) {
                    Boolean editFlg = true;
                    for (String notEdit: this.dto.fieldKeysNotEdit){
                        if (key2.equals(notEdit)) {
                            if (params.get(key2) != null){
                                this.dto.fieldUnEditValues.put(key2, params.get(key2));
                            } else{
                                this.dto.fieldUnEditValues.put(key2, '');
                            }
                            editFlg = false;
                            break;
                        }
                    }
                    if (editFlg){
                        if (params.get(key2) != null && fmap.get(key2).getDescribe().getType() == Schema.DisplayType.Boolean) {
                           this.dto.obj.put(key2, Boolean.valueOf(params.get(key2)));
                        } else if (params.get(key2) != null && 
                            (fmap.get(key2).getDescribe().getType() == Schema.DisplayType.Currency ||
                             fmap.get(key2).getDescribe().getType() == Schema.DisplayType.PERCENT)) {
                            this.dto.obj.put(key2, Decimal.valueOf(params.get(key2)));
                        } else if (params.get(key2) != null && fmap.get(key2).getDescribe().getType() == Schema.DisplayType.Double) {
                            this.dto.obj.put(key2, Double.valueOf(params.get(key2)));
                        } else if (params.get(key2) != null && fmap.get(key2).getDescribe().getType() == Schema.DisplayType.Integer) {
                            this.dto.obj.put(key2, Integer.valueOf(params.get(key2)));
                        } else if (params.get(key2) != null && fmap.get(key2).getDescribe().getType() == Schema.DisplayType.Date) {
                            this.dto.obj.put(key2, Date.valueOf(params.get(key2)));
                        } else if (params.get(key2) != null && fmap.get(key2).getDescribe().getType() == Schema.DisplayType.Datetime) {
                            this.dto.obj.put(key2, Datetime.valueOf(params.get(key2)).addHours(9));
                        //} else if (key2) == null){
                            //this.dto.obj.put(key2, '');
                        } else {
                            this.dto.obj.put(key2, params.get(key2));
                        }
                    }
                }
                this.doSearch();
            }
        }
    }

    /**
     * @method
     * 指定オブジェクトのフィールドリストを取得する
     * @param objectName [String] オブジェクトのAPI参照名
     * @return [List<Schema.SObjectField>] フィールドList
     */
    private List<Schema.SObjectField> getSObjectFields (String objectName) {
        Schema.DescribeSObjectResult sr = Schema.getGlobalDescribe().get(objectName).getDescribe();
        return sr.fields.getMap().values();
    }

}