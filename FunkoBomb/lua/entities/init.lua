-- init.lua

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/funkopop/funkopop.mdl")  
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Explode()
    local explosionEffect = ents.Create("env_explosion")
    explosionEffect:SetPos(self:GetPos())
    explosionEffect:SetOwner(self:GetOwner())
    explosionEffect:Spawn()
    explosionEffect:SetKeyValue("iMagnitude", "100")
    explosionEffect:Fire("Explode", 0, 0)

    self:Remove()
end

function ENT:Use(activator, caller)
    self:Explode()
end
