# Force Jellyfin backdrops for all users
Simple script to change the line in the main.jellyfin.bundle.js file to force backdrops for all users.

This script needs to run in inside the jellyfin container in the web directory
/usr/share/jellyfin/web

As of version 10.10.1, we now need to change enableBackdrops:function(){return R} to enableBackdrops:function(){return E}
