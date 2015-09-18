package br.com.auster.vivo.billcheckout.image;
import java.io.FileWriter;

public class IndividualInvoicedPage{
		
	private String pageName;
	private StringBuffer lines;
	
	public IndividualInvoicedPage(String pageName){
		this.pageName = pageName;
		this.lines = new StringBuffer();
	}
	
	public void putLine(String line){
		this.lines.append(line);
		this.lines.append("\r\n");
	}
	
	public void closePage(){
		this.writeFile();
	}
	
	private void writeFile(){
		try{
			final FileWriter fileW = new FileWriter(pageName);
			final String linesStr = this.lines.toString();
			Thread t = new Thread(){
				public void run(){
					try{
						fileW.write(linesStr);
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						try{fileW.close();}catch(Exception e){}
					}
				}
			};
			t.start();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}