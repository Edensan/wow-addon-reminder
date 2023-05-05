local reminderInterval = 60 * 10
local alertDuration = 60 * 0.2
local deathIcon = "Interface\\AddOns\\Hardcore\\Media\\alert-death.blp"

-- Alert UI
function showAlertFrame(message)
	message = message or ""
	filename = deathIcon
	Reminder_Alert_Icon:SetTexture(filename)
	Reminder_Alert_Text:SetText(message)
	Reminder_Alert_Frame:Show()
    PlaySound(8959)

	C_Timer.After(alertDuration, function()
		Reminder_Alert_Frame:Hide()
	end)
end

function remindUserToReload()
    showAlertFrame("/reload")
end

function scheduleReminder()
    C_Timer.After(reminderInterval, function()
        remindUserToReload()
        scheduleReminder()
    end)
end

local f = CreateFrame("Frame")

function f:OnEvent(event, ...)
	self[event](self, event, ...)
end

function f:PLAYER_ENTERING_WORLD(event, isLogin, isReload)
    scheduleReminder();
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", f.OnEvent)