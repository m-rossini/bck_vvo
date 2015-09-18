package br.com.auster.vivo.invoice.util.extensions;

import java.io.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;

import com.sun.org.apache.xml.internal.serialize.*;

public class CarrierList{

	private Document doc;

	public CarrierList(){
		byte[] buffer = new byte[30514];
	      InputStream in;
	      this.doc = null;
	      try {
	         in = new FileInputStream("conf/image/carrier_list.txt");
	         in.read(buffer);
	         String temp = new String(buffer).trim().toString();

	         String[] linhas = temp.split("\\n");

	         DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	         dbf.setNamespaceAware(false);
	         DocumentBuilder docBuilder = dbf.newDocumentBuilder();
	         this.doc = docBuilder.newDocument();
	         Element el = this.doc.createElement("Operadora");
	         Element el2;

	         for(int x=0; x<linhas.length; x++){

	        	 String[] linha = linhas[x].split(";",-1);

	        	 for(int y=0; y<linha.length; y++){
			        el2 = this.doc.createElement("OperadoraDetalhe");
			         	el2.setAttribute("DESCRIPTION", linha[0]);
			         	el2.setAttribute("CSP", linha[1]);
			         	el2.setAttribute("STATE", linha[2]);
			         	el2.setAttribute("NAME", linha[3]);
			         	el2.setAttribute("ADDRESS", linha[4]);
			         	el2.setAttribute("CNPJ", linha[5]);
			         	el2.setAttribute("INSC_MUNICIPAL", linha[6]);
			         	el2.setAttribute("CFOP", linha[7]);
			         el.appendChild(el2);
		         }
	         }

	         this.doc.appendChild(el);
	        /*
	         XMLSerializer serializer = new XMLSerializer(System.out, new
	         OutputFormat(this.doc, "iso-8859-1", true));
	         serializer.serialize(this.doc);
			*/

	         in.close();



	      } catch (Exception e) {
	         System.out.println(e);
	      }


	}


	public static Node getOperadora(String estado, String codigo ){

		Document docXML = new CarrierList().doc;
		NodeList list = docXML.getElementsByTagName("OperadoraDetalhe");
		Node noRetorno = null;

		for(int x=0; x< list.getLength(); x++){
			NamedNodeMap noAtual = list.item(x).getAttributes();
			if(noAtual.getNamedItem("STATE").getTextContent().equals(estado) &&
				noAtual.getNamedItem("CSP").getTextContent().equals(codigo)){
				noRetorno =  list.item(x);
			}
		}

		return noRetorno;

	}




}