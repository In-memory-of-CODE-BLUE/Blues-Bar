include("shared.lua")

function ENT:Draw()

	self:DrawModel()--We dont draw becuase of a rendering issue so it gets called after the customer is rendered.

end

