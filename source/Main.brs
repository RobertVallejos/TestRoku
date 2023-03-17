sub Main()
    print ">>>>> Channel started"

    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    scene = screen.CreateScene("MainScreen")
    data = getContent()
    scene.setField("content", data)
    screen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

function getContent() as object
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.setRequest("GET")
    request.SetUrl("https://cdn-media.brightline.tv/recruiting/roku/testapi.json")
    request.SetHeaders({
        "Content-Type": "application/json"
    })
    request.SetCertificatesFile("common:/certs/ca-bundle.crt") 
    request.InitClientCertificates()

    if (request.AsyncGetToString())
        while (true)
            msg = wait(0, port)
            event = type(msg)
            if (event = "roUrlEvent")
                code = msg.GetResponseCode()
                if (code = 200)
                    json = msg.GetString()
                    return ParseJson(json)
                end if
            else if (event = invalid)
                request.AsyncCancel()
            endif
        end while
    endif

    return invalid
end function