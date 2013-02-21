<?php
/* Copyright (C) 2010-2011 Regis Houssin  <regis@dolibarr.fr>
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
 *	\file       htdocs/milestone/class/dao_milestone.class.php
 *	\ingroup    milestone
 *	\brief      Fichier de la classe des jalons
 */

include_once(DOL_DOCUMENT_ROOT.'/core/class/commonobject.class.php');


/**
 *	\class      DaoMilestone
 *	\brief      Classe permettant la gestion des jalons
 */
class DaoMilestone extends CommonObject
{
	var $db;
	var $error;

	var $id;
	var $label;
	var $description;
	var $priority;
	
	var $objParent;
	var $fk_element;
	var $elementtype;
	
	var $rang;
	var $rangtouse;
	
	var $fk_user_modif;

	var $lines=array();			// Tableau en memoire des jalons


	/**
	 * 	Constructor
	 * 	@param	DB		acces base de donnees
	 * 	@param	id		milestone id
	 */
	function DaoMilestone($DB)
	{
		$this->db = $DB;
	}

	/**
	 * 	Charge le jalon
	 * 	@param		object		Object line
	 */
	function fetch($object,$line)
	{
		$element = (is_object($object) ? $object->element : $object);
		$lineid = (is_object($line) ? $line->rowid : $line);
		
		$sql = "SELECT rowid, fk_element, elementtype, label, tms, priority, fk_user_modif";
		$sql.= " FROM ".MAIN_DB_PREFIX."milestone";
		$sql.= " WHERE fk_element = ".$lineid;
		$sql.= " AND elementtype = '".$element."'";

		dol_syslog("Milestone::fetch sql=".$sql);
		$resql  = $this->db->query ($sql);
		if ($resql)
		{
			$obj = $this->db->fetch_object($resql);

			$this->rowid			= $obj->rowid;
			$this->fk_element		= $obj->fk_element;
			$this->elementtype		= $obj->elementtype;
			$this->label	   		= $obj->label;
			$this->priority			= $obj->priority;
			$this->fk_user_modif 	= $obj->fk_user_modif;

			$this->db->free($resql);
		}
		else
		{
			dol_print_error ($this->db);
			return -1;
		}
	}

	/**
	 *  Ajoute le jalon dans la base de donnees
	 * 	@return	int 	-1 : erreur SQL
	 *          		-2 : nouvel ID inconnu
	 *          		-3 : jalon invalide
	 */
	function create($user,$clone=0)
	{
		global $conf,$langs;
		
		$langs->load('milestone');

		// Clean parameters
		$this->label=trim($this->label);
		$this->description=trim($this->description);
		
		// TODO uniformiser
		if ($this->objParent->element == 'propal') $fields = array($this->objParent->id,$this->description,0,0,0,0,0,0,0,"HT",0,0,$this->product_type,$this->rang,$this->special_code);
		if ($this->objParent->element == 'commande') $fields = array($this->objParent->id,$this->description,0,0,0,0,0,0,0,0,0,'HT',0,$this->dateo,$this->datee,$this->product_type,$this->rang,$this->special_code);
		if ($this->objParent->element == 'facture') $fields = array($this->objParent->id,$this->description,0,0,0,0,0,0,0,$this->dateo,$this->datee,0,0,0,'HT',0,$this->product_type,$this->rang,$this->special_code);
		
		$this->db->begin();
		
		if (!$clone)
		{
			$result = $this->objParent->addline($fields[0],$fields[1],$fields[2],$fields[3],$fields[4],$fields[5],$fields[6],$fields[7],$fields[8],$fields[9],$fields[10],$fields[11],$fields[12],$fields[13],$fields[14],$fields[15],$fields[16],$fields[17],$fields[18]);
		}
		else
		{
			$result = 1;
		}

		if ($result > 0)
		{
			$sql = "INSERT INTO ".MAIN_DB_PREFIX."milestone (";
			$sql.= "label";
			$sql.= ", fk_element";
			$sql.= ", elementtype";
			$sql.= ") VALUES (";
			$sql.= "'".addslashes($this->label)."'";
			$sql.= ", ".$this->objParent->line->rowid;
			$sql.= ", '".addslashes($this->objParent->element)."'";
			$sql.= ")";

			$res  = $this->db->query ($sql);
			if ($res)
			{
				$this->id = $this->db->last_insert_id (MAIN_DB_PREFIX."milestone");
				
				if ($this->id > 0)
				{
					// Appel des triggers
					include_once(DOL_DOCUMENT_ROOT . "/core/class/interfaces.class.php");
					$interface=new Interfaces($this->db);
					$result=$interface->run_triggers('MILESTONE_CREATE',$this,$user,$langs,$conf);
					if ($result < 0) { $error++; $this->errors=$interface->errors; }
					// Fin appel triggers
					
					$this->db->commit();
					return 1;
				}
				else
				{
					$this->error=$this->db->error();
					dol_syslog("Error sql=$sql, error=".$this->error,LOG_ERR);
					$this->db->rollback();
					return -1;
				}
			}
			else
			{
				$this->error=$this->db->error();
				dol_syslog("Error sql=$sql, error=".$this->error,LOG_ERR);
				$this->db->rollback();
				return -2;
			}
		}	
	}

	/**
	 * 	Update milestone
	 * 	@return	int		 1 : OK
	 *          		-1 : SQL error
	 *          		-2 : invalid milestone
	 */
	function update($user)
	{
		global $conf;

		// Clean parameters
		$this->label=trim($this->label);
		$this->description=trim($this->description);
		
		// TODO uniformiser
		if ($this->objParent->element == 'propal') $fields = array($this->id,0,0,0,0,0,0,$this->description,"HT",0,$this->special_code,0,1);
		if ($this->objParent->element == 'commande') $fields = array($this->id,$this->description,0,0,0,0,0,0,'HT',0,$this->dateo,$this->datee,$this->product_type,0,1);
		if ($this->objParent->element == 'facture') $fields = array($this->id,$this->description,0,0,0,$this->dateo,$this->datee,0,0,0,'HT',0,$this->product_type,0,1);

		$this->db->begin();

		$result = $this->objParent->updateline($fields[0],$fields[1],$fields[2],$fields[3],$fields[4],$fields[5],$fields[6],$fields[7],$fields[8],$fields[9],$fields[10],$fields[11],$fields[12],$fields[13],$fields[14]);

		if ($result >= 0)
		{
			$sql = "UPDATE ".MAIN_DB_PREFIX."milestone SET";
			$sql.= " label = '".addslashes($this->label)."'";
			$sql.= " WHERE fk_element = ".$this->id;
			$sql.= " AND elementtype = '".$this->objParent->element."'";

			dol_syslog("Milestone::update sql=".$sql);
			if ($this->db->query($sql))
			{
				$this->db->commit();
				
				// Appel des triggers
				include_once(DOL_DOCUMENT_ROOT . "/core/class/interfaces.class.php");
				$interface=new Interfaces($this->db);
				$result=$interface->run_triggers('MILESTONE_MODIFY',$this,$user,$langs,$conf);
				if ($result < 0) { $error++; $this->errors=$interface->errors; }
				// Fin appel triggers
				
				return 1;
			}
			else
			{
				$this->db->rollback();
				dol_print_error($this->db);
				return -1;
			}
		}
	}

	/**
	 * 	Delete milestone
	 */
	function delete($lineid,$element='',$delparent=true)
	{
		global $conf, $user, $langs;
		
		$this->db->begin();
		
		$element = ($element?$element:$this->objParent->element);
		
		if ($delparent) $ret=$this->objParent->deleteline($lineid);
		else $ret=1;
		
		if ($ret > 0)
		{
			$sql = "DELETE FROM ".MAIN_DB_PREFIX."milestone";
			$sql.= " WHERE fk_element = ".$lineid;
			$sql.= " AND elementtype = '".$element."'";
			
			if (!$this->db->query($sql))
			{
				$this->db->rollback();
				dol_print_error($this->db);
				return -1;
			}
			else
			{
				$this->db->commit();
				
				// Appel des triggers
				include_once(DOL_DOCUMENT_ROOT . "/core/class/interfaces.class.php");
				$interface=new Interfaces($this->db);
				$result=$interface->run_triggers('MILESTONE_DELETE',$this,$user,$langs,$conf);
				if ($result < 0) { $error++; $this->errors=$interface->errors; }
				// Fin appel triggers
				
				return 1;
			}
		}
	}
	
	/**
	 * 
	 */
	function getChildObject($object)
	{
		global $conf;
		
		$element = $object->element;
		
		$sql = "SELECT rowid";
		$sql.= " FROM ".MAIN_DB_PREFIX.$element;
		$sql.= " WHERE fk_parent_line = ".$lineid;
		
		if ($this->db->query($sql))
		{
			
		}
	}

}
?>