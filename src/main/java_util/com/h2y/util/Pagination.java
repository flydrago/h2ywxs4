package com.h2y.util;



public class Pagination {
	//总的信息数量
	private long totalItems = 1;
	//总页数
	private long totalPages = 1;
	//当前页码page
	private long currentPage = 1;
	//每页显示的分页数
	private long perPageNum = 6;
	//每页显示的图片数pagesize
	private long perPageItem = 10;
	//访问的url地址
	private String url = "";
	
	public Pagination(long totalItems, long currentPage, long perPageItem) {
		this.totalItems = totalItems;
		this.currentPage = currentPage;
		this.perPageItem = perPageItem;
		this.totalPages = (int) Math.ceil((double)((double)totalItems/(double)perPageItem));
		if(this.currentPage > this.totalPages){
			this.currentPage = this.totalPages;
		}
	}


	public long getTotalItems() {
		return totalItems;
	}


	public void setTotalItems(long totalItems) {
		this.totalItems = totalItems;
	}


	public long getTotalPages() {
		return totalPages;
	}


	public void setTotalPages(long totalPages) {
		this.totalPages = totalPages;
	}


	public long getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(long currentPage) {
		this.currentPage = currentPage;
	}


	public long getPerPageNum() {
		return perPageNum;
	}


	public void setPerPageNum(long perPageNum) {
		this.perPageNum = perPageNum;
	}


	public long getPerPageItem() {
		return perPageItem;
	}


	public void setPerPageItem(long perPageItem) {
		this.perPageItem = perPageItem;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
	
	public String createPageHtml(){
		
		String url = this.getUrl();
		long currentPage = this.getCurrentPage();
		long totalPages = this.getTotalPages();
		long perPageNum = this.getPerPageNum();
		String pageHtml = "";
		
		if(totalPages <= perPageNum){//总页数小于等于每页显示的页码数  只有一页的页码数
			
			if(totalPages == 0){
				pageHtml = "";
			}else if(totalPages == 1){//一页上总共就1页码数
				pageHtml = "<li class=\"active\"><a href=\"javascript:void(0)\">1</a></li>";
			}else{//一页上有两页码数以上
				if(currentPage == 1){
					pageHtml = "<li class=\"active\"><a href=\"javascript:void(0);\">" + 1 + "</a></li>";
					for(int i = 2; i <= totalPages; i++){
						pageHtml = pageHtml + "<li class=\"active\"><a href=\"" + url + "&id=" + i + "\">" + i + "</a></li>";
					}
					pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + (currentPage + 1) + "\">&gt;</a></li><br/><li><a href=\"" + url + "&id=" + totalPages + "\">&gt;&gt;</a></li>";
				}else{
					pageHtml = pageHtml + "<li><a href=\"" + url + "&id=1\">&lt;&lt;</a></li><li><a href=\"" + url + "&id=" + (currentPage - 1) + "\">&lt;</a></li>";
					for(int i = 1; i <= totalPages; i++){
						if(i == currentPage){
							pageHtml = pageHtml + "<li class=\"active\"><a href=\"javascript:void(0);\">" + i + "</a></li>";
						}else{
							pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + i + "\">" + i + "</a></li>";
						}
					}
					if( currentPage != totalPages){
						pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + (currentPage + 1) + "\">&gt;</a></li><br/><li><a href=\"" + url + "&id=" + totalPages + "\">&gt;&gt;</a></li>";
					}
				}
				
			}
		}else{//总页数大于每页显示的页码数  两页以上的页码数
			
			if(currentPage == 1){//第一个页码
				pageHtml = "<li class=\"active\"><a href=\"javascript:void(0);\">" + 1 + "</a></li><br/>";
				for(int i = 2; i <= perPageNum; i++){
					pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + i + "\">" + i + "</a></li><br/>";
				}
				pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + (currentPage + 1) + "\">&gt;</a></li><br/><li><a href=\"" + url + "&id=" + totalPages + "\">&gt;&gt;</a></li>";
			}else{//不是第一个页码
				pageHtml = pageHtml +  "<li><a href=\"" + url + "&id=1\">&lt;&lt;</a></li><li><a href=\"" + url + "&id=" + (currentPage - 1) + "\">&lt;</a></li>";
				if(totalPages - currentPage > perPageNum -1){//如果不是最后一页
					for(long i = currentPage; i <= currentPage + perPageNum -1; i++){
						if(i == currentPage){
							pageHtml = pageHtml + "<li class=\"active\"><a href=\"javascript:void(0);\">" + i + "</a></li><br/>";
						}else{
							pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + i + "\">" + i + "</a></li><br/>";
						}
					}
				}else{//如果是最后一页
					for(long i = totalPages - perPageNum + 1; i <= totalPages; i++){
						if(i == currentPage){
							pageHtml = pageHtml + "<li class=\"active\"><a href=\"javascript:void(0);\">" + i + "</a></li><br/>";
						}else{
							pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + i + "\">" + i + "</a></li><br/>";
						}
					}
				}
				if(currentPage != totalPages){
					pageHtml = pageHtml + "<li><a href=\"" + url + "&id=" + (currentPage + 1) + "\">&gt;</a></li><br/><li><a href=\"" + url + "&id=" + totalPages + "\">&gt;&gt;</a></li>";
				}
			}
		}
		return pageHtml;
	}
	public static void main(String[] args) {
		Pagination test = new Pagination(0, 1, 10);
		System.out.println(test.createPageHtml());
	}
	
}
