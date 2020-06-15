docker build -t suhailibnnisar/multi-client:latest -t suhailibnnisar/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t suhailibnnisar/multi-server:latest -t suhailibnnisar/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t suhailibnnisar/multi-worker:latest -t suhailibnnisar/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push suhailibnnisar/multi-client:latest
docker push suhailibnnisar/multi-server:latest
docker push suhailibnnisar/multi-worker:latest

docker push suhailibnnisar/multi-client:$GIT_SHA
docker push suhailibnnisar/multi-server:$GIT_SHA
docker push suhailibnnisar/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=suhailibnnisar/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=suhailibnnisar/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=suhailibnnisar/multi-worker:$GIT_SHA
