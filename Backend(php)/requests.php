<?php
    try{
        require 'connect.php';
        $dateTime = new DateTime('now', new DateTimeZone('Asia/Kolkata')); 
        $time=$dateTime->format("H:i A"); 
        $date=$dateTime->format("d/m/yy");
        $array=array();

        $sql="Select * from request where date>'$date' or (date='$date' and time>'$time') order by date asc";
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