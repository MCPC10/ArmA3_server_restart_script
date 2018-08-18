///////////////////////////////////////////////////////////////////////////
//                  MCPC10's Arma 3 Restart Skript                       //
//                       Copyright to MCPC10                             //
//                        File: mcrs.sqf                              //
///////////////////////////////////////////////////////////////////////////

#define HARDCODET_MINIMUM 300 // DO NOT CHANGE !!! (5 minutes)

//If the caller is not the server, exit here
if (!isServer) exitWith {};

private["_restartTimeInterval","_restartTime","_sleepInterval","_msgTimeInterval", "_useMSG", "_password", "_useShutdown", "_startTime", "_timeUntilRestart", "_timeSinceStart"];

_restartTimeInterval = ["CfgSettings","MCRS_Settings","restartInterval"] call BIS_fnc_getCfgData;
_sleepInterval = ["CfgSettings","MCRS_Settings","checkInterval"] call BIS_fnc_getCfgData;
_msgTimeInterval = ["CfgSettings","MCRS_Settings","warnMsgInterval"] call BIS_fnc_getCfgData;
_useMSG = ["CfgSettings","MCRS_Settings","useWarnMsg"] call BIS_fnc_getCfgData;
_password = ["CfgSettings","MCRS_Settings","serverCommandPassword"] call BIS_fnc_getCfgData;
_useShutdown = ["CfgSettings","MCRS_Settings","useShutdownCommand"] call BIS_fnc_getCfgData;
_msg = ["CfgSettings","MCRS_Settings","warnMessage"] call BIS_fnc_getCfgData;

//Calculate the hours + minute value in only a second value
_restartTime = (((_restartTimeInterval select 0) * 60) + (_restartTimeInterval select 1)) * 60;

//Get start time
_startTime = diag_tickTime;

//Limit the value of _restartTimeInterval
if((_restartTimeInterval select 1) < HARDCODET_MINIMUM) then
{
  _restartTimeInterval set [1, HARDCODET_MINIMUM];
};

//Remove unvalid msg values
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

_timeSinceStart = diag_tickTime - _startTime;
_timeUntilRestart = _restartTime - _timeSinceStart;

//Message System
if(_useMSG isEqualTo 1) then
{
  {
    if((_timeUntilRestart <= _x) AND (_timeUntilRestart > _msgTimeInterval select (_forEachIndex +1))) then
    {
      //Show the message
      if(!isNil "_msg" OR "_msg" != "") then
      {
        _message = format [_msg, _timeUntilRestart];
        _message remoteExec ["hint"];
      };

      _msgTimeInterval deleteAt _forEachIndex;
    };   
  } forEach _msgTimeInterval;
};

//Check if _uptime is higher than _restartTime
if(_timeSinceStart >= _restartTime) then
{
    if(_useShutdown isEqualTo 1) then 
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
};

