# LAPSalternative

Howto and Deployment manual with illustrations: howto/howto.pdf 
(https://github.com/ThatDarkAngel/LAPSalternative/blob/master/howto/howto.pdf)

As we all know for security reasons we need to rename, enable or disable, set passwords for local windows administrator accounts. There are some alternative ways to achieve this. VBscripts and using LAPS (MS solution).
The first one sucks because storing your local admin password in SYSVOL is a bad idea. (otherwise how you are going to set it?)
So i made simple (currently under development) solution for this reason.
But here is main idea (Make the whole process secure as possible)
1). You deploy it via GPO "Software Installation" (Note: msi package is created using "MsiWrapper") to corresponding OU.
2). It runs and discovers all local admin accounts on corresponding servers/computers. Renames all of them by predefined suffix, enables or disables them, sets secure passwords (randomly generated) for them and sends that credentials/computer names, local admin names to your share. This also can be used in critic situations too. Or vice versa can be used in post exploitation. (offensive/defensive way)

Here is solution that is written in autoit scripting language. (Don't blame me please it just took me 5 mins to code it. It's sample anyways but works without any problems).

Sample output:

---------------------
IP address: 172.16.xx.xy
Computer name: WIN7CLIENT0
Password set for: Administrator5
New password: J%DhKI'.dX^R
Account state set to: no
Current logged in user: SYSTEM
When: 20/05/2018 17:00:49:648
Account renamed: Administrator5 to Administrator512
---------------------
---------------------
IP address: 172.16.xx.xy
Computer name: WIN7CLIENT0
Password set for: Win71212121212121212
New password: $MDU3v:)1+fB
Account state set to: no
Current logged in user: SYSTEM
When: 20/05/2018 17:00:50:193
Account renamed: Win71212121212121212 to Win71212121212121212
---------------------


Tested on: Windows Server 2012 R2, Windows 7.

   config.ini explanation
[Main] 
limit=12 ;#password length
suffix=12 ;# Suffix to add Account name: in ex: Administrator12
state=no ;# Disable account. Set to "yes" to enable otherwise set to "no" to disable accounts.

