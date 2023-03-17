sub init()
    print ">>>>> Task init.... "
    m.top.functionName = "setData"
end sub

function setData() as object
    data = m.top.content

    if(data <> invalid)
        for i = 0 to data.Count() - 1
            category = data.categories[i]

            content = {}
            content.title = isValid(category.name)
            
            resourceItems = []

            for each video in category.videos
                item = validateData(video)
                resourceItems.push(item)
            end for

            content.videoData = resourceItems
        end for        
        
        m.top.validatedContent = content
    end if
end function

function validateData(data)
    item = {}

    item.description = isValid(data.description)
    item.sources = isValid(data.sources)
    item.subtitle = isValid(data.subtitle)
    item.thumb = isValid(data.thumb)
    item.title =  isValid(data.title)
    item.startTime = isValid(data.interactiveAd.strtTime)
    item.duration = isValid(data.interactiveAd.duration)

    'TODO: validate the subarray -> data.interactiveAd.url

    return item
end function

function isValid(obj, default = invalid)
    if(default = invalid) then default = ""

    if(obj <> invalid)
        return obj
    else
        return default
    end if
end function