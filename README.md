# od_profile
Video https://www.youtube.com/watch?v=wNiubbt9NHw&list=PLsgI_n0Vd5NMwyxQZLcQOQqH5vsnhD03q&index=7

![preview](https://media.discordapp.net/attachments/577284825455525889/695833920352026684/Capture.JPG)

## Requirements
- [esx](https://github.com/ESX-Org/es_extended)

## Download & Installation

### Manually
- Download https://github.com/davuongthanh/od_profile/archive/master.zip
- Put it in the `[esx]` directory

## Installation
- Import `od_skills.sql` in your database
- Add this to your `server.cfg`:

```
ensure od_profile
```
## SKills
Remember that all of the functions that is "TriggerServerEvent" is on client-side.

- Add "TriggerServerEvent('od_skills:addStamina', GetPlayerServerId(PlayerId()), (math.random() + 0))"

- Add "TriggerServerEvent('od_skills:addStrength', GetPlayerServerId(PlayerId()), (math.random() + 0))"  

- Add "TriggerServerEvent('od_skills:addFishing', GetPlayerServerId(PlayerId()), (math.random() + 0))"

- Add "TriggerServerEvent('od_skills:addDrugs', GetPlayerServerId(PlayerId()), (math.random() + 0))"

### License
od_profile

Copyright (C) 2015-2018 Solaris

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
