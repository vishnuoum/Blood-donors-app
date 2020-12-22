<?php
    try{
        require 'connect.php';
        $bldgrp = $_POST["bloodGroup"];
        $district = $_POST["district"];
        $array=array();

        $sql="Select * from donor where district='$district' and bgroup='$bldgrp'";
        $result=$conn->query($sql);
        if($result->num_rows>0){
            while($row=$result->fetch_assoc()){
                array_push($array,$row);
            }
        }

        echo json_encode($array);

        $conn->close();
    }
    catch(Exception $error){
        echo "error";
    }
?>