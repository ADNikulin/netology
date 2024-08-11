## Project using Ansible
- Projecyt prepare by Alexander for tasks - https://github.com/netology-code/mnt-homeworks/blob/MNT-video/08-ansible-03-yandex/README.md
- This ansible project installs nginx, lighthouse, vector and clickhouse
- You will also find a lot of incredibly interesting things here. You will hardly see anything like this anywhere else.

### Prerequisite

- **Ansible 2.9+**

### Configure projects

projects contains 3 type settings: 

- `~/group_vars/vector/vars.yml`
- `~/group_vars/lighthouse/vars.yml`
- `~/group_vars/clickhouse/vars.yml`

For example, if we need to increase to change clickhouse versions we must set new versions in `~/group_vars/clickhouse/vars.yml`
```
  clickhouse_version: "22.3.3.44"
  clickhouse_packages:
    - clickhouse-client
    - clickhouse-server
    - clickhouse-common-static
```

In `~/inventory/prod.yaml` file, you can configure the node details.

```
---
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: <ip>
      ansible_user: user

vector:
  hosts:
    vector-01:
      ansible_host: <ip>
      ansible_user: user

lighthouse:
  hosts:
    lighthouse-01:
      ansible_host: <ip>
      ansible_user: user
```

## Security

If you discover a potential security issue in this project we ask that you notify AWS/Amazon Security via our [vulnerability reporting page](http://aws.amazon.com/security/vulnerability-reporting/). Please do **not** create a public GitHub issue.

## License

This project is licensed under the [Apache v2.0 License](LICENSE.txt).

## Copyright

Copyright OpenSearch Contributors. See [NOTICE](NOTICE.txt) for details.