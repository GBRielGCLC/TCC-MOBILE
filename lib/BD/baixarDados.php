<?php
require("conexaoAPP.php");

$makeQuery = "SELECT * FROM bebida";

$statement = $conn->prepare($makeQuery);
$statement->execute();

$myarray=array();

while($resultFrom = $statement ->fetch()){
    array_push(
        $myarray,array(
            "idBebida"=>$resultFrom["idBebida"],
            "nome"=>$resultFrom["nome"],
        )
    );
}

echo json_encode($myarray);

?>