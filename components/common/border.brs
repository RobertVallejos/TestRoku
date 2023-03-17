sub init()
    m.context = m.top
    m.borderTop = m.context.findNode("borderTop")
    m.borderLeft = m.context.findNode("borderLeft")
    m.borderBottom = m.context.findNode("borderBottom")
    m.borderRight = m.context.findNode("borderRight")
end sub

sub onColorChange()
    color = m.context.color
    m.borderTop.color = color
    m.borderLeft.color = color
    m.borderBottom.color = color
    m.borderRight.color = color
end sub


