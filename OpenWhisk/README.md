# **Apache OpenWhisk**

## Installazioni e configurazione ambiente

### Installazione di **KinD**

Per prima cosa si installa **KinD** che consentirà la creazione di un cluster *Kubernetes*.

```
$ [ $( uname -m ) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
$ chmod + x ./kind
$ sudo mv ./kind /usr/local/bin/kind
```

Si crea un file `mycluster.yaml` con all'interno la configurazione dell'ambiente e un file `kind-cluster.yaml` con la configurazione del cluster del tipo:
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
    extraPortMappings:
        -hostPort: 31001
            containerPort: 31001;

```

A questo punto si crea il cluster di nome **openwhisk** passando il file di configurazione `kind-cluster.yaml`:
```
kind create cluster --config kind-cluster.yaml --name openwhisk
```

### Installazione di **Helm**

- Download del `.tar` dal [repository ufficiale](https://github.com/helm/helm/releases);
-   ```
    $ tar -zxvf <file>`;
    $ sudo mv <file> /usr/local/bin/helm
    ```

### Deploy di **OpenWhisk** con **Helm**

```
$ helm repo add openwhisk https://openwhisk.apache.org/charts
$ helm repo update
$ helm install owdev openwhisk/openwhisk -n openwhisk --create-namespace -f mycluster.yaml
```

### Installazione della CLI **wsk**

- Download del `.tar` dal [repository ufficiale](https://github.com/apache/openwhisk-cli/releases);
-   ```
    $ tar -zxvf <file>`;
    $ sudo mv <file> /usr/local/bin/wsk
    ```

### Configurazione di **wsk**

```
wsk -i property set -- apihost API_HOST -- auth AUTH_KEY
```
Come valori di esempio:
- `API_HOST`: http://localhost:31001 (valore presente in `mycluster.yaml`)
- `AUTH_KEY`: 23bc46b1-71f6-4ed5-8c54-816aa4f8c502:123zO3xZCLrMN6v2BKK1dXYFpXlPkccOFqm12CdAsMgRU4VrNZ9lyGVCGuMDGIwP

## Gestione **Action**, **Trigger** e **Rule**

### Creazione **Action**

Il framework supporta vari linguaggi. Una volta scelto si crea un file, per esempio consideriamo *Python*: `<filename>.py`

Ora si esegue il seguente comando:
```
wsk -i action create <action-name> <filename>.py
```

### Invocazione **Action**

```
wsk -i action invoke <action-name> --result --param <key> <value>
```

In alternativa è possibile inviare una richiesta HTTP o HTTPS all'indirizzo:
```https://$APIHOST/api/v1/namespaces/<namespace-name>/actions/<action-name>```

Lo stesso si può fare per interagire, attraverso gli *endpoints* messi a disposizione dalla **REST API**, anche con **Triggers**, **Rules**, **Packages**, **Activations**...

### Creazione **Trigger**

```
wsk -i trigger create <trigger-name>
```

### Creazione **Rule**

```
wsk -i rule create <rule-name> <trigger-name> <action-name>
```

### Scatenare **Trigger**

```
wsk -i trigger fire <trigger-name> --param <key> <value>
```

### Lista invocazioni

```
$ wsk -i activation list
$ wsk -i activation result <activationId>
```

### Deploy **Action**

Innanzitutto si deve installare l'*utility* **wskdeploy** analogamente alla CLI **wsk**, partendo dal file scaricato dal [repository](https://github.com/apache/openwhisk-wskdeploy/releases).

A questo punto si deve creare un file `<filename>.yaml` del tipo:
```
packages:
    default:
        actions:
            <action-name>:
                function : <filename>.py

```

Ora si può fare il deploy: `wskdeploy -m <filename>.yaml`.

### Creazione di **Action**, **Trigger** e **Rule** tramite script

Si possono utilizzare per velocizzare il procedimento i due script forniti:
- `script_action.sh` per creare una **action**, invocarla per verificarne la corretta creazione ed infine effettuare il `deploy`. I parametri necessari sono:

    - nome da assegnare all'**action**;
    - path per raggiungere il file che contiene l'handler.

- `script_trigger_rule.sh` per creare un **Trigger** ed una **Rule** che associ il primo ad una determinata **Action** esistente. Gli argomenti da passare sono:

    - nome da assegnare al **trigger**;
    - nome da assegnare alla **rule**;
    - nome dell'**action** da associare al **trigger** creato tramite la **rule**.
