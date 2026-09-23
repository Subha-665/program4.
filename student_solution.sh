#!/bin/bash
# SELinux Access Denial Practical
# Student Name:
# Register Number:
 
echo "~~~~~ SELinux Status ~~~~~"
sestatus
getenforce
echo ""

echo "~~~~~ Creating Web Directory ~~~~~"
mkdir -p /web
echo ""

echo "~~~~~ Creating HTML File ~~~~~"
echo "<html><h1>SELinux Test Page</h1></html>" > /web/index.html
cat /web/index.html
echo ""

echo "~~~~~ Setting Linux Permissions ~~~~~"
chmod -R 755 /web
ls -l /web/
echo ""

echo "~~~~~ Checking Initial Context ~~~~~"
ls -Z /web/
ls -Z /web/index.html
echo ""

echo "~~~~~ Assigning Wrong SELinux Context ~~~~~"
chcon -R -t admin_home_t /web/
echo ""

echo "~~~~~ Checking Wrong Context ~~~~~"
ls -Z /web/
ls -Z /web/index.html
echo ""

echo "~~~~~ Checking AVC Denials ~~~~~"
# Try to access (will be denied)
cat /web/index.html
# Check AVC logs
ausearch -m avc -ts recent | tail -20
# Or: cat /var/log/audit/audit.log | grep avc | tail -20
echo ""

echo "~~~~~ Correcting SELinux Context ~~~~~"
chcon -R -t httpd_sys_content_t /web/
# Alternative correct command: restorecon -Rv /web/
echo ""

echo "~~~~~ Checking Correct Context ~~~~~"
ls -Z /web/
ls -Z /web/index.html
echo ""

echo "~~~~~ Checking AVC Details ~~~~~"
ausearch -m avc -ts recent | tail -20
echo ""

echo "~~~~~ Resetting Context To Default ~~~~~"
restorecon -Rv /web/
ls -Z /web/
echo ""

echo "~~~~~ Practical Completed ~~~~~"
