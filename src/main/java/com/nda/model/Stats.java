package com.nda.model;


public class Stats {


    public Stats() {
        this.startNo = 0;
        this.pageSize = 0;
        this.page = 0;
        SortColumn = "id";
        SortOrder = "desc";
        this.searchWord = "";
        this.searchColumn = "";
        this.startDate = "";
        this.endDate = "";
        this.todaysQcCount = 0;
        this.qcCount = 0;
        this.rows = 0;
        this.yesterdayDate = "";
        this.todaysDate = "";
        this.id = 0;
        this.query_text = "";
        this.pub_date = "";
        this.query_text_and_response = "";
        this.query_continuation = "";
        this.query_response = "";
        this.query_route = "";
        this.query_type = "";
        this.query_blockkeywords = "";
        this.query_work_status = "";
        this.worker = "";
        this.query_qc = "";
        this.query_work_type = "";
        this.serviceCode = "";
        this.update_date = "";
    }


    public int qc_sum;

    public int getQc_sum() {
        return qc_sum;
    }

    public void setQc_sum(int qc_sum) {
        this.qc_sum = qc_sum;
    }

    public int startNo;
    public int pageSize;
    public int page;
    public String SortColumn;
    public String SortOrder;
    private String searchWord;
    private String searchColumn;
    private String startDate;
    private String endDate;
    private int todaysQcCount;
    private int qcCount;
    private int rows;
    private int id;
    private String query_text;
    private String pub_date;
    private String query_text_and_response;
    private String query_continuation;
    private String query_response;
    private String query_route;
    private String query_type;
    private String query_blockkeywords;
    private String query_work_status;
    private String worker;
    private String query_qc;
    private String query_work_type;
    private String serviceCode;
    private String update_date;
    private String yesterdayDate;
    private String todaysDate;





    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }


    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }


    public String getQuery_blockkeywords() {
        return query_blockkeywords;
    }

    public void setQuery_blockkeywords(String query_blockkeywords) {
        this.query_blockkeywords = query_blockkeywords;
    }

    public String getWorker() {
        return worker;
    }

    public void setWorker(String worker) {
        this.worker = worker;
    }

    public String getQuery_qc() {
        return query_qc;
    }

    public void setQuery_qc(String query_qc) {
        this.query_qc = query_qc;
    }

    public String getQuery_work_type() {
        return query_work_type;
    }

    public void setQuery_work_type(String query_work_type) {
        this.query_work_type = query_work_type;
    }

    public String getServiceCode() {
        return serviceCode;
    }

    public void setServiceCode(String serviceCode) {
        this.serviceCode = serviceCode;
    }

    public String getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(String update_date) {
        this.update_date = update_date;
    }

    public String getQuery_text_and_response() {
        return query_text_and_response;
    }

    public void setQuery_text_and_response(String query_text_and_response) {
        this.query_text_and_response = query_text_and_response;
    }

    public int getQcCount() {
        return qcCount;
    }

    public void setQcCount(int qcCount) {
        this.qcCount = qcCount;
    }

    public String getQuery_text() {
        return query_text;
    }

    public void setQuery_text(String query_text) {
        this.query_text = query_text;
    }

    public String getQuery_response() {
        return query_response;
    }

    public void setQuery_response(String query_response) {
        this.query_response = query_response;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTodaysQcCount() {
        return todaysQcCount;
    }

    public void setTodaysQcCount(int todaysQcCount) {
        this.todaysQcCount = todaysQcCount;
    }

    public String getTodaysDate() {
        return todaysDate;
    }


    public void setTodaysDate(String todaysDate) {
        this.todaysDate = todaysDate;
    }

    public String getYesterdayDate() {
        return yesterdayDate;
    }

    public void setYesterdayDate(String yesterdayDate) {
        this.yesterdayDate = yesterdayDate;
    }


    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getQuery_route() {
        return query_route;
    }

    public void setQuery_route(String query_route) {
        this.query_route = query_route;
    }

    public String getQuery_work_status() {
        return query_work_status;
    }

    public void setQuery_work_status(String query_work_status) {
        this.query_work_status = query_work_status;
    }

    public String getPub_date() {
        return pub_date;
    }

    public void setPub_date(String pub_date) {
        this.pub_date = pub_date;
    }

    public String getQuery_continuation() {
        return query_continuation;
    }

    public void setQuery_continuation(String query_continuation) {
        this.query_continuation = query_continuation;
    }

    public String getQuery_type() {
        return query_type;
    }

    public void setQuery_type(String query_type) {
        this.query_type = query_type;
    }

    public String getSearchColumn() {
        return searchColumn;
    }

    public void setSearchColumn(String searchColumn) {
        this.searchColumn = searchColumn;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public int getStartNo() {
        return startNo;
    }

    public void setStartNo(int startNo) {
        this.startNo = startNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getSortColumn() {
        return SortColumn;
    }

    public void setSortColumn(String sortColumn) {
        SortColumn = sortColumn;
    }

    public String getSortOrder() {
        return SortOrder;
    }

    public void setSortOrder(String sortOrder) {
        SortOrder = sortOrder;
    }




    @Override
    public String toString() {
        return "Stats{" +
                "startNo=" + startNo +
                ", pageSize=" + pageSize +
                ", page=" + page +
                ", SortColumn='" + SortColumn + '\'' +
                ", SortOrder='" + SortOrder + '\'' +
                ", searchWord='" + searchWord + '\'' +
                ", searchColumn='" + searchColumn + '\'' +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", todaysQcCount=" + todaysQcCount +
                ", qcCount=" + qcCount +
                ", rows=" + rows +
                ", id=" + id +
                ", query_text='" + query_text + '\'' +
                ", pub_date='" + pub_date + '\'' +
                ", query_text_and_response='" + query_text_and_response + '\'' +
                ", query_continuation='" + query_continuation + '\'' +
                ", query_response='" + query_response + '\'' +
                ", query_route='" + query_route + '\'' +
                ", query_type='" + query_type + '\'' +
                ", query_blockkeywords='" + query_blockkeywords + '\'' +
                ", query_work_status='" + query_work_status + '\'' +
                ", worker='" + worker + '\'' +
                ", query_qc='" + query_qc + '\'' +
                ", query_work_type='" + query_work_type + '\'' +
                ", serviceCode='" + serviceCode + '\'' +
                ", update_date='" + update_date + '\'' +
                ", yesterdayDate='" + yesterdayDate + '\'' +
                ", todaysDate='" + todaysDate + '\'' +
                '}';
    }
}

