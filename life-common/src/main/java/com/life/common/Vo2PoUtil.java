package com.life.common;

import org.apache.commons.beanutils.PropertyUtils;

import java.beans.PropertyDescriptor;
import java.util.Collection;


public class Vo2PoUtil {

	/** VO对象转PO对象 **/
	public static Object vo2Po(Object po, Object vo) {
		if (po == null || vo == null) {
			return po;
		}

		PropertyDescriptor[] destDesc = PropertyUtils.getPropertyDescriptors(po);
		try {
			for (int i = 0; i < destDesc.length; i++) {
				Class destType = destDesc[i].getPropertyType();
				Class origType = PropertyUtils.getPropertyType(vo, destDesc[i].getName());
				if (destType != null && destType.equals(origType) && !destType.equals(Class.class)) {
					if (!Collection.class.isAssignableFrom(origType)) {
						try {
							Object value = PropertyUtils.getProperty(vo, destDesc[i].getName());
							PropertyUtils.setProperty(po, destDesc[i].getName(), value);
						} catch (Exception ex) {}
					}
				}
			}

			return po;
		} catch (Exception ex) {
//			throw new CopyException(ex);
			 return po;
		}
	}
	
	/**	PO对象转VO对象  **/
	public static Object po2Vo(Object vo, Object po) {
		if (vo == null || po == null) {
			return vo;
		}
		
		PropertyDescriptor[] destDesc = PropertyUtils.getPropertyDescriptors(vo);
		try {
			for (int i = 0; i < destDesc.length; i++) {
				Class destType = destDesc[i].getPropertyType();
				Class origType = PropertyUtils.getPropertyType(po, destDesc[i].getName());
				if (destType != null && destType.equals(origType) && !destType.equals(Class.class)) {
					if (!Collection.class.isAssignableFrom(origType)) {
						try {
							Object value = PropertyUtils.getProperty(po, destDesc[i].getName());
							PropertyUtils.setProperty(vo, destDesc[i].getName(), value);
						} catch (Exception ex) {}
					}
				}
			}
			
			return vo;
		} catch (Exception ex) {
//			throw new CopyException(ex);
			return vo;
		}
	}

	/**   */
	/**
	 * Copy properties of orig to dest Exception the Entity and Collection Type
	 * 
	 * @param dest
	 * @param orig
	 * @param ignores
	 * @return the dest bean
	 */
	public static Object copyProperties(Object dest, Object orig, String[] ignores) {
		if (dest == null || orig == null) {
			return dest;
		}

		PropertyDescriptor[] destDesc = PropertyUtils.getPropertyDescriptors(dest);
		try {
			for (int i = 0; i < destDesc.length; i++) {
				if (contains(ignores, destDesc[i].getName())) {
					continue;
				}

				Class destType = destDesc[i].getPropertyType();
				Class origType = PropertyUtils.getPropertyType(orig, destDesc[i].getName());
				if (destType != null && destType.equals(origType) && !destType.equals(Class.class)) {
					if (!Collection.class.isAssignableFrom(origType)) {
						Object value = PropertyUtils.getProperty(orig, destDesc[i].getName());
						PropertyUtils.setProperty(dest, destDesc[i].getName(), value);
					}
				}
			}

			return dest;
		} catch (Exception ex) {
//			throw new CopyException(ex);
		}
		return dest;
	}

	static boolean contains(String[] ignores, String name) {
		boolean ignored = false;
		for (int j = 0; ignores != null && j < ignores.length; j++) {
			if (ignores[j].equals(name)) {
				ignored = true;
				break;
			}
		}

		return ignored;
	}
	
	public static void main(String[] args) {
	}
}
