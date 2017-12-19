package com.life.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.UUID;



public class Randoms {
	
	public static String uuid(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	public static String genUuid() {
		
		String[] arrays = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
				"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
				"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
				"y", "z" };
	
		Map container = new HashMap();
		int start = 0;
		int end = arrays.length;
		while (container.size() < 5) {
			int index = (int) (Math.random() * (end - start) + start - 1);
			String key = arrays[index];
			if (container.get(key) == null) {
				container.put(key, key);
			}
		}
	//	System.out.println("map.size" + container.size());
		Set<String> set = container.keySet();
		Iterator<String> it = set.iterator();
		StringBuffer random = new StringBuffer("");
		for (; it.hasNext();) {
			 random.append(it.next());
		}
		System.out.println(random.toString());
		return random.toString();
	}
}
