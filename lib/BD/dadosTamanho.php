<?php
require("conexaoAPP.php");

$makeQuery = "SELECT * FROM tamanho";

$statement = $conn->prepare($makeQuery);
$statement->execute();

$myarray=array();

while($resultFrom = $statement ->fetch()){
    if($resultFrom["status"]=="on" && $resultFrom["cardapio"]=="on"){
        array_push(
            $myarray,array(
                "idPizza"=>$resultFrom["idPizza"],
                "nome"=>$resultFrom["nome"],
                "preco"=>$resultFrom["preco"],
                "qtdeSabor"=>$resultFrom["qtdeSabor"],
            )
        );
    }
}

echo json_encode($myarray);

?>