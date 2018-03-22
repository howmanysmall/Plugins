-- This script goes as a child to the Mute.lua ModuleScript

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)
wait()
script:Destroy()
script.Disabled = true
