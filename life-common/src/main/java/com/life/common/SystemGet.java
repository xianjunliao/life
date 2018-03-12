package com.life.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

public class SystemGet {

	/**
	 * 获取本机所有IP
	 */
	private static String[] getAllLocalHostIP() {
		List<String> res = new ArrayList<String>();
		Enumeration netInterfaces;
		try {
			netInterfaces = NetworkInterface.getNetworkInterfaces();
			InetAddress ip = null;
			while (netInterfaces.hasMoreElements()) {
				NetworkInterface ni = (NetworkInterface) netInterfaces.nextElement();
				Enumeration nii = ni.getInetAddresses();
				while (nii.hasMoreElements()) {
					ip = (InetAddress) nii.nextElement();
					if (ip.getHostAddress().indexOf(":") == -1) {
						res.add(ip.getHostAddress());
						System.out.println("本机的ip=" + ip.getHostAddress());
					}
				}
			}
		} catch (SocketException e) {
			e.printStackTrace();
		}
		return (String[]) res.toArray(new String[0]);
	}

	/**
	 * 获取本机所有物理地址
	 * 
	 * @return
	 */
	public static String getMacAddress() {
		String mac = "";
		String line = "";

		String os = System.getProperty("os.name");

		if (os != null && os.startsWith("Windows")) {
			try {
				String command = "cmd.exe /c ipconfig /all";
				Process p = Runtime.getRuntime().exec(command);

				BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));

				while ((line = br.readLine()) != null) {
					if (line.indexOf("Physical Address") > 0) {
						int index = line.indexOf(":") + 2;

						mac = line.substring(index);

						break;
					}
				}

				br.close();

			} catch (IOException e) {
			}
		}

		return mac;
	}

	public String getMacAddress(String host) {
		String mac = "";
		StringBuffer sb = new StringBuffer();

		try {
			NetworkInterface ni = NetworkInterface.getByInetAddress(InetAddress.getByName(host));

			byte[] macs = ni.getHardwareAddress();

			for (int i = 0; i < macs.length; i++) {
				mac = Integer.toHexString(macs[i] & 0xFF);

				if (mac.length() == 1) {
					mac = '0' + mac;
				}

				sb.append(mac + "-");
			}

		} catch (SocketException e) {
			e.printStackTrace();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}

		mac = sb.toString();
		mac = mac.substring(0, mac.length() - 1);

		return mac;
	}

	public static String getNowIp() {
		String allLocalHostIP = SystemGet.getAllLocalHostIP()[1];
		return allLocalHostIP;

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String[] allLocalHostIP = SystemGet.getAllLocalHostIP();
		System.out.println(allLocalHostIP[1]);
	}

}