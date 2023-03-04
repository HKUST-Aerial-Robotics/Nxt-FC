# NxtPX4

![1677900720702](image/README/1677900720702.png)

> All GPIO & function small size PX4 for UAV research for HKUST UAV-Group

* Dimension of NxtPX4: 27mmx29mmx8mm

# Getting start

1. clone repo using:     `git@github.com:HKUST-Aerial-Robotics/NxtPX4.git`
2. run init repo script:     `./init_all_repo.sh`
   it will take some time to clone all submodules into loccal
3. Enter directory **NxtPX4-Hardware**:     `cd ./NxtPX4-Hardware`
   you should notice that you are not on main branch, So Checkout to main branch using:  `git checkout -b main`
4. cd back to NXTPX4 dir
5. Enter directory **PX4-Autopilot**:   `cd ./PX4-Autopilot`
   you should notice that you are not on main branch or develop branch. So checkout main branch to local and then checkout to develop branch to compile frameware for NxtPX4.
   `git checkout -b main` and then `git checkout -b develop origin/develop`
6. configure done !

## Hardware development

* Kicad 7.0 required
* Create new branch for your own features
* Only general hardware features can be merged into main branch

## Frameware development

### Compile

* Frameware compile: make hkust_nxt
* bootloader compile: make hkust_nxt_bootloader

### Develop

* Create new branch named as **feature-xxx(feature info)** from **develop** branch to start your own feature development
* After test your own feature, mereged into develop branch and push a pull request (only general features will be accepted)

update repo using script: `./update_all_repo.sh`
