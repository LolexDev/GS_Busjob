--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--─██████████████─████████████████───██████████████─██████──██████─██████████████────██████████████─██████████████─████████████████───██████████─██████████████─██████████████─██████████████─
--─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░░░░░██────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─
--─██░░██████████─██░░████████░░██───██░░██████░░██─██░░██──██░░██─██░░██████████────██░░██████████─██░░██████████─██░░████████░░██───████░░████─██░░██████░░██─██████░░██████─██░░██████████─
--─██░░██─────────██░░██────██░░██───██░░██──██░░██─██░░██──██░░██─██░░██────────────██░░██─────────██░░██─────────██░░██────██░░██─────██░░██───██░░██──██░░██─────██░░██─────██░░██─────────
--─██░░██─────────██░░████████░░██───██░░██──██░░██─██░░██──██░░██─██░░██████████────██░░██████████─██░░██─────────██░░████████░░██─────██░░██───██░░██████░░██─────██░░██─────██░░██████████─
--─██░░██──██████─██░░░░░░░░░░░░██───██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██────██░░░░░░░░░░██─██░░██─────────██░░░░░░░░░░░░██─────██░░██───██░░░░░░░░░░██─────██░░██─────██░░░░░░░░░░██─
--─██░░██──██░░██─██░░██████░░████───██░░██──██░░██─██░░██──██░░██─██░░██████████────██████████░░██─██░░██─────────██░░██████░░████─────██░░██───██░░██████████─────██░░██─────██████████░░██─
--─██░░██──██░░██─██░░██──██░░██─────██░░██──██░░██─██░░░░██░░░░██─██░░██────────────────────██░░██─██░░██─────────██░░██──██░░██───────██░░██───██░░██─────────────██░░██─────────────██░░██─
--─██░░██████░░██─██░░██──██░░██████─██░░██████░░██─████░░░░░░████─██░░██████████────██████████░░██─██░░██████████─██░░██──██░░██████─████░░████─██░░██─────────────██░░██─────██████████░░██─
--─██░░░░░░░░░░██─██░░██──██░░░░░░██─██░░░░░░░░░░██───████░░████───██░░░░░░░░░░██────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██░░░░░░██─██░░░░░░██─██░░██─────────────██░░██─────██░░░░░░░░░░██─
--─██████████████─██████──██████████─██████████████─────██████─────██████████████────██████████████─██████████████─██████──██████████─██████████─██████─────────────██████─────██████████████─
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
local duznost = false
local tablice = math.random(1,100)
local currentStationIndex = 1
local zaradio = 0

if Config.KoristiBlipove == true then
    Citizen.CreateThread(function ()
      for i, v in pairs(Config.Blipovi) do
          local blip = AddBlipForCoord(v.Kordinate.x, v.Kordinate.y, v.Kordinate.z)
    
          SetBlipSprite(blip, v.Ikonica)
    
          if v.Boja ~= nil then
              SetBlipColour(blip, v.Boja)
          end
    
          SetBlipDisplay(blip, v.Pokazuj)
    
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(v.Ime)  -- Stavi ime blipu
          EndTextCommandSetBlipName(blip)
    
    
          local display = v.Pokazuj
    
          SetBlipDisplay(blip, display)
      end
    end)
    else
      TriggerServerEvent('GS_Atmrobbery:notUsingBlips')
end

Citizen.CreateThread(function()
    for _,v in pairs(Config.Boss) do
      RequestModel(GetHashKey(v.model))
      while not HasModelLoaded(GetHashKey(v.model)) do
        Wait(1)
      end
      PostaviPeda = CreatePed(4, v.model, vector3(v.coords.x, v.coords.y, v.coords.z - 1) , v.coords.w, false, true)
      TaskStartScenarioInPlace(PostaviPeda, "WORLD_HUMAN_STAND_MOBILE", 0, true)
      FreezeEntityPosition(PostaviPeda, true) 
      SetEntityInvincible(PostaviPeda, true)
      SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
        exports.qtarget:AddBoxZone('zapocni', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
            name= 'zapocni',
            heading= v.coords.w,
            debugPoly= Config.Debug,
            minZ= v.coords.z -1,
            maxZ= v.coords.z +2,
            }, {
              options = {
                {
                  action = function()
                    TriggerEvent('salkan')
                  end,
                  icon = "fa-solid fa-person",
                  label = TranslateCap("bossnpctext"),
                },
              }
            })
    end
end)

RegisterNetEvent('salkan', function()
lib.registerContext({
  id = 'sefmenu',
  title = TranslateCap('dutytitle'),
  options = {
    {
      title = TranslateCap('leaveduty'),
      description = TranslateCap('leavedutyd'),
      icon = 'fa-solid fa-xmark',
      onSelect = function ()
        obavesti(TranslateCap('leavedduty'),TranslateCap('dutyleave'),'success','top')
        TriggerServerEvent('GS_Busjob:z', zaradio)
        duznost = false
      end,
      disabled = not duznost
    },
    {
      title = TranslateCap('joindutytitle'),
      description = '',
      icon = 'fa-solid fa-check',
      onSelect = function ()
        duznost = true
        obavesti(TranslateCap('joineduty'),TranslateCap('dutyond')..tablice,'success','top')
        TriggerEvent('GS_Busjob:ib')
      end,
      disabled = duznost,
    },
  }
})
lib.showContext('sefmenu')
end)

RegisterNetEvent('GS_Busjob:ib', function ()
  DoScreenFadeOut(800)
  while not IsScreenFadedOut() do
      Wait(100)
    end
    ESX.Game.SpawnVehicle(Config.Vozila.model, vector3(Config.Vozila.kordinatezaspawn.x, Config.Vozila.kordinatezaspawn.y, Config.Vozila.kordinatezaspawn.z), Config.Vozila.kordinatezaspawn.w, function(vozilo)
        TaskWarpPedIntoVehicle(PlayerPedId(), vozilo, -1)
        local props = {
          plate = tablice,
        }
        ESX.Game.SetVehicleProperties(vozilo, props)
        DoScreenFadeIn(800)
    end)
    currentStationIndex = 1
    SetWaypointToStation(currentStationIndex)
    TriggerServerEvent('GS_Busjob:giveDocument', tablice)
end)

local textUI = {}

CreateThread(function()
    while true do
        local sleep = 1500
        for k, v in pairs(Config.Lokacije) do
            local distanca = #(GetEntityCoords(PlayerPedId()) - vector3(v.lokacija.x, v.lokacija.y, v.lokacija.z))
            if distanca < 5.0 and IsPedInAnyVehicle(PlayerPedId(), false) and not v.zavrseno and duznost then
                if not textUI[k] then
                    lib.showTextUI(Config.Lang.collect) -- Collect people from station
                    textUI[k] = true
                end
                sleep = 0
                if IsControlJustReleased(0, 38) then
                    lib.hideTextUI()
                    lib.progressBar({
                      duration = 5000,
                      label = TranslateCap('collecting'),
                      useWhileDead = false,
                      canCancel = false,
                      disable = {
                          car = true,
                          move = true,
                          combat = true,
                          mouse = false
                      },
                  })
                  v.zavrseno = true
                  zaradio = zaradio + math.random(100,500)
                  local newStationIndex = currentStationIndex + 1
                    currentStationIndex = newStationIndex
                    SetWaypointToStation(currentStationIndex)
                    obavesti(TranslateCap('succollected', zaradio),'','success','top',5000)
                end
            else
                if textUI[k] then
                    lib.hideTextUI()
                    textUI[k] = nil
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('GS_Busjob:pb', function ()
  local podatak = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), true))
  TriggerServerEvent('GS_Busjob:returnDocument', podatak.plate)
  Wait(1000)
  TaskLeaveVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
  Wait(2800)
  ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), true))
  obavesti(TranslateCap('returned'),'','success','top',5000)
end)

Citizen.CreateThread(function()
  for _,v in pairs(Config.Worker) do
    RequestModel(GetHashKey(v.model))
    while not HasModelLoaded(GetHashKey(v.model)) do
      Wait(1)
    end
    PostaviPeda = CreatePed(4, v.model, vector3(v.coords.x, v.coords.y, v.coords.z - 1) , v.coords.w, false, true)
    TaskStartScenarioInPlace(PostaviPeda, "WORLD_HUMAN_CLIPBOARD", 0, true)
    FreezeEntityPosition(PostaviPeda, true) 
    SetEntityInvincible(PostaviPeda, true)
    SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
  end
end)

CreateThread(function()
    while true do
        local sleep = 1500
        for k, v in pairs(Config.Worker) do
            local distanca = #(GetEntityCoords(PlayerPedId()) - vector3(v.coords.x, v.coords.y, v.coords.z))
            if distanca < 5.0 and IsPedInAnyVehicle(PlayerPedId(), false) and duznost then
                if not textUI[k] then
                    lib.showTextUI(Config.Lang.returnbus) -- Return bus
                    textUI[k] = true
                end
                sleep = 0
                if IsControlJustReleased(0, 38) then
                    lib.hideTextUI()
                    TriggerEvent('GS_Busjob:pb')
                end
            else
                if textUI[k] then
                    lib.hideTextUI()
                    textUI[k] = nil
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterCommand('testcheat', function ()
  TriggerEvent('troll')
end)