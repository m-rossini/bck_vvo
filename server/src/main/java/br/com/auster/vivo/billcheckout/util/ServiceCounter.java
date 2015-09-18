/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on 15/12/2005
 */

package br.com.auster.vivo.billcheckout.util;

/**
 * <p><b>Title:</b> ServiceCounter</p>
 * <p><b>Description:</b> TODO: Description of ServiceCounter</p>
 * <p><b>Copyright:</b> Copyright (c) 2005</p>
 * <p><b>Company:</b> Auster Solutions</p>
 *
 * @author etirelli
 * @version $Id: ServiceCounter.java 400 2005-12-16 16:53:10Z etirelli $
 */

public class ServiceCounter {
  private String serviceName;
  private int eventCounter;
  private int errorCounter;
  
  public int getErrorCounter() {
    return errorCounter;
  }
  public void setErrorCounter(int errorCounter) {
    this.errorCounter = errorCounter;
  }
  public int getEventCounter() {
    return eventCounter;
  }
  public void setEventCounter(int eventCounter) {
    this.eventCounter = eventCounter;
  }
  public String getServiceName() {
    return serviceName;
  }
  public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
  }

}
