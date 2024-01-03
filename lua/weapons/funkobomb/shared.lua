SWEP.Author        = "Traysir"
SWEP.Category      = "Grenades"
SWEP.Purpose       = "Explodes on impact or after a delay."
SWEP.Instructions  = "Left-Click: Throw grenade"
SWEP.Spawnable     = true
SWEP.AdminSpawnable = false

SWEP.ViewModel     = "models/funkopop/funkopop.mdl" 
SWEP.WorldModel    = "models/funkopop/funkopop.mdl" 

SWEP.HoldType      = "grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

-- Precache the model and sounds
function SWEP:Precache()
    util.PrecacheModel(SWEP.WorldModel)
    util.PrecacheSound("weapons/pinpull.wav")
    util.PrecacheSound("weapons/grenade_throw.wav")
    util.PrecacheSound("weapons/grenade_explode3.wav")
end

-- Primary Fire (Throw Grenade)
function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
    self.Weapon:SendWeaponAnim(ACT_VM_THROW)

    if SERVER then
        timer.Simple(0.2, function() if IsValid(self) then self:ThrowGrenade() end end)
    end
end

-- Grenade throw function
function SWEP:ThrowGrenade()
    if not self or not IsValid(self.Owner) then return end

    local grenadeObj = ents.Create("models/funkopop/funkopop.mdl") 
    grenadeObj:SetPos(self.Owner:GetShootPos())
    grenadeObj:SetAngles(self.Owner:GetAimVector():Angle())
    grenadeObj:SetOwner(self.Owner)
    grenadeObj:Spawn()

    local throwStrength = 1500 -- Adjust as needed
    grenadeObj:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector() * throwStrength + Vector(0, 0, 200))

    self.Owner:EmitSound("weapons/grenade_throw.wav", 40, 100)
end

-- Deploy Function
function SWEP:Deploy()
    self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
    return true
end
