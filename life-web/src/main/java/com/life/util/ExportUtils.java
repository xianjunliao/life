package com.life.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPalette;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.CellStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.life.common.ExcelFile;
import com.life.common.ExcelSheet;

import io.swagger.annotations.Api;

@Api("数据导出 工具类，Created by XHZ on 2017/10/16")
public class ExportUtils{
	private final static Logger log = LoggerFactory.getLogger(ExportUtils.class);// 日志
	/**
	 * 导出Excel文件
	 * @param excelFile excel文件相关参数
     */
	public static void exportExcel(ExcelFile excelFile, HttpServletResponse response){
		// 一、Excel文件处理
		OutputStream out = null;
		try {
			String fileDir = excelFile.getFileDir();
			String fileName = excelFile.getFileName()+".xls";
			if(StringUtil.isNotBlank(fileDir)){
				//有文件路径
				if(FileUtils.createDirecroty(fileDir+fileName)) {
					out = new FileOutputStream(fileDir + fileName);
				}
			}else{
				//否则，直接写到输出流中
				out = response.getOutputStream();
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition", "attachment; filename="+ new String( fileName.getBytes( "gb2312" ), "ISO8859-1" ));
			}

			// 二、表数据处理
			// 1.创建一个webbook，对应一个Excel文件
			HSSFWorkbook wb = new HSSFWorkbook();
			List<ExcelSheet> excelSheets = excelFile.getSheets();

			// 2.在webbook中添加一个sheet,对应Excel文件中的sheet
			for(ExcelSheet excelSheet:excelSheets) {
				HSSFSheet sheet = wb.createSheet(excelSheet.getSheetName());
				// 3.在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
				HSSFRow rowTitle = sheet.createRow(0);//表名
				HSSFRow rowHeader = sheet.createRow(1);//表头

				// 4.创建单元格，并设置值表头 设置表头居中
				// 4.1 设置样式：如居中、字体大小
				HSSFCellStyle styleTitle = wb.createCellStyle();
				styleTitle = (HSSFCellStyle)setFontAndBorder(wb,styleTitle,"",(short) 14);
				styleTitle = (HSSFCellStyle)setColor(wb,styleTitle,"",(short)10);

				// 4.2 设置表名
				HSSFCell cellTitle = rowTitle.createCell((short) 0);
				cellTitle.setCellValue(excelSheet.getTitleName());
				cellTitle.setCellStyle(styleTitle);
				int cellSize = excelSheet.getHeaderName().size();
				Region region1 = new Region(0, (short)0, 0, (short)(cellSize-1));
				sheet.addMergedRegion(region1);

				// 4.3 设置表头
				HSSFCell cellHeader;
				Map<String,String> headerName = excelSheet.getHeaderName();
				List<String> cellProperty = new ArrayList<>();
				int k=0;
				for(String key:headerName.keySet()){
					String value = headerName.get(key);
					sheet.setColumnWidth(k, value.length()*450);    //设置宽度
					cellHeader = rowHeader.createCell((short) k);
					cellHeader.setCellValue(key);
					cellHeader.setCellStyle(styleTitle);
					cellProperty.add(k++,value);
				}

				// 5.写入实体数据 实际应用中这些数据从数据库得到，
				List dataList = excelSheet.getData();
				if(CollectionUtils.isNotEmpty(dataList)){
					// 5.1 设置内容样式
					HSSFCellStyle styleData = wb.createCellStyle();
					styleData = (HSSFCellStyle) setFontAndBorder(wb,styleData,"", (short)12);

					// 5.2 设置数据
					HSSFRow rowData;
					for (int i = 0; i < dataList.size(); i++) {
						// 获得数据对象及实例
						Object obj = dataList.get(i);
						Class dataClass = obj.getClass();
						// 添加行
						rowData = sheet.createRow(i + 2);
						// 遍历列数据
						for(int columnIndex = 0;columnIndex<cellSize;columnIndex++) {
							String property = cellProperty.get(columnIndex).trim();
							HSSFCell cell = rowData.createCell(columnIndex);
							if(StringUtil.isNotBlank(property)){  //字段不为空
								// 设置序号
								if("orderNo".equals(property)){
									cell.setCellValue(columnIndex+1);
								}else{
									// 设置要执行的 属性方法
									String UTitle = Character.toUpperCase(property.charAt(0))+ property.substring(1, property.length()); // 使其首字母大写;
									String methodName  = "get"+UTitle;
									Method method = dataClass.getDeclaredMethod(methodName);

									//获取返回类型
									//String returnType = method.getReturnType().getName();

									// 设置数据
									String data = method.invoke(obj)==null?"":method.invoke(obj).toString();
									if(StringUtil.isNotBlank(data)){
										cell.setCellValue(data);
									}
								}
							}else{   //字段为空 检查该列是否是公式
								String[] colFormula = excelSheet.getColFormula();
								if(null!=colFormula){
									String sixBuf = colFormula[columnIndex].replace("@", (i+2)+"");
									cell.setCellFormula(sixBuf);
								}
							}
							cell.setCellStyle(styleData); //不管是否有值，都设置样式(如边框)
						}
					}
				}

			}
			// 输出文件
			wb.write(out);
		} catch (Exception e) {
			log.info("===exportExcel Exception==="+e.getMessage());
			e.printStackTrace();
		} finally { //关流
			try {
				if(null!=out) out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 颜色样式：设置字体并加外边框
	 * @param wb 表
	 * @param style  样式
	 * @param fontName  字体名
	 * @param size  大小
	 * @return 颜色样式
	 */
	private static CellStyle setFontAndBorder(HSSFWorkbook wb, CellStyle style, String fontName, short size){
		HSSFFont font = wb.createFont();
		font.setFontHeightInPoints(size);
		font.setFontName(fontName);
		font.setBold(true);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
		style.setFont(font);
		style.setBorderBottom(CellStyle.BORDER_THIN); //下边框
		style.setBorderLeft(CellStyle.BORDER_THIN);//左边框
		style.setBorderTop(CellStyle.BORDER_THIN);//上边框
		style.setBorderRight(CellStyle.BORDER_THIN);//右边框
		return style;
	}

	/**
	 * 颜色样式：将16进制的颜色代码写入样式中来设置颜色
	 * @param style  保证style统一
	 * @param color 颜色：66FFDD
	 * @param index 索引 8-64 使用时不可重复
	 * @return 颜色样式
	 */
	private static CellStyle setColor(HSSFWorkbook wb,CellStyle style,String color,short index){
		if(StringUtil.isNotBlank(color)){
			//转为RGB码
			int r = Integer.parseInt((color.substring(0,2)),16);   //转为16进制
			int g = Integer.parseInt((color.substring(2,4)),16);
			int b = Integer.parseInt((color.substring(4,6)),16);
			//自定义cell颜色
			HSSFPalette palette = wb.getCustomPalette();
			palette.setColorAtIndex(index, (byte) r, (byte) g, (byte) b);

			style.setFillPattern(CellStyle.SOLID_FOREGROUND);
			style.setFillForegroundColor(index);
		}
		return style;
	}

}
