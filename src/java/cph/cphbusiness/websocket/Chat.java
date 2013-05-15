/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cph.cphbusiness.websocket;

import com.sun.grizzly.tcp.Request;
import com.sun.grizzly.websockets.DataFrame;
import com.sun.grizzly.websockets.ProtocolHandler;
import com.sun.grizzly.websockets.WebSocket;
import com.sun.grizzly.websockets.WebSocketApplication;
import com.sun.grizzly.websockets.WebSocketListener;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author
 * kasper
 */
public class Chat extends WebSocketApplication {

    @Override
    public boolean isApplicationRequest(Request rqst) {
        return true;
    }

    @Override
    public WebSocket createWebSocket(ProtocolHandler protocolHandler, WebSocketListener... listeners) {
        return new MemberWebSocket(protocolHandler, listeners);
    }

    @Override
    public void onMessage(WebSocket socket, String text) {
        MemberWebSocket mSocket = (MemberWebSocket)socket;
        if (text.startsWith("Message:")) {
             for(WebSocket target : getWebSockets()){
                System.err.println("Message:" + mSocket.getMemberName() +":" + text.substring(8));
                target.send("Message:" + mSocket.getMemberName() +":" + text.substring(8));
            }
        } else if (text.startsWith("List:")) {
            String list = "List:";
            for (WebSocket memberName : getWebSockets()) {
                mSocket = (MemberWebSocket)memberName;
                list += mSocket.getMemberName() + ",";
            }
            for (WebSocket target : getWebSockets()) {
                target.send(list);
            }
            System.err.println(list);
        }
    }
}
