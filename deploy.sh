docker build -t amolkumar56/multi-client:latest -t amolkumar56/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amolkumar56/multi-server:latest -t amolkumar56/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amolkumar56/multi-worker:latest -t amolkumar56/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amolkumar56/multi-client:latest
docker push amolkumar56/multi-server:latest
docker push amolkumar56/multi-worker:latest

docker push amolkumar56/multi-client:$SHA
docker push amolkumar56/multi-server:$SHA
docker push amolkumar56/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amolkumar56/multi-server:$SHA
kubectl set image deployments/client-deployment client=amolkumar56/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amolkumar56/multi-worker:$SHA