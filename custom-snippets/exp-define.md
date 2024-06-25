::: {.cell .markdown}
### Define configuration for this experiment (four hosts and a bridge on a different server)
:::

::: {.cell .code}
```python
slice_name="ethernet_bridge_switch-" + fablib.get_bastion_username()

node_conf = [
 {'name': "romeo",   'cores': 2, 'ram': 4, 'disk': 10, 'image': 'default_ubuntu_22', 'packages': [], host="eduky-w1.fabric-testbed.net"}, 
 {'name': "juliet",  'cores': 2, 'ram': 4, 'disk': 10, 'image': 'default_ubuntu_22', 'packages': [], host="eduky-w1.fabric-testbed.net"}, 
 {'name': "hamlet",  'cores': 2, 'ram': 4, 'disk': 10, 'image': 'default_ubuntu_22', 'packages': [], host="eduky-w1.fabric-testbed.net"},
 {'name': "ophelia", 'cores': 2, 'ram': 4, 'disk': 10, 'image': 'default_ubuntu_22', 'packages': [], host="eduky-w1.fabric-testbed.net"},
 {'name': "bridge",  'cores': 2, 'ram': 4, 'disk': 10, 'image': 'default_ubuntu_22', 'packages': [], host="eduky-w2.fabric-testbed.net"}
]
net_conf = [
 {"name": "net0", "subnet": "10.0.0.0/24", "nodes": [{"name": "romeo",   "addr": "10.0.0.100"}, {"name": "bridge", "addr": "0.0.0.0"}]},
 {"name": "net1", "subnet": "10.0.0.0/24", "nodes": [{"name": "juliet",  "addr": "10.0.0.101"}, {"name": "bridge", "addr": "0.0.0.0"}]},
 {"name": "net2", "subnet": "10.0.0.0/24", "nodes": [{"name": "hamlet",  "addr": "10.0.0.102"}, {"name": "bridge", "addr": "0.0.0.0"}]},
 {"name": "net3", "subnet": "10.0.0.0/24", "nodes": [{"name": "ophelia", "addr": "10.0.0.103"}, {"name": "bridge", "addr": "0.0.0.0"}]}
]
route_conf = []

exp_conf = {'cores': sum([ n['cores'] for n in node_conf]), 'nic': sum([len(n['nodes']) for n in net_conf]) }
```
:::
