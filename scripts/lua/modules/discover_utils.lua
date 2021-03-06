--
-- (C) 2017 - ntop.org
--
local json = require "dkjson"

local discover = {}

discover.debug = false

discover.apple_osx_versions = {
   ['4'] = 'Mac OS X 10.0 (Cheetah)',
   ['5'] = 'Mac OS X 10.1 (Puma)',
   ['6'] = 'Mac OS X 10.2 (Jaguar)',
   ['7'] = 'Mac OS X 10.3 (Panther)',
   ['8'] = 'Mac OS X 10.4 (Tiger)',
   ['9'] = 'Mac OS X 10.5 (Leopard)',
   ['10'] = 'Mac OS X 10.6 (Snow Leopard)',
   ['11'] = 'Mac OS X 10.7 (Lion)',
   ['12'] = 'OS X 10.8 (Mountain Lion)',
   ['13'] = 'OS X 10.9 (Mavericks)',
   ['14'] = 'OS X 10.10 (Yosemite)',
   ['15'] = 'OS X 10.11 (El Capitan)',
   ['16'] = 'OS X 10.12 (Sierra)',
}

discover.apple_products = {
   ['Macmini5,3'] = 'Mac mini "Core i7" 2.0 (Mid-2011/Server)',
   ['Macmini5,2'] = 'Mac mini "Core i7" 2.7 (Mid-2011)',
   ['Macmini5,1'] = 'Mac mini "Core i5" 2.3 (Mid-2011)',
   ['MacPro4,1'] = 'Mac Pro "Eight Core" 2.93 (2009/Nehalem)',
   ['iMac16,2'] = 'iMac "Core i7" 3.3 21.5-Inch (4K, Late 2015)',
   ['iMac16,1'] = 'iMac "Core i5" 1.6 21.5-Inch (Late 2015)',
   ['iMac5,1'] = 'iMac "Core 2 Duo" 2.33 20-Inch',
   ['MacBookPro7,1'] = 'MacBook Pro "Core 2 Duo" 2.66 13" Mid-2010',
   ['MacPro2,1'] = 'Mac Pro "Eight Core" 3.0 (2,1)',
   ['MacBook10,1'] = 'MacBook "Core i7" 1.4 12" (Mid-2017)',
   ['Macmini1,1'] = 'Mac mini "Core Duo" 1.83',
   ['iMac12,2'] = 'iMac "Core i7" 3.4 27-Inch (Mid-2011)',
   ['iMac6,1'] = 'iMac "Core 2 Duo" 2.33 24-Inch',
   ['MacBookPro5,1'] = 'MacBook Pro "Core 2 Duo" 2.93 15" (Unibody)',
   ['MacBookPro11,5'] = 'MacBook Pro "Core i7" 2.8 15" Mid-2015 (DG)',
   ['MacBookPro11,4'] = 'MacBook Pro "Core i7" 2.8 15" Mid-2015 (IG)',
   ['MacBookPro11,3'] = 'MacBook Pro "Core i7" 2.8 15" Mid-2014 (DG)',
   ['MacBookPro11,2'] = 'MacBook Pro "Core i7" 2.8 15" Mid-2014 (IG)',
   ['MacBookPro11,1'] = 'MacBook Pro "Core i7" 3.0 13" Mid-2014',
   ['MacBookPro10,2'] = 'MacBook Pro "Core i7" 3.0 13" Early 2013',
   ['MacBookPro10,1'] = 'MacBook Pro "Core i7" 2.8 15" Early 2013',
   ['MacBookPro5,5'] = 'MacBook Pro "Core 2 Duo" 2.53 13" (SD/FW)',
   ['MacBookAir7,1'] = 'MacBook Air "Core i7" 2.2 11" (Early 2015)',
   ['MacBookAir7,2'] = 'MacBook Air "Core i7" 2.2 13" (Early 2015)',
   ['iMac17,1'] = 'iMac "Core i7" 4.0 27-Inch (5K, Late 2015)',
   ['MacBookPro8,1'] = 'MacBook Pro "Core i7" 2.8 13" Late 2011',
   ['MacBookPro8,2'] = 'MacBook Pro "Core i7" 2.5 15" Late 2011',
   ['MacBookPro8,3'] = 'MacBook Pro "Core i7" 2.5 17" Late 2011',
   ['MacBook6,1'] = 'MacBook "Core 2 Duo" 2.26 13" (Uni/Late 09)',
   ['MacBookPro4,1'] = 'MacBook Pro "Core 2 Duo" 2.6 17" (08)',
   ['Macmini4,1'] = 'Mac mini "Core 2 Duo" 2.66 (Server)',
   ['PowerMac10,2'] = 'Mac mini G4/1.5',
   ['PowerMac10,1'] = 'Mac mini G4/1.42',
   ['iMac13,2'] = 'iMac "Core i7" 3.4 27-Inch (Late 2012)',
   ['iMac13,1'] = 'iMac "Core i3" 3.3 21.5-Inch (Early 2013)',
   ['iMac9,1'] = 'iMac "Core 2 Duo" 2.26 20-Inch (Mid-2009)',
   ['Macmini3,1'] = 'Mac mini "Core 2 Duo" 2.53 (Server)',
   ['iMac5,2'] = 'iMac "Core 2 Duo" 1.83 17-Inch (IG)',
   ['MacBook2,1'] = 'MacBook "Core 2 Duo" 2.16 13" (Black)',
   ['MacBook1,1'] = 'MacBook "Core Duo" 2.0 13" (Black)',
   ['iMac14,4'] = 'iMac "Core i5" 1.4 21.5-Inch (Mid-2014)',
   ['iMac14,1'] = 'iMac "Core i5" 2.7 21.5-Inch (Late 2013)',
   ['iMac14,3'] = 'iMac "Core i7" 3.1 21.5-Inch (Late 2013)',
   ['iMac14,2'] = 'iMac "Core i7" 3.5 27-Inch (Late 2013)',
   ['MacBookPro2,2'] = 'MacBook Pro "Core 2 Duo" 2.33 15"',
   ['MacBookAir3,2'] = 'MacBook Air "Core 2 Duo" 2.13 13" (Late 2010)',
   ['MacBookPro13,1'] = 'MacBook Pro "Core i7" 2.4 13" Late 2016',
   ['MacBookPro13,3'] = 'MacBook Pro "Core i7" 2.9 15" Touch/Late 2016',
   ['MacBookPro13,2'] = 'MacBook Pro "Core i7" 3.3 13" Touch/Late 2016',
   ['MacBook9,1'] = 'MacBook "Core m7" 1.3 12" (Early 2016)',
   ['MacBookAir6,1'] = 'MacBook Air "Core i7" 1.7 11" (Early 2014)',
   ['MacBookAir6,2'] = 'MacBook Air "Core i7" 1.7 13" (Early 2014)',
   ['MacBookPro9,1'] = 'MacBook Pro "Core i7" 2.7 15" Mid-2012',
   ['MacBookPro9,2'] = 'MacBook Pro "Core i7" 2.9 13" Mid-2012',
   ['MacBook3,1'] = 'MacBook "Core 2 Duo" 2.2 13" (Black-SR)',
   ['MacPro6,1'] = 'Mac Pro "Twelve Core" 2.7 (Late 2013)',
   ['iMac10,1'] = 'iMac "Core 2 Duo" 3.33 27-Inch (Late 2009)',
   ['MacBookPro1,1'] = 'MacBook Pro "Core Duo" 2.16 15"',
   ['MacBookPro5,3'] = 'MacBook Pro "Core 2 Duo" 3.06 15" (SD)',
   ['MacBookPro5,2'] = 'MacBook Pro "Core 2 Duo" 3.06 17" Mid-2009',
   ['iMac8,1'] = 'iMac "Core 2 Duo" 3.06 24-Inch (Early 2008)',
   ['MacBookPro5,4'] = 'MacBook Pro "Core 2 Duo" 2.53 15" (SD)',
   ['Macmini2,1'] = 'Mac mini "Core 2 Duo" 2.0',
   ['MacBookAir3,1'] = 'MacBook Air "Core 2 Duo" 1.6 11" (Late 2010)',
   ['Macmini6,1'] = 'Mac mini "Core i5" 2.5 (Late 2012)',
   ['MacBookPro1,2'] = 'MacBook Pro "Core Duo" 2.16 17"',
   ['iMac4,1'] = 'iMac "Core Duo" 2.0 20-Inch',
   ['iMac4,2'] = 'iMac "Core Duo" 1.83 17-Inch (IG)',
   ['Macmini7,1'] = 'Mac mini "Core i7" 3.0 (Late 2014)',
   ['MacBookPro2,1'] = 'MacBook Pro "Core 2 Duo" 2.33 17"',
   ['MacBook5,1'] = 'MacBook "Core 2 Duo" 2.4 13" (Unibody)',
   ['MacBook5,2'] = 'MacBook "Core 2 Duo" 2.13 13" (White-09)',
   ['MacBookPro14,2'] = 'MacBook Pro "Core i7" 3.5 13" Touch/Mid-2017',
   ['MacBookPro14,3'] = 'MacBook Pro "Core i7" 3.1 15" Touch/Mid-2017',
   ['MacPro1,1*'] = 'Mac Pro "Quad Core" 3.0 (Original)',
   ['MacBookPro14,1'] = 'MacBook Pro "Core i7" 2.5 13" Mid-2017',
   ['MacBookPro12,1'] = 'MacBook Pro "Core i7" 3.1 13" Early 2015',
   ['MacBook8,1'] = 'MacBook "Core M" 1.3 12" (Early 2015)',
   ['iMac15,1'] = 'iMac "Core i5" 3.3 27-Inch (5K, Mid-2015)',
   ['MacBookAir1,1'] = 'MacBook Air "Core 2 Duo" 1.8 13" (Original)',
   ['MacBookAir2,1'] = 'MacBook Air "Core 2 Duo" 2.13 13" (Mid-09)',
   ['iMac7,1'] = 'iMac "Core 2 Extreme" 2.8 24-Inch (Al)',
   ['MacBookAir5,2'] = 'MacBook Air "Core i7" 2.0 13" (Mid-2012)',
   ['MacBook4,1'] = 'MacBook "Core 2 Duo" 2.4 13" (Black-08)',
   ['MacBookAir5,1'] = 'MacBook Air "Core i7" 2.0 11" (Mid-2012)',
   ['MacBookPro3,1'] = 'MacBook Pro "Core 2 Duo" 2.6 17" (SR)',
   ['iMac11,1'] = 'iMac "Core i7" 2.8 27-Inch (Late 2009)',
   ['iMac11,2'] = 'iMac "Core i5" 3.6 21.5-Inch (Mid-2010)',
   ['iMac11,3'] = 'iMac "Core i7" 2.93 27-Inch (Mid-2010)',
   ['MacBook7,1'] = 'MacBook "Core 2 Duo" 2.4 13" (Mid-2010)',
   ['Macmini6,2'] = 'Mac mini "Core i7" 2.6 (Late 2012/Server)',
   ['MacPro5,1'] = 'Mac Pro "Twelve Core" 3.06 (Server 2012)',
   ['MacBookPro6,2'] = 'MacBook Pro "Core i7" 2.8 15" Mid-2010',
   ['MacBookPro6,1'] = 'MacBook Pro "Core i7" 2.8 17" Mid-2010',
   ['iMac18,1'] = 'iMac "Core i5" 2.3 21.5-Inch (Mid-2017)',
   ['iMac18,3'] = 'iMac "Core i7" 4.2 27-Inch (5K, Mid-2017)',
   ['iMac18,2'] = 'iMac "Core i7" 3.6 21.5-Inch (4K, Mid-2017)',
   ['iMac12,1'] = 'iMac "Core i3" 3.1 21.5-Inch (Late 2011)',
   ['MacBookAir4,2'] = 'MacBook Air "Core i5" 1.6 13" (Edu Only)',
   ['MacBookAir4,1'] = 'MacBook Air "Core i7" 1.8 11" (Mid-2011)',
   ['MacPro3,1'] = 'Mac Pro "Eight Core" 3.2 (2008)'
}

discover.asset_icons = {
   ['unknown']     = '',
   ['printer']     = '<i class="fa fa-print fa-lg devtype-icon" aria-hidden="true"></i>', -- 1
   ['video']       = '<i class="fa fa-video-camera fa-lg devtype-icon" aria-hidden="true"></i>', -- 2 
   ['workstation'] = '<i class="fa fa-desktop fa-lg devtype-icon" aria-hidden="true"></i>', -- ... and so on
   ['laptop']      = '<i class="fa fa-laptop fa-lg devtype-icon" aria-hidden="true"></i>',
   ['tablet']      = '<i class="fa fa-tablet fa-lg devtype-icon" aria-hidden="true"></i>',
   ['phone']       = '<i class="fa fa-mobile fa-lg devtype-icon" aria-hidden="true"></i>',
   ['tv']          = '<i class="fa fa-television fa-lg devtype-icon" aria-hidden="true"></i>',
   ['networking']  = '<i class="fa fa-arrows fa-lg devtype-icon" aria-hidden="true"></i>',
   ['wifi']        = '<i class="fa fa-wifi fa-lg devtype-icon" aria-hidden="true"></i>',
   ['nas']         = '<i class="fa fa-database fa-lg devtype-icon" aria-hidden="true"></i>',
   ['multimedia']  = '<i class="fa fa-music fa-lg devtype-icon" aria-hidden="true"></i>',
}

local id2label = {
   [0]  = { 'unknown', i18n("device_types.unknown") },
   [1]  = { 'printer', i18n("device_types.printer") },
   [2]  = { 'video', i18n("device_types.video") },
   [3]  = { 'workstation', i18n("device_types.workstation") },
   [4]  = { 'laptop', i18n("device_types.laptop") },
   [5]  = { 'tablet', i18n("device_types.tablet") },
   [6]  = { 'phone', i18n("device_types.phone") },
   [7]  = { 'tv', i18n("device_types.tv") },
   [8]  = { 'networking', i18n("device_types.networking") },
   [9]  = { 'wifi', i18n("device_types.wifi") },
   [10] = { 'nas', i18n("device_types.nas") },
   [11] = { 'multimedia', i18n("device_types.multimedia") },
}

discover.ghost_icon = '<i class="fa fa-snapchat-ghost fa-lg" aria-hidden="true"></i>'
discover.android_icon = '<i class="fa fa-android fa-lg" aria-hidden="true"></i>'
discover.apple_icon = '<i class="fa fa-apple fa-lg" aria-hidden="true"></i>'

-- ################################################################################

local function device_label_sort_fn(a, b)
   return asc_insensitive(a[2], b[2])
end

-- ################################################################################

local function sortedDeviceTypeLabels()
   return pairsByValues(id2label, device_label_sort_fn)
end

-- ################################################################################

function discover.getCachedDiscoveryKey(interface_name)
   return "ntopng.cache.ifid_"..getInterfaceId(interface_name)..".device_discovery"
end

-- ################################################################################

function discover.getInterfaceNetworkDiscoveryEnabledKey(ifid)
   return "ntopng.prefs.ifid_"..ifid..".interface_network_discovery"
end

-- ################################################################################

function discover.interfaceNetworkDiscoveryEnabled(ifid)
   return not (ntop.getPref(discover.getInterfaceNetworkDiscoveryEnabledKey(ifid)) == "false")
end

-- ################################################################################

local function getRequestNetworkDiscoveryKey(ifid)
   return "ntopng.cache.ifid_"..ifid..".network_discovery_requested"
end

-- ################################################################################

function discover.requestNetworkDiscovery(ifid)
   ntop.setCache(getRequestNetworkDiscoveryKey(ifid), "true")
end

-- ################################################################################

function discover.clearNetworkDiscovery(ifid)
   ntop.delCache(getRequestNetworkDiscoveryKey(ifid))
end

-- ################################################################################

function discover.networkDiscoveryRequested(ifid)
   return ntop.getCache(getRequestNetworkDiscoveryKey(ifid)) == "true"
end

-- ################################################################################

function discover.printDeviceTypeSelector(device_type, field_name)
   device_type = tonumber(device_type)

   print [[<div class="form-group"><select name="]] print(field_name) print[[" class="form-control">\
   <option value="0"></option>]]

   for typeid, info in sortedDeviceTypeLabels() do
      local devtype = info[1]
      local label = info[2]

      if devtype ~= "unknown" then
         print("<option value=\"".. typeid .."\"")
         if(typeid == device_type) then print(" selected") end
         print(">".. label .."</option>")
      end
   end

   print [[</select></div>]]
end

-- ################################################################################

function discover.devtype2icon(devtype)
   local label = id2label[tonumber(devtype) or 0]

   if(label == nil) then label = 'unknown' else label = label[1] end

   return(discover.asset_icons[label])
end

-- ################################################################################

function discover.devtype2id(devtype)
   for k,v in pairs(id2label) do
      if(v[1] == devtype) then return k end
   end

   return(0) -- unknown
end

-- ################################################################################

function discover.devtype2string(devtype)
   devtype = tonumber(devtype)
   for k,v in pairs(id2label) do
      if(k == devtype) then return v[2] end
   end

   return("") -- unknown
end

-- ################################################################################

local function getbaseURL(url)
   local name = url:match( "([^/]+)$" )

   if((name == "") or (name == nil)) then
      return(url)
   else
      return(string.sub(url, 1, string.len(url)-string.len(name)-1))
   end
end

-- ################################################################################

local function findDevice(ip, mac, manufacturer, _mdns, ssdp_str, ssdp_entries, names, snmpName, snmpDescr, osx, symName)
   local mdns = { }
   local ssdp = { }
   local str
   local friendlyName = ""

   if((ssdp_entries ~= nil) and (ssdp_entries.friendlyName ~= nil)) then
      friendlyName = ssdp_entries["friendlyName"]
   end

   if((names == nil) or (names[ip] == nil)) then
      hostname = ""
   else
      hostname = string.lower(names[ip])
   end

   if(symName == nil) then symName = "" else symName = string.lower(symName) end

   if(_mdns ~= nil) then
      if(discover.debug) then io.write(mac .. " /" .. manufacturer .. " / ".. _mdns.."\n") end
      local mdns_items = string.split(_mdns, ";")

      if(mdns_items == nil) then
	 mdns[_mdns] = 1
      else
	 for _,v in pairs(mdns_items) do
	    mdns[v] = 1
	 end
      end
   end

   if(ssdp_str ~= nil) then
      if(discover.debug) then  io.write(mac .. " /" .. manufacturer .. " / ".. ssdp_str.."\n") end

      local ssdp_items = string.split(ssdp_str, ";")

      if(ssdp_items == nil) then
	 ssdp[ssdp_str] = 1
      else
	 for _,v in pairs(ssdp_items) do
	    ssdp[v] = 1
	 end
      end
   end

   if(osx ~= nil) then
      -- model=iMac11,3;osxvers=16
      local elems = string.split(osx, ';')

      if((elems == nil) and string.contains(osx, "model=")) then
	 elems = {}
	 table.insert(elems, osx)
      end

      if(elems ~= nil) then
	 local model   = string.split(elems[1], '=')
	 local osxvers = nil

	 if(discover.apple_products[model[2]] ~= nil) then
	    model = discover.apple_products[model[2]]
	    if(model == nil) then model = "" end
	 else
	    model = model[2]
	 end

	 if(elems[2] ~= nil) then
	    local osxvers = string.split(elems[2], '=')
	    if(discover.apple_osx_versions[osxvers[2]] ~= nil) then
	       osxvers = discover.apple_osx_versions[osxvers[2]]
	       if(osxvers == nil) then osxvers = "" end
	    else
	       osxvers = osxvers[2]
	    end
	 end
	 osx = "<br>"..model

	 if(osxvers ~= nil) then osx = osx .."<br>"..osxvers end
      end
   end

   if(mdns["_ssh._tcp.local"] ~= nil) then
      local icon = 'workstation'
      local ret

      if(osx ~= nil) then
	 if(string.contains(osx, "MacBook")) then
	    icon = 'laptop'
	 end
      end

      ret = '</i>'..discover.asset_icons[icon]..' ' .. discover.apple_icon

      if(osx ~= nil) then ret = ret .. osx end
      interface.setMacOperatingSystem(mac, 3) -- 3 = OSX
      return icon, ret
   elseif(mdns["_nvstream_dbd._tcp.local"] ~= nil) then
      interface.setMacOperatingSystem(mac, 2) -- 2 = windows
      return 'workstation', discover.asset_icons['workstation']..' (Windows)'
   elseif(mdns["_workstation._tcp.local"] ~= nil) then
      interface.setMacOperatingSystem(mac, 1) -- 1 = Linux
      return 'workstation', discover.asset_icons['workstation']..' (Linux)'
   end

   if(string.contains(friendlyName, "TV")) then
      return 'tv', discover.asset_icons['tv']
   end

   if((ssdp["urn:upnp-org:serviceId:AVTransport"] ~= nil)
      or (ssdp["urn:upnp-org:serviceId:RenderingControl"] ~= nil)) then
      return 'multimedia', discover.asset_icons['multimedia']
   end

   if(ssdp_entries and ssdp_entries["modelDescription"]) then
	local descr = string.lower(ssdp_entries["modelDescription"])

	if(string.contains(descr, "camera")) then
	   return 'video', discover.asset_icons['video']
	elseif(string.contains(descr, "router")) then
	   return 'networking', discover.asset_icons['networking']
	end
   end

   if(discover.debug) then io.write("[manufacturer] "..manufacturer.."\n") end
   if(string.contains(manufacturer, "Oki Electric") and (snmpName ~= nil)) then
      return 'printer', discover.asset_icons['printer'].. ' ('..snmpName..')'
   elseif(string.contains(manufacturer, "Hikvision")) then
      return 'video', discover.asset_icons['video']
   elseif(string.contains(manufacturer, "Super Micro")) then
      return 'workstation', discover.asset_icons['workstation']
   elseif(string.contains(manufacturer, "Raspberry")) then
      return 'workstation', discover.asset_icons['workstation']
   elseif(string.contains(manufacturer, "Juniper Networks")) then
      return 'networking', discover.asset_icons['networking']
   elseif(string.contains(manufacturer, "Cisco")) then
      return 'networking', discover.asset_icons['networking']
   elseif(string.contains(manufacturer, "Palo Alto Networks")) then
      return 'networking', discover.asset_icons['networking']
   elseif(string.contains(manufacturer, "Liteon Technology")) then
      return 'workstation', discover.asset_icons['workstation']
   elseif(string.contains(manufacturer, 'TP%-LINK')) then -- % is the escape char in Lua
      return 'wifi', discover.asset_icons['wifi']
   elseif(string.contains(manufacturer, 'Broadband')) then -- % is the escape char in Lua
      return 'networking', discover.asset_icons['networking']
   elseif(string.contains(manufacturer, "Samsung Electronics")
	  or string.contains(manufacturer, "SAMSUNG ELECTRO")
	  or string.contains(manufacturer, "HTC Corporation")
	  or string.contains(manufacturer, "HUAWEI")
	  or string.contains(manufacturer, "Xiaomi Communications")
	  or string.contains(manufacturer, "Mobile Communications") -- LG Electronics (Mobile Communications)
   ) then
      interface.setMacOperatingSystem(mac, 5) -- 5 = Android
      return 'phone', discover.asset_icons['phone'].. ' ' ..discover.android_icon
   elseif(string.contains(manufacturer, "Hewlett Packard") and (snmpName ~= nil)) then
      local _snmpName  = string.lower(snmpName)
      local _snmpDescr

      if(snmpDescr == nil) then
        -- io.write("IP "..ip.." has empty descr (".. _snmpName ..")\n")
        _snmpDescr = _snmpName
      else
        _snmpDescr = string.lower(snmpDescr)
      end

      if(string.contains(_snmpDescr, "jet") -- JetDirect, LaserJet, InkJet, DeskJet
          or string.contains(_snmpDescr, "fax")) then
	 return 'printer', discover.asset_icons['printer']..' ('..snmpName..')'
      elseif(string.contains(_snmpDescr, "curve")) then
	 return 'networking', discover.asset_icons['networking']..' ('..snmpName..')'
      else
	 return 'workstation', discover.asset_icons['workstation']..' ('..snmpName..')'
      end
   elseif(string.contains(manufacturer, "VMware")
          or string.contains(manufacturer, "QEMU")
	  or string.contains(manufacturer, "Xen")
	  or string.contains(manufacturer, "Parallel")
          ) then
      return 'workstation', discover.asset_icons['workstation']
   elseif(string.contains(manufacturer, "Xerox") and (snmpName ~= nil)) then
      return 'printer', discover.asset_icons['printer']..' ('..snmpName..')'
   elseif(string.contains(manufacturer, "Apple, Inc.")) then
      if(string.contains(hostname, "iphone") or string.contains(symName, "iphone")) then
	 interface.setMacOperatingSystem(mac, 4) -- 4 = iOS
	 return 'phone', discover.asset_icons['phone']..' ('  .. discover.apple_icon .. ' iPhone)'
      elseif(string.contains(hostname, "ipad") or string.contains(symName, "ipad")) then
	 interface.setMacOperatingSystem(mac, 4) -- 4 = iOS
	 return 'tablet', discover.asset_icons['tablet']..' ('  .. discover.apple_icon .. 'iPad)'
      elseif(string.contains(hostname, "ipod") or string.contains(symName, "ipod")) then
	 interface.setMacOperatingSystem(mac, 4) -- 4 = iOS
	 return 'phone', discover.asset_icons['phone']..' ('  .. discover.apple_icon .. 'iPod)'
      else
	 local ret = '</i> '..discover.asset_icons['workstation']..' ' .. discover.apple_icon
	 local what = 'workstation'
         
	 if(((snmpName ~= nil) and string.contains(snmpName, "capsule"))
            or string.contains(symName, "capsule") or string.contains(hostname, "capsule")) then
	    ret = '</i> '..discover.asset_icons['nas']
	    what = 'nas'
	 elseif(string.contains(symName, "book") or string.contains(hostname, "book")) then
	    ret = '</i> '..discover.asset_icons['laptop']..' ' .. discover.apple_icon
	    what = 'laptop'
	 end

	 if(snmpName ~= nil) then ret = ret .. " ["..snmpName.."]" end
	 interface.setMacOperatingSystem(mac, 3) -- 3 = OSX
	 return what, ret
      end
   end

   if(string.contains(mac, "F0:4F:7C") and string.contains(hostname, "kindle-")) then
      return 'tablet', discover.asset_icons['tablet']..' (Kindle)'
   end

   if(names["gateway.local"] == ip) then
      return 'networking', discover.asset_icons['networking']
   end

   if(string.starts(hostname, "desktop-") or string.starts(symName, "desktop-")) then
      interface.setMacOperatingSystem(mac, 2) -- 2 = windows
      return 'workstation', discover.asset_icons['workstation']..' (Windows)'
   elseif(string.contains(hostname, "thinkpad") or string.contains(symName, "thinkpad")) then
      return 'laptop', discover.asset_icons['laptop']
   elseif(string.contains(hostname, "android") or string.contains(symName, "android")) then
      interface.setMacOperatingSystem(mac, 5) -- 5 = Android
      return 'phone', discover.asset_icons['phone']..' ' ..discover.android_icon
   elseif(string.contains(hostname, "%-NAS") or string.contains(symName, "%-NAS")) then
      return 'nas', discover.asset_icons['nas']
   end

   if(snmpName ~= nil) then
      if(string.contains(snmpName, "router")
	    or string.contains(snmpName, "switch")
      ) then
	 return 'networking', discover.asset_icons['networking']..' ('..snmpName..')'
      elseif(string.contains(snmpName, "air")) then
	 return 'wifi', discover.asset_icons['wifi']..' ('..snmpName..')'
      else
	 return 'unknown', snmpName
      end
   end

   if(string.contains(manufacturer, "Ubiquity")) then
      return 'networking', discover.asset_icons['networking']
   end

   return 'unknown', ""
end

-- #############################################################################

local function analyzeSSDP(ssdp)
   local rsp = {}

   for url,host in pairs(ssdp) do
      local hresp = ntop.httpGet(url, "", "", 3 --[[ seconds ]])
      local manufacturer = ""
      local modelDescription = ""
      local modelName = ""
      local icon = ""
      local base_url = getbaseURL(url)
      local services = { }
      local friendlyName = ""

      if(hresp ~= nil) then
	 local xml = require("xmlSimple").newParser()
	 local r = xml:ParseXmlText(hresp["CONTENT"])

	 if(r.root ~= nil) then
	    if(r.root.device ~= nil) then
	       if(r.root.device.friendlyName ~= nil) then
		  friendlyName = r.root.device.friendlyName:value()
	       end
	       if(r.root.device.modelName ~= nil) then
		  modelName = r.root.device.modelName:value()
	       end
	       if(r.root.device.modelDescription ~= nil) then
		  modelDescription = r.root.device.modelDescription:value()
	       end
	    end
	 end

	 if(r.root ~= nil) then
	    if(r.root.device ~= nil) then
	       if(r.root.device.manufacturer ~= nil) then
		  manufacturer = r.root.device.manufacturer:value()
	       end

	       if(r.root.device.serviceList ~= nil) then
		  local k,v
		  local serviceList = r.root.device.serviceList:children()

		  for k,v in pairs(serviceList) do
		     if(v.serviceId ~= nil) then
			if(discover.debug) then io.write(v.serviceId:value().."\n") end

			table.insert(services, v.serviceId:value())
		     end
		  end
	       end

	       if(r.root.device.iconList ~= nil) then
		  local k,v
		  local iconList = r.root.device.iconList:children()
		  local lastwidth = 999

		  for k,v in pairs(iconList) do
		     if((v.mimetype ~= nil) and (v.width ~= nil) and (v.url ~= nil)) then
			local mime = v.mimetype:value()
			local width = tonumber(v.width:value())

			if(width <= lastwidth) then
			   if((mime == "image/jpeg") or (mime == "image/png") or (mime == "image/gif")) then
			      icon = "<img src="..base_url..v.url:value()..">"
			      lastwidth = width -- Pick the smallest icon
			   end
			end
		     end
		  end
	       end
	    end
	 end

	 if(discover.debug) then  io.write(hresp["CONTENT"].."\n") end
      end

      if(rsp[host] ~= nil) then
	 rsp[host].url = rsp[host].url .. "<br><A HREF="..url..">"..friendlyName.."</A>"

	 for _,v in ipairs(services) do
	    table.insert(rsp[host].services, v)
	 end
      else
	 rsp[host] = { ["icon"] = icon, ["manufacturer"] = manufacturer, ["url"] = "<A HREF="..url..">"..friendlyName.."</A>",
	    ["services"] = services, ["modelName"] = modelName,
	    ["modelDescription"] = modelDescription, ["friendlyName"] = friendlyName }
      end

      if(discover.debug) then io.write(rsp[host].icon .. " / " ..rsp[host].manufacturer .. " / " ..rsp[host].url .. " / " .. "\n") end
   end

   return rsp
end

-- ################################################################################

local function discoverStatus(code, message)
   return {code = code or '', message = message or ''}

end

-- #############################################################################

local function discoverARP()
   if(discover.debug) then io.write("Starting ARP discovery...\n") end
   local status = discoverStatus("OK")
   local res = {}

   local ghost_macs  = {}
   local ghost_found = false
   local arp_mdns = interface.arpScanHosts()


   if(arp_mdns == nil) then
      status = discoverStatus("ERROR", i18n("discover.err_unable_to_arp_discovery"))
   else
      -- Add the known macs to the list
      local known_macs = interface.getMacsInfo(nil, 999, 0, false, 0, tonumber(vlan), true, true, nil) or {}

      for _,hmac in pairs(known_macs.macs) do
	 if(hmac["bytes.sent"] > 0) then -- Skip silent hosts
	    if(arp_mdns[hmac.mac] == nil) then
	       local ips = interface.findHostByMac(hmac.mac) or {}
	       if(discover.debug) then io.write("Missing MAC "..hmac.mac.."\n") end

	       for k,v in pairs(ips) do
		  arp_mdns[hmac.mac] = k
		  ghost_macs[hmac.mac] = k
		  ghost_found = true
	       end
	    end
	 end
      end
   end

   return {status = status, ghost_macs = ghost_macs, ghost_found = ghost_found, arp_mdns = arp_mdns}
end

-- #############################################################################

function discover.discover2table(interface_name, recache)
   interface.select(interface_name)

   if recache ~= true then
      local cached = ntop.getCache(discover.getCachedDiscoveryKey(interface_name))
      if not isEmptyString(cached) then
	 return json.decode(cached) or {status = discoverStatus("ERROR", i18n("discover.error_unable_to_decode_json"))}
      else
	 return {status = discoverStatus("NOCACHE", i18n("discover.error_no_discovery_cached"))}
      end
   end

   -- ARP
   local arp_d = discoverARP()
   if arp_d["status"]["code"] ~= "OK" then
      return {status = arp_d["status"]}
   end

   local arp_mdns = arp_d["arp_mdns"] or {}
   local ghost_macs = arp_d["ghost_macs"]
   local ghost_found = arp_d["ghost_found"]

   -- SSDP, MDNS and SNMP
   if(discover.debug) then io.write("Starting SSDP discovery...\n") end
   local ssdp = interface.discoverHosts(3)
   local osx_devices = {}

   for mac,ip in pairsByValues(arp_mdns, asc) do
      if((ip == "0.0.0.0") or (ip == "255.255.255.255")) then
	 -- This does not look like a good IP/MAC combination
      elseif(string.find(mac, ":") ~= nil) then
	 local manufacturer = get_manufacturer_mac(mac)

	 -- This is an ARP entry
	 if(discover.debug) then io.write("Attempting to resolve "..ip.."\n") end
	 interface.mdnsQueueNameToResolve(ip)

	 interface.snmpGetBatch(ip, "public", "1.3.6.1.2.1.1.5.0", 0)

	 if(string.contains(manufacturer, "HP") or string.contains(manufacturer, "Hewlett Packard")) then
	    -- Query printer model
	    interface.snmpGetBatch(ip, "public", "1.3.6.1.2.1.25.3.2.1.3.1", 0)
	 end
      else
	 local ip_addr = mac
	 local mdns_services = ip

	 if(discover.debug) then io.write("[MDNS Services] '"..ip_addr .. "' = '" ..mdns_services.."'\n") end

	 if(string.contains(mdns_services, '_sftp')) then
	    osx_devices[ip_addr] = 1
	 end

	 ntop.resolveName(ip) -- Force address resolution
      end
   end

   if(discover.debug) then io.write("Analyzing SSDP...\n") end
   ssdp = analyzeSSDP(ssdp)

   local show_services = false

   if(discover.debug) then io.write("Collecting MDNS responses\n") end
   local mdns = interface.mdnsReadQueuedResponses()

   if(discover.debug) then 
      for ip,rsp in pairsByValues(mdns, asc) do
	 io.write("[MDNS Resolver] "..ip.." = "..rsp.."\n")
      end
   end

   for ip,_ in pairs(osx_devices) do
      if(discover.debug) then io.write("[MDNS OSX] Querying "..ip.. "\n") end
      interface.mdnsQueueAnyQuery(ip, "_sftp-ssh._tcp.local")
   end

   if(discover.debug) then io.write("Collecting SNMP responses\n") end
   local snmp = interface.snmpReadResponses()

   -- Query sysDescr for the hosts that have replied
   for ip,rsp in pairsByValues(snmp, asc) do  
     -- io.write("Requesting sysDescr for "..ip.."\n")
     interface.snmpGetBatch(ip, "public", "1.3.6.1.2.1.1.1.0", 0)
   end

   if(discover.debug) then io.write("Collecting MDNS OSX responses\n") end
   osx_devices = interface.mdnsReadQueuedResponses()
   if(discover.debug) then io.write("Collected MDNS OSX responses\n") end

   if(discover.debug) then 
      for a,b in pairs(osx_devices) do
	 io.write("[MDNS OSX] "..a.." / ".. b.. "\n")
      end
   end

   local snmpSysDescr = interface.snmpReadResponses()

   for ip,rsp in pairsByValues(snmpSysDescr, asc) do
	 io.write("[SNMP Descr] "..ip.." OK\n")
   end

  if(discover.debug) then 
      for ip,rsp in pairsByValues(snmp, asc) do
	 io.write("[SNMP] "..ip.." = ["..rsp.."][")
         if(snmpSysDescr[i] ~= nil) then io.write(snmpSysDescr[i]) end
         io.write("]\n")
      end
   end

   -- Time to pack the results in a table...
   local status = discoverStatus("OK")
   local res = {}

   for mac, ip in pairsByValues(arp_mdns, asc) do
      if((string.find(mac, ":") == nil)
	 or (ip == "0.0.0.0")
	 or (ip == "255.255.255.255")) then
	 goto continue
      end

      local entry = {ip = ip, mac = mac, ghost = false, information = {}}

      local host = interface.getHostInfo(ip, 0) -- no VLAN
      local sym, device_type, device_label
      local manufacturer
      local services = ""
      local symIP = mdns[ip]

      if(host ~= nil) then sym = host["name"] else sym = ntop.getResolvedName(ip) end
      if not isEmptyString(sym) and sym ~= ip then
	 entry["sym"] = sym
      end
      if not isEmptyString(symIP) and symIP ~= ip then
	 entry["symIP"] = symIP
      end

      if not isEmptyString(arp_mdns[ip]) then
	 entry["information"] = table.merge(entry["information"], string.split(arp_mdns[ip], ";"))
      end

      if ssdp[ip] then
	 if ssdp[ip].icon then entry["icon"] = ssdp[ip].icon end
	 if ssdp[ip].modelName then entry["modelName"] = ssdp[ip].modelName end
	 if ssdp[ip].url then entry["url"] = ssdp[ip].url end
	 if ssdp[ip].manufacturer then entry["manufacturer"] = ssdp[ip].manufacturer end
	 if ssdp[ip].services then
	    entry["information"] = table.merge(entry["information"], ssdp[ip].services)
	    for i, name in ipairs(ssdp[ip].services) do services = services .. ";" .. name end
	 end
      end

      if(ghost_macs[mac] == true) then entry["ghost"] = true end

      device_type, device_label = findDevice(ip, mac, entry["manufacturer"] or get_manufacturer_mac(mac),
                                             arp_mdns[ip], services, ssdp[ip],mdns, snmp[ip], snmpSysDescr[ip],
                                             osx_devices[ip], sym)

      if isEmptyString(device_label) then
	 local mac_info = interface.getMacInfo(mac, 0) -- 0 = VLAN
	 if mac_info ~= nil then
	    device_label = device_label .. discover.devtype2icon(mac_info.devtype)
	 end
      end
      interface.setMacDeviceType(mac, discover.devtype2id(device_type), false) -- false means don't overwrite if already set to ~= unknown

      entry["device_type"] = device_type
      entry["device_label"] = device_label

      res[#res + 1] = entry
      ::continue::
   end

   local response = {status = status, devices = res, ghost_found = ghost_found, discovery_timestamp = os.time()}

   ntop.setCache(discover.getCachedDiscoveryKey(interface_name), json.encode(response))

   return response
end

-- ################################################################################

return discover
