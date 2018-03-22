-- This script goes as a child of the Unmute.lua ModuleScript

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true)
wait()
script:Destroy()
script.Disabled = true
