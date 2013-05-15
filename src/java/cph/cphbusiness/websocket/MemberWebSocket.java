/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cph.cphbusiness.websocket;

import com.sun.grizzly.websockets.DefaultWebSocket;
import com.sun.grizzly.websockets.ProtocolHandler;
import com.sun.grizzly.websockets.WebSocketListener;

/**
 *
 * @author
 * kasper
 */
public class MemberWebSocket extends DefaultWebSocket{

    private String memberName;
    
    public MemberWebSocket(ProtocolHandler protocolHandler, WebSocketListener... listeners) {
        super(protocolHandler, listeners);
    }

    @Override
    public void onMessage(String text) {
        if(text.startsWith("Name:"))memberName = text.substring(5);
        else super.onMessage(text); //To change body of generated methods, choose Tools | Templates.
    }

    public String getMemberName() {
        return memberName;
    }
    
    
}
