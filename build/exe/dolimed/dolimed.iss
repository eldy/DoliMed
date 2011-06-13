; ----- DoliMed.iss ---------------------------------------------------------------------
; Script to build an auto installer for Dolibarr.
; Works with InnoSetup 5.4.0 (a)
; Idea from WampServer 2 (http://www.wampserver.com)
;----------------------------------------------------------------------------------------
; You must edit some path in this file to build an exe (like SourceDir).
; WARNING: Be sure that user.* files of Mysql database used to build
; package contains only one user called root with no password.
; For this, you can edit the mysql.user table of the source database to keep
; only the root user with no password, stop server and catch
; files user.MY* to put them in the Dolibarr build/exe/doliwamp/mysql directory.
;
; Version: $Id: dolimed.iss,v 1.2 2011/06/11 23:23:37 eldy Exp $
;----------------------------------------------------------------------------------------


[Setup]
; ----- Change this -----
AppName=DoliMed
; DoliWamp-x.x.x or DoliWamp-x.x.x-dev or DoliWamp-x.x.x-beta
AppVerName=DoliMed-3.1.0-alpha
; DoliWamp-x.x x or DoliWamp-x.x.x-dev or DoliWamp-x.x.x-beta
OutputBaseFilename=DoliMed-3.1.0-alpha
; Define full path from wich all relative path are defined
; You must modify this to put here your dolibarr root directory
SourceDir=C:\Work\Data\Workspace\dolibarr
; ----- End of change
;OutputManifestFile=build\doliwampbuild.log
AppId=dolimed
AppPublisher=NLTechno
AppPublisherURL=http://www.nltechno.com
AppSupportURL=http://www.dolibarr.org
AppUpdatesURL=http://www.dolibarr.org
AppComments=DoliMed includes Dolibarr, Apache, PHP and Mysql softwares, and medical module.
AppCopyright=Copyright (C) 2008-2011 Laurent Destailleur, NLTechno
DefaultDirName=c:\dolimed
DefaultGroupName=DoliMed
LicenseFile=COPYING
;Compression=none
Compression=lzma
SolidCompression=yes
WizardImageFile=build\exe\doliwamp\doliwamp.bmp
WizardSmallImageFile=build\exe\doliwamp\doliwampsmall.bmp
SetupIconFile=doc\images\dolibarr.ico
PrivilegesRequired=admin
DisableProgramGroupPage=yes
ChangesEnvironment=no
CreateUninstallRegKey=yes
;UseSetupLdr=no
;UninstallDisplayIcon={app}\bidon
OutputDir=build
ShowLanguageDialog=auto
ShowUndisplayableLanguages=no
;LanguageDetectionMethod=none
LanguageDetectionMethod=uilanguage
;SignedUninstaller=yes

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyEnglish.isl"
Name: "br"; MessagesFile: "compiler:Languages\Portuguese.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyBrazilianPortuguese.isl"
Name: "ca"; MessagesFile: "compiler:Languages\Catalan.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyCatalan.isl"
Name: "da"; MessagesFile: "compiler:Languages\Danish.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyDanish.isl"
Name: "es"; MessagesFile: "compiler:Languages\Spanish.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MySpanish.isl"
Name: "nl"; MessagesFile: "compiler:Languages\Dutch.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyDutch.isl"
Name: "fi"; MessagesFile: "compiler:Languages\Finnish.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyFinnish.isl"
Name: "fr"; MessagesFile: "compiler:Languages\French.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyFrench.isl"
Name: "ge"; MessagesFile: "compiler:Languages\German.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyGerman.isl"
Name: "it"; MessagesFile: "compiler:Languages\Italian.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyItalian.isl"
Name: "nb"; MessagesFile: "compiler:Languages\Norwegian.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyNorwegian.isl"
Name: "po"; MessagesFile: "compiler:Languages\Polish.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyPolish.isl"
Name: "pt"; MessagesFile: "compiler:Languages\Portuguese.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyPortuguese.isl"
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MyRussian.isl"
Name: "sv"; MessagesFile: "compiler:Languages\Slovenian.isl,C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\Languages\MySlovenian.isl"

[Tasks]
;Name: "autostart"; Description: "Automatically launch DoliMed server on startup. If you check this option, Services will be installed as automatic. Otherwise, services will be installed as manual and will start and stop with the service manager."; GroupDescription: "Auto Start:" ;Flags: unchecked;
Name: "quicklaunchicon"; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked
Name: "desktopicon"; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Dirs]
Name: "{app}\logs"
Name: "{app}\tmp"
Name: "{app}\dolibarr_documents"
Name: "{app}\bin\apache\apache2.2.6\logs"

[Files]
; Stop/start
Source: "C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\stopdoliwamp.bat"; DestDir: "{app}\"; Flags: ignoreversion; AfterInstall: close()
Source: "C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\startdoliwamp.bat"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\removefiles.bat"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\rundoliwamp.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\rundolihelp.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\rundoliadmin.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\install_services.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\uninstall_services.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\mysqlinitpassword.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\mysqltestinstall.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\startdoliwamp_manual_donotuse.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\builddemosslfiles.bat.install"; DestDir: "{app}\"; Flags: ignoreversion;
Source: "build\exe\doliwamp\UsedPort.exe"; DestDir: "{app}\"; Flags: ignoreversion;
; PhpMyAdmin, Apache, Php, Mysql
; Put here path of Wampserver applications
; Value OK: apache 2.2.6, php 5.2.5 (5.2.11 fails if php_exif is on), mysql 5.0.45 or 5.1.36
Source: "C:\Work\Applis\Wamp\apps\phpmyadmin3.2.0.1\*.*"; DestDir: "{app}\apps\phpmyadmin3.2.0.1"; Flags: ignoreversion recursesubdirs; Excludes: "config.inc.php,wampserver.conf,*.log,*_log"
Source: "C:\Work\Applis\Wamp\bin\apache\apache2.2.6\*.*"; DestDir: "{app}\bin\apache\apache2.2.6"; Flags: ignoreversion recursesubdirs; Excludes: "php.ini,httpd.conf,wampserver.conf,*.log,*_log"
Source: "C:\Work\Applis\Wamp\bin\php\php5.2.5\*.*"; DestDir: "{app}\bin\php\php5.2.5"; Flags: ignoreversion recursesubdirs; Excludes: "php.ini,phpForApache.ini,wampserver.conf,*.log,*_log"
Source: "C:\Work\Applis\Wamp\bin\mysql\mysql5.0.45\*.*"; DestDir: "{app}\bin\mysql\mysql5.0.45"; Flags: ignoreversion recursesubdirs; Excludes: "my.ini,data\*,wampserver.conf,*.log,*_log,MySQLInstanceConfig.exe"
; Mysql data files (does not overwrite if exists)
Source: "build\exe\doliwamp\mysql\*.*"; DestDir: "{app}\bin\mysql\data\mysql"; Flags: onlyifdoesntexist ignoreversion recursesubdirs; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db"
; Dolibarr
Source: "htdocs\*.*"; DestDir: "{app}\www\dolibarr\htdocs"; Flags: ignoreversion recursesubdirs; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db,custom\*,custom2\*,telephonie\*,*\conf.php,*\conf.php.mysql,*\conf.php.old,*\conf.php.postgres,*\install.forced.php,*\modBookmark4u.class.php,*\modDocument.class.php,*\modDroitPret.class.php,*\modEditeur.class.php,*\modPostnuke.class.php,*\modTelephonie.class.php,*\interface_modEditeur_Editeur.class.php*,*\bureau2crea,*\rodolphe"
Source: "dev\*.*"; DestDir: "{app}\www\dolibarr\dev"; Flags: ignoreversion recursesubdirs; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db,fpdf\*,initdemo\*,iso-normes\*,samples\*,test\*,uml\*,xdebug\*"
Source: "doc\*.*"; DestDir: "{app}\www\dolibarr\doc"; Flags: ignoreversion recursesubdirs; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db,wiki\*,plaquette\*,dev\*"
Source: "scripts\*.*"; DestDir: "{app}\www\dolibarr\scripts"; Flags: ignoreversion recursesubdirs; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db,product\materiel.net.php,product\import-product.php"
Source: "*.*"; DestDir: "{app}\www\dolibarr"; Flags: ignoreversion; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db"
Source: "C:\Work\Data\Workspace\dolibarrmodsf\htdocs\cabinetmed\*.*"; DestDir: "{app}\www\dolibarr\htdocs\cabinetmed"; Flags: ignoreversion recursesubdirs; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db,custom\*,custom2\*,telephonie\*,*\conf.php,*\conf.php.mysql,*\conf.php.old,*\conf.php.postgres,*\install.forced.php,*\modBookmark4u.class.php,*\modDocument.class.php,*\modDroitPret.class.php,*\modEditeur.class.php,*\modPostnuke.class.php,*\modTelephonie.class.php,*\interface_modEditeur_Editeur.class.php*,*\bureau2crea,*\rodolphe"
Source: "C:\Work\Data\Workspace\dolibarrmodsf\htdocs\includes\modules\modCabinetMed.class.php"; DestDir: "{app}\www\dolibarr\htdocs\includes\modules"; Flags: ignoreversion; Excludes: ".cvsignore,.project,CVS\*,Thumbs.db,custom\*,custom2\*,telephonie\*,*\conf.php,*\conf.php.mysql,*\conf.php.old,*\conf.php.postgres,*\install.forced.php,*\modBookmark4u.class.php,*\modDocument.class.php,*\modDroitPret.class.php,*\modEditeur.class.php,*\modPostnuke.class.php,*\modTelephonie.class.php,*\interface_modEditeur_Editeur.class.php*,*\bureau2crea,*\rodolphe"
; Config files
Source: "build\exe\doliwamp\phpmyadmin.conf.install"; DestDir: "{app}\alias"; Flags: ignoreversion;
Source: "build\exe\doliwamp\dolibarr.conf.install"; DestDir: "{app}\alias"; Flags: ignoreversion;
Source: "build\exe\doliwamp\config.inc.php.install"; DestDir: "{app}\apps\phpmyadmin3.2.0.1"; Flags: ignoreversion;
Source: "build\exe\doliwamp\httpd.conf.install"; DestDir: "{app}\bin\apache\apache2.2.6\conf"; Flags: ignoreversion;
Source: "build\exe\doliwamp\my.ini.install"; DestDir: "{app}\bin\mysql\mysql5.0.45"; Flags: ignoreversion;
Source: "build\exe\doliwamp\php.ini.install"; DestDir: "{app}\bin\php\php5.2.5"; Flags: ignoreversion;
Source: "build\exe\doliwamp\index.php.install"; DestDir: "{app}\www"; Flags: ignoreversion;
Source: "C:\Work\Data\Workspace\dolibarrmodsf\build\exe\dolimed\install.forced.php.install"; DestDir: "{app}\www\dolibarr\htdocs\install"; Flags: ignoreversion;
Source: "build\exe\doliwamp\openssl.conf"; DestDir: "{app}"; Flags: ignoreversion;
Source: "build\exe\doliwamp\ca_demo_dolibarr.crt"; DestDir: "{app}"; Flags: ignoreversion;
Source: "build\exe\doliwamp\ca_demo_dolibarr.key"; DestDir: "{app}"; Flags: ignoreversion;
; Licence
Source: "COPYRIGHT"; DestDir: "{app}"; Flags: ignoreversion;



[Icons]
Name: "{group}\DoliMed"; Filename: "{app}\rundoliwamp.bat"; WorkingDir: "{app}"; IconFilename: {app}\www\dolibarr\doc\images\dolibarr.ico
Name: "{group}\Tools\Help center"; Filename: "{app}\rundolihelp.bat"; WorkingDir: "{app}"; IconFilename: {app}\www\dolibarr\doc\images\dolihelp.ico
Name: "{group}\Tools\Start DoliMed server"; Filename: "{app}\startdoliwamp.bat"; WorkingDir: "{app}"; IconFilename: {app}\www\dolibarr\doc\images\doliwampon.ico
Name: "{group}\Tools\Stop DoliMed server"; Filename: "{app}\stopdoliwamp.bat"; WorkingDir: "{app}"; IconFilename: {app}\www\dolibarr\doc\images\doliwampoff.ico
Name: "{group}\Tools\Admin DoliMedp server"; Filename: "{app}\rundoliadmin.bat"; WorkingDir: "{app}"; IconFilename: {app}\www\dolibarr\doc\images\doliadmin.ico
Name: "{group}\Tools\Uninstall DoliMed"; Filename: "{app}\unins000.exe"; WorkingDir: "{app}"; IconFilename: {app}\uninstall_services.bat
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Dolibarr"; WorkingDir: "{app}"; Filename: "{app}\rundoliwamp.bat"; Tasks: quicklaunchicon; IconFilename: {app}\www\dolibarr\doc\images\dolibarr.ico
Name: "{userdesktop}\DoliMed"; Filename: "{app}\rundoliwamp.bat"; WorkingDir: "{app}"; Tasks: desktopicon; IconFilename: {app}\www\dolibarr\doc\images\dolibarr.ico
Name: "{userdesktop}\Dolibarr Help center"; Filename: "{app}\rundolihelp.bat"; WorkingDir: "{app}"; Tasks: desktopicon; IconFilename: {app}\www\dolibarr\doc\images\dolihelp.ico
;Start of servers fromstartup menu disabled as services are auto
;Name: "{userstartup}\DoliMed server"; Filename: "{app}\startdoliwamp.bat"; WorkingDir: "{app}"; Flags: runminimized; IconFilename: {app}\www\dolibarr\doc\images\dolibarr.ico


[Code]

//variables globales
var phpVersion: String;
var apacheVersion: String;
var path: String;
var pfPath: String;
var winPath: String;
var pathWithSlashes: String;
var Page: TInputQueryWizardPage;

var smtpServer: String;
var apachePort: String;
var mysqlPort: String;
var newPassword: String;

var lockFile: String;
var srcFile: String;
var destFile: String;
var srcFileH: String;
var destFileH: String;
var srcFileA: String;
var destFileA: String;
var srcContents: String;
var browser: String;
var mysqlVersion: String;
var phpmyadminVersion: String;
var phpDllCopy: String;
var batFile: String;

var mysmtp: String;
var myporta: String;
var myportas: String;
var myport: String;
var mypass: String;

var firstinstall: Boolean;
var value: String;


//-----------------------------------------------
//procedures lancees au debut de l'installation
function InitializeSetup(): Boolean;
begin
  Result := MsgBox(CustomMessage('YouWillInstallDoliWamp')+#13#13+CustomMessage('ThisAssistantInstallOrUpgrade')+#13#13+CustomMessage('IfYouHaveTechnicalKnowledge')+#13#13+CustomMessage('ButIfYouLook')+#13#13+CustomMessage('DoYouWantToStart'), mbConfirmation, MB_YESNO) = IDYES;
end;

procedure InitializeWizard();
begin
  //version des applis, a modifier pour chaque version de WampServer 2
  apacheVersion := '2.2.6';
  phpVersion := '5.2.5' ;
  mysqlVersion := '5.0.45';
  phpmyadminVersion := '3.2.0.1';

  smtpServer := 'localhost';
  apachePort := '80';
  mysqlPort := '3306';
  newPassword := 'changeme';

  firstinstall := true;


  //LoadStringFromFile (srcFile, srcContents);
  //posvalue=Pos('$dolibarr_main_db_port=', srcFile);

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','smtpServer', value) then
  begin
      if value <> '' then smtpServer:=value;
  end
  else
  begin
    if RegQueryStringValue(HKEY_CURRENT_USER, 'Software\Microsoft\Internet Account Manager\Accounts\00000001','SMTP Server', value) then
    begin
      if value <> '' then smtpServer:=value;
    end
    else
    begin
      if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'PMail\ServiceInfo\Mail_Account_1','SvcSMTPHost', value) then
      begin
        if value <> '' then smtpServer:=value;
      end
      else
      begin
        if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\MSCRM','SMTPServer', value) then
        begin
          if value <> '' then smtpServer:=value;
        end
      end
    end
  end;

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','apachePort', value) then
  begin
      if value <> '' then apachePort:=value;
  end;

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','mysqlPort', value) then
  begin
      if value <> '' then mysqlPort:=value;
  end;

  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','newPassword', value) then
  begin
      if value <> '' then newPassword:=value;
  end;


  // Prepare an object calle "Page" of type wpInstalling.
  // Object will be show later in NextButtonClick function.
  Page := CreateInputQueryPage(wpInstalling,
  CustomMessage('TechnicalParameters'), '',
  CustomMessage('IfFirstInstall'));

  // TODO Add control differently if first install or update
  if firstinstall
  then
  begin
    Page.Add(CustomMessage('SMTPServer'), False);
    Page.Add(CustomMessage('ApachePort'), False);
    Page.Add(CustomMessage('MySqlPort'), False);
    Page.Add(CustomMessage('MySqlPassword'), False);
  end
  else
  begin
    Page.Add(CustomMessage('SMTPServer'), False);
    Page.Add(CustomMessage('ApachePort'), False);
    Page.Add(CustomMessage('MySqlPort'), False);
    Page.Add(CustomMessage('MySqlPassword'), False);
  end;
  
  // Default values
  Page.Values[0] := smtpServer;
  Page.Values[1] := apachePort;
  Page.Values[2] := mysqlPort;
  Page.Values[3] := newPassword;

end;


//-----------------------------------------------
// Stop all services (if exist)
procedure close();
var myResult: Integer;
begin
path := ExpandConstant('{app}');
pfPath := ExpandConstant('{pf}');
winPath := ExpandConstant('{win}');
pathWithSlashes := path;
StringChange (pathWithSlashes, '\','/');

batFile := path+'\stopdoliwamp.bat';
Exec(batFile, '',path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
end;




//-----------------------------------------------------------
// Install pages
function NextButtonClick(CurPageID: Integer): Boolean;
var myResult: Integer;
var res: Boolean;
var paramok: Boolean;
var datadirold: String;
var datadirnew: String;
var exedirold: String;
var exedirnew: String;
var themessage: String;
begin

   res := True;
   
  //MsgBox(''+CurPageID,mbConfirmation,MB_YESNO);

  if CurPageID = Page.ID then
  begin

    // This must be in if curpage.id = page.id, otherwise it is executed after each Next button

    path := ExpandConstant('{app}');
    winPath := ExpandConstant('{win}');
    pathWithSlashes := path;
    StringChange (pathWithSlashes, '\','/');
    datadirold := pathWithSlashes+'/bin/mysql/mysql5.0.45/data';
    datadirnew := pathWithSlashes+'/bin/mysql/data';
    exedirold := pathWithSlashes+'/bin/mysql/mysql5.0.45';
    exedirnew := pathWithSlashes+'/bin/mysql/mysql5.0.45';

    // If we have a new database version, we should only copy old my.ini file into new directory
    // and change only all basedir= strings to use new version. Like this, data dir is still correct.
    // Install of service and stop/start scripts are already rebuild by installer.
//      FileCopy(exedirold+'/my.ini',exedirnew+'/my.ini', true);

//    We should not need this, also databases may not be called dolibarr
//      res := RenameFile(ibdata1dirold+'/dolibarr',ibdata1dirnew+'/dolibarr');
//      if res then
//      begin
//          themessage := CustomMessage('OldVersionFoundAndMoveInNew');
//          MsgBox(themessage,mbInformation,MB_OK);
//          TODO Replace also mysql.ini and resintall service
//      end
//      else
//      begin
//          themessage := CustomMessage('OldVersionFoundButFailedToMoveInNew');
//          MsgBox(themessage,mbInformation,MB_OK);
//      end;


    //----------------------------------------------
    // Copie des dll de php vers apache
    //----------------------------------------------
	// TODO Update this list when changing PHP/Apache versions
	
    phpDllCopy := 'fdftk.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'fribidi.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'gds32.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'libeay32.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'libmhash.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'libmysql.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'libpq.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'msql.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'libmcrypt.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'libmysqli.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'ntwdblib.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);

    phpDllCopy := 'php5activescript.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'php5isapi.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'php5nsapi.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'php5ts.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);

    phpDllCopy := 'ssleay32.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);
    phpDllCopy := 'yaz.dll';
    filecopy (pathWithSlashes+'/bin/php/php'+phpVersion+'/'+phpDllCopy, pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/'+phpDllCopy, False);


    // Remove lock file
    lockfile := pathWithSlashes+'/www/dolibarr/install.lock';
    if FileExists (lockfile) and not DeleteFile(lockfile) then
    begin
      themessage := FmtMessage(CustomMessage('FailedToDeleteLock'),[pathWithSlashes]);
 		  MsgBox(themessage,mbInformation,MB_OK);
    end


		// Check if parameters already defined in conf.php file
		srcFile := pathWithSlashes+'/www/dolibarr/htdocs/conf/conf.php';
		if not FileExists (srcFile) then
		begin
		    firstinstall := true;
		
		    // Values from wizard
		    mysmtp  := Page.Values[0];
		    myporta := Page.Values[1];
		    myportas:= '443';
		    myport  := Page.Values[2];
		    mypass  := Page.Values[3];
		end
		else
		begin
		    firstinstall := false;
		
		    // Values from registry
		    mysmtp  := smtpServer;
		    myporta := apachePort;
		    myportas:= '443';
		    myport  := mysqlPort;
		    mypass  := newPassword;
		end;
		
		paramok := True;
		// TODO Test if choice of param is ok if firstinstall

    if (firstinstall) then
    begin
    
		  // Test serveur SMTP
//      if paramok then
//      begin
//    		batFile := pathWithSlashes+'/UsedPort.exe';
//    		MsgBox('batFile = '+batFile,mbConfirmation,MB_YESNO)
//  	    Exec(batFile, '-s '+smtpServer+' -p 25', path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
        //themessage := 'Le serveur '+smtpServer+' semble ne pas etre joignable pour l envoi de mail SMTP (port 25). Si vous avez un firewall, verifiez sa configuration. Sinon, revenez en arriere pour choisir une autre valeur pour le serveur SMTP sortant d envoi de mail (Cette information est doit etre fournie par votre fournisseur d acces Internet).';
//        themessage := 'The server '+smtpServer+' seems to be unreachable to send outgoing SMTP emails (port 25). If you have a firewall, check its setup. Otherwise, go back to choose another value for the SMTP server (This information shoud be given by your Internet Service Provider) or click "No" to ignore error. Cancel choice to choose another value ?';
//  		  if ((IntToStr(myResult) <> '0') and (MsgBox(themessage,mbConfirmation,MB_YESNO) = IDYES)) then
//        begin
//  		    paramok := False;
//  		  end;
//	    end;
	
      if paramok then
      begin
  		  // Test port Apache
    		batFile := pathWithSlashes+'/UsedPort.exe';
    		//MsgBox('batFile = '+batFile,mbConfirmation,MB_YESNO)
    		Exec(batFile, '-s localhost -p '+myporta, path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
        //themessage := 'Le port '+myporta+' semble deja pris. Revenez en arriere pour choisir une autre valeur pour le port Apache.';
        themessage := FmtMessage(CustomMessage('PortAlreadyInUse'),[myporta,'Apache']);
    		if ((IntToStr(myResult) = '0') and (MsgBox(themessage,mbConfirmation,MB_YESNO) = IDYES)) then
        begin
    		  paramok := False;
    		end;
      end;
      
      if paramok then
      begin
    		// Test port Mysql
    		batFile := pathWithSlashes+'/UsedPort.exe';
    		//MsgBox('batFile = '+batFile,mbConfirmation,MB_YESNO)
    		Exec(batFile, '-s localhost -p '+myport, path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
        //themessage := 'Le port '+myport+' semble deja pris. Revenez en arriere pour choisir une autre valeur pour le port MySQL.';
        themessage := FmtMessage(CustomMessage('PortAlreadyInUse'),[myport,'MySql']);
    		if ((IntToStr(myResult) = '0') and (MsgBox(themessage,mbConfirmation,MB_YESNO) = IDYES)) then
    		begin
      		paramok := False;
    		end;
      end;
      
    end;
		
		if paramok
		then
		begin
		    
	    //----------------------------------------------
	    // Rename file c:/windows/php.ini (we don't want it)
	    //----------------------------------------------
		
	    if FileExists ('c:/windows/php.ini') then
	    begin
	      if MsgBox('A previous c:/windows/php.ini file has been detected in your Windows directory. Do you want DoliMed to rename it to php_old.ini to avoid conflicts ?',mbConfirmation,MB_YESNO) = IDYES then
	      begin
	        RenameFile('c:/windows/php.ini','c:/windows/php_old.ini');
	      end;
	    end;
	    if FileExists ('c:/winnt/php.ini') then
	    begin
	      if MsgBox('A previous c:/winnt/php.ini file has been detected in your Windows directory. Do you want DoliMed to rename it to php_old.ini to avoid conflicts ?',mbConfirmation,MB_YESNO) = IDYES then
	      begin
	        RenameFile('c:/winnt/php.ini','c:/winnt/php_old.ini');
	      end;
	    end;
		
		
		
	    //----------------------------------------------
	    // Create rundoliwamp.bat, rundolihelp.bat and rundoliadmin.bat (if not exists)
	    //----------------------------------------------
	
	    destFile := pathWithSlashes+'/rundoliwamp.bat';
	    srcFile := pathWithSlashes+'/rundoliwamp.bat.install';
	
	    destFileH := pathWithSlashes+'/rundolihelp.bat';
	    srcFileH := pathWithSlashes+'/rundolihelp.bat.install';
	
	    destFileA := pathWithSlashes+'/rundoliadmin.bat';
	    srcFileA := pathWithSlashes+'/rundoliadmin.bat.install';
	
	    if (not FileExists (destFile) or not FileExists (destFileH) or not FileExists (destFileA))
	     and (FileExists(srcFile) and FileExists(srcFileH) and FileExists(srcFileA)) then
	    begin
	      //navigateur
	      browser := 'iexplore.exe';
	      if FileExists (pfPath+'/Mozilla Firefox/firefox.exe')  then
	      begin
	        if MsgBox(CustomMessage('FirefoxDetected'),mbConfirmation,MB_YESNO) = IDYES then
	        begin
	          browser := pfPath+'/Mozilla Firefox/firefox.exe';
	        end;
	      end;
	      if browser = 'iexplore.exe' then
	      begin
	        GetOpenFileName(CustomMessage('ChooseDefaultBrowser'), browser, winPath,'exe files (*.exe)|*.exe|All files (*.*)|*.*' ,'exe');
	      end;
	
	      LoadStringFromFile (srcFile, srcContents);
	      StringChangeEx (srcContents, 'WAMPBROWSER', browser, True);
	      StringChangeEx (srcContents, 'WAMPAPACHEPORT', myporta, True);
	      StringChangeEx (srcContents, 'WAMPAPACHEPSSL', myportas, True);
	      SaveStringToFile(destFile,srcContents, False);
	
	      LoadStringFromFile (srcFileH, srcContents);
	      StringChangeEx (srcContents, 'WAMPBROWSER', browser, True);
	      StringChangeEx (srcContents, 'WAMPAPACHEPORT', myporta, True);
	      StringChangeEx (srcContents, 'WAMPAPACHEPSSL', myportas, True);
	      SaveStringToFile(destFileH,srcContents, False);
	
	      LoadStringFromFile (srcFileA, srcContents);
	      StringChangeEx (srcContents, 'WAMPBROWSER', browser, True);
	      StringChangeEx (srcContents, 'WAMPAPACHEPORT', myporta, True);
	      StringChangeEx (srcContents, 'WAMPAPACHEPSSL', myportas, True);
	      SaveStringToFile(destFileA,srcContents, False);
	    end


      if MsgBox(CustomMessage('DoliWampWillStartApacheMysql'),mbConfirmation,MB_YESNO) = IDYES then
      begin

		
		    //----------------------------------------------
		    // Create file alias phpmyadmin (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/alias/phpmyadmin.conf';
		    srcFile := pathWithSlashes+'/alias/phpmyadmin.conf.install';
		
		    if FileExists(srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //installDir et version de phpmyadmin
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPPHPMYADMINVERSION', phpmyadminVersion, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		    DeleteFile(srcFile);
		
		
		
		    //----------------------------------------------
		    // Create file alias dolibarr (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/alias/dolibarr.conf';
		    srcFile := pathWithSlashes+'/alias/dolibarr.conf.install';
		
		    if not FileExists (destFile) and FileExists(srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLNEWPASSWORD', mypass, True);
		
		      SaveStringToFile(destFile, srcContents, False);
		    end
		    DeleteFile(srcFile);
		
		
		
		
		    //----------------------------------------------
		    // Create file configuration for phpmyadmin (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/apps/phpmyadmin'+phpmyadminVersion+'/config.inc.php';
		    srcFile := pathWithSlashes+'/apps/phpmyadmin'+phpmyadminVersion+'/config.inc.php.install';
		
		    if not FileExists (destFile) and FileExists (srcFile) then
		    begin
	        // sinon on prends le fichier par defaut
	        LoadStringFromFile (srcFile, srcContents);
	        StringChangeEx (srcContents, 'WAMPMYSQLNEWPASSWORD', mypass, True);
	        StringChangeEx (srcContents, 'WAMPMYSQLPORT', myport, True);
	        SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		    //----------------------------------------------
		    // Create file httpd.conf (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/conf/httpd.conf';
		    srcFile := pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/conf/httpd.conf.install';
		
		    if not FileExists (destFile) and FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //installDir et version de php
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPPHPVERSION', phpVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEPORT', myporta, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEPSSL', myportas, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		
		    //----------------------------------------------
		    // Create file my.ini (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/bin/mysql/mysql'+mysqlVersion+'/my.ini';
		    srcFile := pathWithSlashes+'/bin/mysql/mysql'+mysqlVersion+'/my.ini.install';
		
		    if not FileExists (destFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //installDir et version de php
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLPORT', myport, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		
		    //----------------------------------------------
		    // Create file index.php (always but archive if exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/www/index.php';
		    srcFile := pathWithSlashes+'/www/index.php.install';
		
		    if not FileExists (destFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		      StringChangeEx (srcContents, 'WAMPPHPVERSION', phpVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEPORT', myporta, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEPSSL', myportas, True);
		      SaveStringToFile(destFile, srcContents, False);
		    end
		    else
		    begin
		      RenameFile(destFile, destFile+'.old');
		      LoadStringFromFile (srcFile, srcContents);
		      StringChangeEx (srcContents, 'WAMPPHPVERSION', phpVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEPORT', myporta, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEPSSL', myportas, True);
		      SaveStringToFile(destFile, srcContents, False);
		    end
		
		
		
		
		
		    //----------------------------------------------
		    // Create file dolibarr parametres predefinis install web (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/www/dolibarr/htdocs/install/install.forced.php';
		    srcFile := pathWithSlashes+'/www/dolibarr/htdocs/install/install.forced.php.install';
		
		    if not FileExists (destFile) and FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLPORT', myport, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLNEWPASSWORD', mypass, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		    //----------------------------------------------
		    // Create file install_services.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/install_services.bat';
		    srcFile := pathWithSlashes+'/install_services.bat.install';
		
		    if FileExists(srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		    //----------------------------------------------
		    // Create file install_services_auto.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/install_services_auto.bat';
		    srcFile := pathWithSlashes+'/install_services_auto.bat.install';
		
		    if FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		
		    //----------------------------------------------
		    // Create file uninstall_services.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/uninstall_services.bat';
		    srcFile := pathWithSlashes+'/uninstall_services.bat.install';
		
		    if FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
		    //----------------------------------------------
		    // Create file mysqlinitpassword.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/mysqlinitpassword.bat';
		    srcFile := pathWithSlashes+'/mysqlinitpassword.bat.install';
		
		    if FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLPORT', myport, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLNEWPASSWORD', mypass, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		    //----------------------------------------------
		    // Create file mysqltestinstall.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/mysqltestinstall.bat';
		    srcFile := pathWithSlashes+'/mysqltestinstall.bat.install';
		
		    if FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLPORT', myport, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		    //----------------------------------------------
		    // Create file startdoliwamp_manual_donotuse.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/startdoliwamp_manual_donotuse.bat';
		    srcFile := pathWithSlashes+'/startdoliwamp_manual_donotuse.bat.install';
		
		    if FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLVERSION', mysqlVersion, True);
		      StringChangeEx (srcContents, 'WAMPMYSQLPORT', myport, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end
		    
		
		    //----------------------------------------------
		    // Create file builddemosslfiles.bat (always)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/builddemosslfiles.bat';
		    srcFile := pathWithSlashes+'/builddemosslfiles.bat.install';
		
		    if FileExists (srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		
		      //version de apache et mysql
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPAPACHEVERSION', apacheVersion, True);
		
		      SaveStringToFile(destFile,srcContents, False);
		    end

		
		    //----------------------------------------------
		    // Create file php.ini in php (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/bin/php/php'+phpVersion+'/php.ini';
		    srcFile := pathWithSlashes+'/bin/php/php'+phpVersion+'/php.ini.install';
		
		    if not FileExists (destFile) and FileExists(srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPSMTP', mysmtp, True);
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		    //----------------------------------------------
		    // Create file php.ini in apache (if not exists)
		    //----------------------------------------------
		
		    destFile := pathWithSlashes+'/bin/apache/apache'+apacheVersion+'/bin/php.ini';
		    srcFile := pathWithSlashes+'/bin/php/php'+phpVersion+'/php.ini.install';
		
		    if not FileExists (destFile) and FileExists(srcFile) then
		    begin
		      LoadStringFromFile (srcFile, srcContents);
		      StringChangeEx (srcContents, 'WAMPROOT', pathWithSlashes, True);
		      StringChangeEx (srcContents, 'WAMPSMTP', mysmtp, True);
		      SaveStringToFile(destFile,srcContents, False);
		    end
		
		
		
	   		// Uninstall and Install services
		  	batFile := path+'\uninstall_services.bat';
        Exec(batFile, '',path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
  			batFile := path+'\install_services.bat';
  			Exec(batFile, '',path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
			
  			// Start services
        batFile := path+'\startdoliwamp.bat';
        Exec(batFile, '',path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
        //MsgBox(myResult,mbInformation,MB_OK);
			
        // Change mysql password (works only if not yet defined)
        batFile := path+'\mysqlinitpassword.bat';
        Exec(batFile, '',path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);
			
        // Remove dangerous files
        batFile := path+'\removefiles.bat';
        Exec(batFile, '',path+'\', SW_HIDE, ewWaitUntilTerminated, myResult);

			
		    // Save parameters to registry
		    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed', 'smtpServer',  mysmtp);
		    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed', 'apachePort',  myporta);
		    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed', 'apachePSSL',  myportas);
		    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed', 'mysqlPort',   myport);
		    RegWriteStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed', 'newPassword', mypass);
		
		
        res := True;
		
		  end
		  else
		  begin
		  
//	  	MsgBox('Apache and Mysql installation has been canceled. Please select parameters to start their installation.',mbInformation,MB_OK)

      	res := False;
		  	
		  end
      
    end
    else
    begin
    
        //MsgBox('Selected values seems to be already used. Please choose other values.',mbInformation,MB_OK);
		  	
		  	res := False;

    end
    
  end


  Result := res;
end;





//-----------------------------------------------
//procedure launched by the end of the installation, it deletes the installation files
procedure DeinitializeSetup();
begin
//  DeleteFile(path+'\install_services.bat');
//  DeleteFile(path+'\install_services_auto.bat');
end;


//-----------------------------------------------
//procedure launched at beginning of the uninstallation
function InitializeUninstall(): Boolean;
begin
    Result := RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','smtpServer');
    Result := RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','apachePort');
    Result := RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','mysqlPort');
    Result := RegDeleteValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed','newPassword');
    Result := RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\NLTechno\DoliMed');

    Result := True;
end;

//-----------------------------------------------
//procedure launched by the end of the uninstallation
procedure DeinitializeUninstall();
begin
  path := ExpandConstant('{app}');
  winPath := ExpandConstant('{win}');
  pathWithSlashes := path;
  StringChange (pathWithSlashes, '\','/');

  MsgBox(FmtMessage(CustomMessage('ProgramHasBeenRemoved'),[path]),mbInformation,MB_OK);
end;


[Run]
; Launch Dolibarr in browser. This is run after Wizard because of postinstall flag
Filename: "{app}\rundoliwamp.bat"; Description: {cm:LaunchNow}; Flags: shellexec postinstall skipifsilent runhidden


[UninstallDelete]
Type: files; Name: "{app}\*.*"
Type: files; Name: "{app}\bin\mysql\mysql5.0.45\*.*"
Type: filesandordirs; Name: "{app}\alias"
Type: filesandordirs; Name: "{app}\apps"
Type: filesandordirs; Name: "{app}\bin\apache"
Type: filesandordirs; Name: "{app}\bin\php"
Type: filesandordirs; Name: "{app}\help"
Type: filesandordirs; Name: "{app}\lang"
Type: filesandordirs; Name: "{app}\logs"
Type: filesandordirs; Name: "{app}\scripts"
Type: filesandordirs; Name: "{app}\tmp"
Type: filesandordirs; Name: "{app}\www\dolibarr"


[UninstallRun]
Filename: "{app}\uninstall_services.bat"; Flags: runhidden


