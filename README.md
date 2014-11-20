docker-axonivy-engine
=====================

Create a docker image to run a Axon.ivy engine (http://developer.axonivy.com).

Usage
-----

To build the docker image, execute the following command in the root folder: 

	docker build -t dgauch/axonivy-engine .

But usually you will not create the image yourself as it will automatically generated and made available at https://registry.hub.docker.com/u/dgauch/axonivy-engine .

Usage of the docker image
-------------------------

To run the Axon.ivy engine in demo mode, just fire this command:

	docker run -it --rm -p 8081:8081 dgauch/axonivy-engine
	
This will run the container showing the console and finally remove the container (`--rm`) after you stop it with `Ctrl-c`. After startup finished, access the server page at `http://{dockerhost}:8081/ivy`. On a Linux host, that's usually http://127.0.0.1:8081/ivy. Under Mac OS, you usually end up with http://192.168.59.103:8081/ivy.

If you want to run the service in non-demo mode, you have to provide a database for the Axon.ivy system database, as well as a valid license. To run a suitable postgres container, you may execute:

	docker run -d -e LC_ALL=C.UTF-8 --name axonivy-engine-db postgres

The default environment is already configured to be used with a postgres database. If you want to use a different database, please configure these environment variables correctly, e.g. by using the -e switch: 

	-e AXONIVY_ENGINE_DB_URL=jdbc:postgresql://172.17.0.46:5432/AxonIvySystemDatabase
	-e AXONIVY_ENGINE_DB_USER=postgres
	-e AXONIVY_ENGINE_DB_PASS=mypass

Start the Axon.ivy engine container then with a command similar to this (please use the correct path to the license file):

	docker run -d -p 8081:8081 --link axonivy-engine-db:db -v /directory/with/lic:/data --name axonivy-engine dgauch/axonivy-engine

After startup, the server is then available under the same links as above. Consider folder sharing as explained in https://github.com/boot2docker/boot2docker#folder-sharing when you're using boot2docker:

	docker run -d -p 8081:8081 --link axonivy-engine-db:db --volumes-from my-data --name axonivy-engine dgauch/axonivy-engine

To access the server administration application, use username `AxonIvy` with password `AxonIvy` as in demo mode.

Have fun!

