package com.life.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.log4j.Logger;



/**
 * FTP工具类
 * @author  andy
 * @version  V1.0
 */
public class FTPUtil
{
    private Logger log = Logger.getLogger(FTPUtil.class);
    
    private static Map<String, OutputStream> DOWNLOAD_MAP = new ConcurrentHashMap<String, OutputStream>();
    
    /**
     * FTPClient对象
     */
    private FTPClient ftpClient;
    
    private String ftpServerPath;
    
    private String user;
    
    private String password;
    
    /**
     * 获取FTPClient对象
     * @author andy
     * @return 
     *
     */
    public FTPClient getFtpClient()
    {
        return ftpClient;
    }
    
    /**
     * ftp服务初始化
     * @author andy
     * @param ftpPath 格式：ftp://ip:port 或 ip:port 或 ip 或 ftp://ip
     * @param user 登录ftp用户名
     * @param password 登录ftp密码
     * @throws SocketException
     * @throws IOException 
     *
     */
    public FTPUtil(String ftpServerPath, String user, String password) throws IOException
    {
        this.ftpServerPath = ftpServerPath;
        this.user = user;
        this.password = password;
        ftpClient = new FTPClient();
        this.connectServer(ftpServerPath, user, password);
    }
    
    /**
     * ftp服务初始化
     * @author andy
     * @param ftpPath 格式：ftp://ip:port 或 ip:port 或 ip 或 ftp://ip
     * @param user 登录ftp用户名
     * @param password 登录ftp密码
     * @param encoding 编码格式
     * @throws SocketException
     * @throws IOException 
     *
     */
    public FTPUtil(String ftpServerPath, String user, String password, String encoding) throws SocketException, IOException
    {
        this.ftpServerPath = ftpServerPath;
        this.user = user;
        this.password = password;
        ftpClient = new FTPClient();
        ftpClient.setControlEncoding(encoding);
        this.connectServer(ftpServerPath, user, password);
    }
    
    /**
     * ftp服务初始化
     * @author andy
     * @param ip
     * @param port
     * @param user
     * @param password
     * @throws SocketException
     * @throws IOException 
     *
     */
    public FTPUtil(String ip, int port, String user, String password) throws SocketException, IOException
    {
        ftpClient = new FTPClient();
        this.connectServer(ip, port, user, password);
    }
    
    /**
     * ftp服务初始化
     * @author andy
     * @param ip ftp服务ip
     * @param port ftp服务端口
     * @param user 
     * @param password
     * @param encoding
     * @throws SocketException
     * @throws IOException 
     *
     */
    public FTPUtil(String ip, int port, String user, String password, String encoding) throws SocketException, IOException
    {
        ftpClient = new FTPClient();
        this.connectServer(ip, port, user, password, encoding);
    }
    
    /**
     * 连接ftp服务
     * @author andy
     * @param ftpPath 格式：ftp://ip:port 或 ip:port 或 ip 或 ftp://ip
     * @param user 登录ftp用户名
     * @param password 登录ftp密码
     * @throws SocketException
     * @throws IOException 
     *
     */
    private void connectServer(String ftpServerPath, String user, String password) throws SocketException, IOException
    {
        if (null == ftpServerPath || ftpServerPath.length() == 0)
        {
            return;
        }
        String server = ftpServerPath;
        if (ftpServerPath.toLowerCase().startsWith("ftp://"))
        {
            server = server.substring(6, server.length());
        }
        String[] arr = server.split(":");
        if (arr.length == 2)
        {
            ftpClient.connect(arr[0], Integer.valueOf(arr[1]).intValue());
        }
        else if (arr.length == 1)
        {
            ftpClient.connect(arr[0]);
        }
        
        ftpClient.login(user, password);
    }
    
    /**
     * 连接ftp服务
     * @author andy
     * @param ip
     * @param port
     * @param user
     * @param password
     * @throws SocketException
     * @throws IOException 
     *
     */
    private void connectServer(String ip, int port, String user, String password) throws SocketException, IOException
    {
        ftpClient.connect(ip, port);
        ftpClient.login(user, password);
    }
    
    /**
     * 连接ftp服务
     * @author andy
     * @param ip ftp服务ip
     * @param port ftp服务端口
     * @param user 
     * @param password
     * @param encoding
     * @throws SocketException
     * @throws IOException 
     *
     */
    private boolean connectServer(String ip, int port, String user, String password, String encoding) throws SocketException, IOException
    {
        ftpClient.setControlEncoding(encoding);
        ftpClient.connect(ip, port);
        return ftpClient.login(user, password);
    }
    
    /**
     * 改变目录
     * @author andy
     * @param path
     * @return
     * @throws IOException 
     *
     */
    public boolean changeDirectory(String path) throws IOException
    {
        return ftpClient.changeWorkingDirectory(path);
    }
    
    /**
     * 上传文件到FTP服务器
     * @author andy
     * @param localFilePath 本地文件名称，绝对路径
     * @param remoteFilePath 远程文件路径,支持多级目录嵌套，支持递归创建不存在的目录结构
     * @throws Exception 
     *
     */
    public boolean upload(String localFilePath, String remoteFilePath) throws Exception
    {
        // 设置PassiveMode传输
        ftpClient.enterLocalPassiveMode();
        // 设置以二进制流的方式传输
        ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
        // 对远程目录的处理
        String remoteFileName = remoteFilePath;
        if (remoteFilePath.contains("/"))
        {
            remoteFileName = remoteFilePath.substring(remoteFilePath.lastIndexOf("/") + 1);
            // 创建服务器远程目录结构，创建失败直接返回
            if (!createDirecroty(remoteFilePath))
            {
                return false;
            }
        }
        File f = new File(localFilePath);
        // 上传本地文件
        return uploadFile(remoteFileName, f);
    }
    
    /**
     * 上传文件
     * @author andy
     * @param filename
     * @param uploadpath
     * @param ftpPath
     * @return
     * @throws Exception 
     *
     */
    public boolean uploadAll(String filename, String uploadpath, String ftpPath) throws Exception
    {
        // 定义上传是否成功标示
        boolean success = false;
        File file = new File(filename);
        // 要上传的是否存在
        if (!file.exists())
        {
            return success;
        }
        // 要上传的是否是文件夹
        if (!file.isDirectory())
        {
            return success;
        }
        // 获取文件下所有文件列表包括子文件夹
        File[] flles = file.listFiles();
        try
        {
            for (File files : flles)
            {
                if (files.exists())
                {
                    if (files.isDirectory())
                    {
                        // 如果是文件夹递归调用
                        this.uploadAll(files.getAbsoluteFile().toString(), uploadpath, ftpPath);
                    }
                    else
                    {
                        // 获取文件路径
                        String _filePath = files.getCanonicalPath().replaceAll("\\\\", "/");
                        String _ftpPath = ftpPath.replaceAll("\\\\", "/");
                        // 转换成ftp服务器上的路径
                        String remote = uploadpath + _filePath.substring(_filePath.indexOf(_ftpPath) + ftpPath.length() + 1);
                        success = upload(_filePath, remote);
                        if (!success)
                        {
                            return false;
                        }
                        success = this.changeDirectory("/");
                        if (!success)
                        {
                            return false;
                        }
                    }
                }
            }
        }
        catch (Exception e)
        {
            log.error(e);
            return false;
        }
        return true;
    }
    
    /**
     * 文件上传方法
     * 
     * @author andy
     * @param remoteFile
     * @param localFile
     * @throws IOException
     * 
     */
    public boolean uploadFile(String remoteFile, File localFile) throws IOException
    {
        InputStream in = new FileInputStream(localFile);
        boolean flag = ftpClient.storeFile(remoteFile, in);
        in.close();
        return flag;
    }
    
    /**
     * 递归创建远程服务器目录
     * @author andy
     * @param remotePath 远程服务器文件绝对路径
     * @return 目录创建是否成功
     * @throws Exception 
     *
     */
    public boolean createDirecroty(String remotePath) throws Exception
    {
        if (null == remotePath || remotePath.length() == 0)
        {
            return false;
        }
        boolean success = true;
        String directory = remotePath.substring(0, remotePath.lastIndexOf("/") + 1);
        // 如果远程目录不存在，则递归创建远程服务器目录
        if (!directory.equalsIgnoreCase("/") && !changeDirectory(directory))
        {
            int start = 0;
            int end = 0;
            if (directory.startsWith("/"))
            {
                start = 1;
            }
            else
            {
                start = 0;
            }
            end = directory.indexOf("/", start);
            //依次截取目录并创建
            while (true)
            {
                String subDirectory = remotePath.substring(start, end);
                
                if (!changeDirectory(subDirectory))
                {
                    if (makeDirectory(subDirectory))
                    {
                        changeDirectory(subDirectory);
                    }
                    else
                    {
                        //抛创建失败的异常
                        success = false;
                        break;
                    }
                }
                start = end + 1;
                end = directory.indexOf("/", start);
                // 检查所有目录是否创建完毕
                if (end <= start)
                {
                    break;
                }
            }
        }
        return success;
    }
    
    /**
     * 创建目录
     * @author andy
     * @param pathName
     * @return
     * @throws IOException 
     *
     */
    public boolean makeDirectory(String pathName) throws IOException
    {
        return ftpClient.makeDirectory(pathName);
    }
    
    /**
     * 下载文件远程文件到本地
     * @author andy
     * @param remoteFileName
     * @param localFileName
     * @return
     * @throws IOException 
     *
     */
    public boolean download(String remoteFileName, String localFileName) throws IOException
    {
        boolean flag = false;
        File outfile = new File(localFileName);
        if (!outfile.exists())
        {
            outfile.mkdirs();
        }
        OutputStream oStream = null;
        try
        {
            String filePath = localFileName + "/" + remoteFileName.substring(remoteFileName.lastIndexOf("/"));
            oStream = new FileOutputStream(filePath);
            ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
            flag = ftpClient.retrieveFile(remoteFileName, oStream);
            log.info("==========download,result is:" + flag);
            oStream.flush();
        }
        catch (IOException e)
        {
            flag = false;
            log.info("==========download IOException:", e);
            return flag;
        }
        finally
        {
            if (oStream != null)
            {
                oStream.close();
            }
            //            if (!ftpClient.completePendingCommand())
            //            {
            //                ftpClient.logout();
            //                ftpClient.disconnect();
            //            }
            //ftpClient.completePendingCommand();
        }
        return flag;
    }
    
    /**
     * 下载文件到本地
     * @param remoteFilePath ftp路径
     * @param localFilePath 本地存储路径
     * @return
     * @throws IOException
     */
    public boolean downloadForPathForCancel(String remoteFilePath, String localFilePath) throws IOException{
        File dir = new File(localFilePath.substring(0, localFilePath.lastIndexOf("/")));
        if (!dir.exists())
        {
            dir.mkdirs();
        }
        boolean flag = false;
        OutputStream oStream = null;
        try
        {
            oStream = new FileOutputStream(localFilePath);
            DOWNLOAD_MAP.put(localFilePath, oStream);
            ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
            flag = ftpClient.retrieveFile(remoteFilePath, oStream);
            log.info("==========download [" + remoteFilePath + "],result is:" + flag);
            oStream.flush();
        }
        finally
        {
            if (oStream != null)
            {
                oStream.close();
            }
            DOWNLOAD_MAP.remove(localFilePath);
        }
        return flag;
    }
    
    
    public static void cancelDownload(String localFilePath)
    {
        OutputStream outStream = DOWNLOAD_MAP.get(localFilePath);
        if(outStream==null){
            return ;
        }
        try
        {
            outStream.close();
        }
        catch (IOException e)
        {
          e.printStackTrace();
        }finally{
            DOWNLOAD_MAP.remove(localFilePath);
        }
    }
    
    
    /**
     * 下载文件远程文件到本地
     * @author andy
     * @param remoteFileName
     * @param localFileName
     * @return
     * @throws IOException 
     *
     */
    public boolean downloadForPath(String remoteFilePath, String localFilePath) throws IOException
    {
        File dir = new File(localFilePath.substring(0, localFilePath.lastIndexOf(File.separator)));
        if (!dir.exists())
        {
            dir.mkdirs();
        }
        boolean flag = false;
        OutputStream oStream = null;
        try
        {
            oStream = new FileOutputStream(localFilePath);
            ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
            flag = ftpClient.retrieveFile(remoteFilePath, oStream);
            log.info("==========download,result is:" + flag);
            oStream.flush();
        }
        catch (IOException e)
        {
            flag = false;
            log.info("==========download IOException:", e);
            return flag;
        }
        finally
        {
            if (oStream != null)
            {
                oStream.close();
            }
        }
        return flag;
    }
    

    public void downFileOrDir(String ftpFileName, String localDir) 
    { 
        FileOutputStream fos = null;
        try { 
            File file = new File(ftpFileName); 
            File temp = new File(localDir); 
            if (!temp.exists()) 
            { 
                temp.mkdirs(); 
            } 
            // 判断是否是目录 
            if (isDir(ftpFileName)) 
            { 
                String[] fileNames = ftpClient.listNames(); 
                for (String name:fileNames) 
                { 
                 //   Log.info("下载【" + name + "】"); 
                    if (isDir(name)) 
                    { 
                        downFileOrDir(ftpFileName + '/' + name, localDir 
                                + File.separator + name); 
                        ftpClient.changeToParentDirectory(); 
                    }
                    else 
                    { 
                        File localfile = new File(localDir + File.separator 
                                + name); 
                        if (!localfile.exists()) 
                        { 
                            fos = new FileOutputStream(localfile); 
                            ftpClient.retrieveFile(name, fos); 
                        }
                        else 
                        { 
                           // Log.info("开始删除文件"); 
                            file.delete(); 
                         //   Log.info("文件已经删除"); 
                            fos = new FileOutputStream(localfile); 
                            ftpClient.retrieveFile(ftpFileName, fos); 
                        } 
                    } 
                } 
            } 
            else 
            { 
                File localfile = new File(localDir + File.separator 
                        + file.getName()); 
                if (!localfile.exists()) 
                {   
                    fos = new FileOutputStream(localfile); 
                    ftpClient.retrieveFile(ftpFileName, fos); 
                }
                else 
                { 
                 //   Log.info("开始删除文件"); 
                    file.delete(); 
                 //   Log.info(Log.INFO_PREFIX +"文件已经删除"); 
                    fos = new FileOutputStream(localfile); 
                    ftpClient.retrieveFile(ftpFileName, fos); 
                } 
                ftpClient.changeToParentDirectory(); 
            } 
         //   Log.info("下载成功！"); 
        } 
        catch (SocketException e) 
        { 
          //  Log.error("连接失败！", e); 
        } 
        catch (IOException e) 
        { 
          //  Log.error("下载失败！", e); 
        } 
        finally
        {
            if(null != fos)
            {
                try
                {
                    fos.close();
                }
                catch (IOException e)
                {
               //     Log.error(e);
                }
            }
        }
    } 


    /**
     * 判断是否是目录 
     * @param fileName
     * @return
     */
    public boolean isDir(String fileName) 
    { 
        try 
        { 
            // 切换目录，若当前是目录则返回true,否则返回true。 
            return ftpClient.changeWorkingDirectory(fileName); 
        } 
        catch (Exception e) 
        { 
            log.error("", e); 
        } 
        return false; 
    }
    
    
     public long obtainFtpFileSize(String remoteFilePath) throws IOException{
         FTPFile files[] = ftpClient.listFiles(remoteFilePath);
         if(files==null || files.length==0){
             log.error(">>>>>>>>>>>>>>>>文件不存在:"+remoteFilePath);
             return 0l;
         }
         return files[0].getSize();
     }
    
    /**
     * 获取当前路径下的所有文件
     * @author andy
     * @param path
     * @return
     * @throws IOException 
     *
     */
    public FTPFile[] listFiles(String path) throws IOException
    {
        FTPFile[] ftpFiles = ftpClient.listFiles(path);
        return ftpFiles;
    }
    
    /**
     * 删除文件
     * @author andy
     * @param pathName
     * @return
     * @throws IOException 
     *
     */
    public boolean deleteFile(String pathName) throws IOException
    {
        return ftpClient.deleteFile(pathName);
    }
    
    /**
     * 删除文件夹,当此目录下没有其他文件，即为空时
     * @author andy
     * @param pathName
     * @return
     * @throws IOException 
     *
     */
    public boolean deleteDirectory(String pathName) throws IOException
    {
        return ftpClient.removeDirectory(pathName);
    }
    
    /**
     *  删除文件或文件夹
     * @author andy
     * @param remoteFile
     * @return
     * @throws IOException 
     * @throws Exception 
     *
     */
    public boolean deleteFileOrFolder(String remoteFile) throws IOException
    {
        //获取当前路径下的所有文件及文件夹
        FTPFile[] ftpFileArr = listFiles(remoteFile);
        //没有子文件则直接删除当前目录
        if (null == ftpFileArr || ftpFileArr.length == 0)
        {
            return this.deleteDirectory(remoteFile);
        }
        //循环文件
        for (FTPFile ftpFile : ftpFileArr)
        {
            String name = ftpFile.getName();
            if (ftpFile.getName().equals(".") && !ftpFile.getName().equals(".."))
            {
                continue;
            }
            //是文件夹，则进行递归
            if (ftpFile.isDirectory())
            {
                deleteFileOrFolder(remoteFile + "/" + name);
            }
            //是文件则直接删除
            else if (ftpFile.isFile())
            {
                deleteFile(remoteFile + "/" + name);
            }
            //其他的暂不处理
            else
            {
                
            }
        }
        //删除根目录
        return this.deleteDirectory(remoteFile);
    }
    
    /***************************************************************************
     * 删除文件夹或文件,删除文件夹时，必须没有子目录或子文件
     * 
     * @param pathName
     * @throws EMVException
     */
    public boolean dele(String pathName)
    {
        isPositiveable();
        try
        {
            return FTPReply.isPositiveCompletion(ftpClient.dele(pathName));
        }
        catch (IOException e)
        {
            e.printStackTrace();
            
        }
        finally
        {
            closeFtpConnection();
        }
        return false;
    }
    
    /***************************************************************************
     * 删除单个文件
     * 
     * @param pathName
     * @throws EMVException
     */
    public boolean delele(String pathName)
    {
        isPositiveable();
        try
        {
            return ftpClient.deleteFile(pathName);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            closeFtpConnection();
        }
        return false;
    }
    
    /****
     * 删除文件夹里的文件，不是会像 rm -rf 一样的
     * @param path
     * @return
     * @throws EMVException
     */
    public boolean removeDirectory(String path)
    {
        isPositiveable();
        try
        {
            return ftpClient.removeDirectory(path);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            closeFtpConnection();
        }
        return false;
    }
    
    /***************************************************************************
     * 递归删除某个文件夹下的文件,但不会删除当前文件夹，需要自己关闭FTP连接
     * @param path
     * @return
     * @throws EMVException
     * @throws IOException
     */
    public void recursionDelele(String path) throws IOException
    {
        isPositiveable();
        FTPFile files[] = ftpClient.listFiles(path);
        if (files == null || files.length == 0)
        {
            ftpClient.deleteFile(path);
            return;
        }
        for (FTPFile file : files)
        {
            String p = path + (file.isDirectory() ? path.endsWith("/") ? file.getName() : "/" + file.getName() + "/" : path.endsWith("/") ? file.getName() : "/" + file.getName());
            if (!file.isDirectory())
            {
                ftpClient.deleteFile(p);
                continue;
            }
            if (file.isDirectory())
                recursionDelele(p);
        }
    }
    
    /***
     * 递归删除某个文件夹下的文件并删除当前文件夹
     * @param path
     * @throws IOException
     * @throws EMVException
     */
    public void recursionDele(String path)
    {
        isPositiveable();
        FTPFile files[];
        try
        {
            files = ftpClient.listFiles(path);
            for (FTPFile file : files)
            {
                if (!file.isDirectory())
                {
                    ftpClient.deleteFile(path + "/" + file.getName());
                    continue;
                }
                if (file.isDirectory())
                    recursionDelele(path);
            }
            ftpClient.deleteFile(path);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            closeFtpConnection();
        }
    }
    
    /***************************************************************************
     * 移动文件
     * 
     * @param remoteFileFrom
     *            目标文件
     * @param remoteFileTo
     *            移动至
     * 
     */
    public boolean move(String remoteFileFrom, String remoteFileTo)
    {
        isPositiveable();
        try
        {
            return ftpClient.rename(remoteFileFrom, remoteFileTo);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            closeFtpConnection();
        }
        return false;
    }
    
    /***************************************************************************
     * @param pathName
     * @return
     * @throws IOException
     */
    public List<String> listFiles(String pathName, int fileType) throws IOException
    {
        FTPFile[] files = listFiles(pathName);
        List<String> fileList = new ArrayList<String>();
        for (FTPFile file : files)
        {
            if (file.getType() == fileType)
                fileList.add(file.getName());
        }
        return fileList;
    }
    
    public FTPFile[] getFiles(String pathName) throws IOException
    {
        FTPFile[] files = listFiles(pathName);
        List<FTPFile> fileList = new ArrayList<FTPFile>();
        for (FTPFile file : files)
        {
            if (file.getType() == FTPFile.FILE_TYPE)
                fileList.add(file);
        }
        FTPFile[] array = new FTPFile[fileList.size()];
        fileList.toArray(array);
        return array;
    }
    
    public boolean checkHasChildDir(String path) throws IOException
    {
        FTPFile[] files = listFiles(path);
        boolean hasChildDir = !checkIsAllFile(files);
        return hasChildDir;
    }
    
    public boolean checkIsAllFile(FTPFile[] files)
    {
        for (FTPFile file : files)
        {
            if (file.getType() == FTPFile.DIRECTORY_TYPE)
                return false;
        }
        return true;
    }
    
    /***************************************************************************
     * 列出pathName目录下的所有文件,排除文件
     * 
     * @param pathName
     * @return
     * @throws IOException
     */
    public List<String> listDirectory(String pathName) throws IOException
    {
        return listFiles(pathName, FTPFile.DIRECTORY_TYPE);
    }
    
    /***************************************************************************
     * 列出pathName目录下的所有文件,排除文件夹,如果不传入路径，就会显示当前的工作空间的路径
     * 
     * @param pathName
     * @return
     * @throws IOException
     */
    public List<String> listFile(String pathName) throws IOException
    {
        return listFiles(pathName, FTPFile.FILE_TYPE);
    }
    
    public Boolean isPositive()
    {
        return FTPReply.isPositiveCompletion(ftpClient.getReplyCode());
    }
    
    private void isPositiveable()
    {
        if (!isPositive())
        {
            closeFtpConnection();
        }
    }
    
    public void closeFtpConnection()
    {
        try
        {
            if (!isPositive())
            {
                ftpClient.logout();
                ftpClient.disconnect();
            }
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }
    
    /**
     * 关闭FTP
     * @author andy
     * @throws IOException 
     *
     */
    public void closeServer() throws IOException
    {
        if (ftpClient.isConnected())
        {
            ftpClient.logout();
            ftpClient.disconnect();
        }
    }
    
    /**
     * 删除文件夹，不自动关闭ftp连接
     * @author andy
     * @param path
     * @return 
     *
     */
    public boolean removeDirWithoutClose(String path)
    {
        isPositiveable();
        try
        {
            return ftpClient.removeDirectory(path);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        return false;
    }
    
    public void listDirectoryAndFiles(String pathName, Map<String, FTPFile[]> directoryMap, Map<String, FTPFile[]> tempDirMap, String[] allowTypes) throws IOException
    {
        FTPFile[] files = listFiles(pathName);
        if (checkIsAllFile(files))
        {
            List<FTPFile> fileList = getFilesValid(files, allowTypes);
            if (fileList.size() > 0)
            {
                for (FTPFile file : files)
                {
                    int size = fileList.size();
                    FTPFile[] array = (FTPFile[])fileList.toArray(new FTPFile[size]);
                    tempDirMap.put(pathName + "/" + file.getName(), array);
                }
            }
        }
        else
        {
            for (FTPFile file : files)
            {
                if (file.getType() == 1)
                {
                    listDirectoryAndFiles(pathName + "/" + file.getName(), directoryMap, tempDirMap, allowTypes);
                }
                else
                {
                    String fileName = file.getName();
                    String sufffix = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                    if (checkFileType(sufffix, allowTypes))
                    {
                        tempDirMap.put(pathName + "/" + file.getName(), new FTPFile[] {file});
                    }
                }
            }
        }
    }
    
    public static List<FTPFile> getFilesValid(FTPFile[] files, String[] allowTypes)
    {
        List<FTPFile> fileList = new ArrayList<FTPFile>();
        for (FTPFile file : files)
        {
            String fileName = file.getName();
            String sufffix = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            if (checkFileType(sufffix, allowTypes))
            {
                fileList.add(file);
            }
        }
        
        return fileList;
    }
    
    public static boolean checkFileType(String type, String[] limitTypes)
    {
        boolean flag = false;
        if (limitTypes == null || limitTypes.length == 0)
            return true;
        for (String string : limitTypes)
        {
            if (string.equals(type))
            {
                flag = true;
                break;
            }
        }
        return flag;
    }
    
    public static boolean checkFileExist(String fileName, String filePath, FTPUtil ftpTool) throws Exception
    {
        boolean flag = false;
        FTPFile[] files = ftpTool.listFiles(filePath);
        if (files.length == 0)
        {
            throw new Exception("文件夹不存在");
        }
        else
        {
            for (FTPFile file : files)
            {
                if (file.getName().equals(fileName))
                {
                    flag = true;
                    break;
                }
            }
            return flag;
        }
    }
    
    public void setFileType(int fileType) throws IOException
    {
        ftpClient.setFileType(fileType);
    }
    
    public boolean isConnected()
    {
        if (ftpClient == null)
        {
            return false;
        }
        return ftpClient.isConnected();
    }
    
    public boolean rename(String from, String to) throws IOException
    {
        return ftpClient.rename(from, to);
    }
    
    public FTPFile[] listFiles() throws IOException
    {
        return ftpClient.listFiles();
    }
    
    public int cdup() throws IOException
    {
        return ftpClient.cdup();
    }
    
    public int cwd(String directory) throws IOException
    {
        return ftpClient.cwd(directory);
    }
    
    public String pwd() throws IOException
    {
        return ftpClient.printWorkingDirectory();
    }
    
    public boolean abort() throws IOException
    {
        return ftpClient.abort();
    }
    
    public String getFtpServerPath()
    {
        return ftpServerPath;
    }
    
    public String getUser()
    {
        return user;
    }
    
    public String getPassword()
    {
        return password;
    }

    public void setFtpClient(FTPClient ftpClient)
    {
        this.ftpClient = ftpClient;
    }
}
