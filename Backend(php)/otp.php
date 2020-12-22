<?php
    try {
        $phone=$_POST["phone"];
        $otp=$_POST["otp"];

        $field = array(
            "sender_id" => "FSTSMS",
            "language" => "english",
            "route" => "qt",
            "numbers" => $phone,
            "message" => "<Fast2Sms template id>",
            "variables" => "<Variable>",
            "variables_values" => $otp
        );

        $curl = curl_init();

        curl_setopt_array($curl, array(
        CURLOPT_URL => "https://www.fast2sms.com/dev/bulk",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_SSL_VERIFYHOST => 0,
        CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_POSTFIELDS => json_encode($field),
        CURLOPT_HTTPHEADER => array(
            "authorization: <Fast2Sms Api key >",
            "cache-control: no-cache",
            "accept: */*",
            "content-type: application/json"
        ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        if ($err) {
        echo "cURL Error #:" . $err;
        } else {
        echo "ok";
        }
    }
    catch(Exception $error){
        echo "error";
    }
?>