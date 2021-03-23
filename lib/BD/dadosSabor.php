<?php
require("conexaoAPP.php");

$makeQuery = "SELECT * FROM sabor";

$statement = $conn->prepare($makeQuery);
$statement->execute();

$myarray=array();

while($resultFrom = $statement ->fetch()){
    if($resultFrom["status"]=="on" && $resultFrom["cardapio"]=="on"){
        array_push(
            $myarray,array(
                "idSabor"=>$resultFrom["idSabor"],
                "nome"=>$resultFrom["nome"],
                "precoAdd"=>$resultFrom["precoAdd"],
                "descricao"=>$resultFrom["descricao"],
                "disponibilidade"=>$resultFrom["disponibilidade"],
            )
        );
    }
}

echo json_encode($myarray);

?>