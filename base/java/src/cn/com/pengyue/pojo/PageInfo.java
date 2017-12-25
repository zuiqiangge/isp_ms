package cn.com.pengyue.pojo;

//分页信息
public class PageInfo implements Cloneable {
	private static final int DEFAULT_PAGE_NO = 1;
	public static final int DEFAULT_PAGE_SIZE = 15;
	private int pageNo = DEFAULT_PAGE_NO;
	private int pageSize = DEFAULT_PAGE_SIZE;
	private int totalSize;
	private int maxPageNo;
	private int firstNo = 0;
	private int endNo = 0;
	private boolean needSetTotalSize = true;

	public int getPageNo() {
		return pageNo;
	}
	
	public boolean isHasFirst() {
		if (pageNo == 1||pageNo==0)
			return false;
		return true;
	}
	
	public boolean isHasLast() {

		if (pageNo == maxPageNo)
			return false;
		return true;
	}
	
	public boolean isHasPrevious() {
		return isHasFirst();
	}

	public void setPageNo(int pageNo) {
		if (pageNo <= 0) {
			pageNo = DEFAULT_PAGE_NO;
		}
		this.pageNo = pageNo;
		setFirstAndEndNo0();
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		if (pageSize <= 0) {
			pageSize = DEFAULT_PAGE_SIZE;
		}
		this.pageSize = pageSize;
		setFirstAndEndNo0();
	}

	public int getMaxPageNo() {
		return maxPageNo;
	}

	public int getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;

		// 计算最大页数
		if (pageSize != 0) {
			maxPageNo = totalSize / pageSize;
			if (this.totalSize % pageSize != 0) {
				maxPageNo++;
			}
		}
		setFirstAndEndNo0();
	}

	public int getFirstNo() {
		return firstNo;
	}

	public int getEndNo() {
		return endNo;
	}

	private void setFirstAndEndNo0() {
		firstNo = pageSize * (pageNo - 1);
		if (firstNo < 0) {
			firstNo = 0;
		}
		if (firstNo > totalSize) {
			firstNo = totalSize;
		}
		endNo = pageSize * pageNo;
		if (endNo < 0) {
			endNo = 0;
		}
		if (endNo > totalSize) {
			endNo = totalSize;
		}
	}

	public boolean isNeedSetTotalSize() {
		return needSetTotalSize;
	}

	public void setNeedSetTotalSize(boolean needSetTotalSize) {
		this.needSetTotalSize = needSetTotalSize;
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	public boolean isHasNext() {
		return maxPageNo>pageNo;
	}
}
