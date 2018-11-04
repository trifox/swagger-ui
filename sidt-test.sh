#!/usr/bin/env bash

rm -rf componenttest/robot/report
rm -rf componenttest-e2e-selenium/robot/report

./sidt.sh -m dependencies
./sidt.sh -m service


./sidt.sh -u service infra debug
./sidt.sh -u test
./sidt.sh -d all


./sidt.sh -a componenttest-e2e-selenium -u service infra debug
./sidt.sh -a componenttest-e2e-selenium -u test
./sidt.sh -a componenttest-e2e-selenium -d all



