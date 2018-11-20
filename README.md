# Datadog Event Buildkite Plugin

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) for sending event to datadog

It contains a [command hook](hooks/command), and [tests](tests/test.bats) using [plugin-tester](https://github.com/buildkite-plugins/plugin-tester).

Usage:
```
# - Your production deployment step here:
#  ...
#  ...

- wait # wait for the production deployment to complete

- label: ':datadog: Send deployment complete event to datadog'
  branches: 'master'
  plugins:
    seek-oss/aws-sm#v1.0.0:
      env:
        DATADOG_API_KEY: arn of the secret
    seek-oss/datadog-event#v0.0.2:
      title: $BUILDKITE_PIPELINE_SLUG deployed by $BUILDBOX_BUILD_CREATOR
      tags: event-type:deployment,branch:$BUILDKITE_BRANCH # multiple tags can be sent to datadog
      env: DATADOG_API_KEY
  agents:
    queue: xxx-prod:cicd # agent need to be able to assume role to fetch the datadog api key from ssm
```



## License

MIT (see [LICENSE](LICENSE))
