<?php
    try{
        require 'connect.php';
        $name=$_POST['name'];
        $bloodGroup=$_POST['bloodGroup'];
        $dob=$_POST["dob"];
        $district=$_POST["district"];
        $place=$_POST["place"];
        $phone=$_POST["phone"];

        $sql="Insert into donor(id,name,bgroup,dob,district,place,phone) Values(NULL,'$name','$bloodGroup','$dob','$district','$place','$phone')";

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