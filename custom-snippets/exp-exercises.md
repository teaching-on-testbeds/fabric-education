::: {.cell .markdown}
### Run the experiment

Now, you are ready to run the experiment! Follow the instructions in the [TCP congestion control](https://witestlab.poly.edu/blog/tcp-congestion-control-basics/) page to send TCP flows between the two hosts, and generate data about the congestion window and slow start threshold over time.

When you have generated some data, you can use the cell below to transfer it from the sender host and visualize it here.

:::

::: {.cell .markdown}
#### Exercise: visualization
:::

::: {.cell .code}
```python
import os
slice.get_node("romeo").download_file(os.path.join(os.getcwd() + "/sender-ss.csv"), "sender-ss.csv")
```
:::

::: {.cell .code}
```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("sender-ss.csv", names=['time', 'sender', 'retx_unacked', 'retx_cum', 'cwnd', 'ssthresh', 'rtt'])

# exclude the "control" flow
s = df.groupby('sender').size()
df_filtered = df[df.groupby("sender")['sender'].transform('size') > 100]

senders = df_filtered.sender.unique()

time_min = df_filtered.time.min()
cwnd_max = 1.1*df_filtered.cwnd.max()
dfs = [df_filtered[df_filtered.sender==senders[i]] for i in range(3)]

fig, axs = plt.subplots(len(senders), sharex=True, figsize=(12,8))
fig.suptitle('CWND over time')
for i in range(len(senders)):
    if i==len(senders)-1:
        axs[i].plot(dfs[i]['time']-time_min, dfs[i]['cwnd'], label="cwnd")
        axs[i].plot(dfs[i]['time']-time_min, dfs[i]['ssthresh'], label="ssthresh")
        axs[i].set_ylim([0,cwnd_max])
        axs[i].set_xlabel("Time (s)");
    else:
        axs[i].plot(dfs[i]['time']-time_min, dfs[i]['cwnd'])
        axs[i].plot(dfs[i]['time']-time_min, dfs[i]['ssthresh'])
        axs[i].set_ylim([0,cwnd_max])


plt.tight_layout();
fig.legend(loc='upper right', ncol=2);
```
:::


::: {.cell .markdown}
#### Additional exercise: Transfer .pcap files from a FABRIC host

After you have executed the TCP ECN exercise, you can retrieve the `romeo-tcp-ecn.pcap` and `juliet-tcp-ecn.pcap` files from the FABRIC hosts with the following commands:

:::

::: {.cell .code}
```python
slice.get_node("romeo").download_file("/home/fabric/work/romeo-tcp-ecn.pcap", "romeo-tcp-ecn.pcap")
slice.get_node("juliet").download_file("/home/fabric/work/juliet-tcp-ecn.pcap", "juliet-tcp-ecn.pcap")
```
:::

::: {.cell .markdown}
Then in the Jupyter environment, click on the folder icon in the file browser on the left to make sure that you are located in your “Jupyter home” directory.

You should see the above .pcap files appear in the Jupyter file browser on the left. You can now download this file from the Jupyter environment to your own laptop to analyze them in Wireshark.

:::
