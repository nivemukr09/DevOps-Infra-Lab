# ⏱️ Kubernetes CronJob to Call Remote API

# scenario

While working on Kubernetes cluster enhancements, you may need to set up a recurring task that makes a call to a remote API.

This project sets up a **Kubernetes CronJob** that runs every minute and calls a remote API endpoint using `curl`.

## 📌 Use Case

You may need to refresh a service, trigger a webhook, or ping an external endpoint on a schedule as part of your system's automation or health-check mechanism. This CronJob handles that automatically inside your Kubernetes cluster.

## 🚀 Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed and running.
- `kubectl` CLI installed and configured.
- Internet access from within the Kubernetes cluster (to call the API).
- Docker or VirtualBox working with Minikube.

---

## 🔧 Setup Steps

### 1. Start Minikube

```bash
minikube start
```
2. Create the CronJob
```bash
kubectl create cronjob task --image=toolbox --schedule="*/1 * * * *" -- curl -s https://api.cyber-widget.com/refresh
```
This sets up a task that runs every 1 minute.
3. Verify the CronJob
```bash
kubectl get cronjobs
```
you should see

```bash
NAME    SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
task    */1 * * * *   False     0        <time>          <age>
```
---
🔍 Monitor Jobs
Check the created jobs:
```bash
kubectl get jobs
```
Check logs of the latest pod:
```bash
kubectl get pods  # Find pod name
kubectl logs <pod-name>
```
---
🧼 Cleanup
To delete the CronJob and all related jobs:
```bash
kubectl delete cronjob task
```

```bash
kubectl create cronjob task2 --image=curlimages/curl --schedule="*/1 * * * *" -- /bin/sh -c "echo 'Running curl'; curl -s https://api.cyber-widget.com/refresh; echo 'Curl finished'; tail -f /dev/null"

```
### Why this “worked” versus the original
Original CronJob ran curl … and then the container exited. Kubernetes saw the pod finish, and—depending on exit codes—either thought it succeeded or retried a failed pod, leading to logs that disappeared as new pods spun up.

Adding tail -f /dev/null keeps the container alive, so you can attach to it, watch its logs, and confirm the curl ran. The echo statements give you clear markers in the log for “start” and “end” of your API call.

---
### Notes:

For debugging, this pattern is great: you can inspect the container’s log output over time.

For production, you’ll typically want the container to exit when done (so Jobs complete). You would remove the tail -f /dev/null and rely on the CronJob’s built‑in retry behavior (restartPolicy: OnFailure) to retry on errors, or simply log to a central system instead.


## 🛠️ Author  
Maintained by  
<p align="center">
  <img src="assets/logo.png" alt="Logo" width="150"/>
</p>
<p align="center"><em>DevOps Engineer • Nivedha Muthukrishnan</em></p>