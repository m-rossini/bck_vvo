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
 * <p><b>Title:</b> DurationFormat</p>
 * <p><b>Description:</b> TODO class description</p>
 * <p><b>Copyright:</b> Copyright (c) 2004-2005</p>
 * <p><b>Company:</b> Auster Solutions</p>
 *
 * @author rbarone
 * @version $Id: DurationFormat.java 139 2005-08-05 21:37:44Z rbarone $
 */
public class DurationFormat{

  /**
   * Formats the specified time in minutes to the respective 
   * numbers of hours, minutes and seconds.
   * 
   * <p>
   * The resulting String will be in the form:
   * <code>hour + suffix + minute + suffix + second + suffix</code>
   * 
   * @param timeInMinutes The time that will be formatted - must represent a number of minutes.
   * @param hourSuffix The String that will be appended to the hour part.
   * @param minuteSuffix The String that will be appended to the minute part.
   * @param secondSuffix The String that will be appended to the second part.
   * @return the formatted time in hours, minutes and seconds.
   */
  public static String formatFromMinutes(double timeInMinutes,
                                         String hourSuffix,
                                         String minuteSuffix,
                                         String secondSuffix) {
    return br.com.auster.common.text.DurationFormat.formatFromSeconds(timeInMinutes * 60,
                                                                      hourSuffix,
                                                                      minuteSuffix,
                                                                      secondSuffix);
  }

  /**
   * Formats the specified time in minutes to the respective 
   * numbers of hours, minutes and seconds.
   * 
   * <p>
   * The resulting String will be in the form:
   * <code>hour + 'h' + minute + 'm' + second + 's'</code>
   * 
   * @param timeInMinutes The time that will be formatted - must represent a number of minutes.
   * @return the formatted time in hours, minutes and seconds.
   */
  public static String formatFromMinutes(double timeInMinutes) {
    return formatFromMinutes(timeInMinutes, "h", "m", "s"); 
  }
  
  /**
   * Formats the specified time in minutes to the respective 
   * numbers of hours, minutes and seconds.
   * 
   * <p>
   * The resulting String will be in the form:
   * <code>hour + 'h' + minute + 'm' + second + 's'</code>
   * 
   * @param timeInMinutes The time that will be formatted - must represent a number of minutes.
   * @return the formatted time in hours, minutes and seconds.
   */
  public static String formatFromMinutesString(String timeInMinutes) {
	  Double db = Double.valueOf(timeInMinutes);
    return formatFromMinutes(db, "h", "m", "s"); 
  }
}
