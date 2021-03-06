package org.drools.brms.client.common;
/*
 * Copyright 2005 JBoss Inc
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



import com.google.gwt.user.client.ui.ClickListener;
import com.google.gwt.user.client.ui.DialogBox;
import com.google.gwt.user.client.ui.HorizontalPanel;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.Panel;
import com.google.gwt.user.client.ui.PopupPanel;
import com.google.gwt.user.client.ui.Widget;


/** 
 * Generic error dialog popup.
 * This is a lazy singleton, only really need one to be shown at time. 
 */
public class ErrorPopup extends DialogBox {
    
    public static ErrorPopup instance = null;
    
    Label errorMessage = new Label();
    Panel panel = new HorizontalPanel();
    Image ok = new ImageButton("images/close.gif");
    
    public ErrorPopup() {        
        super(true);
        
        panel.add( new Image("images/error_dialog.png") );
        panel.add( errorMessage );
        panel.add( ok );
        final PopupPanel self = this;
        ok.addClickListener( new ClickListener() {
            public void onClick(Widget arg0) {                
                self.hide();
            }            
        });
        this.setWidget( panel );
        this.setPopupPosition( 40, 40 );
        setHeight( "150px" );
        setStyleName( "rule-error-Popup" );        
    }
    
    public void setMessage(String message) {
        errorMessage.setText( message );        
    }
    

    public void hide() {
        errorMessage.setText( "" );
        super.hide();
    }
    
    public static ErrorPopup getInstance() {
        if (instance == null) {
            instance = new ErrorPopup();            
        }
        return instance;
    }
    
    /** Convenience method to popup the message. */
    public static void showMessage(String message) {
        ErrorPopup p = getInstance();
        LoadingPopup.close();
        
        p.errorMessage.setText( message );
        p.show();
    }
    

    
     
    
    
}