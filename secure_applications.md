# Secure networked applications

The exercises in this experiment will focus on the *confidentiality* of network services - to what extent are services that offer remote login, file transfer, or web access, protected from disclosure to unauthorized individuals? In particular, we will consider confidentiality with respect to malicious users who might be eavesdropping on network traffic.

You can run this experiment on GENI or on the new FABRIC testbed! Refer to the testbed-specific prerequisites listed below.

<div style="border-color:#FB8C00; border-style:solid; padding: 15px;">  
<h4 style="color:#FB8C00;"> GENI-specific instructions: Prerequisites</h4>

To reproduce this experiment on GENI, you will need an account on the <a href="http://groups.geni.net/geni/wiki/SignMeUp">GENI Portal</a>, and you will need to have <a href="http://groups.geni.net/geni/wiki/JoinAProject">joined a project</a>. You should have already <a href="http://groups.geni.net/geni/wiki/HowTo/LoginToNodes">uploaded your SSH keys to the portal and know how to log in to a node with those keys</a>.  
</div>  
<p><br></p>
<div style="border-color:#47aae1; border-style:solid; padding: 15px;">  
<h4 style="color:#47aae1;">FABRIC-specific instructions: Prerequisites</h4>  
To run this experiment on <a href="https://fabric-testbed.net/">FABRIC</a>, you should have a FABRIC account and be part of a FABRIC project. 
</div>  
<p><br></p>
<div style="border-color:#5e8a90; border-style:solid; padding: 15px;">  
<h4 style="color:#5e8a90;"> Cloudlab-specific instructions: Prerequisites</h4>

To reproduce this experiment on Cloudlab, you will need an account on <a href="https://cloudlab.us/">Cloudlab</a>, you will need to have <a href="https://docs.cloudlab.us/users.html#%28part._join-project%29">joined a project</a>, and you will need to have <a href="https://docs.cloudlab.us/users.html#%28part._ssh-access%29">set up SSH access</a>.
</div>  

<ul>
<li>Skip to <a href="#runmyexperiment">Run my experiment</a></li>
</ul>

## Background

In today's digital age, protecting data privacy and security is crucial. With the increasing amount of data transmitted over computer networks, it is essential to understand the distinction between secure and non-secure applications. 

Secure applications use encryption techniques to protect sensitive data and communications from unauthorized access or interception. 
Secure applications typically use encryption techniques to encode data and protect it from being read or altered by unauthorized users. Some examples of secure applications include HTTPS, SSH, SFTP and VPNs. HTTPS is a protocol to securely transmit data over the internet, typically used for secure online transactions such as online banking or shopping. SSH (Secure Shell) is a secure communication protocol used to access remote systems, while VPNs (Virtual Private Networks) provide a secure connection between remote devices over the internet. SFTP (Secure File Transfer Protocol) is a secure version of the File Transfer Protocol (FTP), which is used to transfer files between servers and clients over a network.

Non-secure applications, on the other hand, are not designed with the same level of protection and can leave data vulnerable to interception or manipulation. Examples of non-secure applications include unencrypted email, file transfer protocols (FTP), HTTP and Telnet. These applications are often used for non-sensitive communication, but they can pose a risk when used to transmit confidential or sensitive information. 

## Results

## Run my experiment

For this experiment, we will use the topology illustrated here, with IP addresses as noted on the diagram and a subnet mask of 255.255.255.0 on each interface: 

<img src="https://user-images.githubusercontent.com/73753025/224797673-933ec90a-00c9-418e-87c7-a66ed160bf41.png" alt="secure-applications-topology" />

Follow the instructions for the testbed you are using (GENI or FABRIC) to reserve the resources and log in to each of the hosts in this experiment.

<div style="border-color:#FB8C00; border-style:solid; padding: 15px;">  
<h4 style="color:#FB8C00;"> GENI-specific instructions: Reserve resources</h4>

<p>In the GENI Portal, create a new slice, then click "Add Resources". Scroll down to where it says "Choose RSpec" and select the "URL" option, the load the RSpec from the URL: <a href="https://raw.githubusercontent.com/ffund/tcp-ip-essentials/gh-pages/lab9/security-small-rspec.xml">https://raw.githubusercontent.com/ffund/tcp-ip-essentials/gh-pages/lab9/security-small-rspec.xml</a>.</p>

<p>This will load a topology in your canvas, with two hosts ("romeo" and "server") and a router connecting them as shown above.</p>

<p>Click on "Site 1" and choose an InstaGENI site to bind to, then reserve your resources. Wait for your nodes to boot up (they will turn green in the canvas display on your slice page in the GENI portal when they are ready). Then, click on "Details" to get SSH login information, and SSH into each node. </p>

<p>When you have logged in to each node, continue to the <a href="#remote-login">Remote login</a> section.</p>

</div>  
<p><br></p>
<div style="border-color:#47aae1; border-style:solid; padding: 15px;">  
<h4 style="color:#47aae1;">FABRIC-specific instructions: Reserve resources</h4>  
<p>To run this experiment on <a href="https://fabric-testbed.net/">FABRIC</a>, open the JupyterHub environment on FABRIC, open a shell, and run </p>

<pre>
git clone https://github.com/teaching-on-testbeds/fabric-education secure_applications
cd secure_applications
git checkout secure_applications
</pre>
<p>Then open the notebook titled "setup.ipynb".</p>  
<p>Follow along inside the notebook to reserve resources and get the login details for each host in the experiment.</p>  
<p>When you have logged in to each node, continue to the <a href="#remote-login">Remote login</a> section.</p>  
</div>  
<p><br></p>
<div style="border-color:#5e8a90; border-style:solid; padding: 15px;">  
<h4 style="color:#5e8a90;"> Cloudlab-specific instructions: Reserve resources</h4>

<p>To reserve these resources on Cloudlab, open this profile page: </p>

<p><a href="https://www.cloudlab.us/p/nyunetworks/education?refspec=refs/heads/tcp_congestion_control">https://www.cloudlab.us/p/nyunetworks/education?refspec=refs/heads/tcp_congestion_control</a></p>

<p>Click "next", then select the Cloudlab project that you are part of and a Cloudlab cluster with available resources. (This experiment is compatible with any of the Cloudlab clusters.) Then click "next", and "finish".</p>

<p>Wait until all of the sources have turned green and have a small check mark in the top right corner of the "topology view" tab, indicating that they are fully configured and ready to log in. Then, click on "list view" to get SSH login details for the romeo, router, and server hosts. Use these details to SSH into each.</p>

<p>When you have logged in to each node, continue to the <a href="#remote-login">Remote login</a> section.</p>

</div>  

### Remote login

In this exercise, we will compare `telnet` and `SSH`, two applications used for remote login to a host. 

First, we will need to install and configure these services on the "server" node.

On "server", install the `telnet` service with

<pre>
sudo apt-get update  
sudo apt-get -y install xinetd telnetd  
</pre>

Then create the telnet configuration file with

<pre>
sudo nano /etc/xinetd.d/telnet  
</pre>

Paste the following into the file:

<pre>
# default: on
# description: telnet server
service telnet  
{
disable = no  
flags = REUSE  
socket_type = stream  
wait = no  
user = root  
only_from = 10.0.0.0/8
server = /usr/sbin/in.telnetd  
log_on_failure += USERID  
}
</pre>

Hit Ctrl+O and Enter to save the file, and Ctrl+X to exit nano. Finally, restart the telnet service on "server" with

<pre>
sudo service xinetd restart  
</pre>

You can check the service status with


<pre>
service xinetd status
</pre>

it should be "active (running)".

Next, we will start an SSH server process on the "server" host. Hosts on GENI already have SSH servers on them, but these are configured to allow remote access to GENI users and administrators. We will start a second, parallel SSH server process on "server", that will run on port 1000 on the experiment interface. ("Our" SSH server runs on a non-default port because the default port, 22, is already in use by the existing SSH server):

<pre>
sudo /usr/sbin/sshd -o ListenAddress=10.10.2.100 -f /usr/share/openssh/sshd_config -p 1000
</pre>

Finally, we need to set up a user account for remote access to the "server" host. On the "server", create a new user account with the username "shakespeare":

<pre>
sudo useradd -m shakespeare -s /bin/sh  
</pre>

Then run

<pre>
sudo passwd shakespeare
</pre>

You will use your Net ID as the password - enter your Net ID when prompted for a password, then hit "Enter". (No characters will appear as you type.)

Now we are ready to compare the two remote access applications, with respect to security.

On the "romeo" host, run

<pre>
sudo tcpdump -i $(ip route get 10.10.2.100 | grep -oP "(?<=dev )[^ ]+") -w security-telnet-$(hostname -s).pcap
</pre>
        
to capture traffic on the network segment. This packet capture will show you what is visible to anyone eavesdropping on the network segment.

While this is running, initiate a `telnet` connection from "romeo" to "server" - on "romeo", run

<pre>
telnet server
</pre>

When prompted for a "login", enter

<pre>
shakespeare
</pre>

and hit "Enter". Then, when prompted for a password, enter the password you set previously for the "shakespeare" user.

After you have successfully logged in using `telnet`, type 

<pre>
date
</pre>

and hit "Enter", and then type

<pre>
exit
</pre>

in the `telnet` session and hit "Enter" to end it. Stop the `tcpdump` with Ctrl+C.


Next, on the "romeo" host, run

<pre>
sudo tcpdump -i $(ip route get 10.10.2.100 | grep -oP "(?<=dev )[^ ]+") -w security-ssh-$(hostname -s).pcap
</pre>

to capture traffic on the network segment. This packet capture will show you what is visible to anyone eavesdropping on the network segment.

While this is running, initiate an SSH connection from "romeo" to "server" on port 1000 - on "romeo", run

<pre>
ssh shakespeare@server -p 1000
</pre>

Type `yes` when prompted to confirm the connection. Then, when prompted for a password, enter the password you set previously for the "shakespeare" user.

After you have successfully logged in using SSH, type 

<pre>
date
</pre>

and hit "Enter", and then type

<pre>
exit
</pre>

in the SSH session and hit "Enter" to end it. Stop the `tcpdump` with Ctrl+C.

Transfer both packet captures to your laptop with `scp`, and analyze with Wireshark. Examine the individual packet payloads, and also use the Analyze > Follow > TCP Stream tool (while one of the packets in the TCP stream is selected).
<p><br></p>  
<div style="border-color:#47aae1; border-style:solid; padding: 15px;">

<h4 style="color:#47aae1;">FABRIC-specific instructions: transfer files</h4>

<p>If you are running this experiment on FABRIC, you can use the "Exercise: Transfer .pcap files from a FABRIC host" section of the "setup.ipynb" notebook to transfer the .pcap files from the host to the Jupyter environment, then download them on your laptop. </p>

</div>  
<p><br></p>

### File transfer

In this exercise, we will compare FTP and SFTP, two applications used for file transfer to and from a remote host. SFTP tunnels FTP traffic over an SSH session.

First, you'll need to install the SFTP server on the "server" node:

<pre>
sudo apt-get -y install vsftpd
</pre>

You should have already prepared a user account named "shakespeare" on the server node, in the previous exercise. We will use this account again.


On the "romeo" host, run

<pre>
sudo tcpdump -i $(ip route get 10.10.2.100 | grep -oP "(?<=dev )[^ ]+") -w security-ftp-$(hostname -s).pcap
</pre>

to capture traffic on the network segment. This packet capture will show you what is visible to anyone eavesdropping on the network segment.


While this is running, initiate an FTP session from "romeo" to "server" - on "romeo", run

<pre>
ftp server
</pre>

When prompted for a "Name", enter

<pre>
shakespeare
</pre>

and hit "Enter". Then, when prompted for a password, enter the password you set previously for the "shakespeare" user.

After you have successfully authenticated your FTP session (you will see the message "230 Login successful"), you will see an FTP prompt. At the FTP prompt, type

<pre>
cd /etc
</pre>

and then 

<pre>
get passwd
</pre>

This will transfer a list of all usernames on the remote system over the FTP session. Finally, type 

<pre>
exit
</pre>

in the FTP session and hit "Enter" to end it. Stop the `tcpdump` running on the router with Ctrl+C.

You can run

<pre>
cat passwd
</pre>

on "romeo" to view the file that you transferred.


Next, on the "romeo" host, run

<pre>
sudo tcpdump -i $(ip route get 10.10.2.100 | grep -oP "(?<=dev )[^ ]+") -w security-sftp-$(hostname -s).pcap
</pre>

to capture traffic on the network segment. This packet capture will show you what is visible to anyone eavesdropping on the network segment.

While this is running, initiate an SFTP connection from "romeo" to "server" on port 1000 - on "romeo", run

<pre>
sftp -P 1000 shakespeare@server
</pre>

When prompted for a password, enter the password you set previously for the "shakespeare" user.

At the SFTP prompt, type

<pre>
cd /etc
</pre>

and then 

<pre>
get passwd
</pre>

to retrieve the same file. Then, type 

<pre>
exit
</pre>

in the SFTP session and hit "Enter" to end it. Stop the `tcpdump` running on the router with Ctrl+C.


Transfer both packet captures to your laptop with `scp`, and analyze with Wireshark. Examine the individual packet payloads, and also use the Analyze > Follow > TCP Stream tool (while one of the packets in the TCP stream is selected). (Note that FTP uses multiple TCP connections - one for control and one for file data. Use the TCP Stream tool to look at both, the control stream and the file data stream.)
<p><br></p>  
<div style="border-color:#47aae1; border-style:solid; padding: 15px;">

<h4 style="color:#47aae1;">FABRIC-specific instructions: transfer files</h4>

<p>If you are running this experiment on FABRIC, you can use the "Exercise: Transfer .pcap files from a FABRIC host" section of the "setup.ipynb" notebook to transfer the .pcap files from the host to the Jupyter environment, then download them on your laptop. </p>

</div>  
<p><br></p>

### Web access

In this exercise, we'll compare HTTP and HTTPS (HTTP over SSL/TLS).

On the "server" node, install the Apache web server:

<pre>
sudo apt -y install apache2
</pre>

Then, generate a self-signed certificate and key for it, which will be used to authenticate the server and to establish an encrypted connection to the server:

<pre>
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem
</pre>

and answer the questions when prompted. You can invent a fictional "Organization Name" and "Organizational Unit Name" for your server, but for the "Common Name" question, use the name listed under "Hostname" in the GENI or FABRIC or Cloudlab for the "server" node. 

For example:


<pre>
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:New York
Locality Name (eg, city) []:Brooklyn
Organization Name (eg, company) [Internet Widgits Pty Ltd]:NYU Tandon School of Engineering
Organizational Unit Name (eg, section) []:Department of Electrical and Computer Engineering
Common Name (e.g. server FQDN or YOUR name) []:server.lab9-new.ch-geni-net.instageni.idre.ucla.edu
Email Address []:ffund@nyu.edu
</pre>

Now that we have the website certificate and key, we'll update the Apache configuration to use them.

Edit the config file for the SSL-enabled version of the site:

<pre>
sudo nano /etc/apache2/sites-available/default-ssl.conf
</pre>

After the `<VirtualHost _default_:443>` line, add a ServerName line with the hostname of the "server" host. Excluding comments, the config file will end up looking similar to the following:

<pre><code>&lt;IfModule mod_ssl.c&gt;  
        &lt;VirtualHost _default_:443&gt;
                ServerName server.lab9-new.ch-geni-net.instageni.idre.ucla.edu
                ServerAdmin webmaster@localhost

                DocumentRoot /var/www/html

                SSLEngine on
                SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem
                SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
        &lt;/VirtualHost&gt;
&lt;/IfModule&gt;  
</code></pre>

(although there may be some additional lines not shown here.)

Enable the SSL module for Apache and the new SSL-enabled site, and restart the service:

<pre>
sudo a2enmod ssl
sudo a2ensite default-ssl.conf
sudo systemctl restart apache2
</pre>

Finally, create a form for data entry on your new site. Open a new HTML file with


<pre>
sudo nano /var/www/html/form.html
</pre>


and place the following HTML inside this file:

<pre><code>&lt;!DOCTYPE html&gt;  
&lt;html&gt;  
  &lt;body&gt;
    &lt;form action="/done.html"&gt;
      &lt;label for="fname"&gt;First name:&lt;/label&gt;&lt;br&gt;
      &lt;input type="text" id="fname" name="fname" value="John"&gt;&lt;br&gt;
      &lt;label for="lname"&gt;Last name:&lt;/label&gt;&lt;br&gt;
      &lt;input type="text" id="lname" name="lname" value="Doe"&gt;&lt;br&gt;&lt;br&gt;
      &lt;input type="submit" value="Submit"&gt;
    &lt;/form&gt;
  &lt;/body&gt;
&lt;/html&gt;  
</code></pre>

Save with Ctrl+O, then use Ctrl+X to quit `nano`.

Open a new HTML file with


<pre>
sudo nano /var/www/html/done.html
</pre>


and place the following HTML inside this file:

<pre><code>&lt;!DOCTYPE html&gt;  
&lt;html&gt;  
  &lt;body&gt;
    &lt;h1&gt;Done!&lt;/h1&gt;
  &lt;/body&gt;
&lt;/html&gt;  
</code></pre>

Save with Ctrl+O, then use Ctrl+X to quit `nano`.

Now that everything is prepared on the server. We'll compare HTTP vs. HTTPS access to this web form. 


On the "romeo" host, run

<pre>
sudo tcpdump -i $(ip route get 10.10.2.100 | grep -oP "(?<=dev )[^ ]+") -w security-http-$(hostname -s).pcap
</pre>

to capture traffic on the network segment. This packet capture will show you what is visible to anyone eavesdropping on the network segment.

While this is running, initiate an HTTP session from "romeo" to "server" - on "romeo", run

<pre>
sudo apt install lynx
lynx http://server/form.html
</pre>

Enter your first name and last name in the form fields (you can use Tab or Enter to navigate to the next field), then navigate to the Submit button control and hit Enter to submit your form. You should see a "Done!" message. Then, type `q` to quit and `y` to confirm your choice.


Stop the `tcpdump` with Ctrl+C.


Next, on the "romeo" host, run

<pre>
sudo tcpdump -i $(ip route get 10.10.2.100 | grep -oP "(?<=dev )[^ ]+") -w security-https-$(hostname -s).pcap
</pre>

to capture traffic on the network segment. This packet capture will show you what is visible to anyone eavesdropping on the network segment.


While this is running, initiate an HTTPS connection from "romeo" to "server" - on "romeo", run

<pre>
lynx https://server/form.html
</pre>


You'll be warned that you are trying to access a site with a certificate that is not trusted, since our site has a self-signed certificate. Type `y` to continue. Next, you'll be warned that the name of the server doesn't match the certificate name. Type `y` to continue anyway. Finally, you'll see the same form.


Fill in the form fields (you can use Tab or Enter to navigate to the next field), then navigate to the Submit button control and hit Enter to submit your form. 

Before you get to the "Done!" message, you'll have to confirm _again_ that you want to accept the self-signed certificate (`y`) and that you want to continue even though the server name doesn't match (`y`).

Once you see a "Done!" message, type `q` to quit and `y` to confirm your choice.


Stop the `tcpdump` with Ctrl+C.
<p><br></p>  
<div style="border-color:#47aae1; border-style:solid; padding: 15px;">

<h4 style="color:#47aae1;">FABRIC-specific instructions: transfer files</h4>

<p>If you are running this experiment on FABRIC, you can use the "Exercise: Transfer .pcap files from a FABRIC host" section of the "setup.ipynb" notebook to transfer the .pcap files from the host to the Jupyter environment, then download them on your laptop. </p>

</div>  

## Notes

<ul>
<li>In the packet capture of the `telnet` experiment, can you read: the username and password? IP/TCP headers? Session data? Show evidence. </li>
        
<li>In the packet capture of the SSH experiment, can you read: the username and password? IP/TCP headers? Session data? Show evidence. </li>

<li>In the packet capture of the FTP experiment, can you read: the username and password? IP/TCP headers? The name of the file transferred, and the file contents? Show evidence. </li>

<li>In the packet capture of the SFTP experiment, can you read: the username and password? IP/TCP headers? The name of the file transferred, and the file contents? Show evidence.</li>

<li>In the packet capture of the HTTP experiment, can you read: the IP and TCP headers? The contents of the HTTP GET (including the name of the page you visited, `form.html`)? The data you entered in the form? Show evidence.</li>

<li>In the packet capture of the HTTPS experiment, can you read: the IP and TCP headers? The contents of the HTTP GET (including the name of the page you visited, `form.html`)? The data you entered in the form? Show evidence. </li>
</ul>
