docker build -t deepakmodi/multi-client:latest -t deepakmodi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deepakmodi/multi-server:latest -t deepakmodi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deepakmodi/multi-worker:latest -t deepakmodi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push deepakmodi/multi-client: latest
docker push deepakmodi/multi-server:latest
docker push deepakmodi/multi-worker:latest

docker push deepakmodi/multi-client:$SHA
docker push deepakmodi/multi-server:$SHA
docker push deepakmodi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deepakmodi/multi-server:$SHA
kubectl set image deployment/client-deployment client=deepakmodi/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=deepakmodi/multi-worker:$SHA
