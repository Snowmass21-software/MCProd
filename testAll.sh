./clean.sh
source setup.sh
./install.sh

set -e

./testGridpacks.sh
./generateEvents.sh
./lepMult/test.sh
