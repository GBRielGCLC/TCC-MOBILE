<?php
require("conexaoAPP.php");

$makeQuery = "SELECT * FROM bebida";

$statement = $conn->prepare($makeQuery);
$statement->execute();

$myarray=array();

while($resultFrom = $statement ->fetch()){
    if($resultFrom["status"]=="on" && $resultFrom["cardapio"]=="on"){
        array_push(
            $myarray,array(
                "idBebida"=>$resultFrom["idBebida"],
                "nome"=>$resultFrom["nome"],
                "preco"=>$resultFrom["preco"],
            )
        );
    }
}

echo json_encode($myarray);

?>