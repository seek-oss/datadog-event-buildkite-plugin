#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

command_hook="$PWD/hooks/command"

teardown() {
  unset BUILDKITE_PLUGIN_DATADOG_EVENT_DATADOG_API_KEY
  unset BUILDKITE_PLUGIN_DATADOG_EVENT_TITLE
  unset BUILDKITE_PLUGIN_DATADOG_EVENT_TAGS
}


@test "Command fails if clowns exist" {
  export BUILDKITE_PLUGIN_DATADOG_EVENT_DATADOG_API_KEY="blah"
  export BUILDKITE_PLUGIN_DATADOG_EVENT_TITLE="dummy app deployed"
  export BUILDKITE_PLUGIN_DATADOG_EVENT_TAGS="event-type:deployment"

  run "$command_hook"

  assert_failure
  assert_output --partial "An error occurred. Exiting"
}
