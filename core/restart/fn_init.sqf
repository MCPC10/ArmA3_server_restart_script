///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                        File: fn_init.sqf                              //
///////////////////////////////////////////////////////////////////////////

#define HARDCODET_MINIMUM 5 // NICHT ÄNDERN !!!
#define DISABLE_MSG_SERVERTIME 1 // NICHT ÄNDERN / Nicht Implementiert !!!

private["_restartTimeInterval","_restartTime","_sleepInterval","_uptime","_msgTimeInterval","_useMSG"];

//Wenn der Aufruf von einem anderen als dem Server kommt, dann wird ein Exit ausgeführt
if (!isServer) exitWith {};

_restartTimeInterval = ["CfgSettings","RestartSystem","restartInterval"] call BIS_fnc_getCfgData;
_sleepInterval = ["CfgSettings","RestartSystem","checkInterval"] call BIS_fnc_getCfgData;
_msgTimeInterval = ["CfgSettings","RestartSystem","warnMsgInterval"] call BIS_fnc_getCfgData;
_useMSG = ["CfgSettings","RestartSystem","useWarnMsg"] call BIS_fnc_getCfgData;

//Rechne den Array in einen Minuten Wert aus
_restartTime = (((_restartTimeInterval select 0) * 60) + (_restartTimeInterval select 1));

//Hardcodet minimum überprüfung
if((_restartTimeInterval select 1) < HARDCODET_MINIMUM) then
{
  _restartTimeInterval set [1, HARDCODET_MINIMUM];
};

if(_useMSG isEqualTo 1) then
{
{
//Teste die gültigkeit aller MSG Werte
if(_x > _restartTime OR _x == 0) then
{
   _msgTimeInterval deleteAt _forEachIndex;
};
} forEach _msgTimeInterval;
};


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

//Prüfe ob die Uptime die Restart Time überschritten hat 
if(_uptime >= _restartTime) then
{
    if(["CfgSettings","RestartSystem","useShutdownCommand"] call BIS_fnc_getCfgData isEqualTo 1) then 
    {
      //Starte Server neu
      ["#shutdown"] call MCRS_fnc_sendCommand;
    }
    else
    {
      //Nutze "Soft Restart" (Nicht Empfohlen)
      ["#restart"] call MCRS_fnc_sendCommand;
    };
};

//Warte für x Sekunden
uiSleep _sleepInterval;
};

