# container-file-sync
To demonstrate how to sync output files from a container to server

When containers are run in isolation, they produce output files which can be documents, images or metadata files. 
It is also important these processed/output files are transferred to their destination servers.

Destination servers can be either file or web servers based on Linux systems. When an application is run in an EC2 
instance it is easier and convenient to sync the output files to the destination file server as we know the host which 
is static. The public key of the EC2 instance is shared with the file server thereby establishing trust which 
facilitates the syncing mechanism.

But this does not remain true with `Fargate` as the containers run in whatever free hosts available so the host remains 
dynamic. Sharing public key of the container or the host machine where it runs with the file server is not a viable or 
feasible solution for a Fargate container.

## Copying files to Image server  without having to share public key of host:    

- Generate a .pem file by creating a public and private key in the image server How to generate a .pem file
- There is a public key in .pub file created  by executing the keygen command. Copy the public key in `/home/user/.ssh/authorized_keys`
- The generated .pem be copied to the source(where docker file is present in the code) where data is present and needs to be copied
- Change the permission of the private key being copied `chmod 600 sample_file_server.pem`
- Change or modify password authentication status in image server
- Within the Docker file use the rsync command:
  `rsync -rave "ssh -i /path/to/privatekey/location/sample_file_server.pem" -amuvWxq /path/for/files_to_export admin@ifile-server.corp:/to/destination/location`
- The rsync command will SSH into the image server, the private key is in the .pem file.
- The public key was in .pub file and this key was copied into `authorized_keys` file.
- It will be successfully able to login into the image server.
- If the public key was not  copied into `authorized_keys` file  then it will request for a password. This is how we establish the trust.
- Now the rsync command will copy the delta files into the image server 
- The following github repo has a docker file defining the appropriate setting to execute the rsync command
