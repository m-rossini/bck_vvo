package br.com.auster.vivo.billcheckout.image;
import java.util.HashMap;

public class InvoicedPage extends Thread{
	
	private static final short CLOSE_TAG = 0;
	private static final short OPEN_TAG = 1;
	private static final short CLOSE_OPEN_TAG = 2;
	
	private ImageLineHTML lineHTML;
	private String currentLine;
	private HashMap<Integer, IndividualInvoicedPage> pages;
	private Integer currentPagePointer;
	private String pageName;
	
	public InvoicedPage(String pageName){
		this.pageName = pageName;
		this.lineHTML = ImageLineHTML.getInstance();
		this.currentLine = "";
		this.pages = new HashMap<Integer, IndividualInvoicedPage>();
		this.currentPagePointer = 0;
	}
	
	public void run(){
		int x=0;
		while(!this.lineHTML.isFinished()){
			this.currentLine = this.lineHTML.get(x);
			addLine(this.currentLine);
			x++;
		}
	}
	private void addLine(String line){
		lineValidator(line);
	}
	private void lineValidator(String line){
		if(line.contains("</html") && !line.contains("<html")){
			formatLine(line, CLOSE_TAG);
		}else if(line.contains("<html") && !line.contains("</html")){
			formatLine(line, OPEN_TAG);
		}else if(line.contains("</html") && line.contains("<html")){
			formatLine(line, CLOSE_OPEN_TAG);
		}else{
			this.pages.get(this.currentPagePointer).putLine(line);
		}
	}
	
	private void formatLine(String line, short type){
		switch(type){
			case CLOSE_OPEN_TAG:
				this.pages.get(this.currentPagePointer).putLine("</html>");
				this.pages.get(this.currentPagePointer).closePage();
				this.currentPagePointer++;
				this.pages.put(this.currentPagePointer, new IndividualInvoicedPage(getPageName(line)));
				this.pages.get(this.currentPagePointer).putLine("<html>");
			break;
			case OPEN_TAG:
				this.pages.put(this.currentPagePointer, new IndividualInvoicedPage(getPageName(line)));
				this.pages.get(this.currentPagePointer).putLine("<html>");
			break;
			case CLOSE_TAG:
				this.pages.get(this.currentPagePointer).putLine("</html>");
				this.pages.get(this.currentPagePointer).closePage();
				this.currentPagePointer++;
			break;
		}
	}
	
	private String getPageName(String line){
		String[] lineParts = line.split("\"");
		String[] counter;
		String pageNumber = "";
		counter = line.split("\'");
		if(counter.length > 1){
			pageNumber = counter[1];
		}
		return pageName  + "_" +lineParts[1] + pageNumber + ".html";
	}
	
}