package com.life.util;

import java.io.*;
import java.util.Random;


public class UploadFileUtil {

    public static final String UOPLOAD = "/upload";

    public static String getfilepath(String mode) {

        return UOPLOAD + "/" + mode + "/" + DateUtil.getNow3();
    }

    public static String getfilename(String suffix) {
        Random r = new Random();
        int n2 = r.nextInt(99999);
        return DateUtil.getNow2() + n2 + suffix;
    }

    public static String getExtention(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return fileName.substring(pos);
    }

    public static String getFileNameNoSuffix(String wholeFileName) {
        int pos = wholeFileName.lastIndexOf(".") - 1;
        return wholeFileName.substring(0, pos);
    }


    public static void copy(File src, File dst) {
        try {
            InputStream in = null;
            OutputStream out = null;
            try {
                in = new BufferedInputStream(new FileInputStream(src), 1024);

                if(!dst.exists()){
                    //先得到文件的上级目录，并创建上级目录，在创建文件
                    dst.getParentFile().mkdir();
                    try {
                        //创建文件
                        dst.createNewFile();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                out = new BufferedOutputStream(new FileOutputStream(dst), 1024);
                byte[] buffer = new byte[1024];
                int i;
                while ((i = in.read(buffer)) > 0) {
                    out.write(buffer, 0, i);
                }

            } finally {
                if (null != in) {
                    in.close();
                }
                if (null != out) {
                    out.flush();
                    out.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 上传文件到服务器目录
     *
     * @param imgFile  文件
     * @param filePath 文件路径
     * @param fileName 文件名
     * @return
     */
    public static boolean upLoadImg(File imgFile, String filePath, String fileName) {
        boolean flag = false;
        try {
            File fileDirs = new File(filePath);
            File file = new File(filePath + fileName);
            //如果文件夹不存在则创建
            if (!fileDirs.exists() && !fileDirs.isDirectory()) {
                fileDirs.mkdirs();
            }
            if (!file.exists()) {
                file.createNewFile();
                InputStream is = new FileInputStream(imgFile);
                OutputStream os = new FileOutputStream(new File(filePath + fileName));

                byte[] buffer = new byte[1000];
                int length = 0;
                while (-1 != (length = is.read(buffer, 0, buffer.length))) {
                    os.write(buffer);
                }
                os.close();
                is.close();
            }
            flag = true;
        } catch (Exception e) {
            //Log.error("上传照片异常。", e);
        }
        return flag;
    }

    /**
     * 根据路径删除指定的目录或文件，无论存在与否
     *
     * @param sPath 要删除的目录或文件
     * @return 删除成功返回 true，否则返回 false。
     */
    public static boolean DeleteFolder(String sPath) {
        boolean flag = false;
        File file = new File(sPath);
        // 判断目录或文件是否存在
        if (!file.exists()) {  // 不存在返回 false
            return flag;
        } else {
            // 判断是否为文件
            if (file.isFile()) {  // 为文件时调用删除文件方法
                return deleteFile(sPath);
            } else {  // 为目录时调用删除目录方法
                return deleteDirectory(sPath);
            }
        }
    }

    /**
     * 删除单个文件
     *
     * @param sPath 被删除文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public static boolean deleteFile(String sPath) {
        boolean flag = false;
        File file = new File(sPath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists()) {
            file.delete();
            flag = true;
        }
        return flag;
    }

    /**
     * 删除目录（文件夹）以及目录下的文件
     *
     * @param sPath 被删除目录的文件路径
     * @return 目录删除成功返回true，否则返回false
     */
    public static boolean deleteDirectory(String sPath) {
        //如果sPath不以文件分隔符结尾，自动添加文件分隔符
        if (!sPath.endsWith(File.separator)) {
            sPath = sPath + File.separator;
        }
        File dirFile = new File(sPath);
        //如果dir对应的文件不存在，或者不是一个目录，则退出
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            return false;
        }
        boolean flag = true;
        //删除文件夹下的所有文件(包括子目录)
        File[] files = dirFile.listFiles();
        for (int i = 0; i < files.length; i++) {
            //删除子文件
            if (files[i].isFile()) {
                flag = deleteFile(files[i].getAbsolutePath());
                if (!flag) break;
            } //删除子目录
            else {
                flag = deleteDirectory(files[i].getAbsolutePath());
                if (!flag) break;
            }
        }
        if (!flag) return false;
        //删除当前目录
        if (dirFile.delete()) {
            return true;
        } else {
            return false;
        }
    }


}
