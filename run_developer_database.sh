echo "Starting..."
sudo docker stop postgres
sudo docker rm postgres
sudo docker run --name postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:alpine

echo "Running migrations"
# Give some time for the postgres service to be up and running
sleep 5 
sudo docker exec -it postgres psql "user=postgres password=postgres host=localhost port=5432" -c "create database andmebaasid" 
export POSTGRESQL_URL=postgres://postgres:postgres@127.0.0.1:5432/andmebaasid?sslmode=disable
migrate -database ${POSTGRESQL_URL} -path api/db/migrations up

echo "Done."
