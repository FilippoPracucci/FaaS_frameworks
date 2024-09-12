# **FaaS Frameworks**

In questo repository si forniscono delle funzioni e relative modalità di utilizzo per i framework **FaaS** Open-Source:
- **Knative**
- **OpenFaaS**
- **OpenWhisk**

Il repository è stato organizzato in più directories, ognuna delle quali riguarda uno specifico framework.

Si mette inoltre a disposizione un file `file.json` che è stato utilizzato per effettuare i test delle funzionalità.

## Test delle funzioni

Per ogni funzione è presente una directory con i test eseguiti, suddivisi per livello di concorrenza (es. test1 = livello di concorrenza 1, test10 = livello di concorrenza 10...). Oltre al file `.jmx`, che consiste nel file di test creato con **JMeter**, è presente anche un file `JSON` contenente i risultati del test eseguito, i quali sono stati riportati all'interno del documento in forma grafica.

### Replicazione dei test

In caso si vogliano replicare i test delle funzioni è sufficiente eseguire i seguenti passi:

- installare **JMeter**;
- assicurarsi di aver configurato correttamente l'ambiente per poter raggiungere la funzione con una richiesta HTTP/HTTPS;
- eseguire il seguente comando da linea di comando:
    ```
    jmeter -n -t <path-to-file>/<file>.jmx -l <path-to-file>/<file>.csv -e -o <path-to-file>/<file>.html
    ```
    In questo modo si esegue il test presente nel file `.jmx` con la conseguente generazione di un file `csv` e una directory con all'interno un file `JSON`, una pagina `HTML` e altri file che presentano i risultati;
- alternativamente al punto precedente, si può eseguire il test tramite applicativo, utilizzando una quantità di risorse leggermente superiore. In questo caso si consiglia di modificare il file `.jmx` aggiungendo un *Listener* per osservare i risultati.

Ad ogni modo è possibile modificare i test, per esempio cambiando l'URL a cui inviare le richieste, mettendo mano al file `.jmx` fornito o creandone uno nuovo.
