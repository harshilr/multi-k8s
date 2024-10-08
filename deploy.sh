docker build -t harshil2612/multi-client:latest -t harshil2612/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harshil2612/multi-server:latest -t harshil2612/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harshil2612/multi-worker:latest -t harshil2612/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push harshil2612/multi-client:latest
docker push harshil2612/multi-server:latest
docker push harshil2612/multi-worker:latest

docker push harshil2612/multi-client:$SHA
docker push harshil2612/multi-server:$SHA
docker push harshil2612/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=harshil2612/multi-server:$SHA
kubectl set image deployments/client-deployment client=harshil2612/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=harshil2612/multi-worker:$SHA