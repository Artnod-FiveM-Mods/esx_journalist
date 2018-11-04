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
TriggerEvent('esx_society:registerSociety', Config.companyName, Config.companyName, Config.companyLabel, Config.companyLabel, Config.companyLabel, {type = 'private'})

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
function weeklyCollect(source)
  printDebug('weeklyCollect')
  SetTimeout(Config.blackTime, function()
    if playersJournalistHarvestExit[source] then playersJournalistHarvest[source] = false end
    if playersJournalistHarvest[source] then
      local request = "SELECT start_date, harvest, sell, malus FROM weekly_run WHERE company = '" .. Config.jobName .. "'"
      local response = MySQL.Sync.fetchAll(request) -- [{"harvest":0,"malus":0,"sell":0,"start_date":0},]
      local tmpTime = os.time()
      if tmpTime >= response[1].start_date then
      if response[1].harvest < Config.blackStep - response[1].malus then
         local xPlayer = ESX.GetPlayerFromId(source)
         local account = xPlayer.getAccount('black_money')
         if account.money > 0 then TriggerClientEvent('esx:showNotification', source, _U('need_no_bm'))
         else
           xPlayer.addAccountMoney('black_money', Config.blackAdd)
           response[1].harvest = response[1].harvest + 1
           request = "UPDATE weekly_run SET harvest = ".. response[1].harvest .. " WHERE company = '" .. Config.jobName .. "'"
           local resp = MySQL.Sync.fetchScalar(request)
           if response[1].harvest == Config.blackStep - response[1].malus  then TriggerClientEvent('esx:showNotification', source, _U('return_bank',response[1].harvest, Config.blackStep - response[1].malus))
           else TriggerClientEvent('esx:showNotification', source, _U('depose_and_retry',response[1].harvest, Config.blackStep - response[1].malus)) end
         end
       else TriggerClientEvent('esx:showNotification', source, _U('harvest_complete')) end
     else TriggerClientEvent('esx:showNotification', source, _U('wait_week')) end
    else TriggerClientEvent('esx:showNotification', source, _U('weekly_harvest_stop')) end
    playersJournalistHarvest[source] = false
  end)
end
RegisterServerEvent(Config.scriptName ..':startWeeklyCollect')
AddEventHandler(Config.scriptName ..':startWeeklyCollect', function()
  printDebug('startWeeklyCollect')
  local _source = source
  if not playersJournalistHarvest[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('weekly_harvest_start'))
    playersJournalistHarvest[_source] = true
    playersJournalistHarvestExit[_source] = false
    weeklyCollect(_source)
  end
  if playersJournalistHarvestExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent(Config.scriptName ..':stopWeeklyCollect')
AddEventHandler(Config.scriptName ..':stopWeeklyCollect', function()
  printDebug('stopWeeklyCollect')
  local _source = source
  if playersJournalistHarvest[_source] then playersJournalistHarvestExit[_source] = true end
end)
-- journalist destruct
function weeklyDestruct(source)
  printDebug('weeklyDestruct')
  SetTimeout(Config.blackTime, function()
    if playersJournalistSellExit[source] then playersJournalistSell[source] = false end
    if playersJournalistSell[source] == true then
      local xPlayer = ESX.GetPlayerFromId(source)
      local account = xPlayer.getAccount('black_money')
      local amountR = math.floor((Config.blackRemove-(Config.blackRemove % 1000))/1000) .. ' '
      local amountRBis = Config.blackRemove % 1000
      if amountRBis < 100 then amountR = amountR .. '0' end
      if amountRBis < 10  then amountR = amountR .. '0' end
      amountR = amountR .. amountRBis
      if account.money < Config.blackRemove then
        TriggerClientEvent('esx:showNotification', source, _U('need_more_bm', amountR))
        playersJournalistSell[source] = false
      else
        xPlayer.removeAccountMoney('black_money', Config.blackRemove)
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.companyLabel, function(account)account.addMoney(Config.blackPrice)end)
        local request = "SELECT start_date, harvest, sell, malus FROM weekly_run WHERE company = '" .. Config.jobName .. "'"
        local response = MySQL.Sync.fetchAll(request) -- [{"harvest":0,"malus":0,"sell":0,"start_date":0},]
        request = "UPDATE weekly_run SET sell = ".. response[1].sell + 1 .. " WHERE company = '" .. Config.jobName .. "'"
        local resp = MySQL.Sync.fetchScalar(request)
        
        local amountP = math.floor((Config.blackPrice-(Config.blackPrice % 1000))/1000) .. ' '
        local amountPBis = Config.blackPrice % 1000
        if amountPBis < 100 then amountP = amountP .. '0' end
        if amountPBis < 10  then amountP = amountP .. '0' end
        amountP = amountP .. amountPBis
        TriggerClientEvent('esx:showNotification', source, _U('was_destruct', amountR))
        TriggerClientEvent('esx:showNotification', source, _U('your_comp_earned', amountP))
        account = xPlayer.getAccount('black_money')
        if account.money >= Config.blackRemove then weeklyDestruct(source)
        else 
          TriggerClientEvent('esx:showNotification', source, _U('weekly_destruct_stop'))
          playersJournalistSell[source] = false
        end
      end
    else TriggerClientEvent('esx:showNotification', source, _U('weekly_destruct_fail')) end
  end)
end
RegisterServerEvent(Config.scriptName ..':startWeeklyDestruct')
AddEventHandler(Config.scriptName ..':startWeeklyDestruct', function()
  printDebug('startWeeklyDestruct')
  local _source = source
  if not playersJournalistSell[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('weekly_destruct_start'))
    playersJournalistSell[_source] = true
    playersJournalistSellExit[_source] = false
    weeklyDestruct(_source)
  end
  if playersJournalistSellExit[_source] then
    TriggerClientEvent('esx:showNotification', _source, _U('dont_cheat'))
  end
end)
RegisterServerEvent(Config.scriptName ..':stopWeeklyDestruct')
AddEventHandler(Config.scriptName ..':stopWeeklyDestruct', function()
  printDebug('stopWeeklyDestruct')
  local _source = source
  if playersJournalistSell[_source]then playersJournalistSellExit[_source] = true end
end)

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
