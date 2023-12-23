Config = {}

Config.Locale = 'en' -- Jezik // Language
Config.KoristiBlipove = true -- Da li zelite da ima na mapi blip // Do you want to use blips
Config.DocumentItem = 'dokument' -- Stavite ime vaseg dokument itema za bus // Change into your document item name for bus

-- # Webhook Config
Config.LogHeader = "GS BUSJOB » Logs"
Config.Webhook = "" -- Discord webhook
-------------------------------------------------------

Config.Boss = { 
    {
        coords = vector4(452.6385, -615.0372, 28.5811, 266.4893),
        model = "a_m_y_smartcaspat_01",
    }
}

Config.Worker = { -- Za vracanje vozila // For returning vehicles
    {
        coords = vector4(443.5099, -593.9933, 28.4998, 349.0123),
        model = 'cs_floyd'
    }
}

Config.Blipovi = {
    {
        Ime = "Autobuska Stanica", -- Ime blipa // Name of blip
        Velicina = 1, -- Velicina blipa // Size of blip
        Boja = nil, -- Boja blipa // Color of blip
        Ikonica = 513, -- Blip sprite // Blip sprite
        Kordinate = vector3(452.6385, -615.0372, 28.5811), -- Kordinate blipa // Coords of blip
        Pokazuj = 6, -- Display
    }
}

Config.Lang = {
    collect = "[E] Da pokupite ljude sa stanice", -- [E] To collect people from station
    returnbus = "[E] Da vratite autobus", -- [E] Return bus
}

Config.Vozila = {
    model = 'bus',
    kordinatezaspawn = vector4(444.1372, -586.4486, 28.4998, 262.5552), -- Spawn Location Coords
}

Config.Lokacije = { -- Locations
   ["1"] = {
        lokacija = vector3(305.6824, -765.1893, 29.1579),
        zavrseno = false
    },
    ["2"] = {
        lokacija = vector3(115.3933, -783.2010, 31.2418),
        zavrseno = false
    },
    ["3"] = {
        lokacija = vector3(-173.3123, -818.5247, 31.0380),
        zavrseno = false
    },
    ["4"] = {
        lokacija = vector3(-739.6580, -751.1188, 26.6832),
        zavrseno = false
    },
    ["5"] = {
        lokacija = vector3(-691.2828, -668.7142, 30.7696),
        zavrseno = false
    },
    -- Add more if u want
}
