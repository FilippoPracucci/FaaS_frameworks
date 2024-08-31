# **Knative**

## Installazioni e configurazione ambiente

### Installazione di **KinD**

Innanzitutto si deve creare un cluster *Kubernetes* tramite **KinD**, dunque si passa alla sua installazione:

```
$ [ $( uname -m ) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
$ chmod + x ./kind
$ sudo mv ./kind /usr/local/bin/kind
```

### Installazione della CLI **kn**

Inoltre è necessario aver installato **kubectl**  la CLI di *Knative* **kn**, che si installa come segue:

- download del binario in base all'architettura dal [repository ufficiale](https://github.com/knative/client/releases);
- ridenominazione del binario in **kn**: `mv <path-to-binary-file> kn`;
- si rende il binario eseguibile e lo si sposta in una directory sul `PATH`:
    ```
    $ chmod +x kn
    $ mv kn /usr/local/bin
    ```

### Installazione del plugin **quickstart**

Per installare *Knative* e *Kubernetes* si utilizza il *plugin* **quickstart**:

- download del file binario in base all'architettura dal [repository](https://github.com/knative-extensions/kn-plugin-quickstart/releases);
- ridenominazione del binario in **kn-quickstart**: `mv <path-to-binary-file> kn-quickstart`;
- si rende il binario eseguibile e lo si sposta in una directory sul `PATH`:
    ```
    $ chmod +x kn-quickstart
    $ mv kn-quickstart /usr/local/bin
    ```

### Installazione di Knative e Kubernetes

Si sfrutta **KinD** in modo da completare le seguenti funzioni:

- controllo dell'installazione di *Kubernetes*;
- creazione di un cluster chiamato `knative`;
- installazione di **Knative Serving** con **Kourier** come *networking layer* e **sslip.io** come DNS;
- installazione di **Knative Eventing** e creazione di un *Broker* in memoria e implementazione di *Channel*.

Dunque si esegue il comando `kn quickstart kind`.

### Installazione di **Knative Functions**

**func** permette l'utilizzo delle funzioni all'interno di Knative e per installarlo si devono seguire i seguenti passi:

- download del file binario dal [repository ufficiale](https://github.com/knative/func/releases);
- ridenominazione del binario in **func**: `mv <path-to-binary-file> func`;
- si rende il binario eseguibile e lo si sposta in una directory sul `PATH`:
    ```
    $ chmod +x func
    $ mv func /usr/local/bin
    ```

## Gestione funzione

### Creazione funzione

Il framework mette a disposizione diversi linguaggi per la creazione di funzioni; una volta scelto è possibile creare una funzione come segue:
```
func create -l <language> <function-name>
```

### Build, deploy e run della funzione

Si può costruire l'immagine della funzione tramite il seguente comando:
```
func build --registry <registry>
```
Infine per fare il `deploy` della funzione è necessario fornire un **image registry** come *Docker Hub*, dopo aver fatto il login ad esso tramite terminale:
```
func deploy --registry <registry>
```
In alternativa è possibile eseguire localmente la funzione, cioè senza fare il `deploy`, per facilitare la fase di test:
```
func run [--registry <registry>]
```

## Invocazione di una funzione

Per invocare una funzione di cui precedentemente si è fatto il `deploy` oppure messa in esecuzione con il comando `run` si utilizza il comando che segue all'interno della directory della funzione:
```
func invoke
```
In alternativa è possibile invocare una funzione di cui è stato fatto `deploy` si può inviare una richiesta HTTP tramite terminale (per esempio con il comando `curl`) oppure tramite browser, specificando l'URL fornito dopo il `deploy` della funzione.

### Creazione di una funzione

La creazione di una funzione ed il relativo `deploy` possono essere realizzati tramite lo script `script.sh`. Lo script necessita di tre argomenti per essere eseguito:

- **nome** da assegnare alla funzione;
- **linguaggio** che si userà per la funzione;
- **image registry** per il `deploy`.

### Utilizzo funzioni fornite

Se si vuole usare una delle funzioni presenti, basta effettuare la `build` e il `deploy`; per quest'ultimo è necessario anche fornire un **image registry** (es. **Docker Hub**). Il tutto può essere racchiuso in un unico comando, da eseguire all'interno della cartella della funzione. Se per esempio vogliamo usare la funzione **python**, dall'interno della cartella `knative-python-function` si esegue il comando:

`func deploy --build --registry <registry>`.

Oppure utilizzare lo script `script_deploy.sh` presente all'interno della cartella di ogni funzione; questo richiede il passaggio di un argomento, ovvero l'**image registry**.
