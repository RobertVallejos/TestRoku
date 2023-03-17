sub init()
    m.context = m.top
    m.context.setFocus(true)
    m.mainTitle = m.context.findNode("mainTitle")
    m.itemsContainer = m.context.findNode("itemsContainer")
    m.backgroundMainTitle = m.context.findNode("backgroundMainTitle")
    m.boder = m.context.findNode("border")

    m.mainTitle.font.size = 45
    m.mainTitle.color = "0x72DEFF"

    m.backgroundMainTitle.height = m.mainTitle.translation[1] + m.mainTitle.font.size + 10

    m.listedItems = []
    m.indexFocus = 0

    m.itemsContainerAnimation = m.context.findNode("itemsContainerAnimation")

    m.vectorInterpotator = m.context.findNode("vectorInterpotator")
    m.keyValue = [[0,0], [0,0]]
end sub

sub onContentUpdate()
    m.getApiDataTask = createObject("roSGNode", "getApiDataTask")
    m.getApiDataTask.content = m.context.content
    m.getApiDataTask.observeField("validatedContent", "setContent")
    m.getApiDataTask.control = "RUN"
end sub

sub setContent()
    m.data = m.getApiDataTask.validatedContent

    if(m.data <> invalid)
        m.mainTitle.text = m.data.title 'si el titulo no existe subir el layout
    end if

    if(m.data.videoData <> invalid)
        m.videoData = m.data.videoData
        for i = 0 to m.videoData.Count() - 1        
            newItem = CreateObject("roSGNode", "listItem")
            newItem.id = "item_" + i.toStr()
            newItem.content = m.videoData[i]
            newItem.observeField("selected", "onSelectedCancelationOption")

            'to render items
            m.itemsContainer.appendChild(newItem)

            'to control navigation
            m.listedItems.push(newItem)
        end for
    end if

    if(m.listedItems.Count() > 0) then m.listedItems[m.indexFocus].setFocus(true)

    translationX = m.mainTitle.translation[0]
    translationY = m.mainTitle.translation[1] + m.mainTitle.font.size + 15
    m.itemsContainer.translation = [translationX, translationY]
end sub

sub pressKeyAnimation(key as string)
    if(m.itemsContainerAnimation.state = "running")
        m.itemsContainerAnimation.control = "stop"
        keyValue = m.vectorInterpotator.keyValue
        m.itemsContainer.translation = keyValue[1]
    end if

    origin = m.itemsContainer.translation
    if(key = "up")
        final = origin[1] + m.listedItems[0].height
    else
        final = origin[1] - m.listedItems[0].height
    end if
    destiny = [origin[0], final]

    m.keyValue = [origin, destiny]
    m.vectorInterpotator.keyValue = m.keyValue
    m.itemsContainerAnimation.control = "start"
end sub

sub onChangeFocus(key as string)
    if(key = "up")
        m.indexFocus = m.indexFocus - 1
    else
        m.indexFocus = m.indexFocus + 1
    end if

    m.listedItems[m.indexFocus].setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if (press = true)
        if (key = "up" and m.indexFocus <> 0) or (key = "down" and m.indexFocus <> m.listedItems.Count() - 1)
            onChangeFocus(key)
            pressKeyAnimation(key)
            handled = true
        end if
    end if

    return handled
end function