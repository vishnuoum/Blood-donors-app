<?php
    try{
        require 'connect.php';
        $name=$_POST['patient'];
        $date=$_POST['date'];
        $time=$_POST["time"];
        $hospital=$_POST["hospital"];
        $district=$_POST["district"];
        $units=$_POST["units"];
        $bystander=$_POST["bystander"];
        $contact=$_POST["contact"];
        $bloodGroup=$_POST["blood"];

        $sql="Insert into request(id,pname,bgroup,district,hospital,bname,bphone,date,time,units) Values(NULL,'$name','$bloodGroup','$district','$hospital','$bystander','$contact','$date','$time','$units')";

        if($conn->query($sql) === TRUE){
            echo "Done";
        }
        else{
            echo "error";
        }

        $conn->close();
    }
    catch(Exception $error){
        echo "error";
    }
?>