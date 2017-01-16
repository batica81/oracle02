<?php
session_start();
error_reporting(0);
require_once 'connectvars.php';

if (!isset($_SERVER['PHP_AUTH_PW']) || (($_SERVER['PHP_AUTH_PW'] != HTTP_PASS))) {
    header('HTTP/1.1 401 Unauthorized');
    header('WWW-Authenticate: Basic realm="FON_Projekat"');
    exit('<h3>FON_Projekat</h3>Sorry, you need proper credentials.');
} 
?>

<html lang="en" charset="utf-8">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.structure.min.css">
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.theme.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-editable.css">
    <script src="js/jquery-2.2.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src='js/tablesorter.min.js'></script> 
    <script src="js/bootstrap-editable.min.js"></script>
    <script src="js/index.js"></script>
    <title>VWG Inženjering</title>
  </head>
  <body>

    <!-- Static navbar -->
    <nav class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">VWG Inženjering</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="index.php">Home</a></li>
            <li><a href="kupac.php">Kupac</a></li>
            <li><a href="ponuda.php">Ponuda</a></li>
            <li><a href="artikal.php">Artikal</a></li>
            <li><a href="cena.php">Cenovnik</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a href="adminer/adminer.php">Baza</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>