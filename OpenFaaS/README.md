# **OpenFaaS**

## Installazioni e configurazione ambiente

### Installazione di **KinD**

Per prima cosa si installa **KinD** che consentirà la creazione di un cluster *Kubernetes*.

```
$ [ $( uname -m ) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
$ chmod + x ./kind
$ sudo mv ./kind /usr/local/bin/kind
```

Si crea il cluster di nome **openfaas**:
```
kind create cluster --name openfaas
```

### Installazione di **arkade**

```
curl - SLsf https://get.arkade.dev/ | sudo sh
```

### Installazione di **OpenFaaS** tramite **arkade**

```
arkade install openfaas
```

### Installazione della CLI di **OpenFaaS**

```
arkade get faas-cli
```

## Gestione funzione

### Creazione funzione

Il framework mette a disposizione un archivio da cui è possibile scaricare vari template:
```
$ faas-cli template store list
$ faas-cli template store pull <language>
```

A questo punto si può creare una funzione utilizzando il template scaricato:
```
faas-cli new <function-name> --lang <language> --prefix <image-prefix>
```

Il codice può essere modificato all'interno del file `handler`.

Per passare alla fase successiva è necessario che l'utente sia parte del *Docker group* ed effettuare il `port forwarding` del gateway in background:
```
kubectl port-forward -n openfaas svc/gateway 8080:8080 &
```

### Build, push e deploy della funzione

Ci sono due alternative:

1) eseguire i singoli comandi:
    ```
    $ faas-cli build -f <function-name>.yml
    $ faas-cli push -f <function-name>.yml
    $ faas-cli deploy -f <function-name>.yml
    ```

2) eseguire il comando `up` che li racchiude tutti:
    ```
    faas-cli up -f <function-name>.yml
    ```

### Invocazione di una funzione

Si può invocare una funzione inviando una richiesta HTTP all'indirizzo esposto dal gateway, oppure tramite il comando `faas-cli invoke`.

L'invocazione può essere di due tipologie:

1) **sincrona**: l'indirizzo di default è `http://127.0.0.1:8080/function/<function-name>`

2) **asincrona**: l'indirizzo di default è `http://127.0.0.1:8080/async-function/<function-name>`

### Creazione funzione tramite script

Per creare una funzione ed effettuarne il `deploy` è possibile utilizzare lo script fornito `script.sh`, il quale permette di effettuare tutti i passaggi sopracitati con più facilità.
L'esecuzione dello script richiede il passaggio di due argomenti:

- nome da assegnare alla funzione;
- linguaggio che si sfrutterà per la funzione.
