# EPA/ICIS-Air Data Exchange

This repository tracks the data exchange for EPA's [ICIS-Air](https://icis.epa.gov/icis/) system.

Data are reported by APB staff via the IAIP to the `AIRBRANCH` database and via the Air Web App to the `air-web` database. The data are staged in the `NETWORKNODEFLOW` database using stored procedures that run on a daily schedule. Finally, the data are sent to EPA through CDX using the [Virtual Exchange Service (VES)](https://ves.epa.gov/VESA/) on a weekly schedule.
