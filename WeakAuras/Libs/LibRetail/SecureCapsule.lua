local lib = LibStub and LibStub("LibRetail", true)
if not lib then return end

local contents = {};
local issecure = issecure;
local type = type;
local pairs = pairs;

--Create a local version of this function just so we don't have to worry about changes
local function copyTable(tab)
  local copy = {};
  for k, v in pairs(tab) do
    if ( type(v) == "table" ) then
      copy[k] = copyTable(v);
    else
      copy[k] = v;
    end
  end
  return copy;
end

function lib.SecureCapsuleGet(name)

  if ( not issecure() ) then
    return;
  end

  if ( type(contents[name]) == "table" ) then
    --Segment the users
    return copyTable(contents[name]);
  else
    return contents[name];
  end
end

-------------------------------
--Local functions for retaining.
-------------------------------

--Retains a copy of name
local function retain(name)
  if ( type(_G[name]) == "table" ) then
    contents[name] = copyTable(_G[name]);
  else
    contents[name] = _G[name];
  end
end

--Takes name and removes it from the global environment (note: make sure that nothing else has saved off a copy)
local function take(name)
  contents[name] = _G[name];
  _G[name] = nil;
end


-------------------------------
--Things we actually want to save
-------------------------------

--If storing off Lua functions, be careful that they don't in turn call any other Lua functions that may have been swapped out.

--For store
take("CreateForbiddenFrame");
retain("IsOnGlueScreen");
retain("math");
retain("pairs");
retain("select");
retain("unpack");
retain("tostring");
retain("tonumber");
retain("LoadURLIndex");
retain("GetContainerNumFreeSlots");
retain("GetCursorPosition");
retain("GetRealmName");
retain("PlaySound");
retain("SetPortraitToTexture");
retain("BACKPACK_CONTAINER");
retain("NUM_BAG_SLOTS");
retain("RAID_CLASS_COLORS");
retain("C_PetJournal");
retain("IsModifiedClick");
retain("GetTime");
retain("UnitAffectingCombat");

--For auth challenge
take("C_AuthChallenge");
retain("IsShiftKeyDown");
retain("GetBindingFromClick");

--For character services
take("C_SharedCharacterServices");

retain("OKAY");
retain("LARGE_NUMBER_SEPERATOR");
retain("DECIMAL_SEPERATOR");
retain("TOOLTIP_DEFAULT_COLOR");
retain("TOOLTIP_DEFAULT_BACKGROUND_COLOR");

take("BLIZZARD_CHALLENGE_SUBMIT");
take("BLIZZARD_CHALLENGE_CANCEL");
take("BLIZZARD_CHALLENGE_CONNECTING");
take("BLIZZARD_CHALLENGE_OKAY");
take("BLIZZARD_CHALLENGE_DENIED_TITLE");
take("BLIZZARD_CHALLENGE_DENIED_DESCRIPTION");
take("BLIZZARD_CHALLENGE_ERROR_TITLE");
take("BLIZZARD_CHALLENGE_ERROR_DESCRIPTION");
take("BLIZZARD_CHALLENGE_SCREEN_EXPLANATION");

--Lua enums
take("LE_STORE_ERROR_INVALID_PAYMENT_METHOD");
take("LE_STORE_ERROR_PAYMENT_FAILED");
take("LE_STORE_ERROR_WRONG_CURRENCY");
take("LE_STORE_ERROR_BATTLEPAY_DISABLED");
take("LE_STORE_ERROR_INSUFFICIENT_BALANCE");
take("LE_STORE_ERROR_OTHER");
take("LE_STORE_ERROR_ALREADY_OWNED");
take("LE_STORE_ERROR_PARENTAL_CONTROLS_NO_PURCHASE");
take("LE_STORE_ERROR_PURCHASE_DENIED");

