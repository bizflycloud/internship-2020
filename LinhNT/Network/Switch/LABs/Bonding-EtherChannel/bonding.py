from mininet.cli import CLI

from mininet.link import Link,TCLink,Intf

from mininet.net import Mininet

from mininet.node import RemoteController
 

if '__main__' == __name__:

  net = Mininet(link=TCLink)

  h1 = net.addHost('h1', mac='00:00:00:00:00:11')

  h2 = net.addHost('h2', mac='00:00:00:00:00:22')

  h3 = net.addHost('h3', mac='00:00:00:00:00:23')

  h4 = net.addHost('h4', mac='00:00:00:00:00:24')

  linkopts={'bw':1}

  net.addLink(h1, h2, cls=TCLink, **linkopts)

  net.addLink(h1, h2, cls=TCLink, **linkopts)

  net.addLink(h2, h3, cls=TCLink, **linkopts)

  net.addLink(h2, h4, cls=TCLink, **linkopts)

  net.build()

  h2.cmd("sudo ifconfig h2-eth0 0")

  h2.cmd("sudo ifconfig h2-eth1 0")

  h2.cmd("sudo ifconfig h2-eth2 0")

  h2.cmd("sudo ifconfig h2-eth3 0")

  h2.cmd("sudo brctl addbr mybr")

  h2.cmd("sudo brctl addif mybr h2-eth0")

  h2.cmd("sudo brctl addif mybr h2-eth1")

  h2.cmd("sudo brctl addif mybr h2-eth2")

  h2.cmd("sudo brctl addif mybr h2-eth3")

  h2.cmd("sudo ifconfig mybr up")

  CLI(net)

  net.stop()
