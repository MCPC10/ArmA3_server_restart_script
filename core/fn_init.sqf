///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                        File: fn_init.sqf                              //
///////////////////////////////////////////////////////////////////////////

#define HARDCODET_MINIMUM 5 // DO NOT CHANGE !!!

//If the caller is not the server, exit here
if (!isServer) exitWith {};


private["_restartTimeInterval","_restartTime","_sleepInterval","_uptime","_msgTimeInterval","_useMSG", "_password"];
firstCycle = 1; //Set first cycle

_restartTimeInterval = ["CfgSettings","RestartSystem","restartInterval"] call BIS_fnc_getCfgData;
_sleepInterval = ["CfgSettings","RestartSystem","checkInterval"] call BIS_fnc_getCfgData;
_msgTimeInterval = ["CfgSettings","RestartSystem","warnMsgInterval"] call BIS_fnc_getCfgData;
_useMSG = ["CfgSettings","RestartSystem","useWarnMsg"] call BIS_fnc_getCfgData;
_password = ["CfgSettings","RestartSystem","serverCommandPassword"] call BIS_fnc_getCfgData;

//Calculate the hours + minute value in only a minute value
_restartTime = (((_restartTimeInterval select 0) * 60) + (_restartTimeInterval select 1));

//Hardcodet minimum value of _restartTimeInterval
if((_restartTimeInterval select 1) < HARDCODET_MINIMUM) then
{
  _restartTimeInterval set [1, HARDCODET_MINIMUM];
};

if(_useMSG isEqualTo 1) then
{
  {
    //Check the message time intervals
    if(_x > _restartTime OR _x == 0) then
    {
      _msgTimeInterval deleteAt _forEachIndex;
    };
  } forEach _msgTimeInterval;
};


///////////////////////////////////////////////////////////////////////////
//                            Main loop                                  //
///////////////////////////////////////////////////////////////////////////
while {true} do {

_uptime = [] call MCRS_fnc_getUptime;

//Message System
if(_useMSG isEqualTo 1) then
{
  {
    if(((_restartTime - _uptime) <= _x) AND ((_restartTime - _uptime) > _msgTimeInterval select (_forEachIndex +1))) then
    {
      [_x] call MCRS_fnc_showMessage;
      _msgTimeInterval deleteAt _forEachIndex;
    };   
  } forEach _msgTimeInterval;
};

//Check if _uptime is higher than _restartTime
if(_uptime >= _restartTime) then
{
    if(["CfgSettings","RestartSystem","useShutdownCommand"] call BIS_fnc_getCfgData isEqualTo 1) then 
    {
      //Shutdown the server, so that FireDaemon, etc can restart the whole server
      _password serverCommand "#shutdown"
    }
    else
    {
      //use "soft restart"
      _password serverCommand "#restart"
    };
};

//Wait for x seconds
uiSleep _sleepInterval;
firstCycle = 0; //Reset first cycle
};

