#define true 1
#define false 0

class CfgSettings 
{
    class RestartSystem
    {
        // Empfohlen ist true, sonst kann es zu nicht berechenbaren Problemen führen !
        useExtDB2 = true;

        // Hier muss das serverCommandPassword der config.cfg stehen !
        serverCommandPassword = "123";  
        // {Stunden, Minuten} / Hardcodet minimum ist 5 Minuten !
        restartInterval[] = {0,6};
        // Interval in dem das System die Uptime mit der Restart Zeit vergleicht
        checkInterval = 10; 
        
        
        //Nicht Implementiert !
        useAutoKickSystem = true;
        //Nicht Implementiert !
        autoKickTime = 2;
        
        
        //Schaltet die Restart Meldungen ein oder aus
        useWarnMsg = true;
        //Definiert die Minuten wann vor einem Neustart eine Meldung ausgegeben wird
        warnMsgInterval[] = {2,1};  //Darf nicht größer als der restartInterval
        //Text der in der Meldung Steht (%1 = Minuten vor dem Neustart)
        warnMessage = "Der Server startet in %1 Minuten neu !";
    
        //Nutze #shutdown (Empfohlen) anstatt #restart (Nur wenn man kein FireDaemon oder ähnliches hat !)    
        useShutdownCommand = true;
    }
}