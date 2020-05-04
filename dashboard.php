<?php session_start();?>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
<?php
if (isset($_SESSION["username"])) {

    echo '<h3>Hello ' . $_SESSION["username"] . '</h3>';
    echo '<h3>Here is your dashboard.</h3>';
    echo '<br><br><a href="Login.php">Logout</a>';
    
} else {

    header("location:signout.php");
}
        ?>
    </body>
</html>
