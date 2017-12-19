package com.life.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FileUtil {

    private final static Logger log = LoggerFactory.getLogger(FileUtil.class);

    /**
     * 当前文件Map
     **/
//	public static Map<String,SysFile> nowAdFile = new HashMap<String,SysFile>();
    public static String GetNewFileName() {
        SimpleDateFormat simpleDateFormat;
        simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        Date date = new Date();
        String str = simpleDateFormat.format(date);
        Random random = new Random();
        int rannum = (int) (random.nextDouble() * (99999 - 10000 + 1)) + 10000;// 获取5位随机数
        return str + "_" + rannum;// 当前时间
    }

    public static String getFileExt(String fileName) {
        String prefix = fileName.substring(fileName.lastIndexOf("."));
        return prefix;
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
     * 压缩单个文件
     */
    public static boolean ZipFile(String filepath, String zippath) {
        try {
            System.out.println("开始解压");
            long a = System.currentTimeMillis();

            File file = new File(filepath);
            File zipFile = new File(zippath);
            InputStream input = new FileInputStream(file);
            ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(zipFile));
            zipOut.putNextEntry(new ZipEntry(file.getName()));
            int temp = 0;
            while ((temp = input.read()) != -1) {
                zipOut.write(temp);
            }
            input.close();
            zipOut.close();
            System.out.println("解压完成");
            System.out.println("执行耗时 : " + (System.currentTimeMillis() - a) / 1000f + " 秒 ");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean unZip(String filepath, String outFilePath) {
        try {
            System.out.println("开始解压");
            long a = System.currentTimeMillis();
            File zipFile = new File(filepath);
            // 先指定压缩档的位置和档名，建立FileInputStream对象  
            FileInputStream fins = new FileInputStream(zipFile);
            // 将fins传入ZipInputStream中  
            ZipInputStream zins = new ZipInputStream(fins);
            ZipEntry ze = null;
            byte[] ch = new byte[256];
            while ((ze = zins.getNextEntry()) != null) {
                File zfile = new File(outFilePath, ze.getName());
                File fpath = new File(zfile.getParentFile().getPath());
                if (ze.isDirectory()) {
                    if (!zfile.exists())
                        zfile.mkdirs();
                    zins.closeEntry();
                } else {
                    if (!fpath.exists())
                        fpath.mkdirs();
                    FileOutputStream fouts = new FileOutputStream(zfile);
                    int i;
                    while ((i = zins.read(ch)) != -1)
                        fouts.write(ch, 0, i);
                    zins.closeEntry();
                    fouts.close();
                }
            }
            fins.close();
            zins.close();
            System.out.println("解压完成");
            System.out.println("执行耗时 : " + (System.currentTimeMillis() - a) / 1000f + " 秒 ");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 判断图片宽高
     */
    public static boolean imageWH(int width, int height, InputStream inputStream) throws FileNotFoundException, IOException {
        BufferedImage sourceImg = ImageIO.read(inputStream);
        if (width == sourceImg.getWidth() && height == sourceImg.getHeight()) {
            return true;
        }
        return false;
    }

    /**
     * 创建文件
     *
     * @param fileName
     * @return
     */
    public static boolean createFile(File fileName) throws Exception {
        boolean flag = false;
        try {
            if (!fileName.exists()) {
                fileName.createNewFile();
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    /**
     * 读TXT文件内容
     *
     * @param fileName
     * @return
     */
    public static String readTxtFile(File fileName) throws Exception {
        String result = null;
        FileReader fileReader = null;
        BufferedReader bufferedReader = null;
        try {
            fileReader = new FileReader(fileName);
            bufferedReader = new BufferedReader(fileReader);
            try {
                String read = null;
                while ((read = bufferedReader.readLine()) != null) {
                    result = result + read + "\r\n";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (bufferedReader != null) {
                bufferedReader.close();
            }
            if (fileReader != null) {
                fileReader.close();
            }
        }
        System.out.println("读取出来的文件内容是：" + "\r\n" + result);
        return result;
    }


    public static boolean writeTxtFile(String content, File fileName) throws Exception {
        RandomAccessFile mm = null;
        boolean flag = false;
        FileOutputStream o = null;
        try {
            o = new FileOutputStream(fileName);
            o.write(content.getBytes("GBK"));
            o.close();
            //   mm=new RandomAccessFile(fileName,"rw");
            //   mm.writeBytes(content);
            flag = true;
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        } finally {
            if (mm != null) {
                mm.close();
            }
        }
        return flag;
    }


    public static void contentToTxt(String filePath, String content) {
        System.out.println("写入文件  filePath=" + filePath + ",content=" + content);
        String str = new String(); //原有txt内容
        String s1 = new String();//内容更新
        try {
            File f = new File(filePath);
            if (f.exists()) {
                System.out.print("文件存在");
            } else {
                System.out.print("文件不存在");
                f.setWritable(true, false);
                f.createNewFile();// 不存在则创建
                System.out.println(f.getPath());
            }
            BufferedReader input = new BufferedReader(new FileReader(f));

            while ((str = input.readLine()) != null) {
                s1 += str + "\n";
            }
            System.out.println(s1);
            input.close();
            s1 += content;

            BufferedWriter output = new BufferedWriter(new FileWriter(f));
            output.write(s1);
            System.out.println(output.toString());
            System.out.println(s1);
            output.close();
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    /**
     * 通过HTTP方式获取文件
     *
     * @param strUrl
     * @param fileName
     * @return
     * @throws IOException
     */
    private boolean getRemoteFile(String strUrl, String fileName) throws IOException {
        URL url = new URL(strUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        DataInputStream input = new DataInputStream(conn.getInputStream());
        DataOutputStream output = new DataOutputStream(new FileOutputStream(fileName));
        byte[] buffer = new byte[1024 * 8];
        int count = 0;
        while ((count = input.read(buffer)) > 0) {
            output.write(buffer, 0, count);
        }
        output.close();
        input.close();
        return true;
    }

    /**
     * 读取文件
     *
     * @param sourcePath 文件所在的网络路径
     */
    public static String readHtmlFile(String sourcePath) {
        String cont = "";
        String line;
        int lineNum = 0;
        BufferedReader reader = null;
        try {
            URL url = new URL(sourcePath);
            reader = new BufferedReader(new InputStreamReader(url.openStream()));
            while ((line = reader.readLine()) != null) {
                lineNum++;
                System.out.println(line);
                cont += line;
            }
        } catch (Exception ie) {
            ie.printStackTrace();
        } finally {
            try {
                if (reader != null)
                    reader.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return cont;
    }

    /**
     * 获取图片宽度
     *
     * @param file 图片文件
     * @return 宽度
     */
    public static int getImgWidth(File file) {
        InputStream is = null;
        BufferedImage src = null;
        int ret = -1;
        try {
            is = new FileInputStream(file);
            src = ImageIO.read(is);
            ret = src.getWidth(null); // 得到源图宽
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }


    /**
     * 获取图片高度
     *
     * @param file 图片文件
     * @return 高度
     */
    public static int getImgHeight(File file) {
        InputStream is = null;
        BufferedImage src = null;
        int ret = -1;
        try {
            is = new FileInputStream(file);
            src = ImageIO.read(is);
            ret = src.getHeight(null); // 得到源图高
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }


    /**
     * @param imgUrl 图片地址
     * @return
     */
    public static BufferedImage getBufferedImage(String imgUrl) {
        URL url = null;
        InputStream is = null;
        BufferedImage img = null;
        try {
            url = new URL(imgUrl);
            is = url.openStream();
            img = ImageIO.read(is);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {

            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return img;
    }

    public static Long getFileLength(String filePath) {
        File f = new File(filePath);
//	log.info("文件路径:"+filePath);
        if (f.exists() && f.isFile()) {
            return f.length();

        } else {
            log.info("获取文件大小失败");
        }
        return Long.valueOf(0);
    }

    public static void main(String[] args) throws Exception {
        resizeImage("d:/bg.jpg","d:/1.png",0.9);

    }

    /***
     * @param srcImgPath 原图片路径
     * @param distImgPath  转换大小后图片路径
     * @param ratio 转换比例
     */
    public static void resizeImage(String srcImgPath, String distImgPath,double ratio) throws IOException {
        String subfix = "jpg";
        subfix = srcImgPath.substring(srcImgPath.lastIndexOf(".") + 1, srcImgPath.length());
        File srcFile = new File(srcImgPath);
        Image srcImg = ImageIO.read(srcFile);
        BufferedImage buffImg = null;

//        ratio = 0.3;
        int width = (int) (getImgWidth(srcFile) * ratio);
        int height = (int) (getImgHeight(srcFile)*ratio);

        if (subfix.equals("png") || subfix.equals("PNG")) {
            buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        } else {
            buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        }
        Graphics2D graphics = buffImg.createGraphics();
        graphics.setBackground(Color.WHITE);
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, width, height);
        graphics.drawImage(srcImg.getScaledInstance(width, height, Image.SCALE_SMOOTH), 0, 0, null);
        ImageIO.write(buffImg, subfix, new File(distImgPath));
    }


    /**
     * 获取文件大小
     * @param path
     * @return
     */
    public static String getFileSize(String path) {
        String fileSize = null;
        /*try {
			URL url = new URL(path);
			URLConnection uc = url.openConnection();
			fileSize = new DecimalFormat("0").format((float) uc.getContentLength()<0?0:(float) uc.getContentLength());
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
        try {
            FileInputStream fis = new FileInputStream(new File(path));
            fileSize = String.valueOf(fis.available());
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return fileSize;
    }
}
