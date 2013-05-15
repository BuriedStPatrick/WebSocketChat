/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dk.cphbusiness.servlet;

import com.sun.grizzly.websockets.WebSocketEngine;
import cph.cphbusiness.websocket.Chat;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author
 * kasper
 */
@WebServlet(name = "WebSocketApplicationLauncher", urlPatterns = {"/WebSocketApplicationLauncher"},
loadOnStartup = 1)
public class WebSocketApplicationLauncher extends HttpServlet {
    private Chat chat = new Chat();
    Collection<String> onlineNames = new ArrayList<String>();

    @Override
    public void init() throws ServletException {
        super.init();
        WebSocketEngine.getEngine().register(chat);
    }

   
    @Override
    public void destroy() {
        WebSocketEngine.getEngine().unregister(chat);
        super.destroy(); //To change body of generated methods, choose Tools | Templates.
        
    }
    
    
}
