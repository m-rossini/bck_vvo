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
 * Created on 21/03/2007
 */
package br.com.auster.vivo.billcheckout.probes;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * TODO What this class is responsible for
 * 
 * @author mtengelm
 * @version $Id$
 * @since 21/03/2007
 */
public class DBProbeMain {

	public static final int	MODE_CONNECTION	= 1;
	public static final int	MODE_SQL				= 2;

	// private int threads;
	private int							mode;
	private ExecutorService	threadPool;
	private ArrayList				threadList;

	// private DBProbe connectionProbe;

	public DBProbeMain() {
	}

	public void setParameters(String[] args) throws ClassNotFoundException {
		int skipped = 2;
		String parms[] = new String[args.length - skipped];
		System.arraycopy(args, skipped, parms, 0, args.length - skipped);

		int threads = Integer.parseInt(args[0]);
		this.threadPool = Executors.newFixedThreadPool(threads);

		threadList = new ArrayList(threads);

		mode = Integer.parseInt(args[1]);
		if (mode == MODE_CONNECTION) {

			for (int i = 0; i < threads; i++) {
				DBProbe probe = new DBConnectionProbe();
				probe.setParameters(parms);
				threadList.add(probe);
			}

		} else if (mode == MODE_SQL) {
			for (int i = 0; i < threads; i++) {
				DBProbe probe = new DBSQLProbe();
				probe.setParameters(parms);
				threadList.add(probe);
			}
		}
	}

	public List stress() throws InterruptedException {
		return this.threadPool.invokeAll(this.threadList);
	}

	public void shutdown() {
		this.threadPool.shutdown();
	}

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @param args
	 * @throws ClassNotFoundException
	 * @throws InterruptedException
	 */
	public static void main(String[] args) throws ClassNotFoundException,
			InterruptedException {
		System.out.println(">>>Starting a new Probe<<<");
		DBProbeMain probe = new DBProbeMain();
		probe.setParameters(args);
		List results = probe.stress();
		probe.shutdown();
		System.out.println(">>>Current Probe has ended<<<");
	}

}
