package com.life.common.test;

import java.util.Arrays;

public class Mppx {

	public static void main(String[] args) {
		Integer[] a=new Integer[]{3,1,9,2};
		int swap = 0;
		for (int i = 0; i < a.length; i++) {
			System.out.println("外循环第"+(i+1)+"圈:"+i);
			System.out.println("     ");
			int k=1;
			for (int j = i; j < a.length; j++) {
				System.out.println("内循环第"+k+"圈:"+j);
				System.out.println("AJ:"+a[j]);
				System.out.println("AI:"+a[i]);
				System.out.println("     ");
				if (a[j] > a[i]) {
	            System.out.println("TRUE");  
	    		System.out.println("     ");
					swap = a[i];
					a[i] = a[j];
					a[j] = swap;
				}
				k++;
			}
		}
		System.out.println(Arrays.toString(a));
	}

}
