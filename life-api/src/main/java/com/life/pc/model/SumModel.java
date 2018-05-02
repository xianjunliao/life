package com.life.pc.model;

public class SumModel {

	private String name;
	private Double value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "SumModel [name=" + name + ", value=" + value + "]";
	}

}
