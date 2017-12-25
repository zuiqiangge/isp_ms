package cn.com.pengyue.dao.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.springframework.dao.DataAccessException;

import cn.com.pengyue.pojo.Relashipable;

public abstract class RelashipCacheBaseDao<T extends Relashipable<T,PK>, PK extends Serializable>  extends CachedBaseDao<T, PK>{
	 
	public void afterPropertiesSet() throws Exception {
		super.afterPropertiesSet();
		reshipCates(data.values(), null);
	}
	
	//工具方法 处理建立父级树形结构关系。
	public static <T extends Relashipable<T,PK> ,PK extends Serializable>  void reshipCates(Collection<T> values, T parent) {
		for (T t : values) {
			if (parent == null) {
				reshipCates(values, t);
			} else if (parent.getId() == t.getParentId()) {
				parent.getChilds().add(t);
				t.setParent(parent);
			}
		}
	}
	
	public void create(T t) throws DataAccessException {
		super.create(t);

		setParentAndChilds(t);
	}

	private void setParentAndChilds(T t) {
		if (t.getParentId() != null) {
			T parent = data.get(t.getParentId());
			if (parent == null)
				return;
			t.setParent(parent);
			parent.getChilds().add(t);
		}
	}
	
	

	@Override
	public void delete(T t) {
		super.delete(t);
		if (t.getParentId() != null) {
			T parent = data.get(t.getParentId());
			if (parent == null)
				return;
			parent.getChilds().remove(t);
		}
	}

	public void delete(List<PK> ids) {
		super.delete(ids);
		for (T cate : data.values()) {
			if (cate.getChilds() == null)
				continue;
			for (T subCate : cate.getChilds()) {
				if (!data.containsKey(subCate.getId())) {
					cate.getChilds().remove(subCate);
				}
			}
		}
	}
	
	public T save(T t) throws DataAccessException {
		try {
			return super.save(t);
		} finally {
			setParentAndChilds(t);
		}
	}

	@Override
	public void update(T t, String[] ignoreProperties) {
		super.update(t, ignoreProperties);
		boolean update = true;
		if (ignoreProperties != null) {
			for (String p : ignoreProperties) {
				if (p.equals("parentId")) {
					update = false;
				}
			}
		}
		if (update) {
			updateParentRelaship(t);
		}
	}

	private void updateParentRelaship(T t) {
		if (t.getParent() != null) {
			t.getParent().getChilds().remove(t);
		}
		if (t.getParentId() != null) {
			T newParent = data.get(t.getParentId());
			t.setParent(newParent);
			newParent.getChilds().add(t);
		}
	}

	@Override
	public void update(T t) {
		super.update(t);
		updateParentRelaship(t);
	}

	@Override
	public void update(List<PK> ids, String propertyName, Object value) {
		super.update(ids, propertyName, value);
		for (T cate : data.values()) {
			cate.setParent(null);
			cate.getChilds().clear();
		}
		reshipCates(data.values(), null);
	}
}
