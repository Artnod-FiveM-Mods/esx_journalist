ESX = nil

local playersInterimHarvest = {}
local playersInterimHarvestExit = {}

local playersInterimSell = {}
local playersInterimSellExit = {}

local playersJournalistHarvest = {}
local playersJournalistHarvestExit = {}

local playersJournalistSell = {}
local playersJournalistSellExit = {}

-- debug msg
function printDebug(msg)
  if Config.debug then print('['.. Config.scriptName ..']\t'.. msg) end
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', Config.jobName, 'Appel '..Config.companyName, false, false)
TriggerEvent('esx_society:registerSociety', Config.jobName, Config.companyName, Config.companyLabel, Config.companyLabel, Config.companyLabel, {type = 'private'})

-- get Storage
ESX.RegisterServerCallback(Config.scriptName ..':getStockItems', function(source, cb)
  printDebug('getStockItems')
  TriggerEvent('esx_addoninventory:getSharedInventory', Config.companyLabel, function(inventory)
    cb(inventory.items)
  end)
end)
RegisterServerEvent(Config.scriptName ..':getStockItem')
AddEventHandler(Config.scriptName ..':getStockItem', function(itemName, count)
  printDebug('getStockItem')
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', Config.companyLabel, function(inventory)
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
ESX.RegisterServerCallback(Config.scriptName ..':getPlayerInventory', function(source, cb)
  printDebug('getPlayerInventory')
  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)
RegisterServerEvent(Config.scriptName ..':putStockItems')
AddEventHandler(Config.scriptName ..':putStockItems', function(itemName, count)
  printDebug('putStockItems')
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_addoninventory:getSharedInventory', Config.companyLabel, function(inventory)
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

-- interim harvest
function interimHarvest(source)
  printDebug('interimHarvest')
  SetTimeout(Config.iItemTime, function()
    if playersInterimHarvestExit[source] then playersInterimHarvest[source] = false end
    if playersInterimHarvest[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local bag = xPlayer.getInventoryItem(Config.iItemDb_name)
      local quantity = bag.count
      if quantity >= bag.limit then
        TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
        playersInterimHarvest[source] = false
      else
        xPlayer.addInventoryItem(Config.iItemDb_name, Config.iItemAdd)
        if quantity < bag.limit + Config.iItemAdd then
          interimHarvest(source)
        else 
          TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
          playersInterimHarvest[source] = false
        end
      end
    else 
      TriggerClientEvent('esx:showNotification', source, _U('harvest_fail')) 
      playersInterimHarvest[source] = false
    end
  end)
end
RegisterServerEvent(Config.scriptName ..':startInterimHarvest')
AddEventHandler(Config.scriptName ..':startInterimHarvest', function()
  printDebug('startInterimHarvest')
  local _source = source
  if not playersInterimHarvest[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('harvest_start'))
    playersInterimHarvest[_source] = true
    playersInterimHarvestExit[_source] = false
    interimHarvest(_source)
  end
  if playersInterimHarvestExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent(Config.scriptName ..':stopInterimHarvest')
AddEventHandler(Config.scriptName ..':stopInterimHarvest', function()
  printDebug('stopInterimHarvest')
  local _source = source
  if playersInterimHarvest[_source] then playersInterimHarvestExit[_source] = true end
end)
-- interim sell
function interimSell(source)
  printDebug('interimSell')
  SetTimeout(Config.iItemTime, function()
    if playersInterimSellExit[source] then playersInterimSell[source] = false end
    if playersInterimSell[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local quantity = xPlayer.getInventoryItem(Config.iItemDb_name).count
      if quantity < Config.iItemRemove then
        TriggerClientEvent('esx:showNotification', source, _U('no_item_to_sell', Config.iItemDb_name))
        playersInterimSell[source] = false
      else
        xPlayer.removeInventoryItem(Config.iItemDb_name, Config.iItemRemove)
        xPlayer.addMoney(Config.iItemPrice)
        local companyPrice = Config.iItemPrice * Config.iCompanyRate
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.companyLabel, function(account)account.addMoney(math.floor(companyPrice))end )
        TriggerClientEvent('esx:showNotification', source, _U('you_earned', Config.iItemPrice))
        TriggerClientEvent('esx:showNotification', source, _U('your_comp_earned', math.floor(companyPrice)))
        TriggerClientEvent('esx_journalist:nextBoxes', source)
      end
      playersInterimSell[source] = false
    else TriggerClientEvent('esx:showNotification', source, _U('sell_fail')) end
  end)
end
RegisterServerEvent(Config.scriptName ..':startInterimSell')
AddEventHandler(Config.scriptName ..':startInterimSell', function()
  printDebug('startInterimSell')
  local _source = source
  if not playersInterimSell[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('sell_start'))
    playersInterimSell[_source] = true
    playersInterimSellExit[_source] = false
    interimSell(_source)
  end
  if playersInterimSellExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent(Config.scriptName ..':stopInterimSell')
AddEventHandler(Config.scriptName ..':stopInterimSell', function()
  printDebug('stopInterimSell')
  local _source = source
  if playersInterimSell[_source] then playersInterimSellExit[_source] = true end
end)

-- journalist harvest
function journalistHarvest(source)
  printDebug('journalistHarvest')
  SetTimeout(Config.iItemTime, function()
    if playersJournalistHarvestExit[source] then playersJournalistHarvest[source] = false end
    if playersJournalistHarvest[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local bag = xPlayer.getInventoryItem(Config.jItemDb_name)
      local quantity = bag.count
      if quantity >= bag.limit then
        TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
        playersJournalistHarvest[source] = false
      else
        xPlayer.addInventoryItem(Config.jItemDb_name, Config.jItemAdd)
        if quantity < bag.limit + Config.jItemAdd then
          journalistHarvest(source)
        else 
          TriggerClientEvent('esx:showNotification', source, _U('go_sell'))
          playersJournalistHarvest[source] = false
        end
      end
    else 
      TriggerClientEvent('esx:showNotification', source, _U('harvest_fail')) 
      playersJournalistHarvest[source] = false
    end
  end)
end
RegisterServerEvent(Config.scriptName ..':startJournalistHarvest')
AddEventHandler(Config.scriptName ..':startJournalistHarvest', function()
  printDebug('startJournalistHarvest')
  local _source = source
  if not playersJournalistHarvest[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('harvest_start'))
    playersJournalistHarvest[_source] = true
    playersJournalistHarvestExit[_source] = false
    journalistHarvest(_source)
  end
  if playersJournalistHarvestExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent(Config.scriptName ..':stopJournalistHarvest')
AddEventHandler(Config.scriptName ..':stopJournalistHarvest', function()
  printDebug('stopJournalistHarvest')
  local _source = source
  if playersJournalistHarvest[_source] then playersJournalistHarvestExit[_source] = true end
end)
-- journalist sell
function journalistSell(source)
  printDebug('journalistSell')
  SetTimeout(Config.iItemTime, function()
    if playersJournalistSellExit[source] then playersJournalistSell[source] = false end
    if playersJournalistSell[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local quantity = xPlayer.getInventoryItem(Config.jItemDb_name).count
      if quantity < Config.iItemRemove then
        TriggerClientEvent('esx:showNotification', source, _U('no_item_to_sell', Config.jItemDb_name))
        playersJournalistSell[source] = false
      else
        xPlayer.removeInventoryItem(Config.jItemDb_name, Config.jItemRemove)
        xPlayer.addMoney(Config.jItemPrice)
        local companyPrice = Config.jItemPrice * Config.jCompanyRate
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.companyLabel, function(account)account.addMoney(math.floor(companyPrice))end )
        TriggerClientEvent('esx:showNotification', source, _U('you_earned', Config.jItemPrice))
        TriggerClientEvent('esx:showNotification', source, _U('your_comp_earned', math.floor(companyPrice)))
        TriggerClientEvent('esx_journalist:nextBoxes', source)
      end
      playersJournalistSell[source] = false
    else TriggerClientEvent('esx:showNotification', source, _U('sell_fail')) end
  end)
end
RegisterServerEvent(Config.scriptName ..':startJournalistSell')
AddEventHandler(Config.scriptName ..':startJournalistSell', function()
  printDebug('startJournalistSell')
  local _source = source
  if not playersJournalistSell[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('sell_start'))
    playersJournalistSell[_source] = true
    playersJournalistSellExit[_source] = false
    journalistSell(_source)
  end
  if playersJournalistSellExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent(Config.scriptName ..':stopJournalistSell')
AddEventHandler(Config.scriptName ..':stopJournalistSell', function()
  printDebug('stopJournalistSell')
  local _source = source
  if playersJournalistSell[_source] then playersJournalistSellExit[_source] = true end
end)

