require("google-translate")
local widget = require("widget")
local imgChart
local cx,cy
local txfWord,btnOK,btnSound
local background

background = display.newImage("bg.jpg", cx, cy)

function loadImageListener(event)	
	if (event.phase == "ended") then
		if(imgChart) then
				imgChart:removeSelf()
				imgChart = nil
			end
		imgChart = display.newImage(
			event.response.filename,event.response.baseDirectory,
			system.DocumentDirectory)
			imgChart:translate(cx,150)
		end
	end
local function buttonEvent(event)
    if (event.phase == "ended") then
     	if not (txfWord == "") then
     	   reqChart(txfWord.text)
     	end
    end
end

local function buttonEventSound(event)
    if (event.phase == "ended") then
     	if not (txfWord == "") then
     	   reqSpeech(txfWord.text, "en" )
     	end
    end
end


cx=display.contentCenterX
cy=display.contentCenterY
display.setDefault("background",1,1,1)
function reqChart(text)
	
 network.download(
        "https://chart.googleapis.com/chart?chs=250x250&cht=qr&chld=H|2&chl="..text,
        "GET",
        loadImageListener,
        {},
        math.random(1500) .. ".png",
        system.DocumentDirectory
    )
end
btnOK = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 380,
			width = 280,
			shape = "Rectangle",
			label = "Create QR Code",
			id = "button1",
			labelColor = {default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={1, 0.5, 0.5, 0.9}, over={1, 1, 1, 1} },
			onEvent = buttonEvent
		}
	)


btnSound = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 450,
			width = 280,
			shape = "Rectangle",
			label = "Read It!",
			id = "button1",
			labelColor = {default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={1, 0.5, 0.5, 0.9}, over={1, 1, 1, 1} },
			onEvent = buttonEventSound
		}
	)

txfWord = native.newTextField(cx, 340, 200, 40)
txfWord.align = "center"
