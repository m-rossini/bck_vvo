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
 * Created on Jul 5, 2005
 */
package br.com.auster.vivo.invoice.util.extensions;




/**
 * <p><b>Title:</b> DateFormat</p>
 * <p><b>Description:</b> TODO class description</p>
 * <p><b>Copyright:</b> Copyright (c) 2004-2005</p>
 * <p><b>Company:</b> Auster Solutions</p>
 *
 * @author rbarone
 * @version $Id: DateFormat.java 111 2005-07-23 19:34:42Z rbarone $
 */
public class DateFormat {


  
  private static final int DD_MASK = 1;
  private static final int MM_MASK = 2;
  private static final int YY_MASK = 4;
  private static final int YYYY_MASK = 8;
  
  // Caching used formats
  private static final int MMYYYY_MASK = MM_MASK | YYYY_MASK;
  private static final int DDMMYY_MASK = DD_MASK | MM_MASK | YY_MASK;
  private static final int DDMMYYYY_MASK = DD_MASK | MM_MASK | YYYY_MASK;
  
  /**
   * Formats a date in the form 'yyyyMMdd' to 'dd/MM/yyyy'.
   * 
   * @param rawDate The 'yyyyMMdd' date string to be formatted.
   * @return the formatted date.
   */
  public final static String formatDDMMYYYY(String rawDate) {
    return format(rawDate, DDMMYYYY_MASK).toString();
  }
  
  /**
   * Formats a date in the form 'yyyyMMdd' to 'dd/MM/yy'.
   * 
   * @param rawDate The 'yyyyMMdd' date string to be formatted.
   * @return the formatted date.
   */
  public final static String formatDDMMYY(String rawDate) {
    return format(rawDate, DDMMYY_MASK).toString();
  }
  
  /**
   * Formats a date in the form 'yyyyMMdd' to 'MM/yyyy'.
   * 
   * @param rawDate The 'yyyyMMdd' date string to be formatted.
   * @return the formatted date.
   */
  public final static String formatMMYYYY(String rawDate) {
    return format(rawDate, MMYYYY_MASK).toString();
  }
  
  /**
   * Formats a time in the form 'hhmmss' to 'hh:mm:ss'.
   * 
   * @param rawTime The 'hhmmss' time string to be formatted.
   * @return the formatted time.
   */
  public final static String formatHHMMSS(String rawTime) {
    if (rawTime == null || rawTime.length() < 6) {
      throw new IllegalArgumentException("Invalid time, should be 'hhmmss': ["
          + rawTime + "]");
    }
    StringBuffer result = new StringBuffer();
    result.append(rawTime.substring(0, 2)).append(":");
    result.append(rawTime.substring(2, 4)).append(":");
    result.append(rawTime.substring(4, 6));
    return result.toString();
  }
  
  private final static StringBuffer format(String rawDate, int mask) {
    StringBuffer result = new StringBuffer();
    if (rawDate == null || rawDate.length() == 0) {

      return result;
    } else if (rawDate.length() != 8) {
      throw new IllegalArgumentException("Invalid date, should be 'yyyyMMdd': [" + 
          rawDate + "]");
    }
    if ((mask & DD_MASK) > 0) {
      result.append(rawDate.substring(6, 8)).append("/");
    }
    if ((mask & MM_MASK) > 0) {
      result.append(rawDate.substring(4, 6)).append("/");
    }
    if ((mask & YY_MASK) > 0) {
      result.append(rawDate.substring(2, 4));
    } else if ((mask & YYYY_MASK) > 0) {
      result.append(rawDate.substring(0, 4));
    }
    return result;
  }

}
