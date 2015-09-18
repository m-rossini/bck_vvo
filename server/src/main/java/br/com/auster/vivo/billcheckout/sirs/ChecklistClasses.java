/*
 * Copyright (c) 2004-2005 Auster Solutions. All Rights Reserved.
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
 * Created on Apr 1, 2005
 */
package br.com.auster.vivo.billcheckout.sirs;

/**
 * <p><b>Title:</b> ChecklistClasses</p>
 * <p><b>Description:</b> </p>
 * <p><b>Copyright:</b> Copyright (c) 2004-2005</p>
 * <p><b>Company:</b> Auster Solutions</p>
 *
 * @author etirelli
 * @version $Id: ChecklistClasses.java 258 2005-11-04 18:59:24Z etirelli $
 */

public class ChecklistClasses {
  private ChecklistClasses() {}
  
  public static final String CALL_CLASS_NC          = "N/C";
  public static final String CALL_CLASS_VC1H        = "VC1H";
  public static final String CALL_CLASS_FRANQUIA    = "FRANQUIA";
  public static final String CALL_CLASS_ATEND       = "*1234/*555";
  public static final String CALL_CLASS_VC1SPV      = "VC1SPV";
  public static final String CALL_CLASS_VC1C        = "VC1C";
  public static final String CALL_CLASS_ROI         = "ROI";
  public static final String CALL_CLASS_MODEM       = "MODEM";
  public static final String CALL_CLASS_WAP         = "WAP";
  public static final String CALL_CLASS_VAS         = "S.V.A.";
  public static final String CALL_CLASS_VOX         = "CLICKFONE VOX";
  public static final String CALL_CLASS_SPECIAL     = "NÚMEROS ESPECIAIS";
  public static final String CALL_CLASS_ADICIONAL   = "ADICIONAL";
  public static final String CALL_CLASS_VC2H        = "VC2H";
  public static final String CALL_CLASS_VC3H        = "VC3H";
  public static final String CALL_CLASS_VC2C        = "VC2C";
  public static final String CALL_CLASS_VC3C        = "VC3C";
  public static final String CALL_CLASS_VC2R        = "VC2R";
  public static final String CALL_CLASS_VC3R        = "VC3R";
  public static final String CALL_CLASS_INT         = "INT";
  public static final String CALL_CLASS_INTR        = "INTR";
  public static final String CALL_CLASS_INTC        = "INTC";
  public static final String CALL_CLASS_DSL1        = "DSL1";
  public static final String CALL_CLASS_DSL2        = "DSL2";
  public static final String CALL_CLASS_1xRTT       = "DADOS 2,5G";
  public static final String CALL_CLASS_TORPEDO     = "TORPEDO";
  public static final String CALL_CLASS_3RD_PARTY   = "SERVIÇOS TERCEIROS";
  
  public static final String CALL_SUBCLASS_NC       = "N/C";
  public static final String CALL_SUBCLASS_MM       = "MM";
  public static final String CALL_SUBCLASS_MF       = "MF";
  public static final String CALL_SUBCLASS_MMI      = "MMI";
  public static final String CALL_SUBCLASS_GRUPO    = "GRUPO";
  public static final String CALL_SUBCLASS_VC1      = "VC1";
  public static final String CALL_SUBCLASS_VC3      = "VC3";
  public static final String CALL_SUBCLASS_ROAM     = "ROAM";
  public static final String CALL_SUBCLASS_555      = "*555";
  public static final String CALL_SUBCLASS_WAAAP    = "WAP";
  public static final String CALL_SUBCLASS_VC1SPV   = "VC1SPV";
  public static final String CALL_SUBCLASS_7000     = "*7000/*365";
  public static final String CALL_SUBCLASS_3000     = "*3000";
  public static final String CALL_SUBCLASS_ORIGINADO = "ORIGINADO";
  public static final String CALL_SUBCLASS_RECEBIDO = "RECEBIDO";
  public static final String CALL_SUBCLASS_SMS      = "SMS";
  public static final String CALL_SUBCLASS_MMS      = "MMS";
  public static final String CALL_SUBCLASS_VIVO     = "VIVO";
  public static final String CALL_SUBCLASS_CARRIER  = "OUTRA OPER.";
  public static final String CALL_SUBCLASS_STATE    = "OUTRO EST.";
  public static final String CALL_SUBCLASS_OTHER    = "OUTROS";
  public static final String CALL_SUBCLASS_UNIQUE   = "U";
  
  public static final String CALL_TARIFF_PEAK     = "P";
  public static final String CALL_TARIFF_OFFPEAK  = "O";
  public static final String CALL_TARIFF_UNIQUE   = "U";
  public static final String CALL_TARIFF_EVENT    = "E";
}
