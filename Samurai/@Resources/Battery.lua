-- ============================================================
-- Battery.lua — v3 RONIN Edition
-- Reads battery data via WMIC (Win32_Battery WMI class)
-- Guaranteed to work on all Windows 10/11 machines
--
-- Returns: battery percentage (0-100) via Update()
-- Sets:    MeterBatteryStatus Text via SKIN:Bang so the
--          charging status always displays correctly regardless
--          of how PowerPlugin formats its return string
-- ============================================================

function Initialize()
    -- Nothing needed; Update() handles first read
end

function Update()
    local pct = 0
    local statusText = 'NO BATTERY'

    -- WMIC CSV output format (alphabetical columns after Node):
    --   Node,BatteryStatus,EstimatedChargeRemaining
    --   DESKTOP-XXX,6,87
    -- 2>nul suppresses any deprecation warning on Windows 11
    local f = io.popen('wmic path Win32_Battery GET BatteryStatus,EstimatedChargeRemaining /FORMAT:CSV 2>nul')

    if f then
        local raw = f:read('*a')
        f:close()

        -- Match data line: MachineName,<BatteryStatus>,<EstimatedChargeRemaining>
        -- Machine names can contain letters, digits, hyphens, dots, underscores
        local bs_s, ecr_s = raw:match('[%w%-%_%.]+%s*,(%d+)%s*,(%d+)')

        if bs_s and ecr_s then
            pct = tonumber(ecr_s) or 0
            local bs = tonumber(bs_s) or 0

            -- Win32_Battery BatteryStatus values:
            --  1 = Other/Discharging   2 = Unknown/AC (on power, not reporting full)
            --  3 = Fully Charged       4 = Low          5 = Critical
            --  6 = Charging            7 = Charging + High
            --  8 = Charging + Low      9 = Charging + Critical
            if bs == 3 then
                statusText = 'FULLY CHARGED'
            elseif bs >= 6 then
                statusText = 'CHARGING'
            elseif bs == 2 then
                statusText = 'AC CONNECTED'
            elseif bs == 4 then
                statusText = 'LOW BATTERY'
            elseif bs == 5 then
                statusText = '!! CRITICAL !!'
            elseif bs == 1 then
                statusText = 'ON BATTERY'
            end
        end
    end

    -- Push status text into the meter directly via Bang
    -- (Bypasses Substitute string-matching issues with Plugin measures)
    SKIN:Bang('!SetOption MeterBatteryStatus Text "' .. statusText .. '"')

    return pct
end
