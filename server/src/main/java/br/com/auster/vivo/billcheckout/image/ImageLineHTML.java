package br.com.auster.vivo.billcheckout.image;

import java.io.ObjectStreamException;
import java.io.Serializable;
import java.util.HashMap;


public class ImageLineHTML implements Serializable{
	
	private static final long serialVersionUID = 650397498124659321L;
	
	private static final ImageLineHTML INSTANCE = new ImageLineHTML();
    private HashMap<Integer, String> mapLines;
    private boolean available;
    private boolean finished;

    
    private ImageLineHTML(){
    	this.available = false;
    	this.finished = false;
    	mapLines = new HashMap<Integer, String>();
	}
    
    public static ImageLineHTML getInstance(){
    	return INSTANCE;
    }
    
    public void finisher(){
    	this.finished = true;
    }
    
    public boolean isFinished(){
    	if( (this.finished == true) && this.mapLines.size() == 0  ){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    public synchronized String get(int who) {
        while (available == false) {
            try {
                wait();
            } catch (InterruptedException e) { }
        }

        String retorno = this.mapLines.get(who);

        this.mapLines.remove(who);
        if(this.mapLines.size() == 0 ){
        	available = false;
        }
        
        //System.out.println("Consumer " + who + " got: " + retorno);
        notifyAll();
        
        return retorno;
    }

    public synchronized void put(int who, String value) {
        this.mapLines.put(who, value);
        available = true;
        //System.out.println("Producer " + who + " put: " + value);
        notifyAll();
    }
    
    private Object readResolve() throws ObjectStreamException {
		return INSTANCE;
	}
}