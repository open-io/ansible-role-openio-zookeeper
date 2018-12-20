[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-zookeeper.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-zookeeper)
# Ansible role `zookeeper`

An Ansible role for manage zookeeper. Specifically, the responsibilities of this role are to:

- install ZooKeeper
- configure ZooKeeper

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_zookeeper_autopurge_purgeInterval` | `1` | The time interval in hours for which the purge task has to be triggered. Set to a positive integer (1 and above) to enable the auto purging |
| `openio_zookeeper_autopurge_snapRetainCount` | `3` | When enabled, ZooKeeper auto purge feature retains the autopurge.snapRetainCount most recent snapshots and the corresponding transaction logs in the dataDir and dataLogDir respectively and deletes the rest |
| `openio_zookeeper_bind_address` | `hostvars[inventory_hostname]['ansible_' + openio_zookeeper_bind_interface]['ipv4']['address']` | The address that this zookeeper instance will run on |
| `openio_zookeeper_bind_interface` | `ansible_default_ipv4.alias` | The interface that this zookeeper instance will run on |
| `openio_zookeeper_bind_port` | `6005` | Listening port |
| `openio_zookeeper_cluster_ports` | `"2888:3888"` | Peers use the former port to connect to other peers |
| `openio_zookeeper_gridinit_dir` | `"/etc/gridinit.d/{{ openio_zookeeper_namespace }}"` | Path to copy the gridinit conf |
| `openio_zookeeper_gridinit_file_prefix` | `""` | Maybe set it to {{ openio_zookeeper_namespace }}- for old gridinit's style |
| `openio_zookeeper_init_limit` | `10` | initLimit is timeouts ZooKeeper uses to limit the length of time the ZooKeeper servers in quorum have to connect to a leader |
| `openio_zookeeper_java_args` | `string` | String of java arguments |
| `openio_zookeeper_log_properties` | `"INFO,ROLLINGFILE"` | The severity level is associated with the root logger with appenders |
| `openio_zookeeper_max_client_connections` | `200` | This property limits the number of active connections from a host, specified by IP address, to a single ZooKeeper server |
| `openio_zookeeper_memory` | `` | Heap size of JVM |
| `openio_zookeeper_namespace` | `OPENIO` | Namespace |
| `openio_zookeeper_parallel_gc_threads` | `ansible_processor_vcpus` | Sets the number of threads used during parallel phases of the garbage collectors. The default value varies with the platform on which the JVM is running |
| `openio_zookeeper_rolling_log_file_max_size` | `"10MB"` | Maximum allowed file size (in bytes) before rolling over |
| `openio_zookeeper_servers` | `dict` | Dict of ip, host and id of cluster member |
| `openio_zookeeper_serviceid` | `0` | ID in gridinit |
| `openio_zookeeper_sync_limit` | `5` | The entry syncLimit limits how far out of date a server can be from a leader |
| `openio_zookeeper_tick_time` | `2000` | The basic time unit in milliseconds used by ZooKeeper. It is used to do heartbeats and the minimum session timeout will be twice the tickTime |
| `openio_zookeeper_volume` | `"/var/lib/oio/sds/{{ openio_zookeeper_namespace }}/zookeeper-{{ openio_zookeeper_serviceid }}"` | Path to store data |
| `openio_zookeeper_provision_only` | `false` | Provision only without restarting services |


## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: all
  gather_facts: true
  become: true
  roles:
    - role: users
    - role: repo
    - role: gridinit
      openio_gridinit_namespace: "{{ NS }}"
    - role: zookeeper
      openio_zookeeper_namespace: "{{ NS }}"
      openio_zookeeper_memory: 128M
      openio_zookeeper_parallel_gc_threads: 1
      openio_zookeeper_servers:
        - host: "node1"
          ip: "172.17.0.2"
          id: 1
        - host: "node2"
          ip: "172.17.0.3"
          id: 2
        - host: "node3"
          ip: "172.17.0.4"
          id: 3
```


```ini
[all]
node1 ansible_host=192.168.1.173
```

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome.
The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork.
Github can then easily create a PR based on that branch.

## License

GNU AFFERO GENERAL PUBLIC LICENSE, Version 3

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier) (maintainer)
