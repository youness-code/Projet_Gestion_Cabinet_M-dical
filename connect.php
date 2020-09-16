<?php
    
$conn = oci_connect('yz###','8180','localhost:1521/ORCL.UNICE.FR');
if (!$conn) {
    $e = oci_error();
    print htmlentities($e['message']);
    exit;
}

?>
