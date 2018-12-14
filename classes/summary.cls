@RestResource(urlMapping='/summary/*')
global with sharing class summary {

  // 現時点では POST のみを受け入れ
  // 引数は JSON形式で、"reportId" に、レポートのIDを指定する必要があります
    @HttpPost
    global static Integer doPost(String reportId) {
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId, true);
        MAP<String,Reports.ReportFact> summary = results.getFactMap();
        LIST<Reports.SummaryValue> aggr = summary.get('T!T').getAggregates();

        return Integer.valueOf(aggr[0].getValue());        
    }
}