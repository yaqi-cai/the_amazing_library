
<?php

$dsn = "mysql:host=localhost;dbname=LibraryAutoIncrementTest";
$user = "root";
$password = null;
$options = null;


try {
    $pdo = new PDO($dsn, $user, $password, $options);
} catch (PDOException $e) {
    die($e->getMessage());  //die() for illustration
    //always handle errors 
}

$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
?>
