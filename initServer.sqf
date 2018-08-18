if(!isServer) exitWith {};

//If it's an dedicated server => start the restart script
if(isDedicated) then
{
	_nul = [] execVM "mcrs.sqf";
};