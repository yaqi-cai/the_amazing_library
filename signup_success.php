<?php
session_start();
if (isset($_SESSION["username"])) {

    echo '<h3>Thank you for registering- ' . $_SESSION["username"] . '</h3>';
    echo '<h3>Please check your email for confirmation</h3>';
    echo '<br><br><a href="signup.php">Logout</a>';
    
} else {

    header("location:signout.php");
}

