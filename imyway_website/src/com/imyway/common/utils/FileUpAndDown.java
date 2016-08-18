package com.imyway.common.utils;

import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;


public class FileUpAndDown {

    /** image最大size  1M*/
	public final static int PRODUCTPATH_IMAGE_MAX_SIZE = 1048576;//1048576;

	public static String fileUpload(MultipartFile f,String targetName) {
    	String message = "";
        try {
            byte[] fileArray=getFileContent(f);
            doUpload(fileArray,targetName);
            message = CommonUtils.getIPConfigBykey("imageShowPath")+targetName;
        } catch (Exception e) {
            e.printStackTrace();
            message = "0";
        }
        return message;
    }
    
	public static String flashfileUpload(MultipartFile f,String targetName) {
		String message = "";
		try {
			byte[] fileArray=getFileContent(f);
			doFlashUpload(fileArray,targetName);
			message = "0";
		} catch (Exception e) {
			e.printStackTrace();
			message = "对不起,文件上传失败了!!!!";
			
		}
		return message;
	}
    
	public static byte[] getFileContent(MultipartFile f) throws IOException {  
        long fileSize = f.getSize();
        if (fileSize > Integer.MAX_VALUE) {  
            System.out.println("file too big...");  
            return null;
        }  
        return f.getBytes();  
    }  

	 public static void doUpload(byte[] buffer, String targetName) throws Exception {
	     FileOutputStream out = new FileOutputStream(CommonUtils.getIPConfigBykey("imagePath")+targetName);
	     out.write(buffer);
	     out.close();
	 }

	 public static void doFlashUpload(byte[] buffer, String targetName)
			 throws Exception {
		 FileOutputStream out = new FileOutputStream(CommonUtils.getIPConfigBykey("flashPath")+targetName);
		 out.write(buffer);
		 out.close();
	 }
	 public static void main(String[] args) {
	//	 System.out.println(fileUpload(new File("D:/", "bak_5.jpg"), "123.jpg"));
		
	 }
}
