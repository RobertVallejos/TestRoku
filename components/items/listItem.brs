sub init()
    m.context = m.top
    m.border = m.context.findNode("border")
    m.itemPoster = m.context.findNode("itemPoster")
    m.itemPoster.height = m.context.height

    m.title = m.context.findNode("title")
    m.title.color = "0xFFFFFF"
    m.title.font.size=25
    
    m.subtitle = m.context.findNode("subtitle")
    m.subtitle.color = "0x1F4E5F"
    m.subtitle.font.size=18

    m.description = m.context.findNode("description")
    m.description.color = "0xFFFFFF"
    m.description.font.size=16

    m.context.observeField("focusedChild", "onFocus")    
end sub

sub onContentUpdate()
    content = m.context.content
    m.title.text = content.title
    m.subtitle.text = UCase(content.subtitle)
    m.description.text = content.description

    m.itemPoster.uri = content.thumb

    m.title.translation = [m.itemPoster.translation[0] + m.itemPoster.width + 15, 10]
    m.subtitle.translation = [m.title.translation[0], m.title.translation[1] + m.title.font.size + 7]
    m.description.translation = [m.subtitle.translation[0], m.subtitle.translation[1] + m.subtitle.font.size + 7]
end sub

sub onFocus()
    if (m.context.hasFocus())
        m.border.color = "0xFF0000"
    else
        m.border.color = "0xFFFFFF"
    end if
end sub

