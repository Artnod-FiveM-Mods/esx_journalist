local debug = Config.debug
ESX = nil
local playersWork = {}
local playersWorkExit = {}

-- debug msg
function printDebug(msg)
  if debug then print('[esx_journalist] '.. msg) end
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'journalist', 'Client Weazel News', false, false)
TriggerEvent('esx_society:registerSociety', 'journalist', 'Weazel News', 'society_weazel', 'society_weazel', 'society_weazel', {type = 'private'})

-- get Storage
ESX.RegisterServerCallback('esx_journalist:getStockItems', function(source, cb)
  printDebug('getStockItems')
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazel', function(inventory)
    cb(inventory.items)
  end)
end)
RegisterServerEvent('esx_journalist:getStockItem')
AddEventHandler('esx_journalist:getStockItem', function(itemName, count)
  printDebug('getStockItem')
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazel', function(inventory)
    local item = inventory.getItem(itemName)
    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)
  end)
end)
-- put Storage 
ESX.RegisterServerCallback('esx_journalist:getPlayerInventory', function(source, cb)
  printDebug('getPlayerInventory')
  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)
RegisterServerEvent('esx_journalist:putStockItems')
AddEventHandler('esx_journalist:putStockItems', function(itemName, count)
  printDebug('putStockItems')
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weazel', function(inventory)
    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count
    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
  end)
end)

-- harvest
function harvest(source, grade)
  printDebug('harvest')
  local timeout = nil
  local itemDb  = nil
  local iAdd  = nil
  if grade >= Config.journalistMinGrade then
  timeout = Config.jItemTime
  itemDb  = Config.jItemDb_name
  iAdd  = Config.jItemAdd
  else
  timeout = Config.iItemTime
  itemDb  = Config.iItemDb_name
  iAdd  = Config.iItemAdd
  end
  SetTimeout(timeout, function()
    if playersWorkExit[source] then playersWork[source] = false end
    if playersWork[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local bag = xPlayer.getInventoryItem(itemDb)
      local quantity = bag.count
      if quantity >= bag.limit then
        TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
        playersWork[source] = false
      else
        xPlayer.addInventoryItem(itemDb, iAdd)
        if quantity < bag.limit + iAdd then
          harvest(source, grade)
        else 
          TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
          playersWork[source] = false
        end
      end
    else 
      TriggerClientEvent('esx:showNotification', source, _U('harvest_fail')) 
      playersWork[source] = false
    end
  end)
end

-- sell
function sell(source, grade)
  printDebug('sell')
  local timeout = nil
  local itemDb  = nil
  local iRemove = nil
  local iPrice  = nil
  local cPrice  = nil
  local gPrice  = nil
  if grade >= Config.journalistMinGrade then 
    timeout = Config.jItemTime
    itemDb  = Config.jItemDb_name
    iRemove = Config.jItemRemove
    iPrice  = Config.jItemPrice
    cPrice  = math.floor(iPrice * Config.jCompanyRate)
    gPrice  = math.floor(cPrice * Config.gouvRate)
  else 
    timeout = Config.iItemTime
    itemDb  = Config.iItemDb_name
    iRemove = Config.iItemRemove
    iPrice  = Config.iItemPrice
    cPrice  = math.floor(iPrice * Config.iCompanyRate)
    gPrice  = math.floor(cPrice * Config.gouvRate)
  end
  
  SetTimeout(timeout, function()
    if playersWorkExit[source] then playersWork[source] = false end
    if playersWork[source] then
      local xPlayer = ESX.GetPlayerFromId(source)
      local quantity = xPlayer.getInventoryItem(itemDb).count
      if quantity < iRemove then
        TriggerClientEvent('esx:showNotification', source, _U('no_item_to_sell', itemDb))
        playersWork[source] = false
      else
        xPlayer.removeInventoryItem(itemDb, iRemove)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_weazel', function(cAccount)
      cAccount.addMoney(cPrice)
      xPlayer.addMoney(iPrice)
      TriggerClientEvent('esx:showNotification', source, _U('you_earned', iPrice))
      TriggerClientEvent('esx:showNotification', source, _U('your_comp_earned', cPrice))
    end)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxe_weazel', function(gAccount)
      gAccount.addMoney(gPrice)
    end)
        TriggerClientEvent('esx_journalist:nextBoxes', source)
      end
      playersWork[source] = false
    else TriggerClientEvent('esx:showNotification', source, _U('sell_fail')) end
  end)
  
end

RegisterServerEvent('esx_journalist:start')
AddEventHandler('esx_journalist:start', function(action, grade)
  printDebug('start')
  local _source = source
  if not playersWork[_source] then
    playersWork[_source] = true
    playersWorkExit[_source] = false
  if action == 'harvest' then
      TriggerClientEvent('esx:showNotification', _source, _U('harvest_start'))
      harvest(_source, grade)
  elseif action == 'sell' then
    TriggerClientEvent('esx:showNotification', _source, _U('sell_start'))
    sell(_source, grade)
  end
  end
  if playersWorkExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent('esx_journalist:stop')
AddEventHandler('esx_journalist:stop', function()
  printDebug('stop')
  local _source = source
  if playersWork[_source] then playersWorkExit[_source] = true end
end)

