--[[ Calculates the percent of maximum power the unit is currently at. ]]
Protipper.API.Helpers.PowerPercent = function(unit)
  local unitStatus = Protipper.API.Status(unit)
  return unitStatus.currentPower / unitStatus.maxPower * 100
end
