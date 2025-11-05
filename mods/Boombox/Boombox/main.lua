local M = {}


local equat = false


local BoomBox = {}
local Selectsoud = {}
local timemusic = {}
local audioId = {}
local isPlay = "Stop"
local IsSpawn = false
local value = 1
local isLoop = false

local music1 = audioClip.load("audio/music1.mp3")
local music2 = audioClip.load("audio/music2.mp3")
local music3 = audioClip.load("audio/music3.mp3")
local music4 = audioClip.load("audio/music4.mp3")
local music5 = audioClip.load("audio/music5.mp3")


function M.start()
    
    



end





function M.update()
    
    if input.getKeyDown("M") then
        equat = not equat
    end
    if input.getKeyDown("J") and IsSpawn == false then
        SpawnBoombox()
        IsSpawn = true
    end
    if input.getKeyDown("N") and IsSpawn == true then
        DestroyBoombox()
        IsSpawn = false
    end

end



function M.guiUpdate()
    
    if equat == true then
        
        gui.beginArea(550, 200, 300, 500)
        gui.setBackgroundColor(1, 0, 0, 1)

        gui.label("<size=40><align=center>BoomBox Menu <size=20> v1.0")
        gui.space(10)

        if gui.button("Spawn BoomBox [J]") and IsSpawn == false then
            SpawnBoombox()
            IsSpawn = true
        end

        if gui.button("Remuve Boombox [N]") and IsSpawn == true then
            DestroyBoombox()
            IsSpawn = false
        end

        if IsSpawn == true then
            gui.space(20)
            gui.label("<size=20><align=center>Select:" .. Selectsoud .. " " .. timemusic)
            gui.space(10)

            gui.beginHorizontal()

                if gui.button(isPlay) then
                    if isPlay == "Play" then
                        isPlay = "Stop"
                        audioSource.stop(audioId)
                    else
                        isPlay = "Play"
                        audioSource.play(audioId)
                    end
                end

            gui.endHorizontal()

            gui.space(10)
            
            value = gui.slider(value, 0.1, 30.0, true, "float")

            gui.space(10)
            
            isLoop = gui.checkbox(isLoop, "Loop")

            gui.space(20)
            gui.label("<size=20><align=center>Songs")
            gui.space(10)
            gui.beginVertical()

                if gui.button("music1") then
                    local sel = audioSource.setClip(audioId, music1)
                    local string = tostring(music1)
                    Selectsoud = string
                    timemusic = audioClip.getLength(sel)
                end

                if gui.button("music2") then
                    local sel = audioSource.setClip(audioId, music2)
                    local string = tostring(music2)
                    Selectsoud = string
                    timemusic = audioClip.getLength(sel)
                end

                if gui.button("music3") then
                    local sel = audioSource.setClip(audioId, music3)
                    local string = tostring(music3)
                    Selectsoud = string
                    timemusic = audioClip.getLength(sel)
                end

                if gui.button("music4") then
                    local sel = audioSource.setClip(audioId, music4)
                    local string = tostring(music4)
                    Selectsoud = string
                    timemusic = audioClip.getLength(sel)
                end

                if gui.button("music5") then
                    local sel = audioSource.setClip(audioId, music5)
                    local string = tostring(music5)
                    Selectsoud = string
                    timemusic = audioClip.getLength(sel)
                end


            gui.endVertical()

            audioSource.setVolume(audioId, value)
            audioSource.setLoop(audioId, isLoop)
            audioSource.setSpatial(audioId, value)
        end

        
        gui.endArea()


    end

    
end


function DestroyBoombox()
    
    gameObject.destroy(BoomBox)
    Selectsoud = nil
    isPlay = "Stop"

end



function SpawnBoombox()
    
    local playerID = getLocalPlayer()
    local playerTransform = gameObject.getTransform(playerID)
    local x, y, z = transform.getPosition(playerTransform)

    BoomBox = gameObject.createWithModel("MyCube", "models/Boombox.obj", "icons/tex.png")

    rb = component.add(BoomBox, "Rigidbody")
    component.add(BoomBox, "BoxCollider")

    local t = gameObject.getTransform(BoomBox)
    transform.setPosition(t, x, y, z)

    audioId = audioSource.add(BoomBox)
    audioSource.setSpatial(audioId, 1.0)
    audioSource.stop(audioId)
end



 return M