package br.com.auster.vivo.billcheckout.rmi;

import java.rmi.Naming;

import br.com.auster.dware.RemoteBootstrap;
import junit.framework.TestCase;

public class RMIBindTest extends TestCase {

  protected void setUp() throws Exception {
    super.setUp();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
  }
  
  public void testRMIBind() {
    // will always succeed
    try {
      RemoteBootstrap server = (RemoteBootstrap) Naming.lookup("//localhost:2004/billcheckout");
      server.process("default", null, null);
    } catch (Exception e) {
      System.out.println("Error attaching to RMI Registry.");
    }
  }

}
