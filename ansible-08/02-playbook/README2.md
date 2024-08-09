## Project Ansible-Playbook

A community repository for Ansible Playbook.

### Prerequisite

- **Ansible 2.9+**

### Configure

Refer the file `~/group_vars/vars.yml` to change the default values.

For example if we need to increase the java memory heap size for opensearch,

    clickhouse_version: "22.3.3.44"
    clickhouse_packages:
        - clickhouse-client
        - clickhouse-server
        - clickhouse-common-static

    vector_version: "0.37.1"

In `~/inventory/prod.yaml` file, you can configure the node details.

```
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: <IP>
      ansible_user: <USER>
    vector:
      ansible_host: <IP>
      ansible_user: <USER>
```

## Security

If you discover a potential security issue in this project we ask that you notify AWS/Amazon Security via our [vulnerability reporting page](http://aws.amazon.com/security/vulnerability-reporting/). Please do **not** create a public GitHub issue.

## License

This project is licensed under the [Apache v2.0 License](LICENSE.txt).

## Copyright

Copyright OpenSearch Contributors. See [NOTICE](NOTICE.txt) for details.