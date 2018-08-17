#define true 1
#define false 0

class MCRS_Settings
{
    // Hier muss das serverCommandPassword der config.cfg stehen !
    serverCommandPassword = "123";  
    // {Stunden, Minuten} / Hardcodet minimum ist 5 Minuten !
    restartInterval[] = {3,0};
    // Interval in dem das System die Uptime mit der Restart Zeit vergleicht
    checkInterval = 10; 
    
    //Schaltet die Restart Meldungen ein oder aus
    useWarnMsg = true;
    //Definiert die Minuten wann vor einem Neustart eine Meldung ausgegeben wird
    warnMsgInterval[] = {15,10,5,1};  //Darf nicht größer als der restartInterval
    //Text der in der Meldung Steht (%1 = Minuten vor dem Neustart)
    warnMessage = "Der Server startet in %1 Minuten neu !";

    //Nutze #shutdown (Empfohlen) anstatt #restart (Nur wenn man kein FireDaemon oder ähnliches hat !)    
    useShutdownCommand = true;
}