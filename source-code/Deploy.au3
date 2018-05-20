#NoTrayIcon

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=passwordgenerator.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <array.au3>
#include "LocalAccount.au3"

if not @Compiled then Exit


;Prerequisite: Create CNAME that points to loldc
$configfile='\\loldc\securestorage\config.ini'
$storage='\\loldc\securestorage\'

$limit=IniRead($configfile,'Main','limit',"Default Value");
$suffix=IniRead($configfile,'Main','suffix',"Default Value");
$state=IniRead($configfile,'Main','state',"Default Value");

$localadmins=_GroupEnumMembers('Administrators',@ComputerName)
$currentinstance=Random(1,9999999,1);

Global $password, $securepassword, $validadmins, $logchanges
#cs
$limit=12;//password length
$suffix='2';//suffix Administrator15
$state='no'
#ce

#cs

https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements

#ce



for $i=0 to UBound($localadmins)-1

if(_AccountExists($localadmins[$i],@ComputerName)=1) Then

$newpassword=securepassword();

Run(@ComSpec & ' /c net user ' & $localadmins[$i] & ' "' & $securepassword & '"' & ' ' & '/active:'& $state,@ScriptDir,@SW_HIDE)

$logchanges&='---------------------' & @CRLF & _
'IP address: ' & @IPAddress1 & @CRLF & _
'Computer name: ' & @ComputerName  & @CRLF & _
'Password set for: ' & $localadmins[$i] & @CRLF & _
"New password: " & $newpassword  & @CRLF & _
'Account state set to: ' & $state  & @CRLF & _
'Current logged in user: ' & @UserName & @CRLF & _
'When: ' & @MDAY & '/' & @MON & '/' & @YEAR & ' ' & @HOUR & ':' & @MIN & ':' & @SEC & ':' & @MSEC & @CRLF;


$newname=$localadmins[$i]&$suffix;
if(StringLen($newname)>20) Then $newname=StringMid($newname,1,20);//truncate
_AccountRename($localadmins[$i],$newname,@ComputerName);


$logchanges&='Account renamed: ' & $localadmins[$i] & ' to ' & $newname& @CRLF & '---------------------' & @CRLF;

EndIf



Next

FileWrite($storage & "\" & @IPAddress1 & '_' & $currentinstance &  '_.txt',$logchanges);



Func securepassword()
$securepassword=Null

for $i=33 to 120

$password&=Chr($i)
Next


Do

for $x=0 to StringLen($password)

$securepassword&=StringMid($password,Random(1,StringLen($password),1),1);

if(StringLen($securepassword)=$limit) then

return $securepassword;
	ExitLoop

EndIf

Next

Until True

EndFunc

