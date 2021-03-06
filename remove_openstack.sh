#!/usr/bin/bash
# Warning! Dangerous step! Destroys VMs
for x in $(virsh list --all | grep instance- | awk '{print $2}') ; do
        virsh destroy $x ;
        virsh undefine $x ;
done ;

        # Warning! Dangerous step! Removes lots of packages, including many
        # which may be unrelated to RDO.
        yum remove -y nrpe "*nagios*" puppet ntp ntp-perl ntpdate "*openstack*" \
            "*nova*" "*keystone*" "*glance*" "*cinder*" "*swift*" \
            mysql mysql-server httpd "*memcache*" scsi-target-utils \
            iscsi-initiator-utils perl-DBI perl-DBD-MySQL ;

        ps -ef | grep -i repli | grep swift | awk '{print $2}' | xargs kill ;

        # Warning! Dangerous step! Deletes local application data
        rm -rf /etc/nagios /etc/yum.repos.d/packstack_* /root/.my.cnf \
            /var/lib/mysql/ /var/lib/glance /var/lib/nova /etc/nova /etc/swift \
            /srv/node/device*/* /var/lib/cinder/ /etc/rsync.d/frag* \
            /var/cache/swift /var/log/keystone ;

        umount /srv/node/device* ;
        killall -9 dnsmasq tgtd httpd ;
        setenforce 1 ;
        vgremove -f cinder-volumes ;
        losetup -a | sed -e 's/:.*//g' | xargs losetup -d ;
        find /etc/pki/tls -name "ssl_ps*" | xargs rm -rf ;
        for x in $(df | grep "/lib/" | sed -e 's/.* //g') ; do
                umount $x ;
            done
