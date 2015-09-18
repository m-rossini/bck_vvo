/*
 * Copyright (c) 2004 Auster Solutions. All Rights Reserved.
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
 * Created on 22/12/2006
 */
package br.com.auster.vivo.billcheckout;

import java.rmi.server.RemoteServer;
import java.rmi.server.ServerNotActiveException;
import java.text.MessageFormat;

import org.apache.log4j.Logger;

import br.com.auster.common.jmx.AusterMBean;

/**
 * @author mtengelm
 *
 */
public class JMXBootstrap implements JMXBootstrapMBean {

	private static final Logger log = Logger.getLogger(JMXBootstrap.class);
	private Bootstrap ref;
	private String name;

	/**
	 * 
	 */
	public JMXBootstrap(Bootstrap ref) {
		this.ref = ref;
	}

	/* (non-Javadoc)
	 * @see br.com.auster.vivo.billcheckout.JMXBootstrapMBean#shutdownImmediate()
	 */
	public void shutdownImmediate() {
		ref.shutdown(false);
	}

	/* (non-Javadoc)
	 * @see br.com.auster.vivo.billcheckout.JMXBootstrapMBean#shutdownWait()
	 */
	public void shutdownWait() {
		ref.shutdown(true);
	}

  /* (non-Javadoc)
   * @see br.com.auster.dware.management.DWareMBean#getMBeanName()
   */
  public String getMBeanName() {
     return name;
  }
  
  /* (non-Javadoc)
   * @see br.com.auster.dware.monitor.DWareMBean#setMBeanName(java.lang.String)
   */
  public void setMBeanName(String _name) {
	   name = MessageFormat.format(AusterMBean.MBEAN_NAME_FORMAT, new Object[] {_name, _name } );
  }

  /* (non-Javadoc)
   * @see br.com.auster.dware.monitor.DWareMBean#setMBeanName(java.lang.String, java.lang.String)
   */
  public void setMBeanName(String _type, String _name) {
	   name = MessageFormat.format(AusterMBean.MBEAN_NAME_FORMAT, new Object[] {_type, _name } );
  }  


  public void log() {
     log.info("-----------------" + this.getMBeanName() + "----------------------------");
     try {
	    log.info("Client Host:" + RemoteServer.getClientHost());
    } catch (ServerNotActiveException e) {
	    e.printStackTrace();
    }
     log.info("---------------------------------------------");
  }

}
