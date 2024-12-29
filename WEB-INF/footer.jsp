    </main>
    <div id="loginOverlay"  <% if(session.getAttribute("ssid") != null){ %>style="display:none; pointer-events:none;"<%}%>>
        <div id="loginBox">
            <% pageContext.include("login.jsp"); %>
        </div>
    </div>
</body>

</html>