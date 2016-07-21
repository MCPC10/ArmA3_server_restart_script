///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                     File: fn_getUptime.sqf                            //
///////////////////////////////////////////////////////////////////////////

private ["_useExtDB2","_return"];

//Wenn der Aufruf von einem anderen als dem Server kommt, dann wird ein Exit ausgeführt
if (!isServer) exitWith {};

_useExtDB2 = ["CfgSettings","RestartSystem","useExtDB2"] call BIS_fnc_getCfgData;

if(_useExtDB2 isEqualTo 1) then
{
_return = (call compile ("extDB2" callExtension "9:UPTIME:MINUTES")) select 1;
}
else
{
_return = serverTime / 60;

//Verhindern von fälschlichem Restart durch einen Fehler im Command serverTime (In den ersten 5 Minuten kann es zu Fehlern kommen mit der Variable)
uiSleep 300;
};

_return