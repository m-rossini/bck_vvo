/*
 * Copyright (c) 2004-2007 Auster Solutions. All Rights Reserved.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Created on 16/03/2007
 */
package br.com.auster.vivo.billcheckout.probes;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.UnknownHostException;


/**
 * This class has the objective of providing a High level measure of Netowrk Performance.
 * It receives 3 parameters:
 * 1-Hostname (Ou IP Address)
 * 2-Port Number
 * 3-Quantidade de Conexões.
 *
 * @author mtengelm
 * @version $Id$
 * @since 16/03/2007
 */
public class PortProbeMain {

	private Socket	socket;
	private int	times;
	private int	port;
	private String	ip;
	private SocketAddress	address;

	/**
	 * Creates a new instance of the class <code>PortMeasure</code>.
	 */
	public PortProbeMain() {
	}

	public void setParameters(String ip, int port, int times)  {
		this.ip = ip;
		this.port = port;
		this.times = times;		
	}
	
	public Socket createSocket() throws UnknownHostException, IOException {
		System.out.println("Creating Client Socket.");
		socket = new Socket();		
		return socket;
	}
	
	public SocketAddress createAddress() {
		System.out.println("Creating Server Address.");
		address = new InetSocketAddress(ip,port);
		return address;
	}
	
	public void connect() throws IOException {
		createAddress();
		long totalConnectTime=0;
		long totalCloseTime=0;
		for (int i=0; i < times; i++) {
			System.out.println("+--------------------------------------------+");
			createSocket();			
//			socket.setReuseAddress(true);
			
			System.out.println("Connecting for time:" + i + " to address:" + address + " using socket:" + socket);
			long st = System.nanoTime();
			socket.connect(address);
			totalConnectTime += (System.nanoTime() - st);
			
			st = System.nanoTime();
			System.out.println("Closing client socket:" + socket);
			totalCloseTime+= (System.nanoTime() - st);
			socket.close();			
		}
		
		System.out.println("*************************************************");
		System.out.println("Total connection Time (nano):" + totalConnectTime + " (Mili)" + (totalConnectTime/1000/1000) );
		System.out.println("Total close      Time (nano):" + totalCloseTime + " (Mili)" + (totalCloseTime/1000/1000));
	}
	/***
	 * 
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * </p>
	 * IP ADDRESS (NOT HOSTNAME) 
	 * PORT NUMBER
	 * NUMBER OF TIMES I WILL TRY TO CONNECT
	 * @param args
	 * @throws IOException 
	 * @throws UnknownHostException 
	 * @throws NumberFormatException 
	 */
	public static void main(String[] args) throws NumberFormatException, UnknownHostException, IOException {
		if (args.length != 3) {
			printUsage();
			System.exit(1);
		}
		
		PortProbeMain pm = new PortProbeMain();
		pm.setParameters(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]));
//		Socket socket = pm.createSocket();
//		SocketAddress address = pm.createAddress();
		
		pm.connect();
		
	}
	
	public static void printUsage() {
		System.out.println("Usage of this command is like this:");
		System.out.println("java -cp target/classes br.com.auster.vivo.billcheckout.util.PortMeasure <IP> <PORT> <TIMES>");
	}
}
