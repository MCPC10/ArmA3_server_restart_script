///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                     File: fn_showMessage.sqf                          //
///////////////////////////////////////////////////////////////////////////

//If the caller is not the server, exit here
if (!isServer) exitWith {};


params ["_time"];
private ["_msg","_message"];

if(isNil "_msg") then
{
	_msg = ["CfgSettings","RestartSystem","warnMessage"] call BIS_fnc_getCfgData;
};


//Check message and time
if(isNil "_time" isNil "_msg" OR _msg == "") exitWith {};

_message = format [_msg, _time];

//Show the message
_message remoteExec ["hint"];