package com.nda.model;

public class JqGridObject {
    public int startNo;
    public int pageSize;
    public String SortColumn;
    public String SortOrder;
    private String searchWord;
    private String searchColumn;
    private String query_type;
    private String query_route;
    private String query_continuation;
    private String pub_date;
    private String query_work_status;

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
}

