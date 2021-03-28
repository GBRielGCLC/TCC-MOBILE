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
                "descricao"=>$resultFrom["descricao"],
                "disponibilidade"=>$resultFrom["disponibilidade"],
                "precoAdd"=>$resultFrom["precoAdd"],
            )
        );
    }
}

echo json_encode($myarray);

?>