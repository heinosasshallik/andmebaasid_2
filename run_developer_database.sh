echo "Starting..."
docker stop postgres
docker rm postgres
docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:alpine
sleep 5
docker exec -it postgres psql "user=postgres password=postgres host=localhost port=5432" -c "create database tasks" 
echo "Done."
