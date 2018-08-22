## Automated Builds for Your DSpace Contributions

If you are a frequent contributor to DSpace, you can automate the build of Docker images for your contribution branches. 
This will enable other DSpace developers to quickly review and test your changes.

## Create an Automated Build

#### Sign into DockerHub with your account

#### From the menu, choose "Create -> Create Automated Build"

#### Click "Create Auto-build Github"
Carefully review the permissions that have been requested and grant access if you are comfortable.

#### Select your DSpace fork
![screenshot](../documentation/auto2.png)

#### On the "Create Automated Build" screen
Keep the repository name of "DSpace".
For the "Short Description" enter "PR Contributions".
Click "Create"
![screenshot](../documentation/auto1.png)

#### Go to Build Settings
Create a rule to generate a build for all new branches
![screenshot](../documentation/auto3.png)

#### Go to Build Details
Note the status of the builds that are running.
![screenshot](../documentation/auto4.png)
