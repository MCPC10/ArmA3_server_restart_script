///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                    File: fn_sendCommand.sqf                           //
///////////////////////////////////////////////////////////////////////////

params ["_command"];
private ["_return","_password"];


//Wenn der Aufruf von einem anderen als dem Server kommt, dann wird ein Exit ausgeführt
if (!isServer) exitWith {};

_password = ["CfgSettings","RestartSystem","serverCommandPassword"] call BIS_fnc_getCfgData;

//Starte den Command mit dem Passwort von der CFG Datei
_return = _password serverCommand _command;
_return

