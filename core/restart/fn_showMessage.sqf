///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                     File: fn_showMessage.sqf                          //
///////////////////////////////////////////////////////////////////////////

params ["_time"];
private ["_msg","_message"];

if(!isServer OR isNil "_time") exitWith {};

_msg = ["CfgSettings","RestartSystem","warnMessage"] call BIS_fnc_getCfgData;

if(isNil "_msg" OR _msg == "") exitWith {};

_message = format [_msg, _time];

//Zeige einen Nachricht
_message remoteExec ["hint"];