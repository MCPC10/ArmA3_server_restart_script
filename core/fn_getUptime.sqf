///////////////////////////////////////////////////////////////////////////
//                Arma 3 Restart Skript (Altis Life)                     //
//                       Copyright to MCPC10                             //
//                     File: fn_getUptime.sqf                            //
///////////////////////////////////////////////////////////////////////////

//If the caller is not the server, exit here
if (!isServer) exitWith {};


private ["_useArmaServerTimeCmd", "_firstStart","_return"];

//Set first start to 1 if it is the first cycle
if(firstCycle isEqualTo 1) then
{
	_firstStart = 1;
};

if(isNil "_useArmaServerTimeCmd") then
{
	_useArmaServerTimeCmd = ["CfgSettings","RestartSystem","useArmaServerTimeCmd"] call BIS_fnc_getCfgData;
};


if(_useArmaServerTimeCmd isEqualTo 1) then
{
	//Needed to to a bug in serverTime
	//=> There is a bug in this command, about 3 minutes after missionstart this command returns something completely different. See http://dev-heaven.net/issues/13581 for further infomation.
	if(_firstStart isEqualTo 1) then
	{
		uiSleep 200;
		_firstStart = 0;
	};

	_return = serverTime / 60;
}
else
{
	"real_date" callExtension "0";
};

_return