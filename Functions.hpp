class Arma_Restart_System
{
    tag = "MCRS";
    class Auto_Restart
    {
        file = "core";
		class init {}; 
		class getUptime {};
        class sendCommand {};
		class showMessage {};
    };
};