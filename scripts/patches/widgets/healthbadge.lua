return function(self)
    local old_OnUpdate = self.OnUpdate
    function self:OnUpdate(...)
        if _G.TheNet:IsServerPaused() then return end

        local state = self.owner.replica.radiation:GetState()
        local modified = false

        if state == _G.RADIATION_STATE_CRITICAL then
            if self.arrowdir ~= "arrow_loop_decrease_most" then
                self.arrowdir = "arrow_loop_decrease_most"

                self.sanityarrow:GetAnimState():PlayAnimation(self.arrowdir, true)
            end
            
            modified = true
        elseif state == _G.RADIATION_STATE_HIGH then
            if self.arrowdir ~= "arrow_loop_decrease_more" and self.arrowdir ~= "arrow_loop_decrease_most" then
                self.arrowdir = "arrow_loop_decrease_more"

                self.sanityarrow:GetAnimState():PlayAnimation(self.arrowdir, true)
            end
            
            modified = true
        end

        if not modified then
            old_OnUpdate(self, ...)
        end
    end
end