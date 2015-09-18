package br.com.auster.vivo.billcheckout.image;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class ImageCutter extends Thread{
	
	private FileReader fileHTML;
	private BufferedReader reader;
	
	public ImageCutter(File file){
		try{
			this.fileHTML = new FileReader(file);
			this.reader = new BufferedReader(fileHTML);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public void run(){
		try{
			String line = null;
			ImageLineHTML lineHTML = ImageLineHTML.getInstance();
			int x=0;
			while((line = reader.readLine())!= null){
				lineHTML.put(x,line);
				x++;
			}
			lineHTML.finisher();
			reader.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}