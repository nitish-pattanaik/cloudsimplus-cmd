# CloudSim Plus - Manual Build With CMD
This project provides a self-contained command-line based approach to build the whole `cloudsimplus` java library.

## Key Points
- No build system. (no maven, no gradle)
- Only a single `build.bat` file is used to build the whole project.
- I just used `javac` and `java` (comes with JDK) to build the projects (cloudsimplus & cloudsimplus-examples) and run those examples.
- java & javac version
``` sh
javac --version
javac 21.0.5

 java --version
openjdk 21.0.5 2024-10-15 LTS
OpenJDK Runtime Environment Temurin-21.0.5+11 (build 21.0.5+11-LTS)
OpenJDK 64-Bit Server VM Temurin-21.0.5+11 (build 21.0.5+11-LTS, mixed mode, sharing)
```
- You can compile the project using atleast `java-17`.

## Build
- Just run: `build.bat`. That's it.
- You can look what it's doing beforehand. (if you are not comfortable to run it directly).
- Let me know if you'd like a Linux version of the build system (`.sh` scripts). Actually it's super simple to convert `build.bat` to `build.sh`. This is the power of simplicity (I guess).

## Run
- By default script will run the `org.cloudsimplus.examples.BasicFirstExample`.
- If you wants to run something else, modify build.bat (where I try to run example using java).

## Project Structure
``` sh
C:\GitHub\cloudsimplus-cmd
|> tree .
Folder PATH listing for volume OS
Volume serial number is 00EE-4F49
C:\GITHUB\CLOUDSIMPLUS-CMD
├───libs
├───out
│   └───org
│       └───cloudsimplus
│           ├───allocationpolicies
│           │   └───migration
│           ├───autoscaling
│           │   └───resources
│           ├───brokers
│           ├───builders
│           │   └───tables
│           ├───cloudlets
│           │   └───network
│           ├───core
│           │   └───events
│           ├───datacenters
│           │   └───network
│           ├───distributions
│           ├───faultinjection
│           ├───heuristics
│           ├───hosts
│           │   └───network
│           ├───integrationtests
│           ├───listeners
│           ├───mocks
│           ├───network
│           │   ├───switches
│           │   └───topologies
│           │       └───readers
│           ├───power
│           │   └───models
│           ├───provisioners
│           ├───resources
│           ├───schedulers
│           │   ├───cloudlet
│           │   │   └───network
│           │   └───vm
│           ├───selectionpolicies
│           ├───slametrics
│           ├───testbeds
│           ├───traces
│           │   └───google
│           ├───util
│           ├───utilizationmodels
│           ├───vms
│           │   └───network
│           └───vmtemplates
├───out_samples
│   └───org
│       ├───cloudbus
│       │   └───cloudsim
│       │       └───examples
│       │           └───network
│       │               └───applications
│       └───cloudsimplus
│           └───examples
│               ├───autoscaling
│               ├───brokers
│               ├───costs
│               ├───dynamic
│               ├───listeners
│               ├───migration
│               ├───network
│               ├───performance
│               ├───power
│               ├───resourceusage
│               ├───schedulers
│               ├───simulationstatus
│               ├───sla
│               ├───synchronous
│               └───traces
│                   └───google
├───samples
│   └───org
│       ├───cloudbus
│       │   └───cloudsim
│       │       └───examples
│       │           └───network
│       │               └───applications
│       └───cloudsimplus
│           └───examples
│               ├───autoscaling
│               ├───brokers
│               ├───costs
│               ├───dynamic
│               ├───listeners
│               ├───migration
│               ├───performance
│               ├───power
│               ├───resourceusage
│               ├───schedulers
│               ├───simulationstatus
│               ├───sla
│               ├───synchronous
│               └───traces
│                   └───google
└───src
    ├───main
    │   ├───java
    │   │   └───org
    │   │       └───cloudsimplus
    │   │           ├───allocationpolicies
    │   │           │   └───migration
    │   │           ├───autoscaling
    │   │           │   └───resources
    │   │           ├───brokers
    │   │           ├───builders
    │   │           │   └───tables
    │   │           ├───cloudlets
    │   │           │   └───network
    │   │           ├───core
    │   │           │   └───events
    │   │           ├───datacenters
    │   │           │   └───network
    │   │           ├───distributions
    │   │           ├───faultinjection
    │   │           ├───heuristics
    │   │           ├───hosts
    │   │           │   └───network
    │   │           ├───listeners
    │   │           ├───network
    │   │           │   ├───switches
    │   │           │   └───topologies
    │   │           │       └───readers
    │   │           ├───power
    │   │           │   └───models
    │   │           ├───provisioners
    │   │           ├───resources
    │   │           ├───schedulers
    │   │           │   ├───cloudlet
    │   │           │   │   └───network
    │   │           │   └───vm
    │   │           ├───selectionpolicies
    │   │           ├───slametrics
    │   │           ├───testbeds
    │   │           ├───traces
    │   │           │   └───google
    │   │           ├───util
    │   │           ├───utilizationmodels
    │   │           ├───vms
    │   │           │   └───network
    │   │           └───vmtemplates
    │   └───resources
    │       └───vmtemplates
    │           └───aws
    └───test
        ├───java
        │   └───org
        │       └───cloudsimplus
        │           ├───allocationpolicies
        │           ├───autoscaling
        │           ├───cloudlets
        │           │   └───network
        │           ├───core
        │           ├───datacenters
        │           ├───heuristics
        │           ├───hosts
        │           ├───integrationtests
        │           ├───mocks
        │           ├───provisioners
        │           ├───resources
        │           ├───schedulers
        │           │   ├───cloudlet
        │           │   └───vm
        │           ├───traces
        │           │   └───google
        │           ├───util
        │           ├───utilizationmodels
        │           └───vms
        └───resources
```
- `src/`: This directory contains the source code of whole `cloudsimplus` library.
- `samples/`: This contains all the source code of the `cloudsimplus-examples`.
- `out/`: This contains all generated `.class` files for cloudsimplus library. (not added to repo)
- `out_samples/`: This contains all generated `.class` files for cloudsimplus-examples. (not added to repo)
- `lombok.config`: Config file to be used by *preprocessor* i.e. `lombok`.

## Credits
This project uses code from the following open-source repositories:
- CloudSim Plus: https://github.com/cloudsimplus/cloudsimplus
    - Copyright © Manoel Campos
    - Licensed under Apache License 2.0

- CloudSim Plus Examples: https://github.com/cloudsimplus/cloudsimplus-examples
    - Copyright © Manoel Campos
    - Licensed under Apache License 2.0

- This project only modifies the build process for educational and convenience purposes. All credit goes to the original developers of CloudSim Plus.
- MIT License in this repo doesn't refer to original source code of cloudsimplus and cloudsimplus-examples.
