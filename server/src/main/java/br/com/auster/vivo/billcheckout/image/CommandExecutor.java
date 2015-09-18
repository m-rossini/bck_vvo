/*
 * Copyright (c) 2004-2008 Auster Solutions. All Rights Reserved.
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
 * Created on 23/04/2008
 */
package br.com.auster.vivo.billcheckout.image;

import java.io.IOException;
import java.util.LinkedList;

import org.apache.log4j.Logger;

/**
 * @author framos
 * @version $Id$
 *
 */
public class CommandExecutor {


	private static final Logger log = Logger.getLogger(CommandExecutor.class);


	public static final String COMMAND_SYSPROPERTY = "ant.commandLine";

	public static final String COMMAND = System.getProperty(COMMAND_SYSPROPERTY);


	private String antFile;


	public CommandExecutor(String _antFile) {
		this.antFile = _antFile;
	}

	public Process execute(LinkedList<String> _parameters) throws IOException {

		LinkedList<String> parameters = new LinkedList<String>();
		parameters.add("-f");
		parameters.add(this.antFile);
		parameters.addAll(_parameters);

		StringBuffer buff = new StringBuffer();
		buff.append(COMMAND);
		for(String param : parameters) {
			buff.append(" ");
			buff.append(param);
		}
		log.debug("Running command " + buff.toString());
		// really running command
		Process proc = Runtime.getRuntime().exec(buff.toString());
		return proc;
	}


	public static void main(String args[]) {
		//Running command %ANT_HOME%/bin/ant with paramters: -f  -Dinput_file file -Daccount_number number
		try {
			//"-f", "bin/isc-image.xml"
			Process proc = Runtime.getRuntime().exec("cmd /c ant -f src/main/bin/asr1/isc-image.xml" );
			byte[] info = new byte[1024];
			while ( proc.getInputStream().read(info) > 0 ) {
				System.out.println( new String(info) );
			}
			System.out.println(proc.waitFor());
		} catch (Exception e) { e.printStackTrace(); }
	}
}
