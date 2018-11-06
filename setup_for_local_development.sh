#/bin/bash -e

echo "Bringing up postgres..."
docker-compose up -d db
sleep 20
echo "Creating a new database..."
docker-compose run db createdb -U postgres -h db --no-password conduit

echo "Running rails migrations..."
docker-compose run web rake db:migrate

echo "Performing basic housekeeping for a new ADM system..."
docker-compose run web rails runner "SystemBootstrap.basic_setup"

docker-compose up -d
echo "The system is ready. Please run this to setup a root user:"
echo "SystemBootstrap.create_root_user 'YOUR FIRST NAME', 'YOUR LAST NAME', 'YOUR EMAIL'"
