<?php

require '../vendor/autoload.php';
require_once 'connectvars.php';


class DbAccess {
	public $database;
	
	function __construct()
	{
		$database = new medoo([
		    'database_type' => 'oracle',
		    'database_name' => '',
		    'server' => DB_HOST,
		    'username' => DB_USER,
		    'password' => DB_PASSWORD,
		    'charset' => 'UTF8',
		     'option' => [
		        PDO::ATTR_CASE => PDO::CASE_NATURAL
		    ]
		]);
		$this->database = $database;
	}
}


