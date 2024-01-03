AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include('shared.lua')


function ENT:Initialize()
    self:SetModel("models/funkopop.mdl") 
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end


function ENT:Explode()
    -- Explosion effect
    local explosion = ents.Create("env_explosion")
    explosion:SetPos(self:GetPos())
    explosion:SetOwner(self:GetOwner())
    explosion:Spawn()
    explosion:SetKeyValue("iMagnitude", "100") -- Explosion magnitude
    explosion:Fire("Explode", 0, 0)

   

    self:Remove() -- Remove the bomb entity after explosion
end

-- Function for what happens when the bomb is used
function ENT:Use(activator, caller)
    self:Explode()
end
