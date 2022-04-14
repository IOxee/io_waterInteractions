Config = {
    animDict = 'anim@heists@narcotics@funding@gang_idle', -- the dictionary of animations
    anim = 'gang_chatting_idle01', -- The animation it will do when you use the object
    removeObjectWhenPlayerContactWithWater = false, -- If you activate this function the resmon can go from 0.00 to 0.10, if you leave it deactivated the resmon drops to 0.00
}

-- These are the objects that when used collect the water from the lakes when used
CollectorsObject = {
    -- {collectorItem = ''. containerObject = '', progressBarTimer = 0},
    {collectorItem = 'bottle', containerObject = "badwater", progressBarTimer = 10000},
}

-- These are the objects that are replaced by their broken version or will be deleted if you leave it empty
RemovableObject = {
    -- {originalItem = '', brokenItem = ''},
    {originalItem = "walkie", brokenItem = "broken_walkie"},
}


-- My notifications are pNotify and they allow you to add HTML/CSS code if yours do not allow it, remove it or do what you want
Translation = {
    Sayings = {
        [1] = "Filling a ",
        [2] = "You are not near a water source.",
        [3] = "You cannot perform this action from a vehicle.",
        [4] = "You are already interacting with something.",
        [5] = "You have come into contact with unprotected water. <span style='color:red';>", 
        [6] = "</span></br> What has ended up being a useless object",
    }
}

-- You can freely modify this function to do what you need. As long as you use the 2 variables, fromServer is an optional usage
function SendNotifications(msg, typeNotification, fromServer)
    if not fromServer then
        exports.pNotify:SendNotification({text = msg, type = typeNotification, timeout = 4000, layout = "centerLeft"})
    else
        TriggerClientEvent("pNotify:SendNotification", source, {text = msg,type = typeNotification, timeout = 4000, layout = "centerLeft"})
    end
end

-- You can change the type of progressBar you want here, by putting its export/trigger
function exportsProgressBars(msg, time)
    exports['progressBars']:startUI(time, msg)
end