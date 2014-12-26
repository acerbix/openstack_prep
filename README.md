openstack_prep
==============

Files/scripts/Instructions to prep a RHEL 7 Server for openstack packstack execution.

This is intended to be used in three ways:
   - General system prep to get the system to a shape that I like, starting from RHEL 7 minimum install
      - Set up cert based login from my mac to the server:
         - cat .ssh/id_rsa.pub | ssh openstack 'cat >> .ssh/authorized_keys'
         - On server: chmod 700 .ssh; chmod 640 .ssh/authorized_keys
      - RHEL Subscription Manager registration [Centos/RDO shouldnt need to do this]
      - Change hostname/dnsdomainname to what I like, using nmtui or hostnamectl
      - Packages I consider basic that the minimal install does not have:
        - net-tools
        - mlocate
        - vim-enhanced and vim-filesystem
        - telnet
        - psmisc
        - bind-utils
        - git
   - Basic vimrc from Amir Salihefendic at https://github.com/amix/vimrc - with minor changes based on my likings
   - Reconfiguration to shut down NetworkManager and use network instead
      - For my machine this needs extra work since the server is on a wifi network
         - Need to modify wpa_supplicant conf files
         - Need to add a service in systemd to set up default route since we are using a static address
         - 
Scripts are meant to be run as root from the cloned directory.   Right now the repo has only files and scripts to move these files around. I'll puppetize this eventually - once I have the end to end process set up to my liking, including packstack installation

