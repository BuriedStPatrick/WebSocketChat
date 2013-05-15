
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <title></title>
        <link rel="stylesheet" href="https://d10ajoocuyu32n.cloudfront.net/mobile/1.3.1/jquery.mobile-1.3.1.min.css">

        <!-- Extra Codiqa features -->
        <link rel="stylesheet" href="desktop.css">

        <!-- jQuery and jQuery Mobile -->
        <script src="https://d10ajoocuyu32n.cloudfront.net/jquery-1.9.1.min.js"></script>
        <script src="https://d10ajoocuyu32n.cloudfront.net/mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>

        <!-- Extra Codiqa features -->
        <script src="https://d10ajoocuyu32n.cloudfront.net/codiqa.ext.js"></script>
        <script>
            $(document).ready(function() {
                var ws;
                var logFile = logFile += localStorage.getItem("Log");

                $("#send").click(function() {
                    var text = "Message:" + $("#textInput").val();
                    ws.send(text);
                });

                $("#clear").click(function() {
                    localStorage.removeItem("Log");
                });

                function wsOpened(event) {

                    $("#message").text("WS Opened" + "\n");
                    ws.send("Name:Ole");
                    ws.send("List:");
                    if (typeof(Storage) !== "undefined")
                    {
                        $("#message").append(localStorage.getItem("Log"));
                        // Yes! localStorage and sessionStorage support!
                        // Some code.....
                    }
                    else
                    {
                        // Sorry! No web storage support..
                    }
                }

                function wsClosed(event) {
                    ws.send("List:");
                    $("#message").text("WS Closed");
                }


                function wsMessage(message) {
                    if (message.data.indexOf("List:") >= 0) {
                        $("#onlineMembers").text(message.data.substring(5) + "\n");
                    } else if (message.data.indexOf("Message:") >= 0) {
                        $("#message").append(message.data.substring(8) + "\n");
                        if (typeof(Storage) !== "undefined")
                        {
                            logFile += message.data.substring(8) + "\n";
                            localStorage.setItem("Log", logFile);
                            // Yes! localStorage and sessionStorage support!
                            // Some code.....
                        }
                        else
                        {
                            // Sorry! No web storage support..
                        }
                    }
                }
                ws = new WebSocket("ws://localhost:8080/Chat");
                ws.onopen = wsOpened;
                ws.onmessage = wsMessage;
                ws.onclose = wsClosed;
            });
        </script>
    </head>
    <body>
        <!-- Home -->
        <div data-role="page" id="page1">
            <div data-theme="a" data-role="header">
                <h3>
                    Member Chat
                </h3>
            </div>
            <div data-role="content">
                <div data-role="fieldcontain">
                    <textarea name="" id="message" placeholder="" style="height: 300px; width: 100%;"></textarea>
                </div>
                <div class="ui-grid-a">
                    <div class="ui-block-a">
                        <div data-role="fieldcontain">
                            <input id="textInput" placeholder="" value="" type="text">
                        </div>
                    </div>
                    <div class="ui-block-b">
                        <a id="send" data-role="button" >
                            Send
                        </a>
                    </div>
                    <div class="ui-block-c">
                        <a id="clear" data-role="button" >
                            Clear
                        </a>
                    </div>
                </div>
                <div data-role="collapsible-set">
                    <div data-role="collapsible" data-collapsed="false">
                        <h3>
                            Show online members
                        </h3>
                        <div id="onlineMembers">                           
                        </div>
                    </div>
                </div>
            </div>
            <div data-theme="a" data-role="footer" data-position="fixed">
                <h3>
                    Footer
                </h3>
            </div>
        </div>
    </body>
</html>
