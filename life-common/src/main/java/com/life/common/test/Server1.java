package com.life.common.test;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server1 {

	public static void main(String[] args) throws Exception{
		//服务端在20006端口监听客户端请求的TCP连接
				ServerSocket server = new ServerSocket(9999);
				Socket client = null;
				boolean f = true;
				while(f){
					//等待客户端的连接，如果没有获取连接
					client = server.accept();
					OutputStream outputStream = client.getOutputStream();
					String string="abcdefg";
					for (int i = 0; i < string.length(); i++) {
						outputStream.write(string.charAt(i));
					}
					System.out.println("与客户端连接成功！");
					//为每个客户端连接开启一个线程
					new Thread(new ServerThread(client)).start();
				}
				server.close();


	}

}
