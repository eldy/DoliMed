<?php
/* Copyright (C) 2007 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copyright (C) 2010 	   Jean-François FERRY <jfefe@aternatik.fr>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/**
 *   	\file       admin/ovhsms_setup.php
 *		\ingroup    ovhsms
 *		\brief      Configuration du module ovhsms
 *		\version    $Id: ovh_setup.php,v 1.1 2010/12/04 01:32:57 eldy Exp $
 *		\author		Put author name here
 *		\remarks	Put here some comments
 */

define('NOCSRFCHECK',1);

$res=@include("../../main.inc.php");
if (! $res) include("../../../../dolibarr/htdocs/main.inc.php");    // Used on dev env only

require_once(DOL_DOCUMENT_ROOT."/lib/admin.lib.php");
require_once(DOL_DOCUMENT_ROOT."/ovh/class/ovhsms.class.php");

// Load traductions files requiredby by page
$langs->load("companies");
$langs->load("ovh");

if (!$user->admin)
	accessforbidden();
// Get parameters


// Protection if external user
if ($user->societe_id > 0)
{
	//accessforbidden();
}





if ($_POST["action"] == 'setvalue' && $user->admin)
{
   //$result=dolibarr_set_const($db, "PAYBOX_IBS_DEVISE",$_POST["PAYBOX_IBS_DEVISE"],'chaine',0,'',$conf->entity);
   $result=dolibarr_set_const($db, "OVHSMS_NICK",$_POST["OVHSMS_NICK"],'chaine',0,'',$conf->entity);
   $result=dolibarr_set_const($db, "OVHSMS_PASS",$_POST["OVHSMS_PASS"],'chaine',0,'',$conf->entity);
   $result=dolibarr_set_const($db, "OVHSMS_SOAPURL",$_POST["OVHSMS_SOAPURL"],'chaine',0,'',$conf->entity);


   if ($result >= 0)
   {
      $mesg='<div class="ok">'.$langs->trans("SetupSaved").'</div>';
   }
   else
   {
      dol_print_error($db);
   }
}



if ($_POST["action"] == 'setvalue_account' && $user->admin)
{
   $result=dolibarr_set_const($db, "OVHSMS_ACCOUNT",$_POST["OVHSMS_ACCOUNT"],'chaine',0,'',$conf->entity);

   if ($result >= 0)
   {
      $mesg='<div class="ok">'.$langs->trans("SetupSaved").'</div>';
   }
   else
   {
      dol_print_error($db);
   }
}





/***************************************************
* PAGE
*
* Put here all code to build page
****************************************************/


llxHeader('OvhSmsSetup','','');

$linkback='<a href="'.DOL_URL_ROOT.'/admin/modules.php">'.$langs->trans("BackToModuleList").'</a>';

print_fiche_titre($langs->trans("OvhSmsSetup"),$linkback,'setup');

print '<form method="post" action="'.$_SERVER["PHP_SELF"].'">';
print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
print '<input type="hidden" name="action" value="setvalue">';

$var=true;

print '<table class="nobordernopadding" width="100%">';
print '<tr class="liste_titre">';
print '<td>'.$langs->trans("Parameter").'</td>';
print '<td>'.$langs->trans("Value").'</td>';
print "</tr>\n";


$var=!$var;
print '<tr '.$bc[$var].'><td>';
print $langs->trans("OvhSmsNick").'</td><td>';
print '<input size="64" type="text" name="OVHSMS_NICK" value="'.$conf->global->OVHSMS_NICK.'">';
print '<br>'.$langs->trans("Example").': AA123-OVH';
print '</td></tr>';


$var=!$var;
print '<tr '.$bc[$var].'><td>';
print $langs->trans("OvhSmsPass").'</td><td>';
print '<input size="64" type="password" name="OVHSMS_PASS" value="'.$conf->global->OVHSMS_PASS.'">';
print '</td></tr>';

$var=!$var;
print '<tr '.$bc[$var].'><td>';
print $langs->trans("OvhSmsSoapUrl").'</td><td>';
print '<input size="64" type="text" name="OVHSMS_SOAPURL" value="'.$conf->global->OVHSMS_SOAPURL.'">';
print '<br>'.$langs->trans("Example").': https://www.ovh.com/soapi/soapi-re-1.8.wsdl';
print '</td></tr>';

print '<tr><td colspan="2" align="center"><input type="submit" class="button" value="'.$langs->trans("Modify").'"></td></tr>';
print '</table></form>';

require_once(NUSOAP_PATH.'/nusoap.php');     // Include SOAP

$WS_DOL_URL = $dolibarr_main_url_root.'/webservices/server.php';
$WS_METHOD  = 'getVersions';

// Set the parameters to send to the WebService
$parameters = array("param1"=>"value1");

$WS_DOL_URL = $conf->global->OVHSMS_SOAPURL;
// Set the WebService URL
dol_syslog("Create nusoap_client for URL=".$WS_DOL_URL, LOG_DEBUG);

try {
   $soap = new soapclient($WS_DOL_URL);

   //login
   $session = $soap->login($conf->global->OVHSMS_NICK, $conf->global->OVHSMS_PASS,"fr", false);
   print $langs->trans("OvhSmsLoginSuccessFull");

   print '<br /><a class="action" href="ovhsms_recap.php">Liste des comptes sur le NICK HANDLE</a>';

   // Formulaire d'ajout de compte SMS qui sera valable pour tout dolibarr
   print '<form method="post" action="'.$_SERVER["PHP_SELF"].'">';
	print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
	print '<input type="hidden" name="action" value="setvalue_account">';

	$var=true;

	print '<table class="nobordernopadding" width="100%">';
	print '<tr class="liste_titre">';
	print '<td>'.$langs->trans("Parameter").'</td>';
	print '<td>'.$langs->trans("Value").'</td>';
	print "</tr>\n";


	$var=!$var;
	print '<tr '.$bc[$var].'><td>';
	print $langs->trans("OvhSmsLabelAccount").'</td><td>';
	print '<input size="64" type="text" name="OVHSMS_ACCOUNT" value="'.$conf->global->OVHSMS_ACCOUNT.'">';
	print '<br>'.$langs->trans("Example").': sms-aa123-1';
	print '</td></tr>';

	print '<tr><td colspan="2" align="center"><input type="submit" class="button" value="'.$langs->trans("Modify").'"></td></tr>';
	print '</table></form>';




   //logout
   $soap->logout($session);
 //  echo "logout successfull\n";

} catch(SoapFault $fault) {
  echo $langs->trans("OvhSmsNotConfigured").$fault;
  }



// End of page
$db->close();
llxFooter('');
?>