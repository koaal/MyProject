package com.abc.myproject.util;

import java.util.List;

import com.google.common.collect.Lists;

public class Pager<T> {

    public static final String ASC      = "asc";

    public static final String DESC     = "desc";

    private Long               totalRows;

    private Long               pageSize = 10L;

    private Long               currentPage;

    private Long               totalPages;
    
    private List<T>            results  = Lists.newArrayList();

    private String             sortIndex;

    private String             sortOrder;

    private String             search;

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public Pager() {
    }

    public Pager(Long totalRows, Long currentPage) {
        this.currentPage = currentPage;
        this.totalRows = totalRows;
        initPager(totalRows);
    }

    public Pager(Long totalRows, Long currentPage, Long pageSize) {
        this.currentPage = currentPage;
        this.totalRows = totalRows;
        this.pageSize = pageSize;
        initPager(totalRows);
    }

    public Pager(Long _totalRows, List<T> result) {
        setupPager(_totalRows, result);
    }

    public void setupPager(Long _totalRows, List<T> result) {
        initPager(_totalRows);
        results.addAll(result);
    }

    public Long getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(Long totalRows) {
        this.totalRows = totalRows;
    }

    public Long getPageSize() {
        return pageSize;
    }

    public void setPageSize(Long pageSize) {
        this.pageSize = pageSize;
    }

    public Long getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Long currentPage) {
        this.currentPage = currentPage;
    }

    public Long getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Long totalPages) {
        this.totalPages = totalPages;
    }

    public Long getStartRow() {
        return (currentPage - 1) * pageSize;
    }

    public List<T> getResults() {
        return results;
    }

    public void setResults(List<T> results) {
        this.results = results;
    }

    public String getSortIndex() {
        return sortIndex;
    }

    public void setSortIndex(String sortIndex) {
        this.sortIndex = sortIndex;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    public void initPager(Long _totalRows) {
        totalRows = _totalRows;
        totalPages = totalRows / pageSize;
        Long mod = totalRows % pageSize;
        if (mod > 0) {
            totalPages++;
        }
    }

    public void refresh() {
        try {
            initPager(totalRows);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}