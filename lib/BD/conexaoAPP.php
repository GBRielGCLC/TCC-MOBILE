<?php

try{
 $conn = new PDO("mysql:host=localhost;dbname=id16431665_pizzaria","id16431665_root","I^T5!le=NnPzdPkg");
 $conn ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
 echo "conectado";
}
catch(PDOException $e){
echo $e ->getMessage();
die("não conectou");
}