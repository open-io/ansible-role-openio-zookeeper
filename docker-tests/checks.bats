#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

@test 'ZK - Are you OK ?' {
  run bash -c "echo ruok |curl telnet://${SUT_IP}:6005"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'imok' ]]
}

@test 'ZK - Monitoring' {
  run bash -c "echo mntr |curl telnet://${SUT_IP}:6005"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'leader' ]] || [[ "${output}" =~ 'follower' ]]
}
